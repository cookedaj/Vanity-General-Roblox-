--==============================================================================
-- Vanity-General  —  single-file build
--
-- Usage (exploit / loadstring environments):
--     local VanityGeneral = loadstring(readfile("VanityGeneral.lua"))()
--     VanityGeneral.Start()
--     -- VanityGeneral.Stop()     to tear everything down
--     -- VanityGeneral.Toggle()   start/stop in one call
--
-- Keys once running:  RightShift = menu  |  LeftAlt = camera  |  End = unload
--
-- Re-running the script is safe: on load it stops any previous copy found in
-- getgenv() before installing itself, so you never stack duplicate windows,
-- render loops, or orphaned ESP highlights.
--
-- This is the bundled equivalent of the modular version (Configuration,
-- CameraDirector, ESP, UI, MainController). Each section below mirrors one
-- module; they only talk to each other through the controller at the bottom.
--==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

--==============================================================================
-- STRING OBFUSCATION v2.0
-- Advanced string encryption/obfuscation system with multi-level encryption,
-- secret objects, secret manager, vault system, audit logging, and statistics.
--==============================================================================

local StringObfuscation = {
	VERSION = "2.0",
	_stats = {
		encryptions = 0,
		decryptions = 0,
		secrets_created = 0,
		total_access_time = 0,
	},
	_audit_log = {},
	_max_audit_entries = 1000,
}

local KEY_PRIMARY = 0xAA
local KEY_SECONDARY = 0x55
local KEY_TERTIARY = 0xF3

local function _rotateKey(byte, position, level)
	level = level or 1
	if level == 1 then
		return bit32.band(KEY_PRIMARY + position, 0xFF)
	elseif level == 2 then
		return bit32.band(KEY_SECONDARY + position * 2, 0xFF)
	else
		return bit32.band(KEY_TERTIARY + position * 3, 0xFF)
	end
end

local function _simpleHash(str)
	local hash = 5381
	for i = 1, #str do
		local byte = string.byte(str, i)
		hash = bit32.band(hash * 33 + byte, 0xFFFFFFFF)
	end
	return hash
end

local function _addAuditEntry(action, secret_name, details)
	local entry = {
		timestamp = os.time(),
		action = action,
		name = secret_name,
		details = details,
	}
	table.insert(StringObfuscation._audit_log, entry)
	if #StringObfuscation._audit_log > StringObfuscation._max_audit_entries then
		table.remove(StringObfuscation._audit_log, 1)
	end
end

function StringObfuscation.encrypt(str, level)
	level = level or 1
	local encrypted = {}

	for i = 1, #str do
		local char = str:sub(i, i)
		local byte = string.byte(char)
		local key = _rotateKey(byte, i - 1, level)
		local obfuscated = bit32.bxor(byte, key)
		table.insert(encrypted, obfuscated)
	end

	StringObfuscation._stats.encryptions = StringObfuscation._stats.encryptions + 1
	return encrypted
end

function StringObfuscation.decrypt(encrypted, level)
	level = level or 1
	local decrypted = {}

	for i = 1, #encrypted do
		local obfuscated = encrypted[i]
		local key = _rotateKey(obfuscated, i - 1, level)
		local byte = bit32.bxor(obfuscated, key)
		table.insert(decrypted, string.char(byte))
	end

	StringObfuscation._stats.decryptions = StringObfuscation._stats.decryptions + 1
	return table.concat(decrypted)
end

function StringObfuscation.obfuscate(str, level)
	return StringObfuscation.encrypt(str, level or 1)
end

function StringObfuscation.deobfuscate(encrypted, level)
	return StringObfuscation.decrypt(encrypted, level or 1)
end

function StringObfuscation.batchEncrypt(strings, level)
	local results = {}
	for i, str in ipairs(strings) do
		results[i] = StringObfuscation.encrypt(str, level or 1)
	end
	return results
end

function StringObfuscation.batchDecrypt(encrypted_list, level)
	local results = {}
	for i, enc in ipairs(encrypted_list) do
		results[i] = StringObfuscation.decrypt(enc, level or 1)
	end
	return results
end

function StringObfuscation.makeSecret(str, name, level)
	level = level or 1
	name = name or ("secret_" .. tostring({}):match("0x%x+"))
	local encrypted = StringObfuscation.encrypt(str, level)
	local hash = _simpleHash(str)

	_addAuditEntry("secret_created", name, { level = level })
	StringObfuscation._stats.secrets_created = StringObfuscation._stats.secrets_created + 1

	local secret_meta = {
		_encrypted = encrypted,
		_decrypted = nil,
		_access_count = 0,
		_last_access = nil,
		_creation_time = os.time(),
		_name = name,
		_level = level,
		_hash = hash,
		_cleared = false,
		__tostring = function()
			return "[SECRET:" .. name .. "]"
		end,
		__index = function(self, key)
			if key == "value" then
				if self._cleared then
					warn("[StringObfuscation] Secret '" .. self._name .. "' was cleared and cannot be accessed")
					return nil
				end

				local start_time = os.clock()
				if not self._decrypted then
					self._decrypted = StringObfuscation.decrypt(self._encrypted, self._level)
				end

				self._access_count = self._access_count + 1
				self._last_access = os.time()

				local access_time = os.clock() - start_time
				StringObfuscation._stats.total_access_time = StringObfuscation._stats.total_access_time + access_time

				_addAuditEntry("secret_accessed", self._name, {
					access_num = self._access_count,
					access_time_ms = access_time * 1000,
				})

				return self._decrypted
			elseif key == "access_count" then
				return self._access_count
			elseif key == "last_access" then
				return self._last_access
			elseif key == "name" then
				return self._name
			elseif key == "level" then
				return self._level
			elseif key == "creation_time" then
				return self._creation_time
			elseif key == "age_seconds" then
				return os.time() - self._creation_time
			elseif key == "is_cleared" then
				return self._cleared
			end
			return rawget(self, key)
		end,
		__metatable = "[PROTECTED]"
	}

	return setmetatable({
		_encrypted = encrypted,
		_decrypted = nil,
		_access_count = 0,
		_last_access = nil,
		_creation_time = os.time(),
		_name = name,
		_level = level,
		_hash = hash,
		_cleared = false,
	}, secret_meta)
end

function StringObfuscation.clearSecret(secret)
	if type(secret) == "table" and secret._encrypted then
		secret._decrypted = nil
		secret._cleared = true
		_addAuditEntry("secret_cleared", secret._name, {})
		return true
	end
	return false
end

function StringObfuscation.verifySecret(secret, expected_hash)
	if not secret or not secret._hash then
		return false
	end
	if expected_hash then
		return secret._hash == expected_hash
	end
	return true
end

function StringObfuscation.revealSecret(secret)
	if type(secret) == "table" and secret._encrypted then
		return secret.value
	end
	return secret
end

function StringObfuscation.getStats()
	return {
		encryptions = StringObfuscation._stats.encryptions,
		decryptions = StringObfuscation._stats.decryptions,
		secrets_created = StringObfuscation._stats.secrets_created,
		total_access_time_ms = StringObfuscation._stats.total_access_time * 1000,
		audit_log_size = #StringObfuscation._audit_log,
	}
end

function StringObfuscation.getAuditLog(filter)
	filter = filter or {}
	local results = {}

	for _, entry in ipairs(StringObfuscation._audit_log) do
		local matches = true

		if filter.action and entry.action ~= filter.action then
			matches = false
		end
		if filter.name and entry.name ~= filter.name then
			matches = false
		end
		if filter.since and entry.timestamp < filter.since then
			matches = false
		end

		if matches then
			table.insert(results, entry)
		end
	end

	return results
end

function StringObfuscation.clearAuditLog()
	StringObfuscation._audit_log = {}
	return true
end

function StringObfuscation.createSecretManager()
	local manager = {
		_secrets = {},
		_names = {},
	}

	function manager:register(name, value, level)
		if self._names[name] then
			warn("[SecretManager] Secret '" .. name .. "' already registered")
			return nil
		end

		local secret = StringObfuscation.makeSecret(value, name, level)
		self._secrets[name] = secret
		self._names[name] = true
		return secret
	end

	function manager:get(name)
		if self._secrets[name] then
			return self._secrets[name].value
		end
		return nil
	end

	function manager:getSecret(name)
		return self._secrets[name]
	end

	function manager:list()
		local list = {}
		for name, secret in pairs(self._secrets) do
			table.insert(list, {
				name = name,
				accessed = secret.access_count,
				age = secret.age_seconds,
				cleared = secret.is_cleared,
			})
		end
		return list
	end

	function manager:clear(name)
		if self._secrets[name] then
			StringObfuscation.clearSecret(self._secrets[name])
			self._secrets[name] = nil
			self._names[name] = nil
			return true
		end
		return false
	end

	function manager:clearAll()
		for name in pairs(self._secrets) do
			self:clear(name)
		end
	end

	return manager
end

function StringObfuscation.createVault(password)
	local vault = {
		_password = StringObfuscation.makeSecret(password, "vault_password", 3),
		_secrets = {},
		_locked = true,
	}

	function vault:unlock(provided_password)
		if self._password.value == provided_password then
			self._locked = false
			_addAuditEntry("vault_unlocked", "vault", {})
			return true
		end
		_addAuditEntry("vault_unlock_failed", "vault", {})
		return false
	end

	function vault:lock()
		self._locked = true
		_addAuditEntry("vault_locked", "vault", {})
	end

	function vault:store(name, value, level)
		if self._locked then
			warn("[Vault] Vault is locked")
			return false
		end

		self._secrets[name] = StringObfuscation.makeSecret(value, name, level or 2)
		_addAuditEntry("vault_store", name, {})
		return true
	end

	function vault:retrieve(name)
		if self._locked then
			warn("[Vault] Vault is locked")
			return nil
		end

		if self._secrets[name] then
			_addAuditEntry("vault_retrieve", name, {})
			return self._secrets[name].value
		end
		return nil
	end

	function vault:getSecret(name)
		if self._locked then
			return nil
		end
		return self._secrets[name]
	end

	function vault:list()
		if self._locked then
			warn("[Vault] Vault is locked")
			return {}
		end

		local list = {}
		for name in pairs(self._secrets) do
			table.insert(list, name)
		end
		return list
	end

	function vault:delete(name)
		if self._locked then
			return false
		end

		if self._secrets[name] then
			StringObfuscation.clearSecret(self._secrets[name])
			self._secrets[name] = nil
			_addAuditEntry("vault_delete", name, {})
			return true
		end
		return false
	end

	return vault
end

-- Exploit-friendly GUI parent: prefer a hidden container, then CoreGui, then PlayerGui.
local function getGuiParent()
	local ok, hidden = pcall(function()
		return gethui and gethui()
	end)
	if ok and hidden then
		return hidden
	end

	local ok2, coreGui = pcall(function()
		return game:GetService("CoreGui")
	end)
	if ok2 and coreGui then
		return coreGui
	end

	return LocalPlayer:WaitForChild("PlayerGui")
end

--==============================================================================
-- CONFIGURATION
-- Centralized settings and single source of truth. Owns the default snapshot
-- so reset logic lives in exactly one place.
--==============================================================================

local Configuration = {}

Configuration.Camera = {
	Enabled = false,
	Smoothness = 0.15,
	MaxDistance = 300,
	TargetPart = "Head",
	TargetPartOptions = { "Head", "HumanoidRootPart", "UpperTorso", "Torso" },
	ToggleKey = Enum.KeyCode.LeftAlt, -- separate keybind for camera tracking
}

Configuration.ESP = {
	Enabled = false,
	Color = Color3.fromRGB(0, 170, 255),
	Filled = false,
	Thickness = 1,
	OutlineOpacity = 1,
	FillOpacity = 0.4,
	MaxDistance = 1000,
}

Configuration.UI = {
	Scale = 1,
	MenuKey = Enum.KeyCode.RightShift,
	UnloadKey = Enum.KeyCode.End, -- panic key: fully tears down and unloads
	Visible = false,
}

Configuration.Debug = false

-- Default tunables restored by reset(); keybinds/option lists are preserved.
local DEFAULTS = {
	Camera = { Enabled = false, Smoothness = 0.15, MaxDistance = 300, TargetPart = "Head" },
	ESP = {
		Enabled = false,
		Color = Color3.fromRGB(0, 170, 255),
		Filled = false,
		Thickness = 1,
		OutlineOpacity = 1,
		FillOpacity = 0.4,
		MaxDistance = 1000,
	},
	UI = { Scale = 1 },
}

function Configuration.reset()
	for section, values in pairs(DEFAULTS) do
		for key, value in pairs(values) do
			Configuration[section][key] = value
		end
	end
end

--==============================================================================
-- CAMERA DIRECTOR
-- Smooth camera tracking toward prioritized, visible, alive targets.
--==============================================================================

local CameraDirector = {}
local Camera = Workspace.CurrentCamera

-- Find a valid target part, preferring the configured part then the priority list.
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

-- 2D distance from viewport center; huge if behind camera or off-screen.
local function getScreenDistance(worldPosition)
	local viewport, visible = Camera:WorldToViewportPoint(worldPosition)
	if not visible or viewport.Z < 0 then
		return math.huge
	end

	local screen = Vector2.new(viewport.X, viewport.Y)
	local center = Camera.ViewportSize / 2
	return (screen - center).Magnitude
end

-- Raycast from camera to target; visible if nothing blocks or we hit the target.
local function isVisible(position, character)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character }

	local result = Workspace:Raycast(Camera.CFrame.Position, position - Camera.CFrame.Position, params)
	return not result or result.Instance:IsDescendantOf(character)
end

-- Closest-to-center, visible, alive target within max distance.
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

		local distance = getScreenDistance(part.Position)
		if distance < bestDistance and distance < config.MaxDistance and isVisible(part.Position, character) then
			bestDistance = distance
			best = { Player = player, Character = character, Part = part, ScreenDistance = distance }
		end
	end

	return best
end

function CameraDirector:PointCamera(targetPosition, smoothness)
	local desired = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
	Camera.CFrame = Camera.CFrame:Lerp(desired, smoothness)
end

function CameraDirector:Update(config)
	if not config.Enabled then
		return
	end

	-- Refresh cached camera in case CurrentCamera changed (respawn). The helper
	-- closures above share this upvalue, so one assignment updates all of them.
	Camera = Workspace.CurrentCamera
	if not Camera then
		return
	end

	local target = self:FindBestTarget(config)
	if not target then
		return
	end

	self:PointCamera(target.Part.Position, config.Smoothness)

	if config.Debug then
		print("Tracking:", target.Character.Name, "Distance:", math.floor(target.ScreenDistance))
	end

	return target
end

--==============================================================================
-- ESP
-- Player highlighting with outlines, optional fill, and shell-based thickness.
--==============================================================================

local ESP = {}
local entries = {}
local container
local shellFolder
local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop

local function isAlive(humanoid)
	return humanoid and humanoid.Health > 0
end

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

-- Clone a part for shell rendering (meshes preserved, everything else stripped).
local function cloneShellPart(src)
	local clone
	pcall(function()
		clone = src:Clone()
	end)
	if not clone then
		return nil
	end

	for _, child in ipairs(clone:GetChildren()) do
		if not child:IsA("DataModelMesh") then
			child:Destroy()
		end
	end

	clone.Anchored = true
	clone.CanCollide = false
	clone.CanQuery = false
	clone.CanTouch = false
	clone.Massless = true
	clone.CastShadow = false
	clone.Transparency = 1
	clone.Material = Enum.Material.SmoothPlastic
	return clone
end

local function updateShellSizes(entry)
	local scale = 1 + (entry.thickness - 1) * 0.04
	for _, link in ipairs(entry.links) do
		if link.clone and link.clone.Parent then
			link.clone.Size = link.base * scale
		end
	end
end

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
				table.insert(links, { clone = clone, src = descendant, base = descendant.Size })
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

local function updatePlayer(player, entry, config)
	local character = player.Character
	if not character then
		entry.hl.Enabled = false
		teardownShell(entry)
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not config.Enabled or not hrp or not isAlive(humanoid) then
		entry.hl.Enabled = false
		teardownShell(entry)
		return
	end

	-- Distance filter (measured from the local character's root)
	local myChar = LocalPlayer.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if myRoot and (hrp.Position - myRoot.Position).Magnitude > config.MaxDistance then
		entry.hl.Enabled = false
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

	-- Shell provides thicker outlines than a single Highlight can
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
end

local function addPlayer(player, defaultColor)
	if player == LocalPlayer or entries[player] then
		return
	end

	local color = defaultColor or Color3.fromRGB(0, 170, 255)
	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPOutline"
	highlight.Enabled = false
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.Parent = container

	entries[player] = {
		hl = highlight,
		shell = nil,
		shellHl = nil,
		links = nil,
		shellChar = nil,
		thickness = 1,
	}
end

local function removePlayer(player)
	local entry = entries[player]
	if not entry then
		return
	end

	teardownShell(entry)
	if entry.hl then
		entry.hl:Destroy()
	end
	entries[player] = nil
end

function ESP:Init()
	if container then
		return
	end

	container = Instance.new("Folder")
	container.Name = "VanityGeneralESP"

	local ok = pcall(function()
		container.Parent = getGuiParent()
	end)
	if not ok or not container.Parent then
		container.Parent = Workspace
	end

	for _, player in ipairs(Players:GetPlayers()) do
		addPlayer(player, Configuration.ESP.Color)
	end
end

function ESP:Update(config)
	for _, player in ipairs(Players:GetPlayers()) do
		if not entries[player] then
			addPlayer(player, config.Color)
		end
	end

	for player, entry in pairs(entries) do
		if player.Parent == Players then
			updatePlayer(player, entry, config)
		else
			removePlayer(player)
		end
	end
end

function ESP:OnPlayerAdded(player)
	addPlayer(player, Configuration.ESP.Color)
end

function ESP:OnPlayerRemoving(player)
	removePlayer(player)
end

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

--==============================================================================
-- UI
-- Modern tabbed interface with dark theme, smooth animations, and a
-- centralized input router so drag/slider handlers never leak connections.
--==============================================================================

local UI = {}

local COLORS = {
	bg = Color3.fromRGB(22, 22, 30),
	bar = Color3.fromRGB(30, 30, 42),
	row = Color3.fromRGB(34, 34, 48),
	rowHover = Color3.fromRGB(42, 42, 60),
	accent = Color3.fromRGB(0, 170, 255),
	off = Color3.fromRGB(70, 70, 88),
	text = Color3.fromRGB(235, 235, 245),
	textSub = Color3.fromRGB(150, 150, 170),
	danger = Color3.fromRGB(200, 50, 50),
}

local FADE_TIME = 0.18
local ANIM = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local gui
local mainWindow
local windowScale
local currentTab = "Camera"
local layoutOrder = 0
local visible = false

-- Centralized input routing: one InputChanged + one InputEnded connection total,
-- disconnected on Cleanup. Controls register callbacks instead of opening their own.
local uisConnections = {}
local moveHandlers = {}
local releaseHandlers = {}
local syncHandlers = {}

local targetLabel

-- Keybind capture state. When a keybind box is armed, the next key press is
-- consumed as its new binding. The controller checks UI:IsCapturingKey() so the
-- captured press never also fires a normal hotkey (e.g. rebinding to the menu
-- key must not toggle the menu on the same press).
local activeCapture -- { finish = fn, cancel = fn } or nil while a box is armed
local capturingKey = false

local function newInstance(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		inst[k] = v
	end
	return inst
end

local function nextOrder()
	layoutOrder = layoutOrder + 1
	return layoutOrder
end

local function isPointer(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

local function isMovement(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
end

local function startInputRouter()
	table.insert(uisConnections, UserInputService.InputChanged:Connect(function(input)
		if not isMovement(input) then
			return
		end
		for _, fn in ipairs(moveHandlers) do
			fn(input)
		end
	end))

	table.insert(uisConnections, UserInputService.InputEnded:Connect(function(input)
		if not isPointer(input) then
			return
		end
		for _, fn in ipairs(releaseHandlers) do
			fn(input)
		end
	end))

	-- Keybind capture: while a box is armed, the next keyboard press becomes its
	-- new binding (Escape cancels). Ignores gameProcessed so a focused control
	-- can't swallow the rebind.
	table.insert(uisConnections, UserInputService.InputBegan:Connect(function(input)
		if not activeCapture then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		local key = input.KeyCode
		if key == Enum.KeyCode.Unknown then
			return
		end
		if key == Enum.KeyCode.Escape then
			activeCapture.finish(nil)
		else
			activeCapture.finish(key)
		end
	end))
end

-- Animated on/off toggle
local function makeToggle(parent, text, getValue, onChange)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = " " .. text,
	})

	newInstance("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

	local pill = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(38, 18),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = pill, CornerRadius = UDim.new(1, 0) })

	local knob = newInstance("Frame", {
		Parent = pill,
		Size = UDim2.fromOffset(14, 14),
		Position = getValue() and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = knob, CornerRadius = UDim.new(1, 0) })

	local function refresh()
		local on = getValue()
		TweenService:Create(pill, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
		TweenService:Create(knob, ANIM, {
			Position = on and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		}):Play()
	end

	btn.MouseButton1Click:Connect(function()
		onChange()
		refresh()
	end)

	table.insert(syncHandlers, refresh)
end

-- Slider with a shared drag handler
local function makeSlider(parent, text, min, max, getValue, setValue, isInt)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	local label = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, -16, 0, 18),
		Position = UDim2.fromOffset(8, 3),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local track = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.new(1, -16, 0, 6),
		Position = UDim2.new(0, 8, 0, 26),
		BackgroundColor3 = COLORS.off,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) })

	local fill = newInstance("Frame", {
		Parent = track,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(1, 0) })

	local function format(v)
		return isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
	end

	local function apply(v)
		v = math.clamp(v, min, max)
		if isInt then
			v = math.floor(v + 0.5)
		end
		local alpha = (max > min) and (v - min) / (max - min) or 0
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		label.Text = text .. ": " .. format(v)
		setValue(v)
	end

	apply(getValue())

	local dragging = false

	local function fromInput(px)
		local alpha = math.clamp((px - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		apply(min + alpha * (max - min))
	end

	track.InputBegan:Connect(function(input)
		if isPointer(input) then
			dragging = true
			fromInput(input.Position.X)
		end
	end)

	table.insert(moveHandlers, function(input)
		if dragging then
			fromInput(input.Position.X)
		end
	end)

	table.insert(releaseHandlers, function()
		dragging = false
	end)

	table.insert(syncHandlers, function()
		apply(getValue())
	end)
end

-- Dropdown with animated expand/collapse
local function makeDropdown(parent, text, options, getValue, onChange)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.6, 0, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local dropdown = newInstance("TextButton", {
		Parent = holder,
		Size = UDim2.new(0.38, -8, 1, 0),
		Position = UDim2.new(0.6, 4, 0, 0),
		BackgroundColor3 = COLORS.off,
		BorderSizePixel = 0,
		Font = Enum.Font.Gotham,
		TextSize = 11,
		TextColor3 = COLORS.text,
		Text = getValue(),
		ZIndex = 3,
	})

	newInstance("UICorner", { Parent = dropdown, CornerRadius = UDim.new(0, 4) })

	local open = false
	local listSize = #options * 24

	local list = newInstance("Frame", {
		Parent = dropdown,
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.fromOffset(0, 30),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Visible = false,
		ZIndex = 10,
	})

	newInstance("UICorner", { Parent = list, CornerRadius = UDim.new(0, 4) })

	for i, option in ipairs(options) do
		local optionBtn = newInstance("TextButton", {
			Parent = list,
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.fromOffset(0, (i - 1) * 24),
			BackgroundColor3 = COLORS.off,
			BorderSizePixel = 0,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextColor3 = COLORS.text,
			Text = option,
			AutoButtonColor = false,
			ZIndex = 11,
		})

		optionBtn.MouseButton1Click:Connect(function()
			onChange(option)
			dropdown.Text = option
			open = false
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
			task.delay(FADE_TIME, function()
				if not open then
					list.Visible = false
				end
			end)
		end)

		optionBtn.MouseEnter:Connect(function()
			optionBtn.BackgroundColor3 = COLORS.rowHover
		end)

		optionBtn.MouseLeave:Connect(function()
			optionBtn.BackgroundColor3 = COLORS.off
		end)
	end

	dropdown.MouseButton1Click:Connect(function()
		open = not open
		if open then
			list.Visible = true
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, listSize) }):Play()
		else
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
			task.delay(FADE_TIME, function()
				if not open then
					list.Visible = false
				end
			end)
		end
	end)

	table.insert(syncHandlers, function()
		dropdown.Text = getValue()
	end)
end

-- HSV color picker
local function makeColorPicker(parent, getColor, setColor)
	local h, s, v = getColor():ToHSV()
	local SQ_W, SQ_H, HUE_W, GAP = 178, 120, 16, 8

	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, SQ_H + 52),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
	newInstance("UIPadding", {
		Parent = holder,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	local sq = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.fromOffset(SQ_W, SQ_H),
		BackgroundColor3 = Color3.fromHSV(h, 1, 1),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = sq, CornerRadius = UDim.new(0, 4) })

	local satLayer = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = satLayer,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1),
		}),
	})

	local valLayer = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = valLayer,
		Rotation = 90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0),
		}),
	})

	local svDot = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromOffset(10, 10),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
	})

	newInstance("UICorner", { Parent = svDot, CornerRadius = UDim.new(1, 0) })
	newInstance("UIStroke", { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })

	local hue = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.fromOffset(HUE_W, SQ_H),
		Position = UDim2.fromOffset(SQ_W + GAP, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = hue, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = hue,
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
		}),
	})

	local hueDot = newInstance("Frame", {
		Parent = hue,
		Size = UDim2.new(1, 4, 0, 4),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, h, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
	})

	newInstance("UIStroke", { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })

	local preview = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.fromOffset(22, 22),
		Position = UDim2.fromOffset(0, SQ_H + 6),
		BackgroundColor3 = getColor(),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = preview, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = preview, Color = COLORS.off, Thickness = 1 })

	local hexLabel = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, -30, 0, 22),
		Position = UDim2.fromOffset(30, SQ_H + 6),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "",
	})

	local function refresh(writeBack)
		local col = Color3.fromHSV(h, s, v)
		if writeBack ~= false then
			setColor(col)
		end
		sq.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		svDot.Position = UDim2.new(s, 0, 1 - v, 0)
		hueDot.Position = UDim2.new(0.5, 0, h, 0)
		preview.BackgroundColor3 = col

		local r = math.floor(col.R * 255 + 0.5)
		local g = math.floor(col.G * 255 + 0.5)
		local b = math.floor(col.B * 255 + 0.5)
		hexLabel.Text = string.format("#%02X%02X%02X\n(%d, %d, %d)", r, g, b, r, g, b)
	end

	refresh(false)

	local svDrag, hueDrag = false, false

	local function svFrom(px, py)
		s = math.clamp((px - sq.AbsolutePosition.X) / sq.AbsoluteSize.X, 0, 1)
		v = 1 - math.clamp((py - sq.AbsolutePosition.Y) / sq.AbsoluteSize.Y, 0, 1)
		refresh()
	end

	local function hueFrom(py)
		h = math.clamp((py - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
		refresh()
	end

	sq.InputBegan:Connect(function(input)
		if isPointer(input) then
			svDrag = true
			svFrom(input.Position.X, input.Position.Y)
		end
	end)

	hue.InputBegan:Connect(function(input)
		if isPointer(input) then
			hueDrag = true
			hueFrom(input.Position.Y)
		end
	end)

	table.insert(moveHandlers, function(input)
		if svDrag then
			svFrom(input.Position.X, input.Position.Y)
		end
		if hueDrag then
			hueFrom(input.Position.Y)
		end
	end)

	table.insert(releaseHandlers, function()
		svDrag, hueDrag = false, false
	end)

	table.insert(syncHandlers, function()
		h, s, v = getColor():ToHSV()
		refresh(false)
	end)
end

-- Read-only display row; returns the value label for live updates
local function makeLabel(parent, text, initialValue)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local value = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.48, -8, 1, 0),
		Position = UDim2.new(0.5, 4, 0, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = COLORS.accent,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = initialValue,
	})

	return value
end

-- Clickable keybind row: shows the current key in a box on the right. Click it to
-- arm capture ("Press a key…"), then the next key press rebinds it. Escape or a
-- second click cancels. `conflictCheck(key)` may return the name of another action
-- already using that key to reject the bind.
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = labelText,
	})

	local box = newInstance("TextButton", {
		Parent = holder,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -6, 0.5, 0),
		Size = UDim2.fromOffset(0, 22),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = COLORS.accent,
		Text = getKey().Name,
	})

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})
	newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(54, 22) })

	local listening = false

	local function refresh()
		if listening then
			box.Text = "Press a key…"
			box.TextColor3 = Color3.fromRGB(255, 255, 255)
			box.BackgroundColor3 = COLORS.accent
		else
			box.Text = getKey().Name
			box.TextColor3 = COLORS.accent
			box.BackgroundColor3 = COLORS.bar
		end
	end

	local capture = {}

	function capture.finish(key)
		listening = false
		activeCapture = nil
		-- Defer so the controller's InputBegan (same press) still sees capturing
		-- and skips its hotkey handling before we clear the flag.
		task.defer(function()
			capturingKey = false
		end)

		if key then
			local conflict = conflictCheck and conflictCheck(key)
			if conflict then
				UI:Notify(string.format("%s is already bound to %s", key.Name, conflict), 2.5)
			else
				setKey(key)
				UI:Notify(string.format("%s bound to %s", labelText, key.Name), 2)
			end
		end
		refresh()
	end

	function capture.cancel()
		listening = false
		refresh()
	end

	box.MouseButton1Click:Connect(function()
		if listening then
			-- Second click cancels.
			activeCapture = nil
			task.defer(function()
				capturingKey = false
			end)
			capture.cancel()
			return
		end
		-- Arming this box disarms any other listening box.
		if activeCapture then
			activeCapture.cancel()
		end
		activeCapture = capture
		capturingKey = true
		listening = true
		refresh()
	end)

	box.MouseEnter:Connect(function()
		if not listening then
			box.BackgroundColor3 = COLORS.rowHover
		end
	end)

	box.MouseLeave:Connect(function()
		if not listening then
			box.BackgroundColor3 = COLORS.bar
		end
	end)

	table.insert(syncHandlers, function()
		if activeCapture == capture then
			activeCapture = nil
			task.defer(function()
				capturingKey = false
			end)
			listening = false
		end
		refresh()
	end)
end

local function buildCameraTab(parent, config)
	layoutOrder = 0

	makeToggle(parent, "Camera Tracking", function()
		return config.Camera.Enabled
	end, function()
		config.Camera.Enabled = not config.Camera.Enabled
	end)

	makeSlider(parent, "Smoothness", 0.05, 1, function()
		return config.Camera.Smoothness
	end, function(val)
		config.Camera.Smoothness = val
	end, false)

	makeSlider(parent, "Max Distance", 100, 500, function()
		return config.Camera.MaxDistance
	end, function(val)
		config.Camera.MaxDistance = val
	end, true)

	makeDropdown(parent, "Target Part", config.Camera.TargetPartOptions, function()
		return config.Camera.TargetPart
	end, function(val)
		config.Camera.TargetPart = val
	end)

	targetLabel = makeLabel(parent, "Current Target", "None")
end

local function buildESPTab(parent, config)
	layoutOrder = 0

	makeToggle(parent, "ESP Enabled", function()
		return config.ESP.Enabled
	end, function()
		config.ESP.Enabled = not config.ESP.Enabled
	end)

	makeToggle(parent, "Filled", function()
		return config.ESP.Filled
	end, function()
		config.ESP.Filled = not config.ESP.Filled
	end)

	makeSlider(parent, "Thickness", 1, 6, function()
		return config.ESP.Thickness
	end, function(val)
		config.ESP.Thickness = val
	end, true)

	makeSlider(parent, "Outline Opacity", 0, 1, function()
		return config.ESP.OutlineOpacity
	end, function(val)
		config.ESP.OutlineOpacity = val
	end, false)

	makeSlider(parent, "Fill Opacity", 0, 1, function()
		return config.ESP.FillOpacity
	end, function(val)
		config.ESP.FillOpacity = val
	end, false)

	makeSlider(parent, "Max Distance", 100, 2000, function()
		return config.ESP.MaxDistance
	end, function(val)
		config.ESP.MaxDistance = val
	end, true)

	makeColorPicker(parent, function()
		return config.ESP.Color
	end, function(c)
		config.ESP.Color = c
	end)
end

local function buildSettingsTab(parent, config, resetCallback)
	layoutOrder = 0

	makeSlider(parent, "UI Scale", 0.8, 1.5, function()
		return config.UI.Scale
	end, function(val)
		config.UI.Scale = val
		if windowScale then
			windowScale.Scale = val
		end
	end, false)

	local resetBtn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.danger,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Text = "Reset Settings",
	})

	newInstance("UICorner", { Parent = resetBtn, CornerRadius = UDim.new(0, 6) })

	resetBtn.MouseButton1Click:Connect(function()
		resetCallback()
	end)

	resetBtn.MouseEnter:Connect(function()
		TweenService:Create(resetBtn, ANIM, { BackgroundColor3 = Color3.fromRGB(225, 65, 65) }):Play()
	end)

	resetBtn.MouseLeave:Connect(function()
		TweenService:Create(resetBtn, ANIM, { BackgroundColor3 = COLORS.danger }):Play()
	end)

	-- Rejects a key that's already bound to another action so one press can't
	-- trigger two hotkeys. Enum.KeyCode values are singletons, so == is safe.
	local function keyConflict(key, field)
		if field ~= "menu" and config.UI.MenuKey == key then
			return "Menu"
		end
		if field ~= "camera" and config.Camera.ToggleKey == key then
			return "Camera"
		end
		if field ~= "unload" and config.UI.UnloadKey == key then
			return "Unload"
		end
		return nil
	end

	makeKeybind(parent, "Menu Key", function()
		return config.UI.MenuKey
	end, function(key)
		config.UI.MenuKey = key
	end, function(key)
		return keyConflict(key, "menu")
	end)

	makeKeybind(parent, "Camera Key", function()
		return config.Camera.ToggleKey
	end, function(key)
		config.Camera.ToggleKey = key
	end, function(key)
		return keyConflict(key, "camera")
	end)

	makeKeybind(parent, "Unload Key", function()
		return config.UI.UnloadKey
	end, function(key)
		config.UI.UnloadKey = key
	end, function(key)
		return keyConflict(key, "unload")
	end)
end

local function setVisible(state)
	if not mainWindow or state == visible then
		return
	end
	visible = state

	if state then
		mainWindow.Visible = true
		mainWindow.GroupTransparency = 1
		TweenService:Create(mainWindow, TweenInfo.new(FADE_TIME), { GroupTransparency = 0 }):Play()
	else
		local tween = TweenService:Create(mainWindow, TweenInfo.new(FADE_TIME), { GroupTransparency = 1 })
		tween.Completed:Once(function()
			if not visible and mainWindow then
				mainWindow.Visible = false
			end
		end)
		tween:Play()
	end
end

function UI:Init(config, resetCallback)
	if gui then
		return
	end

	startInputRouter()

	gui = newInstance("ScreenGui", {
		Name = "VanityGeneralUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})

	local ok = pcall(function()
		gui.Parent = getGuiParent()
	end)
	if not ok or not gui.Parent then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	-- CanvasGroup lets us fade the whole window via GroupTransparency
	mainWindow = newInstance("CanvasGroup", {
		Parent = gui,
		Size = UDim2.fromOffset(240, 0),
		Position = UDim2.fromOffset(40, 120),
		BackgroundColor3 = COLORS.bg,
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.Y,
		GroupTransparency = 1,
		Visible = false,
	})

	windowScale = newInstance("UIScale", { Parent = mainWindow, Scale = config.UI.Scale })
	newInstance("UICorner", { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
	newInstance("UIListLayout", { Parent = mainWindow, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
	newInstance("UIPadding", {
		Parent = mainWindow,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local titleBar = newInstance("Frame", {
		Parent = mainWindow,
		LayoutOrder = 0,
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = titleBar, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = titleBar,
		Size = UDim2.new(1, -10, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "Vanity-General",
	})

	local dragging, dragStart, startPos

	titleBar.InputBegan:Connect(function(input)
		if isPointer(input) then
			dragging = true
			dragStart = input.Position
			startPos = mainWindow.Position
		end
	end)

	table.insert(moveHandlers, function(input)
		if dragging then
			local delta = input.Position - dragStart
			mainWindow.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	table.insert(releaseHandlers, function()
		dragging = false
	end)

	local tabContainer = newInstance("Frame", {
		Parent = mainWindow,
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = tabContainer, CornerRadius = UDim.new(0, 6) })
	newInstance("UIListLayout", {
		Parent = tabContainer,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 4),
	})
	newInstance("UIPadding", {
		Parent = tabContainer,
		PaddingTop = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		PaddingLeft = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 4),
	})

	local tabs = { "Camera", "ESP", "Settings" }
	local tabFrames = {}

	for i, tabName in ipairs(tabs) do
		local tabBtn = newInstance("TextButton", {
			Parent = tabContainer,
			LayoutOrder = i,
			Size = UDim2.new(0, 70, 1, 0),
			BackgroundColor3 = currentTab == tabName and COLORS.accent or COLORS.off,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = tabName,
		})

		newInstance("UICorner", { Parent = tabBtn, CornerRadius = UDim.new(0, 4) })

		local tabFrame = newInstance("Frame", {
			Parent = mainWindow,
			LayoutOrder = 1 + i,
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			Visible = currentTab == tabName,
		})

		newInstance("UIListLayout", { Parent = tabFrame, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })

		tabFrames[tabName] = { btn = tabBtn, frame = tabFrame }

		tabBtn.MouseButton1Click:Connect(function()
			currentTab = tabName
			for name, tab in pairs(tabFrames) do
				tab.frame.Visible = name == tabName
				TweenService:Create(tab.btn, ANIM, {
					BackgroundColor3 = name == tabName and COLORS.accent or COLORS.off,
				}):Play()
			end
		end)

		-- Hover lift for inactive tabs (the active tab stays accent).
		tabBtn.MouseEnter:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, ANIM, { BackgroundColor3 = COLORS.rowHover }):Play()
			end
		end)

		tabBtn.MouseLeave:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, ANIM, { BackgroundColor3 = COLORS.off }):Play()
			end
		end)
	end

	buildCameraTab(tabFrames["Camera"].frame, config)
	buildESPTab(tabFrames["ESP"].frame, config)
	buildSettingsTab(tabFrames["Settings"].frame, config, resetCallback)

	if config.UI.Visible then
		setVisible(true)
	end
end

function UI:Toggle()
	setVisible(not visible)
end

function UI:Show()
	setVisible(true)
end

function UI:Hide()
	setVisible(false)
end

function UI:SetCurrentTarget(name)
	if targetLabel then
		local text = name or "None"
		if targetLabel.Text ~= text then
			targetLabel.Text = text
		end
	end
end

function UI:SyncControls()
	for _, fn in ipairs(syncHandlers) do
		fn()
	end
end

-- True while a keybind box is armed and waiting for a key. The controller uses
-- this to skip its hotkey handling so the captured press isn't double-processed.
function UI:IsCapturingKey()
	return capturingKey
end

-- Transient top-of-screen toast. Executor consoles are often hidden, so this
-- gives a visible confirmation that the script loaded (and for other events).
function UI:Notify(text, duration)
	if not gui then
		return
	end
	duration = duration or 3

	local toast = newInstance("TextLabel", {
		Parent = gui,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 12),
		Size = UDim2.fromOffset(math.max(200, #text * 8 + 28), 34),
		BackgroundColor3 = COLORS.bar,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = COLORS.text,
		Text = text,
	})

	newInstance("UICorner", { Parent = toast, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })

	TweenService:Create(toast, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()

	task.delay(duration, function()
		if toast and toast.Parent then
			local out = TweenService:Create(toast, TweenInfo.new(0.3), {
				BackgroundTransparency = 1,
				TextTransparency = 1,
			})
			out.Completed:Once(function()
				if toast then
					toast:Destroy()
				end
			end)
			out:Play()
		end
	end)
end

function UI:Cleanup()
	for _, conn in ipairs(uisConnections) do
		conn:Disconnect()
	end
	table.clear(uisConnections)
	table.clear(moveHandlers)
	table.clear(releaseHandlers)
	table.clear(syncHandlers)

	activeCapture = nil
	capturingKey = false
	targetLabel = nil
	windowScale = nil

	if gui then
		gui:Destroy()
		gui = nil
		mainWindow = nil
	end
	visible = false
end

--==============================================================================
-- CONTROLLER  (public entry point)
-- Single RenderStepped loop drives ESP + Camera. Start()/Stop() manage lifecycle.
--==============================================================================

local VanityGeneral = {}
VanityGeneral.Version = "1.2.0"
VanityGeneral.Config = Configuration
VanityGeneral.StringObfuscation = StringObfuscation

local running = false
local connections = {}

function VanityGeneral.IsRunning()
	return running
end

function VanityGeneral.Start()
	if running then
		return VanityGeneral
	end
	running = true

	-- Init inside a pcall so a partial failure (missing service, executor quirk)
	-- doesn't leave half-built state wired to the render loop.
	local ok, err = pcall(function()
		ESP:Init()

		UI:Init(Configuration, function()
			Configuration.reset()
			UI:SyncControls()
		end)

		table.insert(connections, Players.PlayerAdded:Connect(function(player)
			ESP:OnPlayerAdded(player)
		end))

		table.insert(connections, Players.PlayerRemoving:Connect(function(player)
			ESP:OnPlayerRemoving(player)
		end))

		-- Menu key opens the UI; camera key toggles tracking; unload key tears down.
		table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return
			end

			-- A keybind box is armed: this press is a rebind, not a hotkey.
			if UI:IsCapturingKey() then
				return
			end

			if input.KeyCode == Configuration.UI.MenuKey then
				UI:Toggle()
			elseif input.KeyCode == Configuration.UI.UnloadKey then
				VanityGeneral.Stop()
			elseif input.KeyCode == Configuration.Camera.ToggleKey then
				Configuration.Camera.Enabled = not Configuration.Camera.Enabled
				UI:SyncControls()
			end
		end))

		-- Single RenderStepped loop for both systems
		table.insert(connections, RunService.RenderStepped:Connect(function()
			ESP:Update(Configuration.ESP)

			local target = CameraDirector:Update(Configuration.Camera)
			if Configuration.Camera.Enabled and target then
				UI:SetCurrentTarget(target.Player and target.Player.Name or target.Character.Name)
			else
				UI:SetCurrentTarget("None")
			end
		end))
	end)

	if not ok then
		warn("[Vanity-General] Failed to start:", err)
		VanityGeneral.Stop() -- running is still true here, so this fully tears down
		return VanityGeneral
	end

	UI:Notify(string.format("Vanity-General loaded  •  Press %s", Configuration.UI.MenuKey.Name), 4)

	print(string.format("[Vanity-General] Running (v%s with StringObfuscation v%s)", VanityGeneral.Version, StringObfuscation.VERSION))
	print(string.format("Menu: %s  |  Camera: %s  |  Unload: %s",
		Configuration.UI.MenuKey.Name,
		Configuration.Camera.ToggleKey.Name,
		Configuration.UI.UnloadKey.Name))

	return VanityGeneral
end

function VanityGeneral.Stop()
	if not running then
		return VanityGeneral
	end
	running = false

	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disconnect()
		end)
	end
	table.clear(connections)

	pcall(function()
		ESP:Cleanup()
	end)
	pcall(function()
		UI:Cleanup()
	end)

	print("[Vanity-General] Stopped")
	return VanityGeneral
end

-- Convenience: flip between running and stopped in one call.
function VanityGeneral.Toggle()
	if running then
		VanityGeneral.Stop()
	else
		VanityGeneral.Start()
	end
	return VanityGeneral
end

-- Aliases: Start/Stop ignore self, so dot- and colon-calls both work; add
-- lowercase names too for convenience (VanityGeneral.start() / VanityGeneral:stop()).
VanityGeneral.start = VanityGeneral.Start
VanityGeneral.stop = VanityGeneral.Stop
VanityGeneral.toggle = VanityGeneral.Toggle

-- Safe re-injection: if a previous copy is still running (common when the
-- script is executed again in an exploit environment), tear it down first so
-- we never stack duplicate windows, RenderStepped loops, or orphaned ESP.
if getgenv then
	local previous = getgenv().VanityGeneral
	if previous and previous ~= VanityGeneral and type(previous.Stop) == "function" then
		pcall(previous.Stop)
	end
	getgenv().VanityGeneral = VanityGeneral
end

return VanityGeneral
