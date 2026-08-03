-- Camera Director Module
-- Smooth camera tracking toward prioritized targets

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local CameraDirector = {}

-- Find valid target part on character based on priority list
local function getTargetPart(character, targetPartName, partPriority)
	if not character then
		return nil
	end

	local preferred = character:FindFirstChild(targetPartName)
	if preferred and preferred:IsA("BasePart") then
		return preferred
	end

	for _, name in ipairs(partPriority) do
		local part = character:FindFirstChild(name)
		if part and part:IsA("BasePart") then
			return part
		end
	end

	return nil
end

-- Calculate 2D distance from viewport center
local function getScreenDistance(worldPosition)
	local viewport, visible = Camera:WorldToViewportPoint(worldPosition)

	if not visible or viewport.Z < 0 then
		return math.huge
	end

	local screen = Vector2.new(viewport.X, viewport.Y)
	local center = Camera.ViewportSize / 2

	return (screen - center).Magnitude
end

-- Raycast visibility check (target must be visible from camera)
local function isVisible(position, character)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character }

	local result = Workspace:Raycast(
		Camera.CFrame.Position,
		position - Camera.CFrame.Position,
		params
	)

	return not result or result.Instance:IsDescendantOf(character)
end

-- Find best target: closest to screen center, visible, alive, within max distance
function CameraDirector:FindBestTarget(config)
	local best
	local bestDistance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		if player == LocalPlayer then
			continue
		end

		local character = player.Character
		if not character then
			continue
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			continue
		end

		local part = getTargetPart(character, config.TargetPart, config.TargetPartOptions)
		if not part then
			continue
		end

		-- MaxDistance is a world-space range in studs (matches the UI's "m" label).
		local worldDistance = (part.Position - Camera.CFrame.Position).Magnitude
		if worldDistance > config.MaxDistance then
			continue
		end

		local distance = getScreenDistance(part.Position)

		if distance < bestDistance
			and isVisible(part.Position, character)
		then
			bestDistance = distance
			best = {
				Player = player,
				Character = character,
				Part = part,
				ScreenDistance = distance,
			}
		end
	end

	return best
end

-- Smooth camera movement toward target
function CameraDirector:PointCamera(targetPosition, smoothness)
	local cameraPosition = Camera.CFrame.Position
	local desired = CFrame.lookAt(cameraPosition, targetPosition)
	Camera.CFrame = Camera.CFrame:Lerp(desired, smoothness)
end

-- Update camera tracking. `debug` is the top-level Configuration.Debug flag
-- (it does not live inside the Camera config table).
function CameraDirector:Update(config, debug)
	if not config.Enabled then
		return
	end

	-- Refresh the cached camera in case CurrentCamera changed (e.g. respawn).
	-- The helper closures above share this upvalue, so one assignment updates all.
	Camera = Workspace.CurrentCamera
	if not Camera then
		return
	end

	local target = self:FindBestTarget(config)
	if not target then
		return
	end

	self:PointCamera(target.Part.Position, config.Smoothness)

	if debug then
		print("Tracking:", target.Character.Name, "Distance:", math.floor(target.ScreenDistance))
	end

	return target
end

return CameraDirector
