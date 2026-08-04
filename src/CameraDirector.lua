--==============================================================================
-- CAMERA DIRECTOR
-- Smooth camera tracking toward prioritized, visible, alive targets.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Utility = require(script.Utility)
local Candidates = require(script.Candidates)
local Cloak = require(script.Cloak)

local CameraDirector = {}

local Camera = Workspace.CurrentCamera

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
	fovGui.Name = Cloak.RandomName()
	fovGui.ResetOnSpawn = false
	fovGui.IgnoreGuiInset = true -- same space as Camera:WorldToViewportPoint
	fovGui.DisplayOrder = 998

	local ok = pcall(function()
		fovGui.Parent = Utility.getGuiParent()
	end)
	if not ok or not fovGui.Parent then
		fovGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end
	Cloak.Protect(fovGui)

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

-- Pixel distance from the crosshair, reading the candidate's precomputed
-- projection instead of calling WorldToViewportPoint again.
local function screenDistance(cand)
	if not cand.AnchorOnScreen or cand.AnchorScreen.Z < 0 then
		return math.huge
	end

	local screen = Vector2.new(cand.AnchorScreen.X, cand.AnchorScreen.Y)
	local center = Camera.ViewportSize / 2
	return (screen - center).Magnitude
end

-- Candidate-pool filters: Team Check, FOV cone, world-space MaxDistance and
-- WallCheck raycast, reusing the parts, distance and projection Candidates
-- resolved once this frame. The pool only holds living humanoids, so the
-- alive check is implied.
local function evaluateCandidate(cand, config)
	local player = cand.Player
	if config.TeamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team then
		return nil
	end

	local anchor = cand.Anchor
	if not anchor then
		return nil
	end

	local distance = screenDistance(cand)
	if distance >= (config.FOV or 200) then
		return nil
	end

	if (cand.WorldDistance or math.huge) > config.MaxDistance then
		return nil
	end

	if config.WallCheck and not isVisible(anchor.Position, cand.Character) then
		return nil
	end

	return { Player = player, Character = cand.Character, Anchor = anchor, ScreenDistance = distance }
end

function CameraDirector:FindBestTarget(config)
	local best
	local bestDistance = math.huge

	for _, cand in ipairs(Candidates:Get()) do
		local candidate = evaluateCandidate(cand, config)
		if candidate and candidate.ScreenDistance < bestDistance then
			bestDistance = candidate.ScreenDistance
			best = candidate
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
-- screen players score math.huge from screenDistance, so they never win.
-- With Target Bots on NPCs count too (they're in the pool then); the popup then
-- shows the model name.
function CameraDirector:GetLookTarget(espConfig, cameraConfig)
	local best
	local bestDistance = LOOK_RADIUS -- anything further from the crosshair is ignored

	local myRootPos = Candidates.LocalRootPos
	local maxRange = (espConfig and espConfig.MaxDistance) or math.huge

	-- Team Check skips teammates; teamless players and bots stay eligible.
	local teamCheck = cameraConfig and cameraConfig.TeamCheck

	for _, cand in ipairs(Candidates:Get()) do
		local player = cand.Player
		if not (teamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team) then
			local anchor = cand.Anchor
			if anchor and not (myRootPos and (anchor.Position - myRootPos).Magnitude > maxRange) then
				local distance = screenDistance(cand)
				if distance <= bestDistance then
					bestDistance = distance
					best = player or cand.Character -- bots name their model
				end
			end
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
		self._currentTarget = nil
		return
	end

	if not Camera then
		return
	end

	local target = self:FindBestTarget(config)

	if not target then
		self._lockedChar = nil
		self._currentTarget = nil
		return
	end

	local region = self:_resolveRegion(target.Character, config)
	local aimPart = pickPartFromRegion(target.Character, region) or pickAnyPart(target.Character)
	if not aimPart then
		self._currentTarget = nil
		return
	end

	self:PointCamera(aimPart.Position, config.Smoothness)

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
	self._currentTarget = nil
	destroyFovCircle()
end
-- The bot cache moved to Candidates (the shared per-frame provider); the
-- exported name is kept for compatibility.
CameraDirector.GetBotCharacters = Candidates.GetBotCharacters

return CameraDirector
