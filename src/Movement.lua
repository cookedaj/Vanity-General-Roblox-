--==============================================================================
-- MOVEMENT
-- Client-side movement suite: fly, noclip, speed, infinite jump, click TP.
-- Fly/Speed steer through AssemblyLinearVelocity (physics-integrated, so
-- movement replicates naturally and doesn't trip teleport checks or
-- rubber-band). No BodyMovers, no WalkSpeed/JumpPower writes, no
-- Humanoid:ChangeState spoofing. Click TP is the only CFrame teleport.
--==============================================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local UI = require(script.UI)

local Movement = {}

-- Stock WalkSpeed; Speed mode only adds the surplus over this, so a Speed of
-- 16 is a no-op (you move exactly as fast as the game intends).
local BASE_WALKSPEED = 16

-- Matches a normal jump's upward launch (~50 studs/s) so Infinite Jump feels
-- like jumping, just without needing to touch the ground.
local JUMP_VELOCITY = 50

local mv_jumpConnection
local mv_clickConnection
local mv_tpToken = 0 -- incremented per TP; a running stepped TP stops when stale

-- Returns character, root, humanoid for the local player, or nil when any piece
-- is missing or dead (mid-respawn, etc).
local function mv_character()
	local character = LocalPlayer.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not (character and root and humanoid and humanoid.Health > 0) then
		return nil
	end
	return character, root, humanoid
end

-- WASD relative to the camera (flattened, so looking down doesn't dive) plus
-- Space/Shift for up/down. Returns a unit vector, or nil when nothing is held.
local function mv_flyDirection(cam)
	local look = cam.CFrame.LookVector
	local flat = Vector3.new(look.X, 0, look.Z)
	if flat.Magnitude < 0.001 then
		flat = Vector3.new(0, 0, -1) -- looking straight up/down: pick a fallback
	else
		flat = flat.Unit
	end
	local right = cam.CFrame.RightVector
	right = Vector3.new(right.X, 0, right.Z).Unit

	local move = Vector3.zero
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		move = move + flat
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		move = move - flat
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		move = move + right
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		move = move - right
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
		move = move + Vector3.yAxis
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		move = move - Vector3.yAxis
	end

	if move.Magnitude > 0 then
		return move.Unit
	end
	return nil
end

-- Pulse (anti-lagback): server speed checks validate displacement over a time
-- window, so a SUSTAINED high velocity always trips them eventually. Alternating
-- boost and coast intervals keeps every window plausible. Always on with fixed
-- timing (100 ms boost / 150 ms coast — the most compatible window across
-- games); coast frames drop to normal walkspeed rather than zero, so movement
-- never looks scripted stop-start.
local PULSE_BOOST = 0.1
local PULSE_COAST = 0.15

local function mv_pulseActive()
	return (os.clock() % (PULSE_BOOST + PULSE_COAST)) < PULSE_BOOST
end

-- Per-frame driver, called from the controller's RenderStepped loop.
function Movement:Update(dt, config)
	local character, root, humanoid = mv_character()

	-- Noclip: re-applied every frame, so the moment this stops running (toggle
	-- off, or the whole script unloads) collision comes back on its own.
	if config.NoclipEnabled and character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	if not root then
		return
	end

	-- Fly: velocity steering, NOT CFrame teleports. Small per-frame teleports
	-- fight the physics engine and read as position hacks — the server snaps
	-- you back (rubber-banding) and anti-teleport checks fire. Driving
	-- AssemblyLinearVelocity lets physics integrate the movement, so it
	-- replicates like ordinary motion.
	if config.FlyEnabled then
		local cam = Workspace.CurrentCamera
		if cam then
			local velocity = Vector3.zero
			-- While a keybind box is capturing, WASD/Space are a rebind, not flying.
			if not UI:IsCapturingKey() then
				local dir = mv_flyDirection(cam)
				if dir then
					local speed = config.FlySpeed or 50
					if not mv_pulseActive() then
						speed = math.min(speed, BASE_WALKSPEED) -- coast at a plausible rate
					end
					velocity = dir * speed
				end
			end
			root.AssemblyLinearVelocity = velocity
		end
		return -- fly owns the character's velocity; don't let Speed fight it
	end

	-- Speed: override the horizontal velocity toward the humanoid's OWN move
	-- direction (works with any control scheme), preserving vertical velocity
	-- so jumps/falls stay natural. WalkSpeed itself is never written. During
	-- pulse coast frames we don't touch velocity at all, so the humanoid
	-- walks normally — the average stays under server check thresholds.
	if config.SpeedEnabled then
		local speed = config.Speed or BASE_WALKSPEED
		local move = humanoid.MoveDirection
		if speed > BASE_WALKSPEED and move.Magnitude > 0 and mv_pulseActive() then
			local velocity = root.AssemblyLinearVelocity
			root.AssemblyLinearVelocity = Vector3.new(move.X * speed, velocity.Y, move.Z * speed)
		end
	end
end

-- JumpRequest fires on Space even mid-air. AssemblyLinearVelocity is a physics
-- velocity, not one of the property writes anti-cheats watch (WalkSpeed /
-- JumpPower), so this reads as an ordinary jump.
local function mv_onJumpRequest(config)
	if not config.InfJumpEnabled then
		return
	end
	local _, root = mv_character()
	if root then
		local velocity = root.AssemblyLinearVelocity
		root.AssemblyLinearVelocity = Vector3.new(velocity.X, JUMP_VELOCITY, velocity.Z)
	end
end

-- Teleports the local character to a world position (+3 studs so you land on
-- top of the surface instead of inside it). Shared by Click TP and the Players
-- tab's "Teleport To" button. Always stepped: one instant jump gets rejected by
-- server anti-teleport validation (you snap back), so the TP hops in small
-- increments — no single frame's displacement trips the checks. A new TP or a
-- respawn invalidates a running hop via mv_tpToken.
local TP_STEP = 10 -- studs per hop
local TP_INTERVAL = 0.05 -- seconds between hops

function Movement.TeleportTo(position)
	local destination = position + Vector3.new(0, 3, 0)

	mv_tpToken = mv_tpToken + 1
	local token = mv_tpToken
	task.spawn(function()
		while token == mv_tpToken do
			local _, currentRoot = mv_character()
			if not currentRoot then
				return
			end
			local offset = destination - currentRoot.CFrame.Position
			if offset.Magnitude <= TP_STEP then
				currentRoot.CFrame = CFrame.new(destination)
				return
			end
			currentRoot.CFrame = currentRoot.CFrame + offset.Unit * TP_STEP
			task.wait(TP_INTERVAL)
		end
	end)
end

local function mv_onInput(config, input, gameProcessed)
	if gameProcessed or UI:IsCapturingKey() then
		return
	end
	if not config.ClickTPEnabled then
		return
	end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end
	if not UserInputService:IsKeyDown(config.ClickTPKey or Enum.KeyCode.LeftControl) then
		return
	end

	local mouse = LocalPlayer:GetMouse()
	if mouse and mouse.Hit then
		Movement.TeleportTo(mouse.Hit.Position)
	end
end

-- Event-driven halves (jump, click) live on their own connections; the
-- per-frame halves are driven by the controller calling Update.
function Movement:Init(config)
	if not mv_jumpConnection then
		mv_jumpConnection = UserInputService.JumpRequest:Connect(function()
			mv_onJumpRequest(config)
		end)
	end
	if not mv_clickConnection then
		mv_clickConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			mv_onInput(config, input, gameProcessed)
		end)
	end
end

function Movement:Cleanup()
	if mv_jumpConnection then
		mv_jumpConnection:Disconnect()
		mv_jumpConnection = nil
	end
	if mv_clickConnection then
		mv_clickConnection:Disconnect()
		mv_clickConnection = nil
	end
	-- Noclip needs no restore here: it only re-sets CanCollide = false each
	-- frame, so once Update stops running collision returns naturally.
end

return Movement
