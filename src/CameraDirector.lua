--==============================================================================
-- CAMERA DIRECTOR
-- Smooth camera tracking toward prioritized, visible, alive targets.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Utility = require(script.Utility)

local CameraDirector = {}

-- Cached list of NPC ("bot") characters for the Target Bots mode. Scanning the
-- whole Workspace every frame is too expensive, so the list refreshes at most
-- every BOT_SCAN_INTERVAL seconds and the scan only runs while TargetBots is on.
local BOT_SCAN_INTERVAL = 0.5
local botCharacters = {}
local botScanAt = -math.huge

local function getBotCharacters()
	local now = os.clock()
	if now - botScanAt < BOT_SCAN_INTERVAL then
		return botCharacters
	end
	botScanAt = now

	table.clear(botCharacters)
	for _, descendant in ipairs(Workspace:GetDescendants()) do
		if descendant:IsA("Model")
			and descendant:FindFirstChildOfClass("Humanoid")
			and not Players:GetPlayerFromCharacter(descendant)
		then
			table.insert(botCharacters, descendant)
		end
	end
	return botCharacters
end

local Camera = Workspace.CurrentCamera
-- Random source for Humanize jitter (Random.new avoids reseeding the global RNG).
local cd_rng = Random.new()

-- Body regions map to the actual part names each rig type uses. Targeting picks a
-- region (a fixed one, or a weighted-random roll), then the first part that region
-- actually has on the target's character — so it works on both R15 and R6.
local REGION_PARTS = {
	Head = { "Head" },
	Torso = { "UpperTorso", "LowerTorso", "Torso", "HumanoidRootPart" },
	Arms = {
		"LeftHand", "RightHand",
		"LeftLowerArm", "RightLowerArm",
		"LeftUpperArm", "RightUpperArm",
		"Left Arm", "Right Arm",
	},
	Legs = {
		"LeftFoot", "RightFoot",
		"LeftLowerLeg", "RightLowerLeg",
		"LeftUpperLeg", "RightUpperLeg",
		"Left Leg", "Right Leg",
	},
}
local REGION_ORDER = { "Head", "Torso", "Arms", "Legs" }

local rng = Random.new()

local function pickPartFromRegion(character, region)
	local names = REGION_PARTS[region]
	if not names then
		return nil
	end
	for _, name in ipairs(names) do
		local part = character:FindFirstChild(name)
		if part and part:IsA("BasePart") then
			return part
		end
	end
	return nil
end

-- First available part across all regions, then any BasePart as a last resort.
local function pickAnyPart(character)
	for _, region in ipairs(REGION_ORDER) do
		local part = pickPartFromRegion(character, region)
		if part then
			return part
		end
	end
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			return descendant
		end
	end
	return nil
end

-- Stable reference part used to decide WHICH character to target, so the choice of
-- character never jitters with the weighted aim-part roll.
local function anchorPart(character)
	return character:FindFirstChild("Head")
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
		or pickAnyPart(character)
end

-- Weighted-random region using the 0-100 weights. Falls back to Head when every
-- weight is zero so tracking still does something sensible.
local function rollWeightedRegion(weights)
	local total = 0
	for _, region in ipairs(REGION_ORDER) do
		total = total + math.max(0, (weights and weights[region]) or 0)
	end
	if total <= 0 then
		return "Head"
	end
	local roll = rng:NextNumber() * total
	local acc = 0
	for _, region in ipairs(REGION_ORDER) do
		acc = acc + math.max(0, weights[region] or 0)
		if roll <= acc then
			return region
		end
	end
	return "Head"
end

local function getScreenDistance(worldPosition)
	local viewport, visible = Camera:WorldToViewportPoint(worldPosition)
	if not visible or viewport.Z < 0 then
		return math.huge
	end

	local screen = Vector2.new(viewport.X, viewport.Y)
	local center = Camera.ViewportSize / 2
	return (screen - center).Magnitude
end

local function isVisible(position, character)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character }

	local result = Workspace:Raycast(Camera.CFrame.Position, position - Camera.CFrame.Position, params)
	return not result or result.Instance:IsDescendantOf(character)
end

-- ===== FOV circle =============================================================
-- Drawn as a GUI ring instead of via the Drawing library. The old version checked
-- `type(Drawing) == "table"`, which is false on executors that expose Drawing as
-- userdata — so it silently never rendered. A ring works everywhere.
local FOV_RING_COLOR = Color3.fromRGB(132, 62, 190) -- matches the UI accent
local fovGui, fovRing, fovStroke

local function ensureFovRing()
	if fovRing and fovRing.Parent then
		return fovRing
	end

	fovGui = Instance.new("ScreenGui")
	fovGui.Name = "VanityGeneralFOV"
	fovGui.ResetOnSpawn = false
	fovGui.IgnoreGuiInset = true -- same space as Camera:WorldToViewportPoint
	fovGui.DisplayOrder = 998

	local ok = pcall(function()
		fovGui.Parent = Utility.getGuiParent()
	end)
	if not ok or not fovGui.Parent then
		fovGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	fovRing = Instance.new("Frame")
	fovRing.Name = "Ring"
	fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
	fovRing.Position = UDim2.fromScale(0.5, 0.5)
	fovRing.BackgroundTransparency = 1
	fovRing.BorderSizePixel = 0
	fovRing.Parent = fovGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = fovRing

	fovStroke = Instance.new("UIStroke")
	fovStroke.Thickness = 1.5
	fovStroke.Transparency = 0.2
	fovStroke.Color = FOV_RING_COLOR
	fovStroke.Parent = fovRing

	return fovRing
end

-- Sized straight off config.FOV, so the ring always shows the real targeting cone.
local function updateFovCircle(config)
	-- Independent of the aimbot: the circle shows whenever FOV Circle is ticked,
	-- so you can see and tune the cone with the aimbot switched off.
	local show = config.FOVCircle
	if not show then
		if fovRing then
			fovRing.Visible = false
		end
		return
	end

	local ring = ensureFovRing()
	if not ring then
		return
	end

	local diameter = math.max(0, config.FOV or 0) * 2
	ring.Size = UDim2.fromOffset(diameter, diameter)
	ring.Visible = true
end

local function destroyFovCircle()
	if fovGui then
		pcall(function()
			fovGui:Destroy()
		end)
	end
	fovGui, fovRing, fovStroke = nil, nil, nil
end

-- Builds a target table for a character if it currently passes every filter,
-- else nil. `player` is nil for bot (NPC) targets, so target.Player needs a
-- nil-check downstream.
local function evaluateCharacter(character, player, config)
	if not character then
		return nil
	end

	-- Team Check: never target teammates. Teamless players (Team == nil) stay
	-- targetable; bots (player == nil) are unaffected.
	if config.TeamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end

	local anchor = anchorPart(character)
	if not anchor then
		return nil
	end

	-- On-screen cone: how far from the crosshair the target may be, in pixels.
	local distance = getScreenDistance(anchor.Position)
	if distance >= (config.FOV or 200) then
		return nil
	end

	-- MaxDistance is a world-space range in studs (matches the UI's "m" label).
	local worldDistance = (anchor.Position - Camera.CFrame.Position).Magnitude
	if worldDistance > config.MaxDistance then
		return nil
	end

	if config.WallCheck and not isVisible(anchor.Position, character) then
		return nil
	end

	return { Player = player, Character = character, Anchor = anchor, ScreenDistance = distance }
end

-- Player wrapper around evaluateCharacter: rejects yourself and gone players.
local function evaluateTarget(player, config)
	if not player or player.Parent ~= Players or player == LocalPlayer then
		return nil
	end

	return evaluateCharacter(player.Character, player, config)
end

function CameraDirector:FindBestTarget(config)
	local best
	local bestDistance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		local candidate = evaluateTarget(player, config)
		if candidate and candidate.ScreenDistance < bestDistance then
			bestDistance = candidate.ScreenDistance
			best = candidate
		end
	end

	if config.TargetBots then
		for _, character in ipairs(getBotCharacters()) do
			local candidate = evaluateCharacter(character, nil, config)
			if candidate and candidate.ScreenDistance < bestDistance then
				bestDistance = candidate.ScreenDistance
				best = candidate
			end
		end
	end

	return best
end

-- How close to the crosshair (in pixels) somebody must be for the Target Display
-- to name them. Outside this the popup reads "UnKnown".
local LOOK_RADIUS = 50

-- Whoever you're LOOKING at, for the Target Display popup. Deliberately separate
-- from the aimbot's filters: no wall check (so people behind walls/floors still
-- register) and ranged by the ESP render distance rather than the aimbot's. Off-
-- screen players score math.huge from getScreenDistance, so they never win.
-- With Target Bots on NPCs count too; the popup then shows the model name.
function CameraDirector:GetLookTarget(espConfig, cameraConfig)
	local best
	local bestDistance = LOOK_RADIUS -- anything further from the crosshair is ignored

	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	local maxRange = (espConfig and espConfig.MaxDistance) or math.huge

	-- Scores one character; `result` is what the popup names (player or model).
	local function consider(character, result)
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local anchor = humanoid and humanoid.Health > 0 and anchorPart(character) or nil
		if not anchor then
			return
		end

		if myRoot and (anchor.Position - myRoot.Position).Magnitude > maxRange then
			return
		end

		local distance = getScreenDistance(anchor.Position)
		if distance <= bestDistance then
			bestDistance = distance
			best = result
		end
	end

	-- Team Check skips teammates; teamless players and bots stay eligible.
	local teamCheck = cameraConfig and cameraConfig.TeamCheck

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer
			and not (teamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team)
		then
			consider(player.Character, player)
		end
	end

	if cameraConfig and cameraConfig.TargetBots then
		for _, character in ipairs(getBotCharacters()) do
			consider(character, character)
		end
	end

	return best
end

-- Chooses the region to aim at. A specific Hitbox mode uses that region directly;
-- "Random (Weighted)" rolls once per acquired target and stays locked so the
-- camera doesn't jump between body parts every frame.
function CameraDirector:_resolveRegion(character, config)
	local mode = config.Hitbox

	if mode and mode ~= "Random (Weighted)" and REGION_PARTS[mode] then
		return mode
	end

	if self._lockedChar ~= character then
		self._lockedChar = character
		self._rolledRegion = rollWeightedRegion(config.TargetWeights)
	end
	return self._rolledRegion or "Head"
end

function CameraDirector:PointCamera(targetPosition, smoothness)
	local desired = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
	-- Lower Smoothness = harder lock. The slider is inverted into the lerp alpha,
	-- so a small value snaps onto the target and a large value eases in slowly.
	-- Floored at 0.02 so the smoothest setting still tracks instead of freezing.
	local alpha = math.clamp(1 - (smoothness or 0), 0.02, 1)
	Camera.CFrame = Camera.CFrame:Lerp(desired, alpha)
end

-- Update camera tracking. `debug` is the top-level Configuration.Debug flag
-- (it does not live inside the Camera config table).
function CameraDirector:Update(config, debug)
	Camera = Workspace.CurrentCamera
	updateFovCircle(config)

	if not config.Enabled then
		self._lockedChar = nil -- reset the weighted lock so re-enabling re-rolls
		self._stickyCharacter = nil
		self._stickyPlayer = nil
		self._currentTarget = nil
		return
	end

	if not Camera then
		return
	end

	-- Sticky target: stay on the current character while it still passes every
	-- filter, otherwise reacquire the best one. Stops the aim flicking between
	-- targets. Tracks the character (not just the player) so bot targets stick
	-- too; the player reference is kept only to detect a player leaving.
	local target
	if config.StickyTarget and self._stickyCharacter then
		if not self._stickyPlayer or self._stickyPlayer.Parent == Players then
			target = evaluateCharacter(self._stickyCharacter, self._stickyPlayer, config)
		end
	end
	if not target then
		target = self:FindBestTarget(config)
	end

	if not target then
		self._lockedChar = nil
		self._stickyCharacter = nil
		self._stickyPlayer = nil
		self._currentTarget = nil
		return
	end
	self._stickyCharacter = target.Character
	self._stickyPlayer = target.Player

	local region = self:_resolveRegion(target.Character, config)
	local aimPart = pickPartFromRegion(target.Character, region) or pickAnyPart(target.Character)
	if not aimPart then
		self._currentTarget = nil
		return
	end

	local aimPosition = aimPart.Position
	local worldDistance = (aimPosition - Camera.CFrame.Position).Magnitude

	-- Velocity lead. `worldDistance / 500` is a rough time-of-flight in seconds;
	-- game forks with real projectile speeds should override that divisor.
	if (config.Prediction or 0) > 0 then
		aimPosition = aimPosition + aimPart.AssemblyLinearVelocity * config.Prediction * (worldDistance / 500)
	end

	local smoothness = config.Smoothness
	if config.Humanize then
		-- Per-frame jitter: a slightly varying lerp alpha plus a sub-degree
		-- angular wobble (scaled to distance) so the aim path isn't a perfect line.
		smoothness = smoothness * (0.9 + cd_rng:NextNumber() * 0.2)
		aimPosition = aimPosition + cd_rng:NextUnitVector() * (worldDistance * math.rad(cd_rng:NextNumber() * 0.25))
	end

	self:PointCamera(aimPosition, smoothness)

	target.Part = aimPart
	target.Region = region
	self._currentTarget = target

	if debug then
		print("Tracking:", target.Character.Name, "Region:", region, "Distance:", math.floor(target.ScreenDistance))
	end

	return target
end

-- The aimbot's current lock (a target table like FindBestTarget returns), or
-- nil. Silent Aim reads this to redirect shots without moving the camera.
function CameraDirector:GetCurrentTarget()
	return self._currentTarget
end

function CameraDirector:Cleanup()
	self._lockedChar = nil
	self._stickyCharacter = nil
	self._stickyPlayer = nil
	self._currentTarget = nil
	destroyFovCircle()
end
CameraDirector.GetBotCharacters = getBotCharacters

return CameraDirector
