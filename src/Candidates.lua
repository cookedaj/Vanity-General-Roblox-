--==============================================================================
-- CANDIDATES
-- Shared per-frame candidate pool. CameraDirector, ESP, DrawingESP and Hitbox
-- used to walk Players:GetPlayers() independently and repeat the same work
-- (humanoid lookups, part resolution, world distance, viewport projections)
-- several times per frame. Candidates:Update runs ONCE per frame (the
-- controller calls it before the other subsystems) and resolves everything
-- shared; consumers read Candidates:Get() and apply only their own filters
-- (team check, FOV, wall-check raycasts) on top.
--
-- Entry fields:
--   Player        -- nil for bots (NPCs)
--   Character     -- the model
--   Humanoid      -- guaranteed alive this frame
--   Head          -- FindFirstChild("Head"), may be nil
--   RootPart      -- ESP's chain: humanoid.RootPart, HRP, Torso, UpperTorso, PrimaryPart
--   HRP           -- literal HumanoidRootPart child, may be nil
--   Anchor        -- CameraDirector's chain: Head, HRP, UpperTorso, Torso, any part
--   WorldDistance -- anchor-to-camera distance in studs (nil when no anchor)
--   AnchorScreen / AnchorOnScreen -- viewport projection of the anchor
--   TopScreen / TopOnScreen / BotScreen -- box projections (nil when no RootPart)
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local Candidates = {}

-- Position of the local character's root this frame (nil when unavailable).
-- Consumers that range-check from the local character read this instead of
-- re-resolving it per call.
Candidates.LocalRootPos = nil

local frame = {}

-- ===== Bot cache =============================================================
-- Moved here from CameraDirector so this provider can include bots without a
-- require cycle. Scanning the whole Workspace every frame is too expensive, so
-- the list refreshes at most every BOT_SCAN_INTERVAL seconds and the scan only
-- runs while TargetBots is on. CameraDirector.GetBotCharacters delegates here.
local botCharacters = {}
local botModels = {} -- [model] = true, for fast lookup

local function onDescendantAdded(descendant)
	if not descendant:IsA("Model") then
		return
	end
	-- Defer so the Humanoid has time to parent in.
	task.defer(function()
		if descendant.Parent
			and descendant:FindFirstChildOfClass("Humanoid")
			and not Players:GetPlayerFromCharacter(descendant)
		then
			if not botModels[descendant] then
				botModels[descendant] = true
				table.insert(botCharacters, descendant)
			end
		end
	end)
end

local function onDescendantRemoving(descendant)
	if botModels[descendant] then
		botModels[descendant] = nil
		for i = #botCharacters, 1, -1 do
			if botCharacters[i] == descendant then
				table.remove(botCharacters, i)
				break
			end
		end
	end
end

-- Warm-start: one-time scan of existing descendants, then event-driven.
local botInitDone = false
function Candidates.GetBotCharacters()
	if not botInitDone then
		botInitDone = true
		for _, descendant in ipairs(Workspace:GetDescendants()) do
			onDescendantAdded(descendant)
		end
		Workspace.DescendantAdded:Connect(onDescendantAdded)
		Workspace.DescendantRemoving:Connect(onDescendantRemoving)
	end
	return botCharacters
end

-- ===== Part resolution (mirrors the consumers' original chains exactly) ======

-- ESP's anchor part, robust across rig types and custom NPCs.
local function rootPartOf(character, humanoid)
	return humanoid.RootPart
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("Torso")
		or character:FindFirstChild("UpperTorso")
		or character.PrimaryPart
end

-- CameraDirector's region tables, duplicated so the Anchor chain resolves
-- exactly like its anchorPart/pickAnyPart did.
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

-- CameraDirector's targeting reference: Head first so the choice never jitters.
local function anchorOf(character, head, hrp)
	return head
		or hrp
		or character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
		or pickAnyPart(character)
end

-- ===== Frame build ===========================================================

local function buildEntry(character, player, cam, camPos)
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end

	local head = character:FindFirstChild("Head")
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local rootPart = rootPartOf(character, humanoid)
	local anchor = anchorOf(character, head, hrp)

	local entry = {
		Player = player,
		Character = character,
		Humanoid = humanoid,
		Head = head,
		RootPart = rootPart,
		HRP = hrp,
		Anchor = anchor,
	}

	if anchor then
		entry.WorldDistance = (anchor.Position - camPos).Magnitude
		local sv, vis = cam:WorldToViewportPoint(anchor.Position)
		entry.AnchorScreen = sv
		entry.AnchorOnScreen = vis
	end

	-- Box projections, same formulas ESP and DrawingESP used per consumer.
	if rootPart then
		local topWorld = head and (head.Position + Vector3.new(0, head.Size.Y, 0))
			or (rootPart.Position + Vector3.new(0, 3, 0))
		local tv, tvis = cam:WorldToViewportPoint(topWorld)
		entry.TopScreen = tv
		entry.TopOnScreen = tvis
		entry.BotScreen = cam:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3.2, 0))
	end

	return entry
end

-- Rebuilds the pool for this frame. Called once per frame by the controller
-- BEFORE the other subsystems' Update calls. espConfig is accepted for
-- symmetry/future use; the pool itself applies no filters beyond "alive".
function Candidates:Update(cameraConfig, espConfig)
	table.clear(frame)

	local cam = Workspace.CurrentCamera

	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	Candidates.LocalRootPos = myRoot and myRoot.Position or nil

	if not cam then
		return
	end
	local camPos = cam.CFrame.Position

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local entry = buildEntry(player.Character, player, cam, camPos)
			if entry then
				table.insert(frame, entry)
			end
		end
	end

	-- Bots join the pool only while Target Bots is on (the same gate the
	-- consumers used; the scan itself is throttled inside GetBotCharacters).
	if cameraConfig and cameraConfig.TargetBots then
		for _, character in ipairs(Candidates.GetBotCharacters()) do
			local entry = buildEntry(character, nil, cam, camPos)
			if entry then
				table.insert(frame, entry)
			end
		end
	end
end

-- The cached list for this frame. Entries are fresh tables each frame, so
-- consumers may annotate them but must not hold them across frames.
function Candidates:Get()
	return frame
end

-- Exported for CameraDirector (eliminates duplication between modules).
Candidates.REGION_PARTS = REGION_PARTS
Candidates.REGION_ORDER = REGION_ORDER
Candidates.pickPartFromRegion = pickPartFromRegion
Candidates.pickAnyPart = pickAnyPart

return Candidates
