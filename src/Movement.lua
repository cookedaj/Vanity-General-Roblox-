-- Movement Module
-- CFrame-only stealth movement: no BodyVelocity/BodyGyro instances and no
-- WalkSpeed/JumpPower writes, so server-side property watchers have nothing to
-- latch onto. Every feature works by pivoting the character or nudging
-- velocity directly.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local Movement = {}

local config
local connections = {}

-- Resolve the live character parts (re-fetched each call so respawns just work)
local function getCharacter()
	local character = LocalPlayer.Character
	if not character then
		return nil
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then
		return nil
	end

	return character, rootPart, character:FindFirstChildOfClass("Humanoid")
end

-- Fat Walk originals: captured on first application so toggle-off and Cleanup
-- can restore the exact pre-fat scale values.
local fatOriginals

local function restoreFatWalk()
	if fatOriginals then
		-- Parent check guards against restoring a destroyed (pre-respawn) rig
		if fatOriginals.WidthScale.Parent then
			fatOriginals.WidthScale.Value = fatOriginals.Width
		end
		if fatOriginals.DepthScale.Parent then
			fatOriginals.DepthScale.Value = fatOriginals.Depth
		end
		fatOriginals = nil
	end
end

-- Scale the local humanoid's body width/depth. Purely client-side: with
-- FilteringEnabled the scale change never replicates, so only we see the fat
-- character. Height is left untouched.
local function applyFatWalk(humanoid)
	local widthScale = humanoid:FindFirstChild("BodyWidthScale")
	local depthScale = humanoid:FindFirstChild("BodyDepthScale")
	if not widthScale or not depthScale then
		return
	end

	-- A different humanoid means we respawned; the fresh rig already has
	-- default scales, so the stale originals are useless.
	if fatOriginals and fatOriginals.Humanoid ~= humanoid then
		fatOriginals = nil
	end

	if not fatOriginals then
		fatOriginals = {
			Humanoid = humanoid,
			WidthScale = widthScale,
			DepthScale = depthScale,
			Width = widthScale.Value,
			Depth = depthScale.Value,
		}
	end

	-- Re-apply every frame in case something (or a respawn) reset the values
	if widthScale.Value ~= config.FatScale then
		widthScale.Value = config.FatScale
	end
	if depthScale.Value ~= config.FatScale then
		depthScale.Value = config.FatScale
	end
end

-- Fly + Noclip + Speed, driven every frame from the controller's render loop
function Movement:Update(dt)
	if not config then
		return
	end

	local character, rootPart, humanoid = getCharacter()
	if not character then
		return
	end

	-- Noclip: force CanCollide off every frame because Humanoid state changes
	-- keep flipping it back on. Client-side only — the server still collides.
	if config.NoclipEnabled then
		for _, inst in ipairs(character:GetDescendants()) do
			if inst:IsA("BasePart") then
				inst.CanCollide = false
			end
		end
	end

	-- Fly: WASD relative to the camera, Space up, LeftShift down. Position-only
	-- pivot so the character's orientation is preserved.
	if config.FlyEnabled then
		local camera = Workspace.CurrentCamera
		if camera then
			local direction = Vector3.zero
			local look = camera.CFrame.LookVector
			local right = camera.CFrame.RightVector

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				direction = direction + look
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				direction = direction - look
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				direction = direction + right
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				direction = direction - right
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				direction = direction + Vector3.yAxis
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
				direction = direction - Vector3.yAxis
			end

			if direction.Magnitude > 0 then
				character:PivotTo(character:GetPivot() + direction.Unit * config.FlySpeed * dt)
			end
		end
	end

	-- Speed: extra CFrame displacement on top of normal walking. Delta over the
	-- default 16 studs/sec so the slider's low end is a no-op.
	if config.SpeedEnabled and humanoid then
		local moveDirection = humanoid.MoveDirection
		if moveDirection.Magnitude > 0 then
			character:PivotTo(character:GetPivot() + moveDirection * (config.Speed - 16) * dt)
		end
	end

	-- Fat Walk: widen the local rig; restore the originals when toggled off
	if config.FatWalk and humanoid then
		applyFatWalk(humanoid)
	else
		restoreFatWalk()
	end
end

function Movement:Init(movementConfig)
	config = movementConfig

	-- Infinite Jump: set velocity directly instead of touching WalkSpeed/
	-- JumpPower — property watchers scan those two, not velocity.
	table.insert(connections, UserInputService.JumpRequest:Connect(function()
		if not config.InfJumpEnabled then
			return
		end

		local _, rootPart = getCharacter()
		if not rootPart then
			return
		end

		local velocity = rootPart.AssemblyLinearVelocity
		rootPart.AssemblyLinearVelocity = Vector3.new(velocity.X, 50, velocity.Z)
	end))

	-- Click TP: hold the modifier key and left-click to teleport to the mouse,
	-- keeping the character's current orientation and a small lift off the
	-- ground so we don't land inside the floor.
	table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end
		if not config.ClickTPEnabled then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end
		if not UserInputService:IsKeyDown(config.ClickTPKey) then
			return
		end

		local character = getCharacter()
		local mouse = LocalPlayer:GetMouse()
		if not character or not mouse.Hit then
			return
		end

		local pivot = character:GetPivot()
		character:PivotTo(
			CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)) * (pivot - pivot.Position)
		)
	end))
end

function Movement:Cleanup()
	restoreFatWalk()

	for _, conn in ipairs(connections) do
		conn:Disconnect()
	end
	table.clear(connections)
	config = nil
end

return Movement
