--==============================================================================
-- ESP
-- Player highlighting with outlines, optional fill, boxes and head info tags.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Configuration = require(script.Configuration)
local Utility = require(script.Utility)
local Candidates = require(script.Candidates)
local Cloak = require(script.Cloak)

local ESP = {}
local entries = {}
local container
local boxGui -- ScreenGui holding the 2D boxes (Boxes mode)
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop

local function isAlive(humanoid)
	return humanoid and humanoid.Health > 0
end

-- The part to anchor ESP to, robust across rig types and custom NPCs.
local function espRootPart(character)
	local hum = character:FindFirstChildOfClass("Humanoid")
	return (hum and hum.RootPart)
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("Torso")
		or character:FindFirstChild("UpperTorso")
		or character.PrimaryPart
end

local function getBoxGui()
	if boxGui and boxGui.Parent then
		return boxGui
	end

	boxGui = Instance.new("ScreenGui")
	boxGui.Name = Cloak.RandomName() -- random: no "Vanity*" name to signature-scan
	boxGui.ResetOnSpawn = false
	boxGui.IgnoreGuiInset = true -- matches Camera:WorldToViewportPoint space
	boxGui.DisplayOrder = 996

	local ok = pcall(function()
		boxGui.Parent = Utility.getGuiParent()
	end)
	if not ok or not boxGui.Parent then
		boxGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end
	Cloak.Protect(boxGui)

	return boxGui
end

-- Screen-space box around a character. Unlike Highlight (which has no outline
-- width at all), a UIStroke has a real pixel Thickness, so this is what a
-- width-adjustable border would hang off. When a Candidates entry is passed
-- (player path), its precomputed projections are used instead of re-projecting.
local function updateBox(entry, character, config, cand)
	local cam = Workspace.CurrentCamera
	local root = cand and cand.RootPart or espRootPart(character)
	if not cam or not root or not entry.box then
		if entry.box then
			entry.box.Visible = false
		end
		return
	end

	local topV, onScreen, botV
	if cand then
		-- No RootPart this frame meant the provider skipped the projections.
		if not cand.TopScreen then
			entry.box.Visible = false
			return
		end
		topV, onScreen, botV = cand.TopScreen, cand.TopOnScreen, cand.BotScreen
	else
		local head = character:FindFirstChild("Head")
		local topWorld = head and (head.Position + Vector3.new(0, head.Size.Y, 0))
			or (root.Position + Vector3.new(0, 3, 0))
		local botWorld = root.Position - Vector3.new(0, 3.2, 0)

		topV, onScreen = cam:WorldToViewportPoint(topWorld)
		botV = cam:WorldToViewportPoint(botWorld)
	end
	if not onScreen or topV.Z <= 0 then
		entry.box.Visible = false
		return
	end

	local height = math.abs(botV.Y - topV.Y)
	local width = height * 0.62
	local cx = (topV.X + botV.X) * 0.5
	local cy = (topV.Y + botV.Y) * 0.5

	entry.box.Size = UDim2.fromOffset(width, height)
	entry.box.Position = UDim2.fromOffset(cx - width * 0.5, cy - height * 0.5)
	entry.box.BackgroundColor3 = config.FillColor
	entry.box.BackgroundTransparency = config.Filled and (1 - config.FillOpacity) or 1
	entry.boxStroke.Color = config.OutlineColor
	entry.boxStroke.Transparency = 1 - config.OutlineOpacity
	entry.box.Visible = true
end

-- Name tag: a BillboardGui parented straight to the head so it always renders
-- (a billboard inside a ScreenGui doesn't). Recreated on respawn since the old
-- one dies with the old head. Local-only, so it never replicates.
-- The head tag carries two stacked lines: the name and the distance. A
-- UIListLayout skips invisible lines, so either shows on its own (centered) or
-- both stack. Parented to the head so it always renders and dies with respawns.
local function makeInfoTag(entry, name, head, config)
	local tag = Instance.new("BillboardGui")
	tag.Name = Cloak.RandomName()
	tag.Size = UDim2.fromOffset(200, 46)
	tag.StudsOffset = Vector3.new(0, 2.7, 0)
	tag.AlwaysOnTop = true
	tag.Adornee = head
	tag.Parent = head
	-- Lives inside the character, the one place gethui can't hide it: this is
	-- the registration the game-side character scans get filtered against.
	Cloak.Protect(tag)

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromScale(1, 1)
	holder.Parent = tag

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Parent = holder

	local nameLbl = Instance.new("TextLabel")
	nameLbl.LayoutOrder = 1
	nameLbl.BackgroundTransparency = 1
	nameLbl.Size = UDim2.new(1, 0, 0, 16)
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextSize = 13
	nameLbl.TextColor3 = config.OutlineColor
	nameLbl.TextStrokeTransparency = 0.35 -- dark stroke so it reads anywhere
	nameLbl.Text = name
	nameLbl.Visible = false
	nameLbl.Parent = holder

	local distLbl = Instance.new("TextLabel")
	distLbl.LayoutOrder = 2
	distLbl.BackgroundTransparency = 1
	distLbl.Size = UDim2.new(1, 0, 0, 14)
	distLbl.Font = Enum.Font.Gotham
	distLbl.TextSize = 12
	distLbl.TextColor3 = config.OutlineColor
	distLbl.TextStrokeTransparency = 0.4
	distLbl.Text = ""
	distLbl.Visible = false
	distLbl.Parent = holder

	-- Health bar: thin back + fill under the text lines.
	local healthBack = Instance.new("Frame")
	healthBack.LayoutOrder = 3
	healthBack.BackgroundColor3 = Color3.fromRGB(15, 12, 20)
	healthBack.BackgroundTransparency = 0.3
	healthBack.BorderSizePixel = 0
	healthBack.Size = UDim2.new(0.55, 0, 0, 5)
	healthBack.Visible = false
	healthBack.Parent = holder
	newInstance("UICorner", { Parent = healthBack, CornerRadius = UDim.new(1, 0) })

	local healthFill = Instance.new("Frame")
	healthFill.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
	healthFill.BorderSizePixel = 0
	healthFill.Size = UDim2.fromScale(1, 1)
	healthFill.Parent = healthBack
	newInstance("UICorner", { Parent = healthFill, CornerRadius = UDim.new(1, 0) })

	entry.nameTag = tag
	entry.nameLabel = nameLbl
	entry.distanceLabel = distLbl
	entry.healthBack = healthBack
	entry.healthFill = healthFill
	entry.nameHead = head
end

local function updateInfoTag(name, entry, character, config, cand)
	local head = cand and (cand.Head or cand.HRP)
		or character:FindFirstChild("Head")
		or character:FindFirstChild("HumanoidRootPart")
	if not head then
		if entry.nameTag then
			entry.nameTag.Enabled = false
		end
		return
	end

	-- (Re)build if missing, destroyed with the old character, or the head changed.
	if not entry.nameTag or not entry.nameTag.Parent or entry.nameHead ~= head then
		if entry.nameTag then
			pcall(function()
				entry.nameTag:Destroy()
			end)
		end
		makeInfoTag(entry, name, head, config)
	end

	entry.nameLabel.TextColor3 = config.OutlineColor
	entry.nameLabel.Visible = config.Names or config.NameTags

	entry.distanceLabel.Visible = config.Distance or config.DistanceTags
	if entry.distanceLabel.Visible then
		entry.distanceLabel.TextColor3 = config.OutlineColor
		local myRootPos, hrp
		if cand then
			myRootPos, hrp = Candidates.LocalRootPos, cand.HRP
		else
			local myChar = LocalPlayer.Character
			local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
			myRootPos = myRoot and myRoot.Position
			hrp = character:FindFirstChild("HumanoidRootPart")
		end
		local d = (myRootPos and hrp) and math.floor((hrp.Position - myRootPos).Magnitude + 0.5) or 0
		entry.distanceLabel.Text = "[" .. d .. "m]"
	end

	entry.healthBack.Visible = config.HealthBars
	if config.HealthBars then
		local humanoid = cand and cand.Humanoid or character:FindFirstChildOfClass("Humanoid")
		local frac = humanoid and math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1) or 0
		entry.healthFill.Size = UDim2.fromScale(frac, 1)
		-- Red at low health, green at full.
		entry.healthFill.BackgroundColor3 = Color3.fromRGB(220, 60, 60):Lerp(Color3.fromRGB(80, 220, 100), frac)
	end

	entry.nameTag.Enabled = true
end

-- Hides everything this player owns (used on death, out of range, ESP off).
local function hidePlayer(entry)
	entry.hl.Enabled = false
	if entry.box then
		entry.box.Visible = false
	end
	if entry.nameTag then
		entry.nameTag.Enabled = false
	end
end

-- Draws one character (player OR npc) with the current ESP styles. `name` is what
-- the Names line shows. Any character-model with a HumanoidRootPart works here.
-- `cand` is the shared Candidates entry on the player path (nil for NPCs).
local function renderCharacter(entry, character, name, config, cand)
	-- The two styles are independent, so both can draw at once.
	if config.Outlines then
		if entry.hl.Adornee ~= character then
			entry.hl.Adornee = character
		end
		entry.hl.OutlineColor = config.OutlineColor
		entry.hl.FillColor = config.FillColor
		entry.hl.OutlineTransparency = 1 - config.OutlineOpacity
		entry.hl.FillTransparency = config.Filled and (1 - config.FillOpacity) or 1
		entry.hl.DepthMode = DEPTH
		entry.hl.Enabled = true
	else
		entry.hl.Enabled = false
	end

	if config.Boxes then
		updateBox(entry, character, config, cand)
	elseif entry.box then
		entry.box.Visible = false
	end

	if config.Names or config.Distance or config.NameTags or config.DistanceTags or config.HealthBars then
		updateInfoTag(name, entry, character, config, cand)
	elseif entry.nameTag then
		entry.nameTag.Enabled = false
	end
end

-- Distance from the local character to a part, in studs (nil root = 0).
local function distanceTo(part)
	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not myRoot or not part then
		return 0
	end
	return (part.Position - myRoot.Position).Magnitude
end

-- Player path: renders one Candidates entry. The pool guarantees a living
-- humanoid this frame, so only the ESP-specific gates (Enabled, HRP presence,
-- MaxDistance from the local character) are checked here.
local function updatePlayerCandidate(cand, entry, config)
	local hrp = cand.HRP
	if not config.Enabled or not hrp then
		hidePlayer(entry)
		return
	end

	-- distanceTo semantics preserved: 0 (never rejects) when the local root is gone.
	local myRootPos = Candidates.LocalRootPos
	local dist = myRootPos and (hrp.Position - myRootPos).Magnitude or 0
	if dist > config.MaxDistance then
		hidePlayer(entry)
		return
	end

	renderCharacter(entry, cand.Character, cand.Player.Name, config, cand)
end

-- Creates the instances one ESP target needs (highlight + box). Shared by
-- players and NPCs; the info tag is built lazily on the head later.
local function newEspEntry(color)
	color = color or Color3.fromRGB(165, 75, 255)

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPOutline"
	highlight.Enabled = false
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.Parent = container

	local box = Instance.new("Frame")
	box.Name = "ESPBox"
	box.BackgroundColor3 = color
	box.BackgroundTransparency = 1
	box.BorderSizePixel = 0
	box.Visible = false
	box.Parent = getBoxGui()

	local boxStroke = Instance.new("UIStroke")
	boxStroke.Color = color
	boxStroke.Thickness = 1
	boxStroke.Parent = box

	return { hl = highlight, box = box, boxStroke = boxStroke }
end

local function destroyEntry(entry)
	if entry.hl then
		entry.hl:Destroy()
	end
	if entry.box then
		entry.box:Destroy()
	end
	if entry.nameTag then
		pcall(function()
			entry.nameTag:Destroy()
		end)
	end
end

local function addPlayer(player, defaultColor)
	if player == LocalPlayer or entries[player] then
		return
	end
	entries[player] = newEspEntry(defaultColor)
end

local function removePlayer(player)
	local entry = entries[player]
	if not entry then
		return
	end
	destroyEntry(entry)
	entries[player] = nil
end

-- ===== NPC ESP =============================================================
-- "NPC" is defined game-agnostically: any Model in Workspace that has a
-- Humanoid but is NOT a player's character. Rescanned on a timer (a full
-- descendant walk is too heavy per-frame); rendered every frame like players.
local npcEntries = {} -- model -> entry
local lastNpcScan = 0
local NPC_SCAN_INTERVAL = 1 -- seconds between Workspace rescans

local function removeNPC(model)
	local entry = npcEntries[model]
	if not entry then
		return
	end
	destroyEntry(entry)
	npcEntries[model] = nil
end

local function rescanNPCs()
	local current = {}
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Humanoid") then
			local model = obj.Parent
			if
				model
				and model:IsA("Model")
				and model ~= LocalPlayer.Character
				and not Players:GetPlayerFromCharacter(model)
			then
				current[model] = true
				if not npcEntries[model] then
					npcEntries[model] = newEspEntry(Configuration.ESP.OutlineColor)
				end
			end
		end
	end

	-- Drop any we tracked that are gone or no longer qualify.
	for model in pairs(npcEntries) do
		if not current[model] or not model.Parent then
			removeNPC(model)
		end
	end
end

local function updateNPC(model, entry, config)
	local root = espRootPart(model)
	local humanoid = model:FindFirstChildOfClass("Humanoid")

	if not model.Parent or not root or not isAlive(humanoid) then
		hidePlayer(entry)
		return
	end
	if distanceTo(root) > config.MaxDistance then
		hidePlayer(entry)
		return
	end

	renderCharacter(entry, model, model.Name, config)
end

function ESP:Init()
	if container then
		return
	end

	container = Instance.new("Folder")
	container.Name = Cloak.RandomName()

	local ok = pcall(function()
		container.Parent = Utility.getGuiParent()
	end)
	if not ok or not container.Parent then
		container.Parent = Workspace
	end
	-- Covers the Highlight children too (the filter hides whole subtrees) and
	-- matters most on the Workspace fallback, where the game can scan it.
	Cloak.Protect(container)

	for _, player in ipairs(Players:GetPlayers()) do
		addPlayer(player, Configuration.ESP.OutlineColor)
	end
end

function ESP:Update(config)
	-- Players render from the shared per-frame candidate pool (resolved once by
	-- Candidates:Update). Anything tracked but absent from the pool this frame
	-- (dead, no character, no living humanoid) gets hidden; leavers are removed.
	local rendered = {}
	for _, cand in ipairs(Candidates:Get()) do
		local player = cand.Player
		if player then
			rendered[player] = true
			local entry = entries[player]
			if not entry then
				addPlayer(player, config.OutlineColor)
				entry = entries[player]
			end
			updatePlayerCandidate(cand, entry, config)
		end
	end

	for player, entry in pairs(entries) do
		if player.Parent ~= Players then
			removePlayer(player)
		elseif not rendered[player] then
			hidePlayer(entry)
		end
	end

	-- NPCs: rescan on a timer, render every frame. When off, drop them all.
	if config.Enabled and config.NPCs then
		if os.clock() - lastNpcScan >= NPC_SCAN_INTERVAL then
			lastNpcScan = os.clock()
			rescanNPCs()
		end
		for model, entry in pairs(npcEntries) do
			updateNPC(model, entry, config)
		end
	elseif next(npcEntries) then
		for model in pairs(npcEntries) do
			removeNPC(model)
		end
	end
end

function ESP:OnPlayerAdded(player)
	addPlayer(player, Configuration.ESP.OutlineColor)
end

function ESP:OnPlayerRemoving(player)
	removePlayer(player)
end

function ESP:Cleanup()
	for player in pairs(entries) do
		removePlayer(player)
	end
	for model in pairs(npcEntries) do
		removeNPC(model)
	end
	if container then
		container:Destroy()
		container = nil
	end
	if boxGui then
		boxGui:Destroy()
		boxGui = nil
	end
end

return ESP
