-- ESP Module
-- Player highlighting with outlines, fills, and billboard tags

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local ESP = {}
local entries = {}
local container
local shellFolder
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop

local function isAlive(humanoid)
	return humanoid and humanoid.Health > 0
end

-- Get or create shell folder in camera
local function getShellFolder()
	local cam = Workspace.CurrentCamera
	if not cam then
		return nil
	end

	if not shellFolder or shellFolder.Parent ~= cam then
		if shellFolder then
			shellFolder:Destroy()
		end
		shellFolder = Instance.new("Folder")
		shellFolder.Name = "VanityGeneralShells"
		shellFolder.Parent = cam
	end

	return shellFolder
end

-- Clone part for shell rendering (only meshes preserved)
local function cloneShellPart(src)
	local c
	pcall(function()
		c = src:Clone()
	end)
	if not c then
		return nil
	end

	for _, child in ipairs(c:GetChildren()) do
		if not child:IsA("DataModelMesh") then
			child:Destroy()
		end
	end

	c.Anchored = true
	c.CanCollide = false
	c.CanQuery = false
	c.CanTouch = false
	c.Massless = true
	c.CastShadow = false
	c.Transparency = 1
	c.Material = Enum.Material.SmoothPlastic

	return c
end

-- Update shell sizes based on thickness
local function updateShellSizes(entry)
	local scale = 1 + (entry.thickness - 1) * 0.04
	for _, link in ipairs(entry.links) do
		if link.clone and link.clone.Parent then
			link.clone.Size = link.base * scale
		end
	end
end

-- Cleanup shell resources
local function teardownShell(entry)
	if entry.shell then
		entry.shell:Destroy()
		entry.shell = nil
	end
	if entry.shellHl then
		entry.shellHl:Destroy()
		entry.shellHl = nil
	end
	entry.links = nil
	entry.shellChar = nil
	entry.thickness = 1
end

-- Build shell for thick outlines
local function buildShell(entry, character, thickness)
	teardownShell(entry)

	local folder = getShellFolder()
	if not folder then
		return
	end

	local shell = Instance.new("Model")
	shell.Name = "Shell"
	shell.Parent = folder

	local links = {}
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			local clone = cloneShellPart(descendant)
			if clone then
				clone.CFrame = descendant.CFrame
				clone.Parent = shell
				table.insert(links, {
					clone = clone,
					src = descendant,
					base = descendant.Size,
				})
			end
		end
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ShellHighlight"
	highlight.FillTransparency = 1
	highlight.DepthMode = DEPTH
	highlight.Adornee = shell
	highlight.Parent = container

	entry.shell = shell
	entry.shellHl = highlight
	entry.links = links
	entry.shellChar = character
	entry.thickness = thickness

	updateShellSizes(entry)
end

-- Sync shell to current character positions
local function syncShell(entry)
	if not entry.links then
		return
	end

	for _, link in ipairs(entry.links) do
		if link.src and link.src.Parent then
			link.clone.CFrame = link.src.CFrame
		end
	end
end

-- Update highlight for one player
local function updatePlayer(player, entry, config)
	local character = player.Character
	if not character then
		entry.hl.Enabled = false
		entry.tag.Enabled = false
		teardownShell(entry)
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not config.Enabled or not hrp or not isAlive(humanoid) then
		entry.hl.Enabled = false
		entry.tag.Enabled = false
		teardownShell(entry)
		return
	end

	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if myRoot and (hrp.Position - myRoot.Position).Magnitude > config.MaxDistance then
		entry.hl.Enabled = false
		entry.tag.Enabled = false
		teardownShell(entry)
		return
	end

	local col = config.Color
	local outlineTransparency = 1 - config.OutlineOpacity

	if entry.hl.Adornee ~= character then
		entry.hl.Adornee = character
	end

	entry.hl.OutlineColor = col
	entry.hl.FillColor = col
	entry.hl.OutlineTransparency = outlineTransparency
	entry.hl.FillTransparency = config.Filled and (1 - config.FillOpacity) or 1
	entry.hl.DepthMode = DEPTH
	entry.hl.Enabled = true

	-- Build/update shell for thick outlines
	if config.Thickness > 1 then
		if entry.shellChar ~= character or not entry.shell then
			buildShell(entry, character, config.Thickness)
		end

		if entry.shell then
			if entry.thickness ~= config.Thickness then
				entry.thickness = config.Thickness
				updateShellSizes(entry)
			end

			syncShell(entry)
			entry.shellHl.OutlineColor = col
			entry.shellHl.OutlineTransparency = outlineTransparency
			entry.shellHl.FillTransparency = 1
			entry.shellHl.DepthMode = DEPTH
			entry.shellHl.Enabled = true
		end
	else
		teardownShell(entry)
	end

	-- Billboard tag: adorn to the head and compose the text from whichever tag
	-- toggles are on. Range/enabled culling above already hid it when out of
	-- view, so reaching here means the player is ESP-visible.
	local head = character:FindFirstChild("Head")
	if head and (config.NameTags or config.HealthBars or config.DistanceTags) then
		if entry.tag.Adornee ~= head then
			entry.tag.Adornee = head
		end

		local lines = {}
		if config.NameTags then
			table.insert(lines, player.Name)
		end

		local info = {}
		if config.HealthBars then
			table.insert(info, tostring(math.floor(humanoid.Health)))
		end
		if config.DistanceTags then
			local camera = Workspace.CurrentCamera
			if camera then
				table.insert(info, string.format("%dm", (hrp.Position - camera.CFrame.Position).Magnitude))
			end
		end
		if #info > 0 then
			table.insert(lines, table.concat(info, " | "))
		end

		entry.tagLabel.Text = table.concat(lines, "\n")
		entry.tag.Enabled = true
	else
		entry.tag.Enabled = false
	end
end

-- Add player to ESP tracking
local function addPlayer(player, defaultColor)
	if player == LocalPlayer or entries[player] then
		return
	end

	local color = defaultColor or Color3.fromRGB(165, 75, 255)
	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPOutline"
	highlight.Enabled = false
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.Parent = container

	-- Billboard tag above the head; name/health/distance text is composed per
	-- Update depending on which tag toggles are on
	local tag = Instance.new("BillboardGui")
	tag.Name = "ESPTag"
	tag.Size = UDim2.new(4, 0, 1, 0)
	tag.StudsOffsetWorldSpace = Vector3.new(0, 2.5, 0)
	tag.AlwaysOnTop = true
	tag.Enabled = false
	tag.Parent = container

	local tagLabel = Instance.new("TextLabel")
	tagLabel.Size = UDim2.fromScale(1, 1)
	tagLabel.BackgroundTransparency = 1
	tagLabel.Font = Enum.Font.GothamBold
	tagLabel.TextSize = 12
	tagLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tagLabel.TextStrokeTransparency = 0.5
	tagLabel.Parent = tag

	entries[player] = {
		hl = highlight,
		tag = tag,
		tagLabel = tagLabel,
		shell = nil,
		shellHl = nil,
		links = nil,
		shellChar = nil,
		thickness = 1,
	}
end

-- Remove player from ESP tracking
local function removePlayer(player)
	local entry = entries[player]
	if not entry then
		return
	end

	teardownShell(entry)
	if entry.hl then
		entry.hl:Destroy()
	end
	if entry.tag then
		entry.tag:Destroy()
	end

	entries[player] = nil
end

-- Initialize ESP system
function ESP:Init()
	if container then
		return
	end

	container = Instance.new("Folder")
	container.Name = "VanityGeneralESP"

	pcall(function()
		local gui = Players.LocalPlayer:WaitForChild("PlayerGui", 5)
		if gui then
			container.Parent = gui
		end
	end)

	if not container.Parent then
		container.Parent = Workspace
	end

	-- Track all current players
	for _, player in ipairs(Players:GetPlayers()) do
		addPlayer(player)
	end
end

-- Clean up ESP system
function ESP:Cleanup()
	for player in pairs(entries) do
		removePlayer(player)
	end

	if container then
		container:Destroy()
		container = nil
	end

	if shellFolder then
		shellFolder:Destroy()
		shellFolder = nil
	end
end

-- Update ESP display
function ESP:Update(config)
	-- Add any new players
	for _, player in ipairs(Players:GetPlayers()) do
		if not entries[player] then
			addPlayer(player, config.Color)
		end
	end

	-- Update all player highlights
	for player, entry in pairs(entries) do
		if player.Parent == Players then
			updatePlayer(player, entry, config)
		else
			removePlayer(player)
		end
	end
end

-- Handle player joining
function ESP:OnPlayerAdded(player)
	addPlayer(player)
end

-- Handle player leaving
function ESP:OnPlayerRemoving(player)
	removePlayer(player)
end

return ESP
