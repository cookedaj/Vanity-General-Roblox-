--==============================================================================
-- MOVEMENT
-- Client-side movement suite: fly, noclip, speed, infinite jump, click TP.
-- Everything is CFrame or physics velocity only — no BodyMovers, no
-- WalkSpeed/JumpPower writes, no Humanoid:ChangeState spoofing.
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

	-- Fly: pure CFrame translation of the root (rotation untouched, so the
	-- character stays upright and keeps its look direction). Velocity is zeroed
	-- while flying so gravity can't make you sink between steps.
	if config.FlyEnabled then
		local cam = Workspace.CurrentCamera
		if cam then
			root.AssemblyLinearVelocity = Vector3.zero
			-- While a keybind box is capturing, WASD/Space are a rebind, not flying.
			if not UI:IsCapturingKey() then
				local dir = mv_flyDirection(cam)
				if dir then
					root.CFrame = root.CFrame + dir * (config.FlySpeed or 50) * dt
				end
			end
		end
	end

	-- Speed: a CFrame nudge along the humanoid's OWN move direction, so it works
	-- with any control scheme and never touches WalkSpeed.
	if config.SpeedEnabled then
		local surplus = (config.Speed or BASE_WALKSPEED) - BASE_WALKSPEED
		if surplus > 0 and humanoid.MoveDirection.Magnitude > 0 then
			root.CFrame = root.CFrame + humanoid.MoveDirection * surplus * dt
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

	local _, root = mv_character()
	local mouse = LocalPlayer:GetMouse()
	if root and mouse and mouse.Hit then
		-- +3 studs so you land on top of the surface instead of inside it.
		root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
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
