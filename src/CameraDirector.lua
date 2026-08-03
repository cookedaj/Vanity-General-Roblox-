-- Camera Director Module
-- Smooth camera tracking toward prioritized targets

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local CameraDirector = {}

-- Single Random instance for humanization jitter (created once, never reseeded
-- per frame — reseeding would produce correlated values on fast frames).
local rng = Random.new()

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

-- NPC (bot) character cache. A full descendant scan every frame is too
-- expensive, so it refreshes at most this often and only while TargetBots
-- is enabled.
local BOT_SCAN_INTERVAL = 0.5
local botScanTime = 0
local botCharacters = {}

local function refreshBotCharacters()
	table.clear(botCharacters)
	for _, inst in ipairs(Workspace:GetDescendants()) do
		if inst:IsA("Humanoid") then
			local character = inst.Parent
			if character
				and character:IsA("Model")
				and not Players:GetPlayerFromCharacter(character)
			then
				table.insert(botCharacters, character)
			end
		end
	end
end

-- Find best target: closest to screen center, visible, alive, within max distance
function CameraDirector:FindBestTarget(config)
	local best
	local bestDistance = math.huge

	local function consider(character, player)
		if not character then
			return
		end

		-- Team check: skip teammates (teamless players are always fair game)
		if config.TeamCheck
			and player
			and player.Team ~= nil
			and player.Team == LocalPlayer.Team
		then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return
		end

		local part = getTargetPart(character, config.TargetPart, config.TargetPartOptions)
		if not part then
			return
		end

		-- MaxDistance is a world-space range in studs (matches the UI's "m" label).
		local worldDistance = (part.Position - Camera.CFrame.Position).Magnitude
		if worldDistance > config.MaxDistance then
			return
		end

		local distance = getScreenDistance(part.Position)

		if distance < bestDistance
			and isVisible(part.Position, character)
		then
			bestDistance = distance
			best = {
				Player = player, -- nil for bots
				Character = character,
				Part = part,
				ScreenDistance = distance,
				-- Carried through so Update can scale prediction lead by range
				WorldDistance = worldDistance,
			}
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			consider(player.Character, player)
		end
	end

	if config.TargetBots then
		if os.clock() - botScanTime > BOT_SCAN_INTERVAL then
			botScanTime = os.clock()
			refreshBotCharacters()
		end
		for _, character in ipairs(botCharacters) do
			consider(character, nil)
		end
	end

	return best
end

-- Smooth camera movement toward target. `humanize` adds a sub-degree random
-- angular offset so the aim path isn't a perfectly straight mechanical line.
function CameraDirector:PointCamera(targetPosition, smoothness, humanize)
	local cameraPosition = Camera.CFrame.Position
	local desired = CFrame.lookAt(cameraPosition, targetPosition)

	if humanize then
		local maxOffset = math.rad(0.3)
		desired = desired * CFrame.Angles(
			(rng:NextNumber() - 0.5) * 2 * maxOffset,
			(rng:NextNumber() - 0.5) * 2 * maxOffset,
			0
		)
	end

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

	local aimPosition = target.Part.Position

	-- Prediction: lead the target by its velocity, scaled by range. The /500
	-- normalizes against a generic reference speed — real projectile speeds
	-- are per-game, so game-specific forks should tune this constant.
	if config.Prediction > 0 then
		aimPosition = aimPosition
			+ target.Part.Velocity * config.Prediction * (target.WorldDistance / 500)
	end

	-- Humanize: ±10% jitter on smoothness so the lerp speed isn't constant
	local smoothness = config.Smoothness
	if config.Humanize then
		smoothness = smoothness * (0.9 + rng:NextNumber() * 0.2)
	end

	self:PointCamera(aimPosition, smoothness, config.Humanize)

	if debug then
		print("Tracking:", target.Character.Name, "Distance:", math.floor(target.ScreenDistance))
	end

	return target
end

return CameraDirector
