--==============================================================================
-- VANITY-GENERAL - FULLY INTEGRATED BUILD
-- GENERATED FILE - do not edit. Edit src/ and re-run tools/build.py.
--
-- Usage:
--   local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
--   VanityGeneral.Start()
--   -- VanityGeneral.Stop() to tear down
--   -- VanityGeneral.Toggle() to toggle start/stop
--
-- Keys: RightShift = menu | LeftAlt = camera tracking | End = unload
--==============================================================================

-- Module tables (hoisted so every section can reference any module)
local Cloak
local Configuration
local ConfigManager
local Utility
local Candidates
local CameraDirector
local ESP
local DrawingESP
local Visuals
local Webhook
local Triggerbot
local SilentAim
local Hitbox
local NoRecoil
local NoSpread
local UI
local Movement
local Controller

--============================================================================
-- CLOAK
--============================================================================
Cloak = (function()
	--==============================================================================
	-- CLOAK
	-- Keeps the script out of a game's environment integrity checks:
	--  * The getgenv().VanityGeneral export is served through a metatable __index
	--    instead of a raw key, so pairs(getgenv()) enumerations never see it.
	--  * Instances the script creates are registered via Protect(); when the GAME
	--    (not one of our threads) calls GetChildren/GetDescendants/FindFirstChild*,
	--    the results are filtered of registered instances and their descendants.
	--    This is what hides the head BillboardGui tags, which live inside player
	--    characters and are otherwise visible to any character scan.
	--  * RandomName() gives DataModel objects throwaway names, so nothing carries
	--    a "Vanity*" string for name-signature scans.
	-- Everything is best-effort: without hookmetamethod/checkcaller the filters
	-- simply never install, and the script behaves exactly as before.
	--==============================================================================

	local Cloak = {}

	-- Seed the RNG so RandomName() produces non-deterministic output.
	pcall(function() math.randomseed(os.time()) end)

	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")
	local LocalPlayer = Players.LocalPlayer

	-- Weak keys: destroyed instances (ESP entries churn on respawn/leave) drop out
	-- of the set on their own once collected.
	local protected = setmetatable({}, { __mode = "k" })
	local protectedCount = 0
	local protecting = false -- re-entry guard, see Protect()

	-- Values served through the getgenv metatable. A re-execution wraps the
	-- previous chunk's __index, so a name only the OLD copy set still resolves
	-- (this is how Main finds the previous Controller to stop it).
	local hiddenGlobals = {}

	local NAME_CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

	function Cloak.RandomName(length)
		length = length or 14
		local out = {}
		for i = 1, length do
			local n = math.random(1, #NAME_CHARS)
			out[i] = string.sub(NAME_CHARS, n, n)
		end
		return table.concat(out)
	end

	-- Wraps a hook replacement so it presents as a C function: islclosure() is
	-- false, debug.getinfo shows no Lua source, string.dump fails, and no Lua
	-- frames appear in a game's debug.traceback — the same profile the original
	-- engine functions and metamethods have. Falls back to the plain function on
	-- executors without newcclosure.
	function Cloak.CClosure(fn)
		if type(newcclosure) == "function" then
			local ok, wrapped = pcall(newcclosure, fn)
			if ok and type(wrapped) == "function" then
				return wrapped
			end
		end
		return fn
	end

	-- True when the game can enumerate this instance: it sits under Workspace or
	-- the local PlayerGui (the fallbacks). gethui/CoreGui containers can't be read
	-- by game scripts, so instances there need no filtering.
	local function exposedToGame(inst)
		local ok, exposed = pcall(function()
			if inst:IsDescendantOf(Workspace) then
				return true
			end
			local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
			return playerGui ~= nil and inst:IsDescendantOf(playerGui)
		end)
		return ok and exposed == true
	end

	function Cloak.Protect(inst)
		if not protected[inst] then
			protected[inst] = true
			protectedCount = protectedCount + 1
		end
		-- The __namecall filter is itself a modification a game can probe for, so
		-- it installs on demand — only once something protected is actually
		-- exposed to game-side scans. On an executor with gethui and everything
		-- disabled, the game's metatable is never touched at all.
		--
		-- protecting re-entry guard: exposedToGame issues IsDescendantOf /
		-- FindFirstChild namecalls. On executors where checkcaller can't tell a
		-- hook-internal call from a game call, those re-enter the __namecall
		-- hooks, and anything that leads back here would recurse until a
		-- C stack overflow. A nested Protect simply defers to the outer call —
		-- Install() runs either way.
		if not protecting then
			protecting = true
			local exposed = exposedToGame(inst)
			protecting = false
			if exposed then
				Cloak.Install()
			end
		end
		return inst
	end

	-- True when inst is, or lives under, a registered instance. Walks .Parent (an
	-- __index read), so it cannot recurse through our own __namecall hook. Stops
	-- at the DataModel, whose .Parent read is locked and would throw.
	local function isHidden(inst)
		local node = inst
		while node and node ~= game do
			if protected[node] then
				return true
			end
			node = node.Parent
		end
		return false
	end

	-- Stores value under getgenv()[name] WITHOUT a raw key: reads still work, but
	-- pairs()/next() scans of the environment never enumerate it. Returns false
	-- when the environment can't take a metatable (caller may fall back to a raw
	-- assignment if the export matters more than the hiding).
	function Cloak.HideGlobal(name, value)
		hiddenGlobals[name] = value

		if type(getgenv) ~= "function" then
			return false
		end
		local ok, env = pcall(getgenv)
		if not ok or type(env) ~= "table" then
			return false
		end

		-- A pre-cloak build may have left a raw key behind; drop it.
		pcall(function()
			if rawget(env, name) ~= nil then
				rawset(env, name, nil)
			end
		end)

		local ok2 = pcall(function()
			local mt = getmetatable(env)
			local oldIndex = mt and rawget(mt, "__index")
			local newMt = {}
			if mt then
				for k, v in pairs(mt) do
					newMt[k] = v
				end
			end
			newMt.__index = function(_, key)
				local hidden = hiddenGlobals[key]
				if hidden ~= nil then
					return hidden
				end
				if type(oldIndex) == "function" then
					return oldIndex(env, key)
				elseif type(oldIndex) == "table" then
					return oldIndex[key]
				end
				return nil
			end
			setmetatable(env, newMt)
		end)
		return ok2
	end

	local installed = false

	local FILTERED_METHODS = {
		GetChildren = true,
		GetDescendants = true,
		FindFirstChild = true,
		FindFirstChildOfClass = true,
		FindFirstChildWhichIsA = true,
	}

	-- Installs the __namecall filter. Only GAME threads (checkcaller() == false)
	-- get filtered results; our own modules keep seeing the full tree, so
	-- applyAccent / NPC rescans / etc. are unaffected. Chains cleanly with the
	-- Silent Aim hook, which installs later and wraps this closure.
	function Cloak.Install()
		if installed then
			return
		end
		if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" then
			return
		end
		-- Without checkcaller we cannot tell the game's scans from our own lookups,
		-- and filtering our own calls would break the UI/ESP internals.
		if type(checkcaller) ~= "function" then
			return
		end

		local oldNamecall
		local inFilter = false
		local ok = pcall(function()
			oldNamecall = hookmetamethod(game, "__namecall", Cloak.CClosure(function(self, ...)
				local method = getnamecallmethod()
				-- inFilter re-entry guard: while a filtered call is being resolved
				-- (oldNamecall + isHidden's .Parent walk), any nested namecall must
				-- pass through raw. Without this, an executor that reports
				-- hook-internal calls as game calls recurses until C stack overflow.
				if not inFilter and protectedCount > 0 and method and FILTERED_METHODS[method] and not checkcaller() then
					inFilter = true
					local results = table.pack(pcall(oldNamecall, self, ...))
					inFilter = false
					if not results[1] then
						error(results[2], 0)
					end
					local res = results[2]
					if method == "GetChildren" or method == "GetDescendants" then
						local kept = {}
						for i = 1, #res do
							if not isHidden(res[i]) then
								kept[#kept + 1] = res[i]
							end
						end
						return kept
					end
					-- FindFirstChild*: single Instance result (or nil).
					if typeof(res) == "Instance" and isHidden(res) then
						return nil
					end
					return res
				end
				return oldNamecall(self, ...)
			end))
		end)

		installed = ok
	end

	return Cloak
end)() -- /Cloak

--============================================================================
-- CONFIGURATION
--============================================================================
Configuration = (function()
	--==============================================================================
	-- CONFIGURATION
	-- Centralized settings and single source of truth.
	--==============================================================================


	local Configuration = {}

	Configuration.Camera = {
		Enabled = false,
		-- LOWER = harder/snappier lock, HIGHER = slower, smoother follow.
		Smoothness = 0.85,
		-- Targeting cone radius in PIXELS from the crosshair (what the FOV circle draws).
		FOV = 200,
		-- World range limit in studs from your character.
		MaxDistance = 1000,

		-- Hitbox mode: "Random (Weighted)" uses TargetWeights below; otherwise a
		-- specific region ("Head" / "Torso" / "Arms" / "Legs") is aimed at directly.
		Hitbox = "Random (Weighted)",
		HitboxOptions = { "Random (Weighted)", "Head", "Torso", "Arms", "Legs" },

		-- 0-100 chance weights per body region, used only in Random (Weighted) mode.
		-- They don't need to sum to 100 — they're relative.
		TargetWeights = {
			Head = 85,
			Torso = 15,
			Arms = 0,
			Legs = 0,
		},

		WallCheck = true,     -- require line of sight to the target
		TargetBots = false,   -- also target NPCs (non-player models with a Humanoid)
		TeamCheck = true,     -- never target players on your own team
		FOVCircle = false,    -- draw the targeting radius on screen

		ToggleKey = Enum.KeyCode.LeftAlt,
		FOVCircleKey = Enum.KeyCode.F1,
	}

	Configuration.NoRecoil = {
		Enabled = false,
		-- 0..1 hold strength (1 = fully locked to where you started firing).
		Strength = 1,
		-- Only lock while the fire button (LMB) is held.
		RequireMouseDown = true,
		-- Still allow pulling the aim downward while firing (climb stays blocked).
		AllowAim = false,
		ToggleKey = Enum.KeyCode.F2,
	}

	Configuration.NoSpread = {
		Enabled = false,
		-- 0..1 how far each spread roll is pulled toward centre. 1 = dead centre
		-- (no spread at all), 0.5 = half the cone, 0 = untouched.
		Strength = 1,
		-- Only suppress spread rolls while the fire button (LMB) is held. Leaving this
		-- on keeps the rest of the game's randomness untouched except while shooting.
		RequireMouseDown = true,
		ToggleKey = Enum.KeyCode.F3,
	}

	Configuration.Triggerbot = {
		Enabled = false,
		-- Humanized reaction time: each shot waits a random delay sampled between
		-- MinDelay and MaxDelay (seconds the crosshair must sit on the target).
		MinDelay = 0.1,
		MaxDelay = 0.25,
		MaxDistance = 1000, -- studs; shots past this are ignored
		WallCheck = true,   -- "Vischeck": require line of sight (off = fire through walls)
		ToggleKey = Enum.KeyCode.F4,
	}

	Configuration.Movement = {
		FlyEnabled = false,
		FlySpeed = 50,
		NoclipEnabled = false,
		SpeedEnabled = false,
		-- 16 = stock WalkSpeed, i.e. no boost. Only the surplus over 16 is applied.
		Speed = 16,
		InfJumpEnabled = false,
		ClickTPEnabled = false,
		ClickTPKey = Enum.KeyCode.LeftControl, -- hold this + left click to teleport
		-- Speed/Fly anti-lagback pulsing and stepped Click TP are always on with
		-- fixed best settings inside the Movement module (not configurable).
	}

	Configuration.SilentAim = {
		Enabled = false,
		-- Network plausibility: shots further than MaxAngle degrees off the real
		-- camera aim are NOT rewritten (they miss legitimately), so the server
		-- never sees a hit claim it can't reconcile with your look direction.
		MaxAngle = 30,
		-- Percent of in-cone shots to rewrite. Below 100 your hit rate stays
		-- statistically human instead of a perfect, flaggable 100%.
		HitChance = 100,
	}

	Configuration.Hitbox = {
		Enabled = false,
		Size = 5,
		Transparency = 0.5,
	}

	Configuration.Drawing = {
		Boxes = false,
		Tracers = false,
		BoxColor = Color3.fromRGB(165, 75, 255),
		TracerColor = Color3.fromRGB(255, 255, 255),
	}

	Configuration.Visuals = {
		Fullbright = false,
		NoFog = false,
	}

	Configuration.ESP = {
		Enabled = false,
		-- Render styles; independent, so any combination can be on at once.
		Outlines = true, -- Highlight silhouette
		Boxes = false,   -- 2D screen-space box
		Names = false,   -- player name floating above the head
		Distance = false, -- meters from your character, under the name
		-- Tag-suite keys: NameTags/DistanceTags alias Names/Distance (same head
		-- billboard); HealthBars adds a health bar line to it.
		NameTags = false,
		HealthBars = false,
		DistanceTags = false,
		NPCs = false,    -- also highlight non-player characters (mobs/dummies)
		OutlineColor = Color3.fromRGB(165, 75, 255),
		FillColor = Color3.fromRGB(165, 75, 255),
		Filled = false,
		OutlineOpacity = 1,
		FillOpacity = 0.4,
		MaxDistance = 1000,
		ToggleKey = Enum.KeyCode.RightAlt, -- keybind for toggling ESP, like the aimbot
	}

	Configuration.UI = {
		Scale = 1,
		MenuKey = Enum.KeyCode.RightShift,
		UnloadKey = Enum.KeyCode.End,
		Visible = false, -- the menu itself; opened with MenuKey, not an Interface toggle
		Accent = Color3.fromRGB(132, 62, 190), -- UI accent color (live-recolored)
		-- Interface overlays all start ON.
		KeybindPanel = true,  -- standalone keybind window
		TargetDisplay = true, -- popup naming whoever you're looking at
		FPSCounter = true,    -- bottom-right fps readout
		Watermark = true,     -- bottom-left watermark logo
		-- Uploaded image id for the watermark logo. Leave "" to hide it.
		-- This is the IMAGE id (a Decal id renders as nothing) — resolved from
		-- decal 123653124904094 via InsertService:LoadAsset -> Decal.Texture.
		WatermarkImageId = "139845693858856",
	}

	-- Discord webhook URL in plaintext. The old single-file build kept this
	-- encrypted via StringObfuscation/ProtectedSecrets; those modules left the
	-- bundle (obfuscation happens at release build time), so the URL is plain
	-- config now. Deliberately NOT in DEFAULTS, so Reset Settings keeps it.
	Configuration.Webhook = {
		Url = "",
	}

	Configuration.Debug = false

	local DEFAULTS = {
		Camera = {
			Enabled = false,
			Smoothness = 0.85,
			FOV = 200,
			MaxDistance = 1000,
			Hitbox = "Random (Weighted)",
			TargetWeights = { Head = 85, Torso = 15, Arms = 0, Legs = 0 },
			WallCheck = true,
			TargetBots = false,
			TeamCheck = true,
			FOVCircle = false,
		},
		ESP = {
			Enabled = false,
			Outlines = true,
			Boxes = false,
			Names = false,
			Distance = false,
			NameTags = false,
			HealthBars = false,
			DistanceTags = false,
			NPCs = false,
			OutlineColor = Color3.fromRGB(165, 75, 255),
			FillColor = Color3.fromRGB(165, 75, 255),
			Filled = false,
			OutlineOpacity = 1,
			FillOpacity = 0.4,
			MaxDistance = 1000,
		},
		NoRecoil = { Enabled = false, Strength = 1, RequireMouseDown = true, AllowAim = false },
		NoSpread = { Enabled = false, Strength = 1, RequireMouseDown = true },
		Triggerbot = { Enabled = false, MinDelay = 0.1, MaxDelay = 0.25, MaxDistance = 1000, WallCheck = true },
		Movement = {
			FlyEnabled = false,
			FlySpeed = 50,
			NoclipEnabled = false,
			SpeedEnabled = false,
			Speed = 16,
			InfJumpEnabled = false,
			ClickTPEnabled = false,
		},
		SilentAim = { Enabled = false, MaxAngle = 30, HitChance = 100 },
		Hitbox = { Enabled = false, Size = 5, Transparency = 0.5 },
		Drawing = {
			Boxes = false,
			Tracers = false,
			BoxColor = Color3.fromRGB(165, 75, 255),
			TracerColor = Color3.fromRGB(255, 255, 255),
		},
		Visuals = { Fullbright = false, NoFog = false },
		UI = {
			Scale = 1,
			Accent = Color3.fromRGB(132, 62, 190),
			KeybindPanel = true,
			TargetDisplay = true,
			FPSCounter = true,
			Watermark = true,
		},
	}

	function Configuration.reset()
		for section, values in pairs(DEFAULTS) do
			for key, value in pairs(values) do
				if type(value) == "table" then
					-- Copy nested defaults (e.g. TargetWeights) into the existing table
					-- so we never alias the DEFAULTS table itself.
					local target = Configuration[section][key]
					if type(target) ~= "table" then
						target = {}
						Configuration[section][key] = target
					end
					for k, v in pairs(value) do
						target[k] = v
					end
				else
					Configuration[section][key] = value
				end
			end
		end
	end

	return Configuration
end)() -- /Configuration

--============================================================================
-- CONFIGMANAGER
--============================================================================
ConfigManager = (function()
	--==============================================================================
	-- CONFIG MANAGER
	-- Saves/loads the whole Configuration to the executor's filesystem as JSON, so
	-- settings survive between sessions. Color3 and EnumItem (keybinds) can't be
	-- represented in JSON, so they're tagged and rebuilt on load.
	-- Profiles are per-game (PlaceId in the file name) with a legacy-path fallback.
	--==============================================================================


	local ConfigManager = {}
	local CONFIG_FOLDER = "VanityGeneral"
	local SAVED_SECTIONS = { "Camera", "ESP", "NoRecoil", "NoSpread", "Movement", "SilentAim", "Hitbox", "Drawing", "Visuals", "UI" }

	-- Executors vary in what file APIs they expose; everything degrades gracefully.
	local function fsAvailable()
		return type(writefile) == "function"
			and type(readfile) == "function"
			and type(listfiles) == "function"
	end

	local function ensureFolder()
		if type(isfolder) == "function" and type(makefolder) == "function" then
			if not isfolder(CONFIG_FOLDER) then
				pcall(makefolder, CONFIG_FOLDER)
			end
		end
	end

	-- Strips anything that could break a file path.
	local function sanitizeName(name)
		return (tostring(name or ""):gsub("[^%w_%- ]", ""):gsub("^%s+", ""):gsub("%s+$", ""))
	end

	-- Profiles are per-game: the PlaceId is baked into the file name so one
	-- executor folder can hold settings for every game without collisions.
	local function pathFor(name)
		return CONFIG_FOLDER .. "/profile_" .. game.PlaceId .. "_" .. name .. ".json"
	end

	-- Pre-per-game saves lived at VanityGeneral/<name>.json; still read as a
	-- fallback so old profiles keep loading (they're never written anymore).
	local function legacyPathFor(name)
		return CONFIG_FOLDER .. "/" .. name .. ".json"
	end

	local function encodeValue(v)
		local t = typeof(v)
		if t == "Color3" then
			return { __t = "Color3", r = v.R, g = v.G, b = v.B }
		elseif t == "EnumItem" then
			return { __t = "Enum", e = tostring(v.EnumType), n = v.Name }
		elseif t == "table" then
			local out = {}
			for k, val in pairs(v) do
				if type(val) ~= "function" then
					local enc = encodeValue(val)
					if enc ~= nil then
						out[k] = enc
					end
				end
			end
			return out
		elseif t == "number" or t == "string" or t == "boolean" then
			return v
		end
		return nil -- functions, Instances, anything else: not persisted
	end

	local function decodeValue(v)
		if type(v) ~= "table" then
			return v
		end
		if v.__t == "Color3" then
			return Color3.new(v.r or 0, v.g or 0, v.b or 0)
		end
		if v.__t == "Enum" then
			local ok, item = pcall(function()
				return Enum[v.e][v.n]
			end)
			if ok then
				return item
			end
			return nil -- unknown key: leave the existing bind alone
		end
		return v
	end

	-- Copies decoded values into the live tables in place, so every closure that
	-- captured a config table keeps working.
	local function applyInto(target, src)
		for k, v in pairs(src) do
			if type(v) == "table" and v.__t == nil then
				if type(target[k]) == "table" then
					applyInto(target[k], v)
				end
			else
				local decoded = decodeValue(v)
				if decoded ~= nil then
					target[k] = decoded
				end
			end
		end
	end

	function ConfigManager.isSupported()
		return fsAvailable()
	end

	function ConfigManager.list()
		local out = {}
		if not fsAvailable() then
			return out
		end
		ensureFolder()

		local ok, files = pcall(listfiles, CONFIG_FOLDER)
		if not ok or type(files) ~= "table" then
			return out
		end

		for _, path in ipairs(files) do
			-- Only this game's profiles (other PlaceIds' files stay hidden).
			local prefix = "profile_" .. game.PlaceId .. "_"
			local name = tostring(path):match("([^/\\]+)%.json$")
			if name and name:sub(1, #prefix) == prefix then
				table.insert(out, name:sub(#prefix + 1))
			end
		end
		table.sort(out)
		return out
	end

	function ConfigManager.save(name, config)
		if not fsAvailable() then
			return false, "This executor has no file API"
		end

		name = sanitizeName(name)
		if name == "" then
			return false, "Enter a config name"
		end

		ensureFolder()

		local data = {}
		for _, section in ipairs(SAVED_SECTIONS) do
			if type(config[section]) == "table" then
				data[section] = encodeValue(config[section])
			end
		end

		local okJson, json = pcall(function()
			return game:GetService("HttpService"):JSONEncode(data)
		end)
		if not okJson then
			return false, "Encode failed: " .. tostring(json)
		end

		local okWrite, err = pcall(writefile, pathFor(name), json)
		if not okWrite then
			return false, "Write failed: " .. tostring(err)
		end
		return true, name
	end

	function ConfigManager.load(name, config)
		if not fsAvailable() then
			return false, "This executor has no file API"
		end

		name = sanitizeName(name)
		if name == "" then
			return false, "Enter a config name"
		end

		local path = pathFor(name)
		if type(isfile) == "function" then
			local okIs, exists = pcall(isfile, path)
			if okIs and not exists then
				-- Migration fallback: an old pre-per-game save with the same name.
				local legacy = legacyPathFor(name)
				local okLegacy, legacyExists = pcall(isfile, legacy)
				if okLegacy and legacyExists then
					path = legacy
				else
					return false, "No config named '" .. name .. "'"
				end
			end
		end

		local okRead, raw = pcall(readfile, path)
		if not okRead or type(raw) ~= "string" then
			return false, "Read failed"
		end

		local okJson, data = pcall(function()
			return game:GetService("HttpService"):JSONDecode(raw)
		end)
		if not okJson or type(data) ~= "table" then
			return false, "That file isn't valid JSON"
		end

		for _, section in ipairs(SAVED_SECTIONS) do
			if type(data[section]) == "table" and type(config[section]) == "table" then
				applyInto(config[section], data[section])
			end
		end
		return true, name
	end

	function ConfigManager.delete(name)
		name = sanitizeName(name)
		if name == "" then
			return false, "Enter a config name"
		end
		if type(delfile) ~= "function" then
			return false, "This executor can't delete files"
		end

		local ok, err = pcall(delfile, pathFor(name))
		if not ok then
			return false, tostring(err)
		end
		return true, name
	end

	return ConfigManager
end)() -- /ConfigManager

--============================================================================
-- UTILITY
--============================================================================
Utility = (function()
	--==============================================================================
	-- UTILITY
	-- Small quality-of-life features: server hop / rejoin, GUI parent helper.
	--==============================================================================

	local Players = game:GetService("Players")
	local TeleportService = game:GetService("TeleportService")

	local LocalPlayer = Players.LocalPlayer

	local Utility = {}

	function Utility:ServerHop()
		local ok, err = pcall(function()
			TeleportService:Teleport(game.PlaceId, LocalPlayer)
		end)
		if not ok then
			warn("[Vanity-General] Server hop failed:", err)
		end
		return ok
	end

	function Utility:Rejoin()
		local ok, err = pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end)
		if not ok then
			warn("[Vanity-General] Rejoin failed:", err)
		end
		return ok
	end

	-- Exploit-friendly GUI parent: prefer a hidden container, then CoreGui, then PlayerGui.
	function Utility.getGuiParent()
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

	return Utility
end)() -- /Utility

--============================================================================
-- CANDIDATES
--============================================================================
Candidates = (function()
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
end)() -- /Candidates

--============================================================================
-- CAMERADIRECTOR
--============================================================================
CameraDirector = (function()
	--==============================================================================
	-- CAMERA DIRECTOR
	-- Smooth camera tracking toward prioritized, visible, alive targets.
	--==============================================================================

	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer
	local Utility = Utility
	local Candidates = Candidates
	local Cloak = Cloak

	local CameraDirector = {}

	local Camera = Workspace.CurrentCamera

	-- Body regions and part resolution are delegated to Candidates (shared per-frame
	-- provider) to eliminate duplication between modules.
	local REGION_PARTS = Candidates.REGION_PARTS
	local REGION_ORDER = Candidates.REGION_ORDER
	local pickPartFromRegion = Candidates.pickPartFromRegion
	local pickAnyPart = Candidates.pickAnyPart


	-- Weighted-random region using the 0-100 weights. Falls back to Head when every
	-- weight is zero so tracking still does something sensible.
	local function rollWeightedRegion(weights)
		local total = 0
		for _, region in ipairs(Candidates.REGION_ORDER) do
			total = total + math.max(0, (weights and weights[region]) or 0)
		end
		if total <= 0 then
			return "Head"
		end
		local roll = rng:NextNumber() * total
		local acc = 0
		for _, region in ipairs(Candidates.REGION_ORDER) do
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

		if mode and mode ~= "Random (Weighted)" and Candidates.REGION_PARTS[mode] then
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
		local aimPart = Candidates.pickPartFromRegion(target.Character, region) or Candidates.pickAnyPart(target.Character)
		if not aimPart then
			self._currentTarget = nil
			return
		end

		-- Streaming guard: the part may have been streamed out mid-frame.
		if not aimPart:IsDescendantOf(Workspace) then
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
end)() -- /CameraDirector

--============================================================================
-- ESP
--============================================================================
ESP = (function()
	--==============================================================================
	-- ESP
	-- Player highlighting with outlines, optional fill, boxes and head info tags.
	--==============================================================================

	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer
	local Configuration = Configuration
	local Utility = Utility
	local Candidates = Candidates
	local Cloak = Cloak

	local ESP = {}
	local entries = {}
	local container
	local boxGui -- ScreenGui holding the 2D boxes (Boxes mode)
	local DEPTH = Enum.HighlightDepthMode.AlwaysOnTop

	-- Helper to create and configure instances (mirrors the UI.lua helper).
	local function newInstance(class, props)
		local inst = Instance.new(class)
		for k, v in pairs(props) do
			inst[k] = v
		end
		return inst
	end

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
end)() -- /ESP

--============================================================================
-- DRAWINGESP
--============================================================================
DrawingESP = (function()
	--==============================================================================
	-- DRAWING ESP
	-- Screen-space boxes + tracers via the executor's Drawing library.
	--==============================================================================

	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer
	local Candidates = Candidates

	local DrawingESP = {}
	local de_available = type(Drawing) == "table" and type(Drawing.new) == "function"
	local de_warned = false
	local de_entries = {} -- player -> { box = {4 Lines}, tracer = Line }

	local function de_newLine()
		local line = Drawing.new("Line")
		line.Thickness = 1
		line.Visible = false
		return line
	end

	local function de_newEntry(player)
		local entry = {
			box = { de_newLine(), de_newLine(), de_newLine(), de_newLine() },
			tracer = de_newLine(),
		}
		de_entries[player] = entry
		return entry
	end

	local function de_hide(entry)
		for _, line in ipairs(entry.box) do
			line.Visible = false
		end
		entry.tracer.Visible = false
	end

	local function de_removePlayer(player)
		local entry = de_entries[player]
		if not entry then
			return
		end
		de_entries[player] = nil
		for _, line in ipairs(entry.box) do
			line:Remove()
		end
		entry.tracer:Remove()
	end

	-- Draws (or hides) one player from the shared candidate pool. The pool
	-- guarantees a living humanoid, so only the Drawing-specific gates apply.
	local function de_updateCandidate(cand, config, cam, cameraConfig)
		local player = cand.Player
		local entry = de_entries[player]

		-- Team Check: never draw teammates (teamless players stay fair game).
		if cameraConfig.TeamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team then
			if entry then
				de_hide(entry)
			end
			return
		end

		local root = cand.HRP
		if not (config.Boxes or config.Tracers) or not root then
			if entry then
				de_hide(entry)
			end
			return
		end

		-- Behind the camera, off-screen, or no root this frame: nothing to draw.
		local topV, onScreen, botV = cand.TopScreen, cand.TopOnScreen, cand.BotScreen
		if not topV or not onScreen or topV.Z <= 0 or botV.Z <= 0 then
			if entry then
				de_hide(entry)
			end
			return
		end

		entry = entry or de_newEntry(player)

		local height = math.abs(botV.Y - topV.Y)
		local width = height * 0.62
		local cx = (topV.X + botV.X) * 0.5
		local left, right = cx - width * 0.5, cx + width * 0.5
		local top, bottom = topV.Y, botV.Y

		local box = entry.box
		-- top, bottom, left, right edges
		box[1].From = Vector2.new(left, top)
		box[1].To = Vector2.new(right, top)
		box[2].From = Vector2.new(left, bottom)
		box[2].To = Vector2.new(right, bottom)
		box[3].From = Vector2.new(left, top)
		box[3].To = Vector2.new(left, bottom)
		box[4].From = Vector2.new(right, top)
		box[4].To = Vector2.new(right, bottom)
		for _, line in ipairs(box) do
			line.Color = config.BoxColor
			line.Visible = config.Boxes
		end

		entry.tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
		entry.tracer.To = Vector2.new(cx, bottom)
		entry.tracer.Color = config.TracerColor
		entry.tracer.Visible = config.Tracers
	end

	-- Candidates mirror the aimbot's team rule (camera config drives Team Check).
	function DrawingESP:Update(config, cameraConfig)
		if not de_available then
			if (config.Boxes or config.Tracers) and not de_warned then
				warn("[Vanity-General] Box/Tracer ESP needs the Drawing library — not available in this executor.")
				de_warned = true
			end
			return
		end

		local cam = Workspace.CurrentCamera
		if not cam then
			return
		end

		local seen = {}
		for _, cand in ipairs(Candidates:Get()) do
			if cand.Player then
				seen[cand.Player] = true
				de_updateCandidate(cand, config, cam, cameraConfig)
			end
		end

		-- Drawing objects can't be parented, so leavers must be cleaned up by hand;
		-- players absent from this frame's pool (dead, characterless) get hidden.
		for player, entry in pairs(de_entries) do
			if player.Parent ~= Players then
				de_removePlayer(player)
			elseif not seen[player] then
				de_hide(entry)
			end
		end
	end

	function DrawingESP:Cleanup()
		for player in pairs(de_entries) do
			de_removePlayer(player)
		end
	end

	return DrawingESP
end)() -- /DrawingESP

--============================================================================
-- VISUALS
--============================================================================
Visuals = (function()
	--==============================================================================
	-- VISUALS
	-- World lighting tweaks (Fullbright / No Fog) with original-state restore.
	--==============================================================================

	local Lighting = game:GetService("Lighting")

	local Visuals = {}
	local Lighting = game:GetService("Lighting")
	local vs_originals -- captured the first time either feature turns on
	local Lighting = game:GetService("Lighting")
	local vs_originals -- captured the first time either feature turns on
	local vs_fullbrightOn = false
	local vs_noFogOn = false
	local vs_lastCheck = 0
	local VS_CHECK_INTERVAL = 1

	local function vs_captureOriginals()
		if vs_originals then
			return
		end
		vs_originals = {
			Brightness = Lighting.Brightness,
			ClockTime = Lighting.ClockTime,
			GlobalShadows = Lighting.GlobalShadows,
			FogEnd = Lighting.FogEnd,
			FogStart = Lighting.FogStart,
			Ambient = Lighting.Ambient,
			OutdoorAmbient = Lighting.OutdoorAmbient,
		}
	end

	local function vs_applyFullbright()
		Lighting.Brightness = 2
		Lighting.ClockTime = 14 -- noon
		Lighting.GlobalShadows = false
	end

	local function vs_applyNoFog()
		Lighting.FogEnd = 100000
	end

	local function vs_restoreFullbright()
		Lighting.Brightness = vs_originals.Brightness
		Lighting.ClockTime = vs_originals.ClockTime
		Lighting.GlobalShadows = vs_originals.GlobalShadows
	end

	local function vs_restoreNoFog()
		Lighting.FogEnd = vs_originals.FogEnd
		Lighting.FogStart = vs_originals.FogStart
	end

	function Visuals:Update(config)
		if not (config.Fullbright or config.NoFog or vs_fullbrightOn or vs_noFogOn) then
			return
		end
		vs_captureOriginals()

		if config.Fullbright ~= vs_fullbrightOn then
			vs_fullbrightOn = config.Fullbright
			if vs_fullbrightOn then
				vs_applyFullbright()
			else
				vs_restoreFullbright()
			end
		end

		if config.NoFog ~= vs_noFogOn then
			vs_noFogOn = config.NoFog
			if vs_noFogOn then
				vs_applyNoFog()
			else
				vs_restoreNoFog()
			end
		end

		-- The game may re-write lighting (new area, weather script); push back ~1/s.
		if (vs_fullbrightOn or vs_noFogOn) and os.clock() - vs_lastCheck >= VS_CHECK_INTERVAL then
			vs_lastCheck = os.clock()
			if vs_fullbrightOn
				and (Lighting.Brightness ~= 2 or Lighting.ClockTime ~= 14 or Lighting.GlobalShadows)
			then
				vs_applyFullbright()
			end
			if vs_noFogOn and Lighting.FogEnd < 100000 then
				vs_applyNoFog()
			end
		end
	end

	function Visuals:Cleanup()
		if vs_originals then
			if vs_fullbrightOn then
				vs_restoreFullbright()
			end
			if vs_noFogOn then
				vs_restoreNoFog()
			end
		end
		vs_fullbrightOn = false
		vs_noFogOn = false
	end

	return Visuals
end)() -- /Visuals

--============================================================================
-- WEBHOOK
--============================================================================
Webhook = (function()
	--==============================================================================
	-- SECURE WEBHOOK
	-- On load the script pings a Discord webhook (player name / game / etc).
	--
	-- SECURITY NOTE: the old single-file build stored the URL as an encrypted
	-- cipher and gated reveals behind StringObfuscation/DebuggerDetection. Those
	-- modules left the bundle — obfuscation now happens at release build time —
	-- so the URL lives in plain config: Configuration.Webhook.Url (set it directly,
	-- or via Webhook.SetWebhook at runtime).
	--==============================================================================

	local Players = game:GetService("Players")

	local LocalPlayer = Players.LocalPlayer

	local Configuration = Configuration

	local Webhook = {}
	Webhook.Version = "0" -- stamped by the controller on load (used in the embed)

	-- Finds whatever HTTP-POST function this executor exposes.
	local function resolveHttpRequest()
		local candidates = {
			(syn and syn.request),
			(http and http.request),
			http_request,
			request,
			(fluxus and fluxus.request),
		}
		for _, fn in ipairs(candidates) do
			if type(fn) == "function" then
				return fn
			end
		end
		return nil
	end

	-- The configured URL, or nil when none is set.
	local function resolveWebhookUrl()
		local url = Configuration.Webhook.Url
		if type(url) == "string" and url ~= "" then
			return url
		end
		return nil
	end

	-- Store/replace the webhook URL at runtime.
	function Webhook.SetWebhook(url)
		Configuration.Webhook.Url = tostring(url or "")
		return true
	end

	-- True if a URL is configured.
	function Webhook.HasWebhook()
		return resolveWebhookUrl() ~= nil
	end

	-- Sends a Discord message. Returns false (never throws) when unconfigured or
	-- the executor has no HTTP function.
	function Webhook.SendWebhook(content, opts)
		opts = opts or {}

		local url = resolveWebhookUrl()
		if not url then
			return false, "no_webhook"
		end

		local req = resolveHttpRequest()
		if not req then
			warn("[Vanity-General] No HTTP request function available in this executor")
			return false, "no_http"
		end

		local payload = {
			username = opts.username or "Vanity-General",
			avatar_url = opts.avatar_url,
			content = content,
			embeds = opts.embeds,
		}

		local ok, err = pcall(function()
			local body = game:GetService("HttpService"):JSONEncode(payload)
			return req({
				Url = url,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = body,
			})
		end)
		url = nil -- drop the reference promptly

		if not ok then
			warn("[Vanity-General] Webhook send failed:", err)
			return false, err
		end
		return true
	end

	-- The nice "loaded" embed. Kept here so both Start and manual calls can reuse it.
	function Webhook.SendLoadedEmbed(isDebugged)
		local placeName = "?"
		pcall(function()
			placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
		end)

		return Webhook.SendWebhook(nil, {
			embeds = {
				{
					title = "Vanity.dev General loaded",
					color = 8666558, -- accent purple (0x843EBE)
					fields = {
						{ name = "Player", value = "`" .. (LocalPlayer and LocalPlayer.Name or "?") .. "`", inline = true },
						{ name = "Version", value = "`v" .. tostring(Webhook.Version) .. "`", inline = true },
						{ name = "Game", value = placeName, inline = false },
						{ name = "PlaceId", value = "`" .. tostring(game.PlaceId) .. "`", inline = true },
						{ name = "Debugged", value = "`" .. tostring(isDebugged) .. "`", inline = true },
					},
					footer = { text = os.date("%Y-%m-%d %H:%M:%S") },
				},
			},
		})
	end

	return Webhook
end)() -- /Webhook

--============================================================================
-- TRIGGERBOT
--============================================================================
Triggerbot = (function()
	--==============================================================================
	-- TRIGGERBOT
	-- Fires when the crosshair is over a living player.
	--==============================================================================

	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer

	local Triggerbot = {}
	local tb_click -- resolved click function
	local tb_resolved = false
	local tb_warned = false
	local tb_onTargetSince = nil -- os.clock when the crosshair first landed on a target
	local tb_currentDelay -- humanized reaction time, re-sampled per target landing
	local tb_rng = Random.new()
	local tb_lastFire = 0
	local tb_refire = 0.1 -- sampled refire interval; a FIXED interval is a timing signature

	local function tb_resolveClick()
		if tb_resolved then
			return
		end
		tb_resolved = true

		if type(mouse1click) == "function" then
			tb_click = function()
				mouse1click()
			end
		elseif type(mouse1press) == "function" and type(mouse1release) == "function" then
			tb_click = function()
				mouse1press()
				task.delay(0.04, function()
					pcall(mouse1release)
				end)
			end
		end
	end

	-- Returns the character model under the crosshair (living, not you), else nil.
	local function tb_targetUnderCrosshair(config, cameraConfig)
		local cam = Workspace.CurrentCamera
		if not cam then
			return nil
		end

		local vs = cam.ViewportSize
		local ray = cam:ViewportPointToRay(vs.X / 2, vs.Y / 2)

		local params = RaycastParams.new()
		if config.WallCheck then
			-- Vischeck ON: hit the first thing, so walls between you and the target block.
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = { LocalPlayer.Character }
		else
			-- Vischeck OFF: only collide with other players' characters, so the ray
			-- passes straight through walls and still registers a target behind them.
			local chars = {}
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character then
					table.insert(chars, plr.Character)
				end
			end
			params.FilterType = Enum.RaycastFilterType.Include
			params.FilterDescendantsInstances = chars
		end

		local result = Workspace:Raycast(ray.Origin, ray.Direction * (config.MaxDistance or 1000), params)
		if not result then
			return nil
		end

		local model = result.Instance:FindFirstAncestorOfClass("Model")
		local plr = model and Players:GetPlayerFromCharacter(model)
		if not plr or plr == LocalPlayer then
			return nil
		end

		-- Team Check (lives in the Camera config): never fire on teammates.
		-- Teamless players (Team == nil) stay fair game.
		if cameraConfig and cameraConfig.TeamCheck and plr.Team ~= nil and plr.Team == LocalPlayer.Team then
			return nil
		end

		local hum = model:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then
			return nil
		end

		return model
	end

	function Triggerbot:Update(config, cameraConfig)
		if not config.Enabled then
			tb_onTargetSince = nil
			return
		end

		tb_resolveClick()
		if not tb_click then
			if not tb_warned then
				warn("[Vanity-General] Triggerbot needs a mouse-click function (mouse1click) — not available in this executor.")
				tb_warned = true
			end
			return
		end

		local target = tb_targetUnderCrosshair(config, cameraConfig)
		if not target then
			tb_onTargetSince = nil -- reset the reaction timer when off-target
			return
		end

		local now = os.clock()
		if not tb_onTargetSince then
			tb_onTargetSince = now
			-- Humanized reaction time, sampled fresh each time the crosshair lands.
			local lo = math.min(config.MinDelay or 0.1, config.MaxDelay or 0.25)
			local hi = math.max(config.MinDelay or 0.1, config.MaxDelay or 0.25)
			tb_currentDelay = tb_rng:NextNumber(lo, hi)
		end

		if (now - tb_onTargetSince) >= (tb_currentDelay or 0) and (now - tb_lastFire) >= tb_refire then
			tb_lastFire = now
			-- Re-sample the refire interval every shot (~6-11 clicks/s, human
			-- semi-auto range) so server-side timing analysis sees jitter, not a
			-- metronome.
			tb_refire = tb_rng:NextNumber(0.09, 0.17)
			tb_click()
		end
	end

	return Triggerbot
end)() -- /Triggerbot

--============================================================================
-- SILENTAIM
--============================================================================
SilentAim = (function()
	--==============================================================================
	-- SILENT AIM
	-- Redirects your shots onto a target WITHOUT moving the camera, by hooking the
	-- game's metatable. When something (a hill, a wall, a building) sits between
	-- you and the target, the shot is CURVED over it: the launch direction is
	-- raised toward an arc apex computed above the obstruction, so a gravity-
	-- affected projectile arcs up and drops onto the target instead of burying
	-- itself in the hillside. Clear line of sight still takes a flat shot.
	--
	-- Target resolution: the aimbot's current lock first; with no lock, whoever
	-- the crosshair is nearest (the same pick the Target Display makes — no wall
	-- check, so targets behind terrain still register).
	--
	-- Network plausibility: before any rewrite, the target must pass a gate —
	-- within MaxAngle of the real camera aim (so the server can reconcile the
	-- shot with your look direction) and a HitChance roll (so your hit rate
	-- stays statistically human). Failing shots go out unbent as legit misses.
	--
	-- Requires an executor with hookmetamethod/getnamecallmethod — support varies,
	-- so both hooks are guarded and independent of each other; without them the
	-- feature simply no-ops.
	--==============================================================================

	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer
	local CameraDirector = CameraDirector
	local Cloak = Cloak

	local SilentAim = {}
	local sa_installed = false
	local sa_warned = false
	local sa_config -- the full Configuration table, stored by Init

	-- Arc tuning. The apex is found by probing straight down from high above the
	-- shot's midpoint; the shot is then lobbed CLEARANCE studs above whatever that
	-- probe hits (the hilltop), capped at MAX_LIFT above the higher endpoint so we
	-- never mortar rounds into orbit.
	local ARC_PROBE_HEIGHT = 500
	local ARC_CLEARANCE = 12
	local ARC_MAX_LIFT = 200

	-- Local muzzle approximation: the head when we have one, else the root, else
	-- the camera. Used to aim rewritten remote args (the Raycast hook gets the
	-- game's own origin passed in).
	local function sa_muzzle()
		local character = LocalPlayer.Character
		if character then
			local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
			if head then
				return head.Position
			end
		end
		local camera = Workspace.CurrentCamera
		return camera and camera.CFrame.Position or Vector3.zero
	end

	-- Resolve a BodyPart to shoot at from a Player or character model.
	local function sa_anchorPart(character)
		if not character then
			return nil
		end
		return character:FindFirstChild("Head")
			or character:FindFirstChild("HumanoidRootPart")
			or character:FindFirstChild("UpperTorso")
			or character:FindFirstChild("Torso")
	end

	-- The part to curve shots onto: the aimbot's lock when it has one, else
	-- whoever the crosshair is nearest (Target Display pick — deliberately no wall
	-- check, so someone behind a mountain still counts).
	local function sa_targetPart()
		local target = CameraDirector:GetCurrentTarget()
		if target and target.Part and target.Part.Parent then
			return target.Part
		end

		if not sa_config then
			return nil
		end
		local look = CameraDirector:GetLookTarget(sa_config.ESP, sa_config.Camera)
		if typeof(look) ~= "Instance" then
			return nil
		end
		local character = look:IsA("Player") and look.Character or look
		local part = sa_anchorPart(character)
		if part and part.Parent then
			return part
		end
		return nil
	end

	-- Where a shot from `origin` should be aimed to land on `part`. Flat when the
	-- line is clear; raised over the obstruction's apex when it isn't, so gravity
	-- carries the projectile over the top and down onto the target.
	local function sa_aimPoint(origin, part)
		local targetPos = part.Position

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		-- Excluding the target's own character too: a ray that would reach the
		-- target then hits nothing, which reads as a clear line.
		params.FilterDescendantsInstances = { LocalPlayer.Character, part:FindFirstAncestorOfClass("Model") or part }

		if not Workspace:Raycast(origin, targetPos - origin, params) then
			return targetPos -- clear line: flat shot
		end

		-- Blocked. Probe down from high above the midpoint to find the top of
		-- whatever is in the way, then aim CLEARANCE studs over it.
		local mid = (origin + targetPos) / 2
		local probeTop = mid + Vector3.new(0, ARC_PROBE_HEIGHT, 0)
		local floorY = math.min(origin.Y, targetPos.Y)
		local hit = Workspace:Raycast(probeTop, Vector3.new(0, floorY - 5 - probeTop.Y, 0), params)

		local ceilingY = math.max(origin.Y, targetPos.Y)
		local apexY
		if hit then
			apexY = hit.Position.Y + ARC_CLEARANCE
		else
			apexY = ceilingY + ARC_MAX_LIFT -- nothing found: assume it's tall
		end
		apexY = math.clamp(apexY, ceilingY + 5, ceilingY + ARC_MAX_LIFT)

		return Vector3.new(mid.X, apexY, mid.Z)
	end

	-- Only rewrite calls from game scripts. If the executor can't tell (no
	-- checkcaller), we don't rewrite at all — bending our own raycasts would break
	-- the script itself.
	local function sa_fromGameScript()
		return type(checkcaller) == "function" and not checkcaller()
	end

	local sa_rng = Random.new()

	-- Network-plausibility gate. The server can reconcile a rewritten shot against
	-- your replicated look direction and your hit rate, so a target is only
	-- returned when a hit on it is a claim a legitimate player could have made:
	-- within MaxAngle of the real camera aim, and passing the HitChance roll.
	local function sa_plausiblePart()
		local part = sa_targetPart()
		if not part or not sa_config then
			return nil
		end

		-- Streaming guard: don't rewrite shots at streamed-out parts.
		if not part:IsDescendantOf(Workspace) then
			return nil
		end

		local maxAngle = sa_config.SilentAim.MaxAngle or 30
		if maxAngle < 180 then
			local cam = Workspace.CurrentCamera
			if cam then
				local toTarget = (part.Position - cam.CFrame.Position).Unit
				if cam.CFrame.LookVector:Dot(toTarget) < math.cos(math.rad(maxAngle)) then
					return nil -- too far off-aim: a hit here can't reconcile server-side
				end
			end
		end

		local chance = sa_config.SilentAim.HitChance or 100
		if chance < 100 and sa_rng:NextNumber(0, 100) > chance then
			return nil
		end

		return part
	end

	function SilentAim:Init(config)
		-- Deliberately stores config ONLY: the metatable hooks install lazily on
		-- the first Update with the feature enabled, so loading the script with
		-- Silent Aim off leaves the game's metatable completely untouched.
		sa_config = config
	end

	-- Per-frame hook point from the controller's loop. The installed hooks do the
	-- real work passively; this exists only to defer installation until enable.
	function SilentAim:Update(config)
		if sa_installed or not config.SilentAim.Enabled then
			return
		end
		self:_install()
	end

	function SilentAim:_install()
		if sa_installed then
			return
		end
		if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" then
			if not sa_warned then
				warn("[Vanity-General] Silent Aim needs hookmetamethod — not available in this executor.")
				sa_warned = true
			end
			sa_installed = true -- tried and failed; don't retry every frame
			return
		end
		sa_installed = true

		local function enabled()
			return sa_config.SilentAim.Enabled
		end

		-- __namecall: remote fires and Workspace.Raycast. CClosure-wrapped so the
		-- metamethod still looks like a C function to islclosure/getinfo checks.
		--
		-- sa_busy re-entry guard: sa_aimPoint does its OWN Workspace:Raycast probes
		-- and sa_plausiblePart does IsDescendantOf/FindFirstChild namecalls, all of
		-- which fire this hook again. On executors where checkcaller can't recognize
		-- a call made from inside a hook as ours, that recursion never terminates
		-- (namecall -> hook -> namecall -> ...) and kills the executor with a
		-- C stack overflow. The guard therefore covers the WHOLE hook body —
		-- target resolution included, not just the rewrite — and while it is set,
		-- everything passes through raw.
		local sa_busy = false

		-- Applies the rewrite for one call. Returns a packed result list when the
		-- call was rewritten, or nil to let the original call through untouched.
		local function rewrite(oldNamecall, self, method, part, ...)
			if method == "FireServer" or method == "InvokeServer" then
				-- Rewrite position-like args onto the target and direction-like
				-- args (unit-ish vectors) onto the arc's launch direction;
				-- everything else passes through untouched.
				local muzzle = sa_muzzle()
				local aimPoint = sa_aimPoint(muzzle, part)
				local args = { ... }
				for i, value in ipairs(args) do
					if typeof(value) == "Vector3" then
						local magnitude = value.Magnitude
						if magnitude > 0.5 and magnitude < 1.5 then
							args[i] = (aimPoint - muzzle).Unit
						else
							args[i] = part.Position
						end
					elseif typeof(value) == "CFrame" then
						args[i] = part.CFrame
					end
				end
				return table.pack(oldNamecall(self, table.unpack(args)))
			end
			if method == "Raycast" and self == Workspace then
				-- Raycast(origin, direction, params): keep the original cast
				-- length, bend the direction along the arc's launch heading.
				local origin, direction, params = ...
				if typeof(origin) == "Vector3" and typeof(direction) == "Vector3" then
					local aimPoint = sa_aimPoint(origin, part)
					local bent = (aimPoint - origin).Unit * direction.Magnitude
					return table.pack(oldNamecall(self, origin, bent, params))
				end
			end
			return nil
		end

		local oldNamecall
		oldNamecall = hookmetamethod(game, "__namecall", Cloak.CClosure(function(self, ...)
			-- Busy: a namecall issued by our own hook logic (target resolution,
			-- arc probes). Pass it straight through so it can never re-enter.
			if sa_busy then
				return oldNamecall(self, ...)
			end
			if enabled() and sa_fromGameScript() then
				-- Capture the varargs BEFORE the pcall closure — a nested function
				-- is not vararg, so '...' cannot be referenced inside it.
				local args = table.pack(...)
				sa_busy = true
				local ok, packed = pcall(function()
					local part = sa_plausiblePart()
					if not part then
						return nil
					end
					return rewrite(oldNamecall, self, getnamecallmethod(), part, table.unpack(args, 1, args.n))
				end)
				sa_busy = false
				if ok and packed then
					return table.unpack(packed, 1, packed.n)
				end
			end
			return oldNamecall(self, ...)
		end))

		-- __index: the classic Mouse.Hit / Mouse.Target spoof. Same re-entry
		-- guard: sa_plausiblePart reads properties off instances, and on
		-- executors that can't tell hook-internal reads from game reads those
		-- would fire this hook again.
		local mouse = LocalPlayer:GetMouse()
		local oldIndex
		oldIndex = hookmetamethod(game, "__index", Cloak.CClosure(function(self, key)
			if sa_busy then
				return oldIndex(self, key)
			end
			if enabled() and sa_fromGameScript() and self == mouse then
				sa_busy = true
				local ok, part = pcall(sa_plausiblePart)
				sa_busy = false
				if ok and part then
					if key == "Hit" then
						return part.CFrame
					end
					if key == "Target" then
						return part
					end
				end
			end
			return oldIndex(self, key)
		end))
	end

	return SilentAim
end)() -- /SilentAim

--============================================================================
-- HITBOX
--============================================================================
Hitbox = (function()
	--==============================================================================
	-- HITBOX EXPANDER
	-- Inflates enemy HumanoidRootParts so they're easier to hit. These are
	-- CLIENT-SIDE writes on other players' characters: whether hits actually
	-- register depends on the game (it works where the server trusts client
	-- physics). Originals are stored per character and restored on disable,
	-- cleanup, or when the character leaves the candidate set.
	--==============================================================================

	local Players = game:GetService("Players")

	local LocalPlayer = Players.LocalPlayer
	local Candidates = Candidates

	local HitboxExpander = {}
	local hb_originals = {} -- [character] = { root, size, transparency, canCollide }

	local function hb_restore(character)
		local original = hb_originals[character]
		if not original then
			return
		end
		hb_originals[character] = nil
		local root = original.root
		if root and root.Parent then
			root.Size = original.size
			root.Transparency = original.transparency
			root.CanCollide = original.canCollide
		end
	end

	local function hb_restoreAll()
		for character in pairs(hb_originals) do
			hb_restore(character)
		end
	end

	local function hb_apply(cand, config, seen)
		-- The pool guarantees a living humanoid; only the HRP presence gate remains.
		local root = cand.HRP
		if not root then
			return
		end

		local character = cand.Character
		seen[character] = true
		if not hb_originals[character] then
			hb_originals[character] = {
				root = root,
				size = root.Size,
				transparency = root.Transparency,
				canCollide = root.CanCollide,
			}
		end

		local size = config.Size or 5
		root.Size = Vector3.new(size, size, size)
		root.Transparency = config.Transparency or 0.5
		root.CanCollide = false
	end

	-- The candidate set mirrors the aimbot's: teammates skipped while Team Check is
	-- on, NPCs included only while Target Bots is on (they're in the pool then).
	function HitboxExpander:Update(config, cameraConfig)
		if not config.Enabled then
			hb_restoreAll()
			return
		end

		local seen = {}
		for _, cand in ipairs(Candidates:Get()) do
			local player = cand.Player
			if not (cameraConfig.TeamCheck and player and player.Team ~= nil and player.Team == LocalPlayer.Team) then
				hb_apply(cand, config, seen)
			end
		end

		-- Restore anyone who left the candidate set (died, left, switched teams).
		for character in pairs(hb_originals) do
			if not seen[character] then
				hb_restore(character)
			end
		end
	end

	function HitboxExpander:Cleanup()
		hb_restoreAll()
	end

	return HitboxExpander
end)() -- /Hitbox

--============================================================================
-- NORECOIL
--============================================================================
NoRecoil = (function()
	--==============================================================================
	-- NO RECOIL
	-- Hard vertical aim-lock plus Humanoid.CameraOffset zeroing.
	--==============================================================================

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer

	local NoRecoil = {}
	local function isFiring()
		return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
	end
	local basePitch = nil

	local function cameraPitch(cam)
		local look = cam.CFrame.LookVector
		return math.asin(math.clamp(look.Y, -1, 1))
	end


	-- aimbotActive: when the camera director is actively steering the view, skip the
	-- pitch lock (which also steers the CFrame) so the two don't fight. The
	-- CameraOffset kill still runs, since it doesn't touch the aim direction.
	function NoRecoil:Update(config, aimbotActive)
		if not config.Enabled then
			basePitch = nil
			return
		end

		local cam = Workspace.CurrentCamera
		if not cam then
			basePitch = nil
			return
		end

		if config.RequireMouseDown and not isFiring() then
			basePitch = nil -- re-lock on the first firing frame
			return
		end

		-- Always kill recoil/shake applied through Humanoid.CameraOffset. This is a
		-- very common Roblox recoil source (the whole view kicks) and zeroing it
		-- removes kick on every axis at once — the piece the pitch lock alone can't
		-- catch. There's no reason to want No Recoil on but this off, so it's not a
		-- switch; it just runs whenever No Recoil is active.
		local char = LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.CameraOffset = Vector3.new(0, 0, 0)
		end

		-- Pitch lock steers the camera CFrame, so hand off to the aimbot when it's on.
		if aimbotActive then
			basePitch = nil
			return
		end

		local strength = math.clamp(config.Strength, 0, 1)
		if strength <= 0 then
			basePitch = nil
			return
		end

		local pitch = cameraPitch(cam)
		if basePitch == nil then
			basePitch = pitch -- lock to wherever you started firing
			return
		end

		local drift = pitch - basePitch
		if config.AllowAim and drift < 0 then
			-- Pulled below the lock (aiming down) — adopt the lower baseline instead of
			-- fighting it, so you keep downward control while the climb stays blocked.
			basePitch = pitch
			return
		end

		if drift ~= 0 then
			-- Force the view straight back to the locked pitch.
			cam.CFrame = cam.CFrame * CFrame.Angles(-drift * strength, 0, 0)
		end
	end

	function NoRecoil:Reset()
		basePitch = nil
	end
	NoRecoil.IsFiring = isFiring

	return NoRecoil
end)() -- /NoRecoil

--============================================================================
-- NOSPREAD
--============================================================================
NoSpread = (function()
	--==============================================================================
	-- NO SPREAD
	-- Best-effort removal of client-side bullet spread via function hooking.
	--==============================================================================

	local NoRecoil = NoRecoil
	local Cloak = Cloak

	local NoSpread = {}
	local ns_active = false
	local ns_warned = false
	local ns_mathHooked = false
	local ns_randHooked = false
	local ns_strength = 1 -- 0..1, mirrored from config each frame
	local ns_origMathRandom = nil
	local ns_origNextNumber = nil
	local ns_origNextInteger = nil

	local function ns_hookApi()
		if type(hookfunction) == "function" then
			return hookfunction
		elseif type(replaceclosure) == "function" then
			return replaceclosure
		end
		return nil
	end

	-- Midpoint of a math.random(...) call, i.e. the centre of the spread cone.
	-- Mirrors math.random's three argument forms.
	local function ns_mathMid(a, b)
		if a == nil then
			return 0.5
		elseif b == nil then
			return math.floor((1 + a) / 2 + 0.5)
		else
			return math.floor((a + b) / 2 + 0.5)
		end
	end

	-- Pulls a roll from its real value toward the centre by Strength. At 1 it lands
	-- dead centre (no spread); at 0.5 the cone is halved; at 0 it's untouched. This
	-- is what makes the Strength slider meaningful rather than just on/off.
	local function ns_pull(original, centre, isInt)
		local v = original + (centre - original) * ns_strength
		if isInt then
			return math.floor(v + 0.5)
		end
		return v
	end

	-- Covers guns that use math.random for their spread cone.
	local function ns_installMath(hook)
		if ns_mathHooked then
			return
		end
		-- CClosure-wrapped: math.random is a C function stock, so the replacement
		-- must look like one too (islclosure/debug.getinfo/string.dump checks).
		--
		-- Pre-hook capture as fallback: a sane hookfunction returns the original,
		-- but an executor that returns the REPLACEMENT (or nothing) would make the
		-- hook call itself — infinite recursion, C stack overflow. The pre-hook
		-- capture is the same function object, so it is a safe fallback.
		local original = math.random
		ns_origMathRandom = original
		local replacement = Cloak.CClosure(function(...)
			local value = ns_origMathRandom(...)
			if ns_active and ns_strength > 0 then
				local a, b = ...
				-- math.random() returns a float; the (n) and (a,b) forms return integers.
				return ns_pull(value, ns_mathMid(a, b), a ~= nil)
			end
			return value
		end)
		local ok, ret = pcall(hook, math.random, replacement)
		if ok then
			if type(ret) == "function" and ret ~= replacement then
				ns_origMathRandom = ret
			end
			ns_mathHooked = true
		end
	end

	-- Covers guns that use a Random.new() object (NextNumber / NextInteger). The
	-- method closures are shared across all Random instances, so hooking them once
	-- from a sample instance affects every gun that uses them.
	local function ns_installRandom(hook)
		if ns_randHooked then
			return
		end
		local ok = pcall(function()
			local sample = Random.new()

			-- Same fallback pattern as the math hook: capture the originals
			-- pre-hook, and only trust hook()'s return when it is a different
			-- function — a self-return would recurse until C stack overflow.
			local origNumber = sample.NextNumber
			local origInteger = sample.NextInteger
			ns_origNextNumber = origNumber
			ns_origNextInteger = origInteger

			local numberReplacement = Cloak.CClosure(function(self, ...)
				local original = ns_origNextNumber(self, ...)
				if ns_active and ns_strength > 0 then
					local mn, mx = ...
					local centre = (mn == nil) and 0.5 or ((mn + mx) / 2)
					return ns_pull(original, centre, false)
				end
				return original
			end)
			local retNumber = hook(sample.NextNumber, numberReplacement)
			if type(retNumber) == "function" and retNumber ~= numberReplacement then
				ns_origNextNumber = retNumber
			end

			local integerReplacement = Cloak.CClosure(function(self, ...)
				local original = ns_origNextInteger(self, ...)
				if ns_active and ns_strength > 0 then
					local mn, mx = ...
					return ns_pull(original, (mn + mx) / 2, true)
				end
				return original
			end)
			local retInteger = hook(sample.NextInteger, integerReplacement)
			if type(retInteger) == "function" and retInteger ~= integerReplacement then
				ns_origNextInteger = retInteger
			end
		end)
		if ok then
			ns_randHooked = true
		end
	end

	function NoSpread:_install()
		if ns_mathHooked or ns_randHooked then
			return true
		end

		local hook = ns_hookApi()
		if not hook then
			if not ns_warned then
				warn("[Vanity-General] No Spread needs function hooking (hookfunction) — not available in this executor.")
				ns_warned = true
			end
			return false
		end

		ns_installMath(hook)
		ns_installRandom(hook)

		if not (ns_mathHooked or ns_randHooked) then
			if not ns_warned then
				warn("[Vanity-General] No Spread: failed to install any hook.")
				ns_warned = true
			end
			return false
		end
		return true
	end

	function NoSpread:Update(config)
		ns_strength = math.clamp(config.Strength or 1, 0, 1)

		if config.Enabled then
			if not (ns_mathHooked or ns_randHooked) and not self:_install() then
				return
			end
			ns_active = (not config.RequireMouseDown) or NoRecoil.IsFiring()
		else
			ns_active = false
		end
	end

	-- Restores the originals (called on unload) so no global hook lingers.
	function NoSpread:Cleanup()
		ns_active = false
		local hook = ns_hookApi()
		if not hook then
			return
		end
		local okMath, errMath = pcall(function()
			if ns_mathHooked and ns_origMathRandom then
				hook(math.random, ns_origMathRandom)
				ns_mathHooked = false
			end
		end)
		if not okMath then
			warn("[Vanity-General] NoSpread math.random restore failed:", errMath)
		end
		local okRand, errRand = pcall(function()
			if ns_randHooked then
				local sample = Random.new()
				if ns_origNextNumber then
					hook(sample.NextNumber, ns_origNextNumber)
				end
				if ns_origNextInteger then
					hook(sample.NextInteger, ns_origNextInteger)
				end
				ns_randHooked = false
			end
		end)
		if not okRand then
			warn("[Vanity-General] NoSpread Random restore failed:", errRand)
		end
	end

	return NoSpread
end)() -- /NoSpread

--============================================================================
-- UI
--============================================================================
UI = (function()
	--==============================================================================
	-- UI
	-- Modern tabbed interface with dark theme, smooth animations, keybind customization
	--==============================================================================

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer
	local ConfigManager = ConfigManager
	local Utility = Utility
	local Webhook = Webhook
	local Cloak = Cloak

	-- Injected by the controller (avoids a UI <-> Movement require cycle): the
	-- Players tab's "Teleport To" button calls this.
	local UI = {}

	UI.TeleportTo = nil

	-- Deep purple + black theme.
	local COLORS = {
		bg = Color3.fromRGB(10, 8, 14),        -- near-black window
		bar = Color3.fromRGB(16, 12, 22),      -- title bar / sidebar
		panel = Color3.fromRGB(19, 15, 26),    -- group box fill
		row = Color3.fromRGB(26, 20, 36),      -- control rows
		rowHover = Color3.fromRGB(38, 29, 52), -- hover lift
		accent = Color3.fromRGB(132, 62, 190), -- deep purple
		accentDim = Color3.fromRGB(92, 44, 134),
		border = Color3.fromRGB(44, 34, 60),   -- group outlines
		off = Color3.fromRGB(36, 28, 48),      -- unchecked / inactive
		text = Color3.fromRGB(226, 220, 238),
		textSub = Color3.fromRGB(138, 124, 160),
		danger = Color3.fromRGB(188, 52, 88),
	}

	local FADE_TIME = 0.18
	local ANIM = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local gui
	local mainWindow
	local windowScale
	local currentTab = "Combat"
	local layoutOrder = 0
	local visible = false
	local activeConfig -- stored by Init so visibility can be written back to config
	local onUnloadCallback -- stored by Init; the Unload button calls it (controller's Stop)

	local uisConnections = {}
	local moveHandlers = {}
	local releaseHandlers = {}
	local syncHandlers = {}

	local targetPanel, targetPanelLabel -- floating "who you're locked onto" popup
	local targetDisplayOn = false
	local keybindPanel -- standalone keybind window (Settings > Interface toggle)
	local watermark -- bottom-left watermark logo
	local fpsPanel, fpsLabel -- bottom-right fps readout
	local activeCapture
	local capturingKey = false
	local activeDropdown = nil -- { frame, close, contains } for the one open dropdown

	-- Players tab state.
	local playerRows = {} -- player -> { btn, dist }
	local playerListFrame
	local selectedPlayer
	local spectatePlayer
	local spectateBtn -- action button whose label flips with the spectate state

	-- Recolors every existing element still showing the OLD accent to the new one.
	-- Rapid changes (e.g. dragging the color picker) are coalesced with task.defer
	-- so the tree is only walked once per frame.
	local pendingAccent = nil
	local function applyAccent(newColor)
		local oldColor = COLORS.accent
		if newColor == oldColor then
			return
		end
		COLORS.accent = newColor
		if activeConfig and activeConfig.UI then
			activeConfig.UI.Accent = newColor
		end
		if not gui then
			return
		end
		-- Coalesce rapid successive calls into a single tree walk.
		pendingAccent = newColor
		task.defer(function()
			if pendingAccent ~= newColor then
				return
			end
			pendingAccent = nil
			for _, inst in ipairs(gui:GetDescendants()) do
				if inst:IsA("GuiObject") then
					if inst.BackgroundColor3 == oldColor then
						inst.BackgroundColor3 = newColor
					end
					if (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox"))
						and inst.TextColor3 == oldColor
					then
						inst.TextColor3 = newColor
					end
					if inst:IsA("ScrollingFrame") and inst.ScrollBarImageColor3 == oldColor then
						inst.ScrollBarImageColor3 = newColor
					end
				elseif inst:IsA("UIStroke") and inst.Color == oldColor then
					inst.Color = newColor
				end
			end
		end)
	end

	local function refreshSpectateBtn()
		if spectateBtn then
			spectateBtn.Text = spectatePlayer and "Stop Spectating" or "Spectate"
		end
	end

	local function stopSpectate()
		if not spectatePlayer then
			return
		end
		spectatePlayer = nil
		-- Hand the camera back to the local humanoid.
		local cam = Workspace.CurrentCamera
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if cam and humanoid then
			cam.CameraSubject = humanoid
		end
		refreshSpectateBtn()
	end

	local function startSpectate(player)
		local character = player and player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local cam = Workspace.CurrentCamera
		if not (cam and humanoid) then
			return
		end
		spectatePlayer = player
		cam.CameraSubject = humanoid
		refreshSpectateBtn()
	end

	-- True while the camera follows another player; the controller's aimbot skips
	-- steering then so the two don't fight over the camera.
	function UI.IsSpectating()
		return spectatePlayer ~= nil
	end

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

		-- Click anywhere outside an open dropdown closes it.
		table.insert(uisConnections, UserInputService.InputBegan:Connect(function(input)
			if not activeDropdown or not isPointer(input) then
				return
			end
			local pos = Vector2.new(input.Position.X, input.Position.Y)
			if not activeDropdown.contains(pos) then
				activeDropdown.close()
			end
		end))

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

	-- Compact checkbox row: small square on the left, label beside it.
	local function makeToggle(parent, text, getValue, onChange)
		local btn = newInstance("TextButton", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
		})

		local box = newInstance("Frame", {
			Parent = btn,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(13, 13),
			BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 3) })
		newInstance("UIStroke", { Parent = box, Color = COLORS.border, Thickness = 1 })

		local label = newInstance("TextLabel", {
			Parent = btn,
			Position = UDim2.fromOffset(21, 0),
			Size = UDim2.new(1, -21, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = getValue() and COLORS.text or COLORS.textSub,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = text,
		})

		local function refresh()
			local on = getValue()
			TweenService:Create(box, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
			TweenService:Create(label, ANIM, { TextColor3 = on and COLORS.text or COLORS.textSub }):Play()
		end

		btn.MouseButton1Click:Connect(function()
			onChange()
			refresh()
		end)

		btn.MouseEnter:Connect(function()
			if not getValue() then
				box.BackgroundColor3 = COLORS.rowHover
			end
		end)

		btn.MouseLeave:Connect(function()
			if not getValue() then
				box.BackgroundColor3 = COLORS.off
			end
		end)

		table.insert(syncHandlers, refresh)
	end

	local function makeSlider(parent, text, min, max, getValue, setValue, isInt, suffix)
		suffix = suffix or ""
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
			local base = isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
			return base .. suffix
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
		local ROW_H = 24
		local fullSize = #options * ROW_H
		-- Cap the open height so long lists (e.g. every body part) stay on-screen and
		-- scroll instead of running off the bottom.
		local listSize = math.min(fullSize, 7 * ROW_H)

		local list = newInstance("ScrollingFrame", {
			Parent = dropdown,
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.fromOffset(0, 30),
			BackgroundColor3 = COLORS.bar,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Visible = false,
			ZIndex = 10,
			CanvasSize = UDim2.fromOffset(0, fullSize),
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = COLORS.accent,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Active = true,
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

	-- Clickable action button with hover feedback. `color` defaults to the accent.
	local function makeButton(parent, text, onClick, color)
		local base = color or COLORS.accent
		local hover = Color3.new(
			math.min(base.R + 0.1, 1),
			math.min(base.G + 0.1, 1),
			math.min(base.B + 0.1, 1)
		)

		local btn = newInstance("TextButton", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = base,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = text,
		})

		newInstance("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

		btn.MouseButton1Click:Connect(onClick)

		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, ANIM, { BackgroundColor3 = hover }):Play()
		end)

		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, ANIM, { BackgroundColor3 = base }):Play()
		end)

		return btn
	end

	-- Single-line text input. Returns the TextBox so callers can read/set .Text.
	local function makeTextBox(parent, placeholder)
		local holder = newInstance("Frame", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = COLORS.row,
			BorderSizePixel = 0,
		})

		newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
		local stroke = newInstance("UIStroke", {
			Parent = holder,
			Color = COLORS.border,
			Thickness = 1,
			Transparency = 0.3,
		})

		local box = newInstance("TextBox", {
			Parent = holder,
			Size = UDim2.new(1, -16, 1, 0),
			Position = UDim2.fromOffset(8, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = COLORS.text,
			PlaceholderText = placeholder or "",
			PlaceholderColor3 = COLORS.textSub,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			Text = "",
		})

		box.Focused:Connect(function()
			TweenService:Create(stroke, ANIM, { Transparency = 0, Color = COLORS.accent }):Play()
		end)

		box.FocusLost:Connect(function()
			TweenService:Create(stroke, ANIM, { Transparency = 0.3, Color = COLORS.border }):Play()
		end)

		return box
	end

	-- Small section header ("TARGET SETTINGS", "HITBOX") to group related controls.
	local function makeHeader(parent, text)
		newInstance("TextLabel", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 18),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = COLORS.textSub,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = string.upper(text),
		})
	end

	-- Filled-row slider: the accent fill grows with the value and the label sits on
	-- top, e.g. "Head Weight: 85/100%". showMax appends "/<max><unit>".
	local function makeFillSlider(parent, text, min, max, getValue, setValue, isInt, unit, showMax)
		unit = unit or ""

		local holder = newInstance("TextButton", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = COLORS.row,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
			ClipsDescendants = true,
		})

		newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

		local fill = newInstance("Frame", {
			Parent = holder,
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = COLORS.accent,
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,
			ZIndex = 1,
		})

		newInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(0, 6) })

		local label = newInstance("TextLabel", {
			Parent = holder,
			Size = UDim2.new(1, -16, 1, 0),
			Position = UDim2.fromOffset(8, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = text,
			ZIndex = 3,
		})

		local function fmt(v)
			local s = isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
			if showMax then
				local m = isInt and tostring(math.floor(max + 0.5)) or string.format("%.2f", max)
				return s .. "/" .. m .. unit
			end
			return s .. unit
		end

		local function apply(v)
			v = math.clamp(v, min, max)
			if isInt then
				v = math.floor(v + 0.5)
			end
			local alpha = (max > min) and (v - min) / (max - min) or 0
			fill.Size = UDim2.new(alpha, 0, 1, 0)
			label.Text = text .. ": " .. fmt(v)
			setValue(v)
		end

		apply(getValue())

		local dragging = false

		local function fromInput(px)
			local alpha = math.clamp((px - holder.AbsolutePosition.X) / holder.AbsoluteSize.X, 0, 1)
			apply(min + alpha * (max - min))
		end

		holder.InputBegan:Connect(function(input)
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

	-- Full-width dropdown. The option list expands INLINE (growing the panel and
	-- pushing whatever follows down) rather than floating over the layout — floating
	-- got clipped by the scroll panel and drawn over by sibling group boxes.
	local function makeDropdownFull(parent, options, getValue, onChange)
		local holder = newInstance("Frame", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})

		newInstance("UIListLayout", {
			Parent = holder,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		})

		local dropdown = newInstance("TextButton", {
			Parent = holder,
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = COLORS.row,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
		})

		newInstance("UICorner", { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
		local dropStroke = newInstance("UIStroke", {
			Parent = dropdown,
			Color = COLORS.border,
			Thickness = 1,
			Transparency = 0.3,
		})

		local valueLabel = newInstance("TextLabel", {
			Parent = dropdown,
			Size = UDim2.new(1, -34, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Text = getValue(),
		})

		local caret = newInstance("TextLabel", {
			Parent = dropdown,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Size = UDim2.fromOffset(14, 14),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.accent,
			Text = "▾",
		})

		local open = false
		local ROW_H = 26
		local fullSize = #options * ROW_H
		local listSize = math.min(fullSize, 6 * ROW_H)

		local list = newInstance("ScrollingFrame", {
			Parent = holder,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundColor3 = COLORS.bar,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Visible = false,
			CanvasSize = UDim2.fromOffset(0, fullSize),
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = COLORS.accent,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Active = true,
		})

		newInstance("UICorner", { Parent = list, CornerRadius = UDim.new(0, 6) })
		newInstance("UIStroke", { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })

		local optionButtons = {}

		-- Repaints every row so the active choice reads as selected.
		local function paintOptions()
			local current = getValue()
			for option, btn in pairs(optionButtons) do
				local selected = (option == current)
				btn.BackgroundColor3 = selected and COLORS.accent or COLORS.panel
				btn.BackgroundTransparency = selected and 0 or 1
				btn.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or COLORS.textSub
				btn.Font = selected and Enum.Font.GothamBold or Enum.Font.Gotham
			end
		end

		local function collapse()
			if not open then
				return
			end
			open = false
			if activeDropdown and activeDropdown.frame == dropdown then
				activeDropdown = nil
			end
			TweenService:Create(caret, ANIM, { Rotation = 0 }):Play()
			TweenService:Create(dropStroke, ANIM, { Transparency = 0.3 }):Play()
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
			task.delay(FADE_TIME, function()
				if not open then
					list.Visible = false
				end
			end)
		end

		local function expand()
			if open then
				return
			end
			if activeDropdown and activeDropdown.close then
				activeDropdown.close() -- only one open at a time
			end
			open = true
			paintOptions()
			list.Visible = true
			TweenService:Create(caret, ANIM, { Rotation = 180 }):Play()
			TweenService:Create(dropStroke, ANIM, { Transparency = 0 }):Play()
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, listSize) }):Play()

			activeDropdown = {
				frame = dropdown,
				close = collapse,
				contains = function(pos)
					local function inside(obj)
						local p, s = obj.AbsolutePosition, obj.AbsoluteSize
						return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
					end
					return inside(dropdown) or (list.Visible and inside(list))
				end,
			}
		end

		for i, option in ipairs(options) do
			local optionBtn = newInstance("TextButton", {
				Parent = list,
				Size = UDim2.new(1, 0, 0, ROW_H),
				Position = UDim2.fromOffset(0, (i - 1) * ROW_H),
				BackgroundColor3 = COLORS.panel,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Font = Enum.Font.Gotham,
				TextSize = 11,
				TextColor3 = COLORS.textSub,
				Text = option,
				AutoButtonColor = false,
			})

			optionButtons[option] = optionBtn

			optionBtn.MouseButton1Click:Connect(function()
				onChange(option)
				valueLabel.Text = option
				paintOptions()
				collapse()
			end)

			optionBtn.MouseEnter:Connect(function()
				if option ~= getValue() then
					optionBtn.BackgroundTransparency = 0
					optionBtn.BackgroundColor3 = COLORS.rowHover
					optionBtn.TextColor3 = COLORS.text
				end
			end)

			optionBtn.MouseLeave:Connect(function()
				paintOptions()
			end)
		end

		paintOptions()

		dropdown.MouseButton1Click:Connect(function()
			if open then
				collapse()
			else
				expand()
			end
		end)

		dropdown.MouseEnter:Connect(function()
			if not open then
				TweenService:Create(dropdown, ANIM, { BackgroundColor3 = COLORS.rowHover }):Play()
			end
		end)

		dropdown.MouseLeave:Connect(function()
			if not open then
				TweenService:Create(dropdown, ANIM, { BackgroundColor3 = COLORS.row }):Play()
			end
		end)

		table.insert(syncHandlers, function()
			valueLabel.Text = getValue()
			paintOptions()
		end)
	end

	-- HSV color picker: saturation/value square + hue strip + hex readout.
	local function makeColorPicker(parent, title, getColor, setColor)
		local h, s, v = getColor():ToHSV()
		local SQ_H, HUE_W, GAP = 120, 16, 8

		local holder = newInstance("Frame", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, SQ_H + 74),
			BackgroundColor3 = COLORS.panel,
			BorderSizePixel = 0,
		})

		newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
		newInstance("UIStroke", { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
		newInstance("UIPadding", {
			Parent = holder,
			PaddingTop = UDim.new(0, 8),
			PaddingBottom = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 8),
		})

		local heading = newInstance("TextLabel", {
			Parent = holder,
			Size = UDim2.new(1, 0, 0, 16),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = title or "Color",
		})

		local body = newInstance("Frame", {
			Parent = holder,
			Position = UDim2.fromOffset(0, 20),
			Size = UDim2.new(1, 0, 1, -20),
			BackgroundTransparency = 1,
		})

		local sq = newInstance("Frame", {
			Parent = body,
			Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H), -- responsive: fits any column width
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
			Parent = body,
			Size = UDim2.fromOffset(HUE_W, SQ_H),
			Position = UDim2.new(1, -HUE_W, 0, 0),
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
			Parent = body,
			Size = UDim2.fromOffset(22, 22),
			Position = UDim2.fromOffset(0, SQ_H + 6),
			BackgroundColor3 = getColor(),
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = preview, CornerRadius = UDim.new(0, 4) })
		newInstance("UIStroke", { Parent = preview, Color = COLORS.off, Thickness = 1 })

		local hexLabel = newInstance("TextLabel", {
			Parent = body,
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
			hexLabel.Text = string.format("#%02X%02X%02X  (%d, %d, %d)", r, g, b, r, g, b)
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

	-- Wires capture/refresh/sync behavior onto an already-created keybind box
	-- (a TextButton). Shared by the standalone keybind row and the inline
	-- toggle+keybind control so the capture state machine lives in one place.
	local function wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
		local listening = false

		local function refresh()
			if listening then
				box.Text = "Press…"
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
				activeCapture = nil
				task.defer(function()
					capturingKey = false
				end)
				capture.cancel()
				return
			end
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

		refresh()
	end

	-- Returns the name of the action already using `key` (excluding `field`), or nil.
	-- Fields: menu, aimbot, esp, fovcircle, norecoil, nospread, clicktp, unload.
	local function keyConflict(config, key, field)
		if field ~= "menu" and config.UI.MenuKey == key then
			return "Menu"
		end
		if field ~= "aimbot" and config.Camera.ToggleKey == key then
			return "Aimbot"
		end
		if field ~= "esp" and config.ESP.ToggleKey == key then
			return "ESP"
		end
		if field ~= "fovcircle" and config.Camera.FOVCircleKey == key then
			return "FOV Circle"
		end
		if field ~= "norecoil" and config.NoRecoil.ToggleKey == key then
			return "No Recoil"
		end
		if field ~= "nospread" and config.NoSpread.ToggleKey == key then
			return "No Spread"
		end
		if field ~= "triggerbot" and config.Triggerbot.ToggleKey == key then
			return "Triggerbot"
		end
		if field ~= "clicktp" and config.Movement.ClickTPKey == key then
			return "Click TP"
		end
		if field ~= "unload" and config.UI.UnloadKey == key then
			return "Unload"
		end
		return nil
	end

	-- Standalone keybind row: a label on the left and a clickable key box on the right.
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

		wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
	end

	-- Toggle row with an inline keybind box sitting just left of the switch. The row
	-- itself toggles on click; the key box captures its own clicks (it's on top) so
	-- rebinding never flips the toggle.
	-- Checkbox row with an inline keybind box on the right. The row toggles; the key
	-- box captures its own clicks (it sits on top) so rebinding never flips it.
	local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
		local btn = newInstance("TextButton", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 24),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
		})

		local check = newInstance("Frame", {
			Parent = btn,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(13, 13),
			BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = check, CornerRadius = UDim.new(0, 3) })
		newInstance("UIStroke", { Parent = check, Color = COLORS.border, Thickness = 1 })

		local label = newInstance("TextLabel", {
			Parent = btn,
			Position = UDim2.fromOffset(21, 0),
			Size = UDim2.new(1, -76, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = getValue() and COLORS.text or COLORS.textSub,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = text,
		})

		local box = newInstance("TextButton", {
			Parent = btn,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0),
			Size = UDim2.fromOffset(0, 20),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = COLORS.bar,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = COLORS.accent,
			Text = getKey().Name,
			ZIndex = 3,
		})

		newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 4) })
		newInstance("UIStroke", { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
		newInstance("UIPadding", {
			Parent = box,
			PaddingLeft = UDim.new(0, 7),
			PaddingRight = UDim.new(0, 7),
		})
		newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(44, 20) })

		local function refresh()
			local on = getValue()
			TweenService:Create(check, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
			TweenService:Create(label, ANIM, { TextColor3 = on and COLORS.text or COLORS.textSub }):Play()
		end

		btn.MouseButton1Click:Connect(function()
			onChange()
			refresh()
		end)

		table.insert(syncHandlers, refresh)

		wireKeybindBox(box, keyLabel, getKey, setKey, conflictCheck)
	end

	-- Splits a tab panel into two side-by-side columns (the tab's own layout is
	-- horizontal). Groups get distributed between them for the two-column look.
	local function makeColumns(parent)
		local function column(order)
			local col = newInstance("Frame", {
				Parent = parent,
				LayoutOrder = order,
				Size = UDim2.new(0.5, -4, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
			})
			newInstance("UIListLayout", {
				Parent = col,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			})
			return col
		end
		return column(1), column(2)
	end

	-- Bordered, titled panel. Returns:
	--   content   -- parent controls to this
	--   setEnabled(bool) -- greys the panel out and blocks input when false
	local function makeGroup(parent, title)
		-- Wrapper holds the panel plus the disabled veil. It deliberately has NO
		-- AutomaticSize: AutomaticSize measures the veil too, so the veil (sized off
		-- the wrapper) and the wrapper would inflate each other into a giant box. Its
		-- height is instead synced from the panel below, which nothing else depends on.
		local wrapper = newInstance("Frame", {
			Parent = parent,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})

		local box = newInstance("Frame", {
			Parent = wrapper,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = COLORS.panel,
			BorderSizePixel = 0,
		})

		newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 6) })
		newInstance("UIStroke", { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
		newInstance("UIPadding", {
			Parent = box,
			PaddingTop = UDim.new(0, 8),
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
		})
		newInstance("UIListLayout", {
			Parent = box,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
		})

		newInstance("TextLabel", {
			Parent = box,
			LayoutOrder = -1,
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = title,
		})

		-- Disabled veil: dims the panel AND hatches it with diagonal lines so it reads
		-- as unusable. It's a TextButton (not a Frame+Active) because only a button
		-- reliably swallows the press that starts a slider drag.
		local veil = newInstance("TextButton", {
			Parent = wrapper,
			Position = UDim2.fromOffset(0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = COLORS.bg,
			BackgroundTransparency = 0.45,
			BorderSizePixel = 0,
			Visible = false,
			Active = true,
			AutoButtonColor = false,
			Text = "",
			ClipsDescendants = true,
			ZIndex = 50,
		})
		newInstance("UICorner", { Parent = veil, CornerRadius = UDim.new(0, 6) })

		-- Diagonal hatching drawn with a rotated GRADIENT, not rotated frames:
		-- ClipsDescendants does not clip rotated children in Roblox, so the old stripe
		-- frames escaped the panel and smeared across the whole menu. A gradient is
		-- painted inside its own frame, so it can never spill.
		local STRIPE, GAP = 0.72, 1 -- transparency of a stripe vs the space between
		local hatch = newInstance("Frame", {
			Parent = veil,
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = COLORS.textSub,
			BorderSizePixel = 0,
			ZIndex = 51,
		})
		newInstance("UICorner", { Parent = hatch, CornerRadius = UDim.new(0, 6) })
		newInstance("UIGradient", {
			Parent = hatch,
			Rotation = 35,
			-- Alternating hard bands (paired keypoints make the edges crisp).
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0.000, GAP),
				NumberSequenceKeypoint.new(0.119, GAP),
				NumberSequenceKeypoint.new(0.120, STRIPE),
				NumberSequenceKeypoint.new(0.199, STRIPE),
				NumberSequenceKeypoint.new(0.200, GAP),
				NumberSequenceKeypoint.new(0.319, GAP),
				NumberSequenceKeypoint.new(0.320, STRIPE),
				NumberSequenceKeypoint.new(0.399, STRIPE),
				NumberSequenceKeypoint.new(0.400, GAP),
				NumberSequenceKeypoint.new(0.519, GAP),
				NumberSequenceKeypoint.new(0.520, STRIPE),
				NumberSequenceKeypoint.new(0.599, STRIPE),
				NumberSequenceKeypoint.new(0.600, GAP),
				NumberSequenceKeypoint.new(0.719, GAP),
				NumberSequenceKeypoint.new(0.720, STRIPE),
				NumberSequenceKeypoint.new(0.799, STRIPE),
				NumberSequenceKeypoint.new(0.800, GAP),
				NumberSequenceKeypoint.new(0.919, GAP),
				NumberSequenceKeypoint.new(0.920, STRIPE),
				NumberSequenceKeypoint.new(1.000, STRIPE),
			}),
		})

		-- Keep the wrapper exactly as tall as the panel. AbsoluteSize is already
		-- post-UIScale while Size offsets get scaled again, so divide it back out.
		local function syncWrapper()
			local sc = (windowScale and windowScale.Scale) or 1
			if sc <= 0 then
				sc = 1
			end
			wrapper.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / sc)
		end

		box:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncWrapper)
		syncWrapper()

		local function setEnabled(enabled)
			veil.Visible = not enabled
		end

		return box, setEnabled
	end

	-- Sub-tab bar across the top of a section, with one scrolling two-column panel
	-- per sub-tab below it. Returns a host whose :add(name) creates a sub-tab and
	-- returns its content frame (pass that to makeColumns). First added shows first.
	local function makeSubTabHost(parent)
		local bar = newInstance("Frame", {
			Parent = parent,
			Size = UDim2.new(1, 0, 0, 24),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UIListLayout", {
			Parent = bar,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 14),
		})

		-- Thin divider under the bar.
		local divider = newInstance("Frame", {
			Parent = parent,
			Position = UDim2.fromOffset(0, 27),
			Size = UDim2.new(1, -6, 0, 1),
			BackgroundColor3 = COLORS.border,
			BackgroundTransparency = 0.2,
			BorderSizePixel = 0,
		})

		local area = newInstance("Frame", {
			Parent = parent,
			Position = UDim2.fromOffset(0, 34),
			Size = UDim2.new(1, 0, 1, -34),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})

		local host = { frames = {}, buttons = {}, order = 0, current = nil }

		local function select(name)
			host.current = name
			for n, f in pairs(host.frames) do
				f.Visible = (n == name)
			end
			for n, b in pairs(host.buttons) do
				local active = (n == name)
				TweenService:Create(b.btn, ANIM, { TextColor3 = active and COLORS.text or COLORS.textSub }):Play()
				TweenService:Create(b.underline, ANIM, { BackgroundTransparency = active and 0 or 1 }):Play()
			end
		end

		function host:add(name)
			self.order = self.order + 1

			local btn = newInstance("TextButton", {
				Parent = bar,
				LayoutOrder = self.order,
				Size = UDim2.fromOffset(0, 24),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				TextColor3 = COLORS.textSub,
				Text = name,
			})

			local underline = newInstance("Frame", {
				Parent = btn,
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.5, 0, 1, 1),
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundColor3 = COLORS.accent,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
			})
			newInstance("UICorner", { Parent = underline, CornerRadius = UDim.new(1, 0) })

			local frame = newInstance("ScrollingFrame", {
				Parent = area,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Visible = false,
				CanvasSize = UDim2.new(0, 0, 0, 0),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 5,
				ScrollBarImageColor3 = COLORS.accent,
				ScrollBarImageTransparency = 0.25,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				Active = true,
			})
			newInstance("UIListLayout", {
				Parent = frame,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				Padding = UDim.new(0, 8),
			})
			newInstance("UIPadding", { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })

			self.buttons[name] = { btn = btn, underline = underline }
			self.frames[name] = frame

			btn.MouseButton1Click:Connect(function()
				select(name)
			end)
			btn.MouseEnter:Connect(function()
				if host.current ~= name then
					btn.TextColor3 = COLORS.text
				end
			end)
			btn.MouseLeave:Connect(function()
				if host.current ~= name then
					btn.TextColor3 = COLORS.textSub
				end
			end)

			if not self.current then
				select(name)
			end
			return frame
		end

		return host
	end

	local function buildCameraTab(parent, config)
		layoutOrder = 0
		local host = makeSubTabHost(parent)
		local left, right = makeColumns(host:add("Aimbot"))

		local aim = makeGroup(left, "Aimbot")

		makeToggleWithKeybind(aim, "Enabled", function()
			return config.Camera.Enabled
		end, function()
			config.Camera.Enabled = not config.Camera.Enabled
		end, "Aimbot Key", function()
			return config.Camera.ToggleKey
		end, function(key)
			config.Camera.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "aimbot")
		end)

		makeToggle(aim, "Vischeck", function()
			return config.Camera.WallCheck
		end, function()
			config.Camera.WallCheck = not config.Camera.WallCheck
		end)

		makeToggle(aim, "Target Bots", function()
			return config.Camera.TargetBots
		end, function()
			config.Camera.TargetBots = not config.Camera.TargetBots
		end)

		makeToggle(aim, "Team Check", function()
			return config.Camera.TeamCheck
		end, function()
			config.Camera.TeamCheck = not config.Camera.TeamCheck
		end)

		makeToggleWithKeybind(aim, "FOV Circle", function()
			return config.Camera.FOVCircle
		end, function()
			config.Camera.FOVCircle = not config.Camera.FOVCircle
		end, "FOV Circle Key", function()
			return config.Camera.FOVCircleKey
		end, function(key)
			config.Camera.FOVCircleKey = key
		end, function(key)
			return keyConflict(config, key, "fovcircle")
		end)

		makeFillSlider(aim, "Smoothness", 0.05, 1, function()
			return config.Camera.Smoothness
		end, function(val)
			config.Camera.Smoothness = val
		end, false)

		-- FOV drives both the targeting cone and the on-screen circle.
		makeFillSlider(aim, "FOV", 20, 800, function()
			return config.Camera.FOV
		end, function(val)
			config.Camera.FOV = val
		end, true, "px", true)

		makeFillSlider(aim, "Max Distance", 100, 2000, function()
			return config.Camera.MaxDistance
		end, function(val)
			config.Camera.MaxDistance = val
		end, true, "m", true)

		-- Declared up front so the dropdown's callback can refresh the weights gate,
		-- which is created just below it.
		local refreshWeightGate

		local hitbox = makeGroup(right, "Hitbox")
		makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
			return config.Camera.Hitbox
		end, function(val)
			config.Camera.Hitbox = val
			if refreshWeightGate then
				refreshWeightGate()
			end
		end)

		-- Per-region weights live with the Hitbox mode that uses them, on the right.
		local weights, setWeightsEnabled = makeGroup(right, "Target Settings")

		local function weightRow(name)
			makeFillSlider(weights, name .. " Weight", 0, 100, function()
				return config.Camera.TargetWeights[name]
			end, function(val)
				config.Camera.TargetWeights[name] = val
			end, true, "%", true)
		end

		weightRow("Head")
		weightRow("Torso")
		weightRow("Arms")
		weightRow("Legs")

		-- Weights only do anything in Random (Weighted); grey the panel out and block
		-- input when a specific body part is picked instead.
		refreshWeightGate = function()
			setWeightsEnabled(config.Camera.Hitbox == "Random (Weighted)")
		end
		refreshWeightGate()
		table.insert(syncHandlers, refreshWeightGate)

		-- Triggerbot lives with the Aimbot on this sub-tab.
		local trigger = makeGroup(right, "Triggerbot")

		makeToggleWithKeybind(trigger, "Enabled", function()
			return config.Triggerbot.Enabled
		end, function()
			config.Triggerbot.Enabled = not config.Triggerbot.Enabled
		end, "Triggerbot Key", function()
			return config.Triggerbot.ToggleKey
		end, function(key)
			config.Triggerbot.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "triggerbot")
		end)

		makeFillSlider(trigger, "Min Delay", 0, 500, function()
			return config.Triggerbot.MinDelay * 1000
		end, function(val)
			config.Triggerbot.MinDelay = val / 1000
		end, true, "ms", true)

		makeFillSlider(trigger, "Max Delay", 0, 500, function()
			return config.Triggerbot.MaxDelay * 1000
		end, function(val)
			config.Triggerbot.MaxDelay = val / 1000
		end, true, "ms", true)

		makeFillSlider(trigger, "Max Distance", 100, 2000, function()
			return config.Triggerbot.MaxDistance
		end, function(val)
			config.Triggerbot.MaxDistance = val
		end, true, "m", true)

		makeToggle(trigger, "Vischeck", function()
			return config.Triggerbot.WallCheck
		end, function()
			config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
		end)

		-- Silent Aim curves shots onto the target without moving the camera — over
		-- obstacles when the line is blocked. On executors without hookmetamethod
		-- the toggle simply does nothing (see the SILENT AIM section).
		local silent = makeGroup(right, "Silent Aim")

		makeToggle(silent, "Enabled", function()
			return config.SilentAim.Enabled
		end, function()
			config.SilentAim.Enabled = not config.SilentAim.Enabled
		end)

		-- Client-side root inflation; originals restore when toggled back off.
		local expander = makeGroup(right, "Hitbox Expander")

		makeToggle(expander, "Enabled", function()
			return config.Hitbox.Enabled
		end, function()
			config.Hitbox.Enabled = not config.Hitbox.Enabled
		end)

		makeFillSlider(expander, "Size", 1, 20, function()
			return config.Hitbox.Size
		end, function(val)
			config.Hitbox.Size = val
		end, true)

		makeFillSlider(expander, "Transparency", 0, 1, function()
			return config.Hitbox.Transparency
		end, function(val)
			config.Hitbox.Transparency = val
		end, false)

		------------------------------------------------------------------- Weapons --
		left, right = makeColumns(host:add("Weapons"))

		local recoil = makeGroup(left, "No Recoil")

		makeToggleWithKeybind(recoil, "Enabled", function()
			return config.NoRecoil.Enabled
		end, function()
			config.NoRecoil.Enabled = not config.NoRecoil.Enabled
		end, "No Recoil Key", function()
			return config.NoRecoil.ToggleKey
		end, function(key)
			config.NoRecoil.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "norecoil")
		end)

		makeToggle(recoil, "Only While Firing", function()
			return config.NoRecoil.RequireMouseDown
		end, function()
			config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
		end)

		makeToggle(recoil, "Allow Aim Down", function()
			return config.NoRecoil.AllowAim
		end, function()
			config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
		end)

		makeFillSlider(recoil, "Strength", 0, 100, function()
			return config.NoRecoil.Strength * 100
		end, function(val)
			config.NoRecoil.Strength = val / 100
		end, true, "%", true)

		local spread = makeGroup(left, "No Spread")

		makeToggleWithKeybind(spread, "Enabled", function()
			return config.NoSpread.Enabled
		end, function()
			config.NoSpread.Enabled = not config.NoSpread.Enabled
		end, "No Spread Key", function()
			return config.NoSpread.ToggleKey
		end, function(key)
			config.NoSpread.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "nospread")
		end)

		makeToggle(spread, "Only While Firing", function()
			return config.NoSpread.RequireMouseDown
		end, function()
			config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
		end)

		makeFillSlider(spread, "Strength", 0, 100, function()
			return config.NoSpread.Strength * 100
		end, function(val)
			config.NoSpread.Strength = val / 100
		end, true, "%", true)
	end

	local function buildESPTab(parent, config)
		layoutOrder = 0
		local host = makeSubTabHost(parent)
		local left, right = makeColumns(host:add("ESP"))

		local esp = makeGroup(left, "ESP")

		makeToggleWithKeybind(esp, "Enabled", function()
			return config.ESP.Enabled
		end, function()
			config.ESP.Enabled = not config.ESP.Enabled
		end, "ESP Key", function()
			return config.ESP.ToggleKey
		end, function(key)
			config.ESP.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "esp")
		end)

		makeToggle(esp, "NPCs", function()
			return config.ESP.NPCs
		end, function()
			config.ESP.NPCs = not config.ESP.NPCs
		end)

		makeFillSlider(esp, "Max Distance", 100, 2000, function()
			return config.ESP.MaxDistance
		end, function(val)
			config.ESP.MaxDistance = val
		end, true, "m", true)

		-- Appearance: render style, fill toggle, then the opacities at the bottom.
		local look = makeGroup(left, "Appearance")

		makeToggle(look, "Outlines", function()
			return config.ESP.Outlines
		end, function()
			config.ESP.Outlines = not config.ESP.Outlines
		end)

		makeToggle(look, "Boxes", function()
			return config.ESP.Boxes
		end, function()
			config.ESP.Boxes = not config.ESP.Boxes
		end)

		makeToggle(look, "Names", function()
			return config.ESP.Names
		end, function()
			config.ESP.Names = not config.ESP.Names
		end)

		makeToggle(look, "Distance", function()
			return config.ESP.Distance
		end, function()
			config.ESP.Distance = not config.ESP.Distance
		end)

		makeToggle(look, "Health Bars", function()
			return config.ESP.HealthBars
		end, function()
			config.ESP.HealthBars = not config.ESP.HealthBars
		end)

		makeToggle(look, "Filled", function()
			return config.ESP.Filled
		end, function()
			config.ESP.Filled = not config.ESP.Filled
		end)

		makeFillSlider(look, "Outline Opacity", 0, 1, function()
			return config.ESP.OutlineOpacity
		end, function(val)
			config.ESP.OutlineOpacity = val
		end, false)

		makeFillSlider(look, "Fill Opacity", 0, 1, function()
			return config.ESP.FillOpacity
		end, function(val)
			config.ESP.FillOpacity = val
		end, false)

		-- Executor Drawing-library boxes/tracers (no-op where Drawing is missing).
		local drawing = makeGroup(right, "Drawing ESP")

		makeToggle(drawing, "Boxes", function()
			return config.Drawing.Boxes
		end, function()
			config.Drawing.Boxes = not config.Drawing.Boxes
		end)

		makeToggle(drawing, "Tracers", function()
			return config.Drawing.Tracers
		end, function()
			config.Drawing.Tracers = not config.Drawing.Tracers
		end)

		local world = makeGroup(right, "World")

		makeToggle(world, "Fullbright", function()
			return config.Visuals.Fullbright
		end, function()
			config.Visuals.Fullbright = not config.Visuals.Fullbright
		end)

		makeToggle(world, "No Fog", function()
			return config.Visuals.NoFog
		end, function()
			config.Visuals.NoFog = not config.Visuals.NoFog
		end)

		----------------------------------------------------------------- Colors -----
		left, right = makeColumns(host:add("Colors"))

		makeColorPicker(left, "Outline Color", function()
			return config.ESP.OutlineColor
		end, function(c)
			config.ESP.OutlineColor = c
		end)

		makeColorPicker(right, "Fill Color", function()
			return config.ESP.FillColor
		end, function(c)
			config.ESP.FillColor = c
		end)

		makeColorPicker(left, "Box Color", function()
			return config.Drawing.BoxColor
		end, function(c)
			config.Drawing.BoxColor = c
		end)

		makeColorPicker(right, "Tracer Color", function()
			return config.Drawing.TracerColor
		end, function(c)
			config.Drawing.TracerColor = c
		end)
	end

	local function buildMovementTab(parent, config)
		layoutOrder = 0
		local host = makeSubTabHost(parent)
		local left, right = makeColumns(host:add("Movement"))

		local fly = makeGroup(left, "Fly")

		makeToggle(fly, "Enabled", function()
			return config.Movement.FlyEnabled
		end, function()
			config.Movement.FlyEnabled = not config.Movement.FlyEnabled
		end)

		makeFillSlider(fly, "Fly Speed", 10, 200, function()
			return config.Movement.FlySpeed
		end, function(val)
			config.Movement.FlySpeed = val
		end, true)

		local speed = makeGroup(left, "Speed")

		makeToggle(speed, "Enabled", function()
			return config.Movement.SpeedEnabled
		end, function()
			config.Movement.SpeedEnabled = not config.Movement.SpeedEnabled
		end)

		makeFillSlider(speed, "Speed", 16, 100, function()
			return config.Movement.Speed
		end, function(val)
			config.Movement.Speed = val
		end, true)

		local misc = makeGroup(left, "Other")

		makeToggle(misc, "Noclip", function()
			return config.Movement.NoclipEnabled
		end, function()
			config.Movement.NoclipEnabled = not config.Movement.NoclipEnabled
		end)

		makeToggle(misc, "Infinite Jump", function()
			return config.Movement.InfJumpEnabled
		end, function()
			config.Movement.InfJumpEnabled = not config.Movement.InfJumpEnabled
		end)

		local tp = makeGroup(right, "Click TP")

		makeToggle(tp, "Enabled", function()
			return config.Movement.ClickTPEnabled
		end, function()
			config.Movement.ClickTPEnabled = not config.Movement.ClickTPEnabled
		end)

		makeKeybind(tp, "Modifier Key", function()
			return config.Movement.ClickTPKey
		end, function(key)
			config.Movement.ClickTPKey = key
		end, function(key)
			return keyConflict(config, key, "clicktp")
		end)
	end

	--==============================================================================
	-- Players tab: live player list (TeamColor name + distance) with per-player
	-- actions (teleport to, spectate). List refreshes on PlayerAdded/Removing;
	-- distances tick ~2x/sec on a shared RenderStepped connection (cleaned up with
	-- the rest of the UI).
	--==============================================================================
	local function buildPlayersTab(parent, config)
		layoutOrder = 0
		local host = makeSubTabHost(parent)
		local left, right = makeColumns(host:add("Players"))

		local listGroup = makeGroup(left, "Player List")

		playerListFrame = newInstance("ScrollingFrame", {
			Parent = listGroup,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 230),
			BackgroundColor3 = COLORS.panel,
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = COLORS.accent,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Active = true,
		})
		newInstance("UICorner", { Parent = playerListFrame, CornerRadius = UDim.new(0, 6) })
		newInstance("UIListLayout", {
			Parent = playerListFrame,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		})
		newInstance("UIPadding", {
			Parent = playerListFrame,
			PaddingTop = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 4),
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
		})

		local function refreshSelection()
			for player, row in pairs(playerRows) do
				row.btn.BackgroundColor3 = (player == selectedPlayer) and COLORS.accent or COLORS.row
			end
		end

		local function refreshList()
			if not playerListFrame then
				return
			end
			for _, child in ipairs(playerListFrame:GetChildren()) do
				if not child:IsA("UIListLayout") then
					child:Destroy()
				end
			end
			table.clear(playerRows)

			local count = 0
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					count = count + 1

					local row = newInstance("TextButton", {
						Parent = playerListFrame,
						LayoutOrder = count,
						Size = UDim2.new(1, 0, 0, 24),
						BackgroundColor3 = (player == selectedPlayer) and COLORS.accent or COLORS.row,
						BorderSizePixel = 0,
						AutoButtonColor = false,
						Text = "",
					})
					newInstance("UICorner", { Parent = row, CornerRadius = UDim.new(0, 4) })

					newInstance("TextLabel", {
						Parent = row,
						Size = UDim2.new(0.65, -8, 1, 0),
						Position = UDim2.fromOffset(8, 0),
						BackgroundTransparency = 1,
						Font = Enum.Font.GothamBold,
						TextSize = 12,
						TextColor3 = player.TeamColor.Color,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextTruncate = Enum.TextTruncate.AtEnd,
						Text = player.Name,
					})

					local dist = newInstance("TextLabel", {
						Parent = row,
						Size = UDim2.new(0.35, -8, 1, 0),
						Position = UDim2.new(0.65, 0, 0, 0),
						BackgroundTransparency = 1,
						Font = Enum.Font.Gotham,
						TextSize = 11,
						TextColor3 = COLORS.textSub,
						TextXAlignment = Enum.TextXAlignment.Right,
						Text = "—",
					})

					row.MouseButton1Click:Connect(function()
						-- Click again to deselect.
						selectedPlayer = (selectedPlayer == player) and nil or player
						refreshSelection()
					end)

					playerRows[player] = { btn = row, dist = dist }
				end
			end

			if count == 0 then
				newInstance("TextLabel", {
					Parent = playerListFrame,
					LayoutOrder = 1,
					Size = UDim2.new(1, 0, 0, 22),
					BackgroundTransparency = 1,
					Font = Enum.Font.Gotham,
					TextSize = 11,
					TextColor3 = COLORS.textSub,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = "  no other players",
				})
			end
		end

		local actions = makeGroup(right, "Actions")

		local selectedLabel = makeLabel(actions, "Selected", "—")

		makeButton(actions, "Teleport To", function()
			local character = selectedPlayer and selectedPlayer.Character
			local root = character and character:FindFirstChild("HumanoidRootPart")
			if root and UI.TeleportTo then
				UI.TeleportTo(root.Position)
			end
		end)

		spectateBtn = makeButton(actions, "Spectate", function()
			if spectatePlayer then
				stopSpectate()
			elseif selectedPlayer then
				startSpectate(selectedPlayer)
			end
		end)

		-- Keep the "Selected" readout in sync with clicks.
		table.insert(syncHandlers, function()
			selectedLabel.Text = selectedPlayer and selectedPlayer.Name or "—"
			refreshSelection()
		end)

		refreshList()

		table.insert(uisConnections, Players.PlayerAdded:Connect(function()
			refreshList()
		end))

		table.insert(uisConnections, Players.PlayerRemoving:Connect(function(player)
			if player == selectedPlayer then
				selectedPlayer = nil
			end
			if player == spectatePlayer then
				stopSpectate()
			end
			refreshList()
		end))

		-- One ticker for distances (~2x/sec) and the spectate watchdog.
		local lastTick = 0
		table.insert(uisConnections, RunService.RenderStepped:Connect(function()
			if os.clock() - lastTick < 0.5 then
				return
			end
			lastTick = os.clock()

			selectedLabel.Text = selectedPlayer and selectedPlayer.Name or "—"

			local myChar = LocalPlayer.Character
			local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
			for player, row in pairs(playerRows) do
				local character = player.Character
				local root = character and character:FindFirstChild("HumanoidRootPart")
				row.dist.Text = (myRoot and root)
					and (math.floor((root.Position - myRoot.Position).Magnitude + 0.5) .. "m")
					or "—"
			end

			if spectatePlayer then
				-- Fly steers the same camera, so it wins: stop spectating when it
				-- turns on (cheap flag check, no hooking into the toggle).
				if activeConfig and activeConfig.Movement and activeConfig.Movement.FlyEnabled then
					stopSpectate()
				else
					local character = spectatePlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					local cam = Workspace.CurrentCamera
					if humanoid and humanoid.Health > 0 and cam then
						cam.CameraSubject = humanoid -- re-affirm (covers respawn too)
					else
						stopSpectate() -- target died or lost their character
					end
				end
			end
		end))
	end

	--==============================================================================
	-- Misc tab: session actions moved out of Settings (account info,
	-- server hop / rejoin) plus webhook configuration.
	--==============================================================================
	local function buildMiscTab(parent, config)
		layoutOrder = 0
		local host = makeSubTabHost(parent)
		local left, right = makeColumns(host:add("Session"))

		local account = makeGroup(left, "Account")
		makeLabel(account, "Username", LocalPlayer and LocalPlayer.Name or "—")
		makeLabel(account, "Display Name", LocalPlayer and LocalPlayer.DisplayName or "—")
		makeLabel(account, "User ID", LocalPlayer and tostring(LocalPlayer.UserId) or "—")

		makeButton(account, "Server Hop", function()
			Utility:ServerHop()
		end)

		makeButton(account, "Rejoin Server", function()
			Utility:Rejoin()
		end)

		local webhook = makeGroup(right, "Webhook")

		local urlBox = makeTextBox(webhook, "webhook url…")
		urlBox.Text = config.Webhook.Url
		urlBox.FocusLost:Connect(function()
			config.Webhook.Url = urlBox.Text
		end)

		makeButton(webhook, "Send Test Webhook", function()
			local ok, res = Webhook.SendWebhook("Vanity-General test webhook")
			if ok then
				UI:Notify("Test webhook sent", 2)
			else
				UI:Notify("Webhook failed: " .. tostring(res), 3)
			end
		end)
	end

	local function buildSettingsTab(parent, config)
		layoutOrder = 0
		local host = makeSubTabHost(parent)
		local left, right = makeColumns(host:add("General"))

		local iface = makeGroup(left, "Interface")
		makeFillSlider(iface, "UI Scale", 0.8, 1.5, function()
			return config.UI.Scale
		end, function(val)
			config.UI.Scale = val
			if windowScale then
				windowScale.Scale = val
			end
		end, false)

		-- Opens the standalone keybind window (built by buildKeybindPanel).
		makeToggle(iface, "Keybind Panel", function()
			return config.UI.KeybindPanel
		end, function()
			config.UI.KeybindPanel = not config.UI.KeybindPanel
			if keybindPanel then
				keybindPanel.Visible = config.UI.KeybindPanel
			end
		end)

		makeToggle(iface, "Target Display", function()
			return config.UI.TargetDisplay
		end, function()
			config.UI.TargetDisplay = not config.UI.TargetDisplay
			targetDisplayOn = config.UI.TargetDisplay
			if not targetDisplayOn and targetPanel then
				targetPanel.Visible = false
			end
		end)

		makeToggle(iface, "FPS Counter", function()
			return config.UI.FPSCounter
		end, function()
			config.UI.FPSCounter = not config.UI.FPSCounter
			if fpsPanel then
				fpsPanel.Visible = config.UI.FPSCounter
			end
		end)

		makeToggle(iface, "Watermark", function()
			return config.UI.Watermark
		end, function()
			config.UI.Watermark = not config.UI.Watermark
			if watermark then
				watermark.Visible = config.UI.Watermark
			end
		end)

		makeColorPicker(iface, "Accent Color", function()
			return config.UI.Accent
		end, function(newColor)
			applyAccent(newColor)
		end)

		-- Reset / profile-load rewrites config.UI.Accent behind our back; re-apply
		-- it to the live theme on every sync.
		table.insert(syncHandlers, function()
			if config.UI.Accent then
				applyAccent(config.UI.Accent)
			end
		end)

		------------------------------------------------------------------ Configs ---
		-- Save / load / delete named setting profiles.
		left, right = makeColumns(host:add("Configs"))
		local cfg = makeGroup(left, "Configs")

		if not ConfigManager.isSupported() then
			makeLabel(cfg, "Status", "Unsupported")
			return
		end

		local nameBox = makeTextBox(cfg, "config name…")

		-- Scrollable list of saved configs; clicking one selects it into the box.
		local listHolder = newInstance("Frame", {
			Parent = cfg,
			LayoutOrder = nextOrder(),
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UIListLayout", {
			Parent = listHolder,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		})

		local refreshList

		local function selectName(name)
			nameBox.Text = name
			refreshList()
		end

		refreshList = function()
			for _, child in ipairs(listHolder:GetChildren()) do
				if not child:IsA("UIListLayout") then
					child:Destroy()
				end
			end

			local names = ConfigManager.list()
			if #names == 0 then
				newInstance("TextLabel", {
					Parent = listHolder,
					LayoutOrder = 1,
					Size = UDim2.new(1, 0, 0, 22),
					BackgroundTransparency = 1,
					Font = Enum.Font.Gotham,
					TextSize = 11,
					TextColor3 = COLORS.textSub,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = "no saved configs",
				})
				return
			end

			for i, name in ipairs(names) do
				local selected = (nameBox.Text == name)
				local row = newInstance("TextButton", {
					Parent = listHolder,
					LayoutOrder = i,
					Size = UDim2.new(1, 0, 0, 22),
					BackgroundColor3 = selected and COLORS.accent or COLORS.row,
					BackgroundTransparency = selected and 0 or 0.35,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Font = Enum.Font.Gotham,
					TextSize = 11,
					TextColor3 = selected and Color3.fromRGB(255, 255, 255) or COLORS.textSub,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = "  " .. name,
				})
				newInstance("UICorner", { Parent = row, CornerRadius = UDim.new(0, 4) })

				row.MouseButton1Click:Connect(function()
					selectName(name)
				end)

				row.MouseEnter:Connect(function()
					if nameBox.Text ~= name then
						row.BackgroundTransparency = 0
						row.BackgroundColor3 = COLORS.rowHover
					end
				end)

				row.MouseLeave:Connect(function()
					if nameBox.Text ~= name then
						row.BackgroundTransparency = 0.35
						row.BackgroundColor3 = COLORS.row
					end
				end)
			end
		end

		makeButton(cfg, "Save", function()
			local ok, res = ConfigManager.save(nameBox.Text, config)
			if ok then
				UI:Notify("Saved config '" .. res .. "'", 2)
				refreshList()
			else
				UI:Notify(tostring(res), 3)
			end
		end)

		makeButton(cfg, "Load", function()
			local ok, res = ConfigManager.load(nameBox.Text, config)
			if ok then
				-- Push every loaded value back into the controls, and re-apply UI scale.
				if windowScale then
					windowScale.Scale = config.UI.Scale
				end
				UI:SyncControls()
				UI:Notify("Loaded config '" .. res .. "'", 2)
			else
				UI:Notify(tostring(res), 3)
			end
		end)

		makeButton(cfg, "Delete", function()
			local ok, res = ConfigManager.delete(nameBox.Text)
			if ok then
				UI:Notify("Deleted config '" .. res .. "'", 2)
				nameBox.Text = ""
				refreshList()
			else
				UI:Notify(tostring(res), 3)
			end
		end, COLORS.danger)

		refreshList()
	end

	-- Bottom-right watermark: brand, player name and a live FPS readout. Toggled by
	-- the "Watermark" switch under Settings > Interface.
	-- Floating popup naming whoever the aimbot is currently locked onto. Only shows
	-- while there IS a target, so it behaves like a callout rather than a static row.
	-- Draggable; toggled by "Target Display" under Settings > Interface.
	local function buildTargetPanel(config)
		targetPanel = newInstance("Frame", {
			Parent = gui,
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 90),
			Size = UDim2.fromOffset(0, 30),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = COLORS.panel,
			BackgroundTransparency = 0.05,
			BorderSizePixel = 0,
			Visible = false,
		})

		newInstance("UICorner", { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
		newInstance("UIStroke", { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
		newInstance("UIPadding", {
			Parent = targetPanel,
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 12),
		})
		newInstance("UIListLayout", {
			Parent = targetPanel,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 8),
		})

		local dot = newInstance("Frame", {
			Parent = targetPanel,
			LayoutOrder = 0,
			Size = UDim2.fromOffset(6, 6),
			BackgroundColor3 = COLORS.accent,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

		targetPanelLabel = newInstance("TextLabel", {
			Parent = targetPanel,
			LayoutOrder = 1,
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Text = "",
		})

		local dragging, dragStart, startPos
		targetPanel.InputBegan:Connect(function(input)
			if isPointer(input) then
				dragging = true
				dragStart = input.Position
				startPos = targetPanel.Position
			end
		end)

		table.insert(moveHandlers, function(input)
			if dragging and targetPanel then
				local delta = input.Position - dragStart
				targetPanel.Position = UDim2.new(
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

		table.insert(syncHandlers, function()
			targetDisplayOn = config.UI.TargetDisplay
			if not targetDisplayOn and targetPanel then
				targetPanel.Visible = false
			end
		end)

		targetDisplayOn = config.UI.TargetDisplay
	end

	-- Bottom-right fps readout. Toggled by "FPS Counter" under Settings > Interface.
	local function buildFpsPanel(config)
		fpsPanel = newInstance("Frame", {
			Parent = gui,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -14, 1, -14),
			Size = UDim2.fromOffset(0, 26),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = COLORS.panel,
			BackgroundTransparency = 0.05,
			BorderSizePixel = 0,
			Visible = false,
		})

		newInstance("UICorner", { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
		newInstance("UIStroke", { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
		newInstance("UIPadding", {
			Parent = fpsPanel,
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 12),
		})
		newInstance("UIListLayout", {
			Parent = fpsPanel,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 8),
		})

		local dot = newInstance("Frame", {
			Parent = fpsPanel,
			LayoutOrder = 0,
			Size = UDim2.fromOffset(6, 6),
			BackgroundColor3 = COLORS.accent,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

		fpsLabel = newInstance("TextLabel", {
			Parent = fpsPanel,
			LayoutOrder = 1,
			Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Text = "-- fps",
		})

		table.insert(syncHandlers, function()
			if fpsPanel then
				fpsPanel.Visible = config.UI.FPSCounter
			end
		end)

		fpsPanel.Visible = config.UI.FPSCounter
	end

	local function buildWatermark(config)
		-- Just the logo: no panel, border or text. ScaleType.Fit letterboxes inside
		-- the box, so any source aspect ratio stays undistorted. Sits bottom-LEFT so
		-- it doesn't collide with the fps counter in the bottom-right.
		watermark = newInstance("ImageLabel", {
			Parent = gui,
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 14, 1, -14),
			Size = UDim2.fromOffset(180, 64),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScaleType = Enum.ScaleType.Fit,
			Image = "",
			Visible = false,
		})

		UI:SetWatermarkImage(config.UI.WatermarkImageId)

		table.insert(syncHandlers, function()
			if watermark then
				watermark.Visible = config.UI.Watermark
			end
		end)

		watermark.Visible = config.UI.Watermark
	end

	-- Standalone, draggable window listing every bound key. Each row is a live
	-- keybind control, so you can rebind straight from here. Toggled by the
	-- "Keybind Panel" switch under Settings > Interface.
	local function buildKeybindPanel(config)
		layoutOrder = 0

		keybindPanel = newInstance("Frame", {
			Parent = gui,
			Size = UDim2.fromOffset(230, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromOffset(680, 100),
			BackgroundColor3 = COLORS.bg,
			BorderSizePixel = 0,
			Visible = false,
		})

		newInstance("UICorner", { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
		newInstance("UIStroke", { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
		newInstance("UIListLayout", {
			Parent = keybindPanel,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
		})
		newInstance("UIPadding", {
			Parent = keybindPanel,
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 12),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
		})

		-- Title bar doubles as the drag handle.
		local bar = newInstance("Frame", {
			Parent = keybindPanel,
			LayoutOrder = 0,
			Size = UDim2.new(1, 0, 0, 26),
			BackgroundColor3 = COLORS.bar,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = bar, CornerRadius = UDim.new(0, 6) })

		newInstance("TextLabel", {
			Parent = bar,
			Size = UDim2.new(1, -20, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = "Keybinds",
		})

		local dragging, dragStart, startPos
		bar.InputBegan:Connect(function(input)
			if isPointer(input) then
				dragging = true
				dragStart = input.Position
				startPos = keybindPanel.Position
			end
		end)

		table.insert(moveHandlers, function(input)
			if dragging and keybindPanel then
				local delta = input.Position - dragStart
				keybindPanel.Position = UDim2.new(
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

		makeKeybind(keybindPanel, "Menu", function()
			return config.UI.MenuKey
		end, function(key)
			config.UI.MenuKey = key
		end, function(key)
			return keyConflict(config, key, "menu")
		end)

		makeKeybind(keybindPanel, "Aimbot", function()
			return config.Camera.ToggleKey
		end, function(key)
			config.Camera.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "aimbot")
		end)

		makeKeybind(keybindPanel, "ESP", function()
			return config.ESP.ToggleKey
		end, function(key)
			config.ESP.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "esp")
		end)

		makeKeybind(keybindPanel, "FOV Circle", function()
			return config.Camera.FOVCircleKey
		end, function(key)
			config.Camera.FOVCircleKey = key
		end, function(key)
			return keyConflict(config, key, "fovcircle")
		end)

		makeKeybind(keybindPanel, "No Recoil", function()
			return config.NoRecoil.ToggleKey
		end, function(key)
			config.NoRecoil.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "norecoil")
		end)

		makeKeybind(keybindPanel, "No Spread", function()
			return config.NoSpread.ToggleKey
		end, function(key)
			config.NoSpread.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "nospread")
		end)

		makeKeybind(keybindPanel, "Triggerbot", function()
			return config.Triggerbot.ToggleKey
		end, function(key)
			config.Triggerbot.ToggleKey = key
		end, function(key)
			return keyConflict(config, key, "triggerbot")
		end)

		makeKeybind(keybindPanel, "Unload", function()
			return config.UI.UnloadKey
		end, function(key)
			config.UI.UnloadKey = key
		end, function(key)
			return keyConflict(config, key, "unload")
		end)

		-- Keeps the window in step with the config (e.g. after a Reset).
		table.insert(syncHandlers, function()
			if keybindPanel then
				keybindPanel.Visible = config.UI.KeybindPanel
			end
		end)

		keybindPanel.Visible = config.UI.KeybindPanel
	end

	local function setVisible(state)
		if not mainWindow or state == visible then
			return
		end
		visible = state

		-- Keep Configuration.UI.Visible in sync with the actual window state
		if activeConfig and activeConfig.UI then
			activeConfig.UI.Visible = state
		end

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

	-- onUnload: called by the Settings > Unload button (the controller passes its
	-- own Stop, so the UI never needs a forward reference to the controller).
	function UI:Init(config, onUnload)
		if gui then
			return
		end

		activeConfig = config
		onUnloadCallback = onUnload

		-- Seed the live accent from config before anything is built with it.
		if config.UI.Accent then
			COLORS.accent = config.UI.Accent
		end

		startInputRouter()

		gui = newInstance("ScreenGui", {
			Name = Cloak.RandomName(), -- random: no "Vanity*" name to signature-scan
			ResetOnSpawn = false,
			IgnoreGuiInset = true,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			DisplayOrder = 999,
		})

		local ok = pcall(function()
			gui.Parent = Utility.getGuiParent()
		end)
		if not ok or not gui.Parent then
			gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
		end
		Cloak.Protect(gui)

		mainWindow = newInstance("CanvasGroup", {
			Parent = gui,
			Size = UDim2.fromOffset(580, 400),
			Position = UDim2.fromOffset(60, 80),
			BackgroundColor3 = COLORS.bg,
			BorderSizePixel = 0,
			GroupTransparency = 1,
			Visible = false,
		})

		windowScale = newInstance("UIScale", { Parent = mainWindow, Scale = config.UI.Scale })
		newInstance("UICorner", { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
		newInstance("UIStroke", { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })

		-- Title bar spans the top; it's the drag handle.
		local titleBar = newInstance("Frame", {
			Parent = mainWindow,
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = COLORS.bar,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
		newInstance("Frame", { -- square off the lower edge of the rounded bar
			Parent = titleBar,
			Size = UDim2.new(1, 0, 0, 12),
			Position = UDim2.new(0, 0, 1, -12),
			BackgroundColor3 = COLORS.bar,
			BorderSizePixel = 0,
		})

		local dot = newInstance("Frame", {
			Parent = titleBar,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 12, 0.5, 0),
			Size = UDim2.fromOffset(8, 8),
			BackgroundColor3 = COLORS.accent,
			BorderSizePixel = 0,
			ZIndex = 2,
		})
		newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

		newInstance("TextLabel", {
			Parent = titleBar,
			Size = UDim2.new(1, -34, 1, 0),
			Position = UDim2.fromOffset(28, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextColor3 = COLORS.text,
			TextXAlignment = Enum.TextXAlignment.Left,
			-- RichText so ".dev" picks up the accent colour.
			RichText = true,
			Text = 'Vanity<font color="#843EBE">.dev</font> General'
				.. '<font color="#8A7CA0">   ·   v0</font>',
			ZIndex = 2,
		})

		newInstance("TextLabel", { -- local player name on the right, like the reference
			Parent = titleBar,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -12, 0.5, 0),
			Size = UDim2.new(0, 140, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = COLORS.textSub,
			TextXAlignment = Enum.TextXAlignment.Right,
			Text = LocalPlayer and LocalPlayer.Name or "",
			ZIndex = 2,
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

		-- Left sidebar: an inset panel of its own (rounded + outlined to match the
		-- content groups), tabs stacked at the top, Unload pinned to the bottom.
		local sidebar = newInstance("Frame", {
			Parent = mainWindow,
			Position = UDim2.fromOffset(10, 44),
			Size = UDim2.new(0, 120, 1, -54),
			BackgroundColor3 = COLORS.panel,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
		newInstance("UIStroke", { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
		newInstance("UIPadding", {
			Parent = sidebar,
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
		})

		-- Tabs live in their own list so the Unload button can sit at the bottom.
		local tabList = newInstance("Frame", {
			Parent = sidebar,
			Size = UDim2.new(1, 0, 1, -40),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UIListLayout", { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })

		local unloadBtn = newInstance("TextButton", {
			Parent = sidebar,
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = COLORS.row,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = COLORS.danger,
			Text = "Unload",
		})
		newInstance("UICorner", { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
		local unloadStroke = newInstance("UIStroke", {
			Parent = unloadBtn,
			Color = COLORS.danger,
			Thickness = 1,
			Transparency = 0.55,
		})

		unloadBtn.MouseButton1Click:Connect(function()
			if onUnloadCallback then
				onUnloadCallback()
			end
		end)

		unloadBtn.MouseEnter:Connect(function()
			TweenService:Create(unloadBtn, ANIM, {
				BackgroundColor3 = COLORS.danger,
				TextColor3 = Color3.fromRGB(255, 255, 255),
			}):Play()
			TweenService:Create(unloadStroke, ANIM, { Transparency = 0 }):Play()
		end)

		unloadBtn.MouseLeave:Connect(function()
			TweenService:Create(unloadBtn, ANIM, {
				BackgroundColor3 = COLORS.row,
				TextColor3 = COLORS.danger,
			}):Play()
			TweenService:Create(unloadStroke, ANIM, { Transparency = 0.55 }):Play()
		end)

		-- Right content area: one scrolling panel per tab, layered and toggled.
		-- Starts after the inset sidebar (10 margin + 120 wide + 10 gutter).
		local content = newInstance("Frame", {
			Parent = mainWindow,
			Position = UDim2.fromOffset(140, 44),
			Size = UDim2.new(1, -150, 1, -54),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UIPadding", {
			Parent = content,
			PaddingRight = UDim.new(0, 4),
		})

		local tabs = { "Combat", "Visual", "Movement", "Players", "Misc", "Settings" }
		local tabFrames = {}

		for i, tabName in ipairs(tabs) do
			local isActive = currentTab == tabName

			-- Buttons share the sidebar height equally (minus layout padding), so
			-- any tab count fits without overflowing.
			local tabBtn = newInstance("TextButton", {
				Parent = tabList,
				LayoutOrder = i,
				Size = UDim2.new(1, 0, 1 / #tabs, -6),
				BackgroundColor3 = COLORS.rowHover,
				BackgroundTransparency = isActive and 0 or 1,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				TextColor3 = isActive and COLORS.text or COLORS.textSub,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = "    " .. tabName,
			})

			newInstance("UICorner", { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })

			local stripe = newInstance("Frame", {
				Parent = tabBtn,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 5, 0.5, 0),
				Size = UDim2.fromOffset(3, 16),
				BackgroundColor3 = COLORS.accent,
				BorderSizePixel = 0,
				Visible = isActive,
				ZIndex = 2,
			})
			newInstance("UICorner", { Parent = stripe, CornerRadius = UDim.new(1, 0) })

			-- Fixed-height scroll panel + AutomaticCanvasSize = reliable vertical scroll.
			-- Plain container; the sub-tab host (makeSubTabHost) fills it with a
			-- sub-tab bar plus one scrolling two-column panel per sub-tab.
			local tabFrame = newInstance("Frame", {
				Parent = content,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Visible = isActive,
			})

			tabFrames[tabName] = { btn = tabBtn, frame = tabFrame, stripe = stripe }

			tabBtn.MouseButton1Click:Connect(function()
				currentTab = tabName
				for name, tab in pairs(tabFrames) do
					local active = name == tabName
					tab.frame.Visible = active
					tab.stripe.Visible = active
					TweenService:Create(tab.btn, ANIM, {
						BackgroundTransparency = active and 0 or 1,
						TextColor3 = active and COLORS.text or COLORS.textSub,
					}):Play()
				end
			end)

			tabBtn.MouseEnter:Connect(function()
				if currentTab ~= tabName then
					TweenService:Create(tabBtn, ANIM, { BackgroundTransparency = 0.6 }):Play()
				end
			end)

			tabBtn.MouseLeave:Connect(function()
				if currentTab ~= tabName then
					TweenService:Create(tabBtn, ANIM, { BackgroundTransparency = 1 }):Play()
				end
			end)
		end

		buildCameraTab(tabFrames["Combat"].frame, config)
		buildESPTab(tabFrames["Visual"].frame, config)
		buildMovementTab(tabFrames["Movement"].frame, config)
		buildPlayersTab(tabFrames["Players"].frame, config)
		buildMiscTab(tabFrames["Misc"].frame, config)
		buildSettingsTab(tabFrames["Settings"].frame, config)
		buildKeybindPanel(config)
		buildTargetPanel(config)
		buildFpsPanel(config)
		buildWatermark(config)

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

	-- Called every frame by the controller. Stays visible whenever the option is on,
	-- showing "UnKnown" when nobody is in view.
	function UI:SetCurrentTarget(name)
		if not targetPanel then
			return
		end

		if targetPanel.Visible ~= targetDisplayOn then
			targetPanel.Visible = targetDisplayOn
		end
		if not targetDisplayOn or not targetPanelLabel then
			return
		end

		local shown, colour
		if name and name ~= "" and name ~= "None" then
			shown, colour = name, "#843EBE"
		else
			shown, colour = "UnKnown", "#8A7CA0" -- muted, so it reads as "nobody"
		end

		local text = 'Target: <font color="' .. colour .. '">' .. shown .. "</font>"
		if targetPanelLabel.Text ~= text then
			targetPanelLabel.Text = text
		end
	end

	-- Refreshes the fps readout. No-ops when the counter is off or not built.
	function UI:UpdateFPS(fps)
		if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
			return
		end
		local text = string.format('<font color="#843EBE">%d</font> fps', fps or 0)
		if fpsLabel.Text ~= text then
			fpsLabel.Text = text
		end
	end

	-- Points the watermark at an uploaded image. Accepts a bare id,
	-- "rbxassetid://123", or a number; "" (or nil) clears it.
	function UI:SetWatermarkImage(id)
		if not watermark then
			return
		end

		local digits = tostring(id or ""):match("%d+")
		watermark.Image = digits and ("rbxassetid://" .. digits) or ""
	end

	function UI:SyncControls()
		for _, fn in ipairs(syncHandlers) do
			fn()
		end
	end

	function UI:IsCapturingKey()
		return capturingKey
	end

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
		stopSpectate() -- hand the camera back before the UI goes away
		selectedPlayer = nil
		spectateBtn = nil
		playerListFrame = nil
		table.clear(playerRows)

		for _, conn in ipairs(uisConnections) do
			conn:Disconnect()
		end
		table.clear(uisConnections)
		table.clear(moveHandlers)
		table.clear(releaseHandlers)
		table.clear(syncHandlers)

		activeCapture = nil
		capturingKey = false
		activeDropdown = nil
		targetPanel, targetPanelLabel = nil, nil
		targetDisplayOn = false
		keybindPanel = nil -- destroyed with the ScreenGui below
		watermark = nil
		fpsPanel, fpsLabel = nil, nil
		windowScale = nil

		if gui then
			gui:Destroy()
			gui = nil
			mainWindow = nil
		end
		visible = false
	end

	return UI
end)() -- /UI

--============================================================================
-- MOVEMENT
--============================================================================
Movement = (function()
	--==============================================================================
	-- MOVEMENT
	-- Client-side movement suite: fly, noclip, speed, infinite jump, click TP.
	-- Fly/Speed steer through AssemblyLinearVelocity (physics-integrated, so
	-- movement replicates naturally and doesn't trip teleport checks or
	-- rubber-band). No BodyMovers, no WalkSpeed/JumpPower writes, no
	-- Humanoid:ChangeState spoofing. Click TP is the only CFrame teleport.
	--==============================================================================

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = Players.LocalPlayer
	local UI = UI

	local Movement = {}

	-- Stock WalkSpeed; Speed mode only adds the surplus over this, so a Speed of
	-- 16 is a no-op (you move exactly as fast as the game intends).
	local BASE_WALKSPEED = 16

	-- Matches a normal jump's upward launch (~50 studs/s) so Infinite Jump feels
	-- like jumping, just without needing to touch the ground.
	local JUMP_VELOCITY = 50

	local mv_jumpConnection
	local mv_clickConnection
	local mv_tpToken = 0 -- incremented per TP; a running stepped TP stops when stale

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

	-- Pulse (anti-lagback): server speed checks validate displacement over a time
	-- window, so a SUSTAINED high velocity always trips them eventually. Alternating
	-- boost and coast intervals keeps every window plausible. Always on with fixed
	-- timing (100 ms boost / 150 ms coast — the most compatible window across
	-- games); coast frames drop to normal walkspeed rather than zero, so movement
	-- never looks scripted stop-start.
	local PULSE_BOOST = 0.1
	local PULSE_COAST = 0.15

	local function mv_pulseActive()
		return (os.clock() % (PULSE_BOOST + PULSE_COAST)) < PULSE_BOOST
	end

	-- Per-frame driver, called from the controller's RenderStepped loop.
	function Movement:Update(dt, config)
		local character, root, humanoid = mv_character()

		-- Noclip: re-applied every frame, so the moment this stops running (toggle
		-- off, or the whole script unloads) collision comes back on its own.
		-- Cached per-character to avoid walking the descendant tree every frame.
		if config.NoclipEnabled and character then
			local noclipParts = character:GetDescendants()
			for i = 1, #noclipParts do
				local part = noclipParts[i]
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end

		if not root then
			return
		end

		-- Fly: velocity steering, NOT CFrame teleports. Small per-frame teleports
		-- fight the physics engine and read as position hacks — the server snaps
		-- you back (rubber-banding) and anti-teleport checks fire. Driving
		-- AssemblyLinearVelocity lets physics integrate the movement, so it
		-- replicates like ordinary motion.
		if config.FlyEnabled then
			local cam = Workspace.CurrentCamera
			if cam then
				local velocity = Vector3.zero
				-- While a keybind box is capturing, WASD/Space are a rebind, not flying.
				if not UI:IsCapturingKey() then
					local dir = mv_flyDirection(cam)
					if dir then
						local speed = config.FlySpeed or 50
						if not mv_pulseActive() then
							speed = math.min(speed, BASE_WALKSPEED) -- coast at a plausible rate
						end
						velocity = dir * speed
					end
				end
				root.AssemblyLinearVelocity = velocity
			end
			return -- fly owns the character's velocity; don't let Speed fight it
		end

		-- Speed: override the horizontal velocity toward the humanoid's OWN move
		-- direction (works with any control scheme), preserving vertical velocity
		-- so jumps/falls stay natural. WalkSpeed itself is never written. During
		-- pulse coast frames we don't touch velocity at all, so the humanoid
		-- walks normally — the average stays under server check thresholds.
		if config.SpeedEnabled then
			local speed = config.Speed or BASE_WALKSPEED
			local move = humanoid.MoveDirection
			if speed > BASE_WALKSPEED and move.Magnitude > 0 and mv_pulseActive() then
				local velocity = root.AssemblyLinearVelocity
				root.AssemblyLinearVelocity = Vector3.new(move.X * speed, velocity.Y, move.Z * speed)
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

	-- Teleports the local character to a world position (+3 studs so you land on
	-- top of the surface instead of inside it). Shared by Click TP and the Players
	-- tab's "Teleport To" button. Always stepped: one instant jump gets rejected by
	-- server anti-teleport validation (you snap back), so the TP hops in small
	-- increments — no single frame's displacement trips the checks. A new TP or a
	-- respawn invalidates a running hop via mv_tpToken.
	local TP_STEP = 10 -- studs per hop
	local TP_INTERVAL = 0.05 -- seconds between hops

	function Movement.TeleportTo(position)
		local destination = position + Vector3.new(0, 3, 0)

		mv_tpToken = mv_tpToken + 1
		local token = mv_tpToken
		task.spawn(function()
			while token == mv_tpToken do
				local _, currentRoot = mv_character()
				if not currentRoot then
					return
				end
				local offset = destination - currentRoot.CFrame.Position
				if offset.Magnitude <= TP_STEP then
					currentRoot.CFrame = CFrame.new(destination)
					return
				end
				currentRoot.CFrame = currentRoot.CFrame + offset.Unit * TP_STEP
				task.wait(TP_INTERVAL)
			end
		end)
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

		local mouse = LocalPlayer:GetMouse()
		if mouse and mouse.Hit then
			Movement.TeleportTo(mouse.Hit.Position)
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
end)() -- /Movement

--============================================================================
-- CONTROLLER
--============================================================================
Controller = (function()
	--==============================================================================
	-- MAIN CONTROLLER - Entry Point
	-- Orchestrates all systems (ESP, Camera, UI, Movement, Webhook, etc).
	-- Exported as getgenv().VanityGeneral on Start — through the Cloak, so the
	-- name reads normally but never enumerates in an environment scan.
	--==============================================================================

	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")

	local LocalPlayer = Players.LocalPlayer

	local Configuration = Configuration
	local ConfigManager = ConfigManager
	local Candidates = Candidates
	local CameraDirector = CameraDirector
	local HitboxExpander = Hitbox
	local SilentAim = SilentAim
	local NoRecoil = NoRecoil
	local NoSpread = NoSpread
	local Triggerbot = Triggerbot
	local ESP = ESP
	local DrawingESP = DrawingESP
	local Visuals = Visuals
	local Utility = Utility
	local UI = UI
	local Movement = Movement
	local Webhook = Webhook
	local Cloak = Cloak

	local Controller = {}
	Controller.Version = "1.0.0"
	Controller.Config = Configuration

	-- Injected rather than required by the UI (would be a UI <-> Movement cycle):
	-- the Players tab's "Teleport To" button calls this.
	UI.TeleportTo = Movement.TeleportTo

	Webhook.Version = Controller.Version -- stamped for the "loaded" embed

	local running = false
	local connections = {}
	local aimbotSteering = false -- set each frame; tells NoRecoil to stand down
	-- Randomized so the BindToRenderStep name carries no script signature.
	local RECOIL_BIND = Cloak.RandomName() -- BindToRenderStep name (runs after camera)

	-- Per-frame crash guard. A raw error inside a RenderStepped handler repeats every
	-- frame, flooding the console and tanking FPS. This swallows the error, keeps the
	-- rest of the frame running, and reports at most once every few seconds per site.
	local guardState = {}
	local GUARD_WARN_INTERVAL = 5

	local function guarded(name, fn, ...)
		local ok, res = pcall(fn, ...)
		if ok then
			local st = guardState[name]
			if st then
				st.failures = 0
			end
			return true, res
		end

		local st = guardState[name]
		if not st then
			st = { failures = 0, lastWarn = -math.huge }
			guardState[name] = st
		end
		st.failures = st.failures + 1

		local now = os.clock()
		if now - st.lastWarn >= GUARD_WARN_INTERVAL then
			st.lastWarn = now
			warn(string.format("[Vanity-General] %s failed (x%d): %s", name, st.failures, tostring(res)))
		end
		return false, nil
	end

	function Controller.IsRunning()
		return running
	end

	-- Config profiles, also usable from the console:
	--   VanityGeneral.SaveConfig("legit") / .LoadConfig("legit") / .ListConfigs()
	function Controller.SaveConfig(name)
		return ConfigManager.save(name, Configuration)
	end

	function Controller.LoadConfig(name)
		local ok, res = ConfigManager.load(name, Configuration)
		if ok then
			pcall(function()
				UI:SyncControls()
			end)
		end
		return ok, res
	end

	function Controller.ListConfigs()
		return ConfigManager.list()
	end

	function Controller.DeleteConfig(name)
		return ConfigManager.delete(name)
	end

	-- Teleport helpers (also on the Settings > Account buttons).
	function Controller.ServerHop()
		return Utility:ServerHop()
	end

	function Controller.Rejoin()
		return Utility:Rejoin()
	end

	-- Sets the watermark logo from an uploaded image id (bare id or rbxassetid://).
	-- Persists into config so it survives a menu rebuild.
	function Controller.SetWatermarkImage(id)
		Configuration.UI.WatermarkImageId = tostring(id or "")
		UI:SetWatermarkImage(Configuration.UI.WatermarkImageId)
		return Controller
	end

	-- Webhook passthroughs (implementation lives in the Webhook module).
	function Controller.SetWebhook(url)
		return Webhook.SetWebhook(url)
	end

	function Controller.HasWebhook()
		return Webhook.HasWebhook()
	end

	function Controller.SendWebhook(content, opts)
		return Webhook.SendWebhook(content, opts)
	end

	function Controller.SendLoadedEmbed(isDebugged)
		return Webhook.SendLoadedEmbed(isDebugged)
	end

	function Controller.Start()
		if running then
			return Controller
		end

		running = true

		-- Note: no global hooks are installed here. The Cloak filter installs
		-- itself on the first Protect() of a game-visible instance, and Silent Aim
		-- installs on first enable — so simply loading the script with everything
		-- off leaves the game's metatable completely untouched.
		local ok, err = pcall(function()
			ESP:Init()

			UI:Init(Configuration, function()
				Controller.Stop()
			end)

			Movement:Init(Configuration.Movement)

			-- Full config: Silent Aim reads its own toggle plus the ESP/Camera
			-- sections for its crosshair (look-target) fallback.
			SilentAim:Init(Configuration)

			table.insert(connections, Players.PlayerAdded:Connect(function(player)
				guarded("PlayerAdded", ESP.OnPlayerAdded, ESP, player)
			end))

			table.insert(connections, Players.PlayerRemoving:Connect(function(player)
				guarded("PlayerRemoving", ESP.OnPlayerRemoving, ESP, player)
			end))

			table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed or UI:IsCapturingKey() then
					return
				end

				-- Guarded so a bad SyncControls/toggle can't kill the input connection.
				guarded("Keybinds", function()
					-- Data-driven so adding a bind is one row, not another elseif branch.
					local key = input.KeyCode
					if key == Configuration.UI.MenuKey then
						UI:Toggle()
					elseif key == Configuration.UI.UnloadKey then
						Controller.Stop()
					else
						local toggles = {
							{ Configuration.Camera, "Enabled", Configuration.Camera.ToggleKey },
							{ Configuration.ESP, "Enabled", Configuration.ESP.ToggleKey },
							{ Configuration.Camera, "FOVCircle", Configuration.Camera.FOVCircleKey },
							{ Configuration.NoRecoil, "Enabled", Configuration.NoRecoil.ToggleKey },
							{ Configuration.NoSpread, "Enabled", Configuration.NoSpread.ToggleKey },
							{ Configuration.Triggerbot, "Enabled", Configuration.Triggerbot.ToggleKey },
						}
						for _, t in ipairs(toggles) do
							if key == t[3] then
								t[1][t[2]] = not t[1][t[2]]
								UI:SyncControls()
								break
							end
						end
					end
				end)
			end))

			-- Rolling FPS sample for the counter, refreshed ~4x a second.
			local fpsAccum, fpsFrames = 0, 0

			-- Every subsystem runs behind `guarded`, so one throwing (a destroyed part,
			-- a nil character mid-respawn) can't kill the loop or spam the console.
			table.insert(connections, RunService.RenderStepped:Connect(function(dt)
				-- Shared per-frame candidate pool FIRST: CameraDirector, ESP,
				-- DrawingESP and Hitbox all read it below instead of re-walking
				-- players and re-resolving parts/projections themselves.
				guarded("Candidates", Candidates.Update, Candidates, Configuration.Camera, Configuration.ESP)

				guarded("ESP", ESP.Update, ESP, Configuration.ESP)

				-- While spectating (Players tab), the aimbot must not steer the
				-- camera away from the spectate target.
				local okAim, target = true, nil
				if not (UI.IsSpectating and UI.IsSpectating()) then
					okAim, target = guarded("Aimbot", CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
				end
				if not okAim then
					target = nil
				end

				-- Target Display names whoever you're LOOKING at (walls ignored, ESP
				-- render distance), independent of whether the aimbot has a lock. Only
				-- resolved while the popup is on, so it costs nothing when off.
				if Configuration.UI.TargetDisplay then
					guarded("Target display", function()
						local looking = CameraDirector:GetLookTarget(Configuration.ESP, Configuration.Camera)
						UI:SetCurrentTarget(looking and looking.Name or nil)
					end)
				end

				-- Record whether the aimbot owns the camera this frame (NoRecoil reads it).
				aimbotSteering = Configuration.Camera.Enabled and target ~= nil

				-- Neutralize client-side bullet spread rolls when enabled.
				guarded("NoSpread", NoSpread.Update, NoSpread, Configuration.NoSpread)

				-- Installs the Silent Aim hooks on first enable (kept out of Init so
				-- loading the script never touches the game's metatable).
				guarded("Silent Aim", SilentAim.Update, SilentAim, Configuration)

				-- Auto-fire when the crosshair is on a target.
				guarded("Triggerbot", Triggerbot.Update, Triggerbot, Configuration.Triggerbot, Configuration.Camera)

				-- CFrame movement suite (fly / noclip / speed); event halves run on
				-- their own connections from Movement:Init.
				guarded("Movement", Movement.Update, Movement, dt, Configuration.Movement)

				-- Client-side root inflation on the aimbot's candidate set.
				guarded("Hitbox", HitboxExpander.Update, HitboxExpander, Configuration.Hitbox, Configuration.Camera)

				-- Executor Drawing boxes/tracers (no-op without the Drawing library).
				guarded("Drawing ESP", DrawingESP.Update, DrawingESP, Configuration.Drawing, Configuration.Camera)

				-- Fullbright / No Fog lighting watches.
				guarded("Visuals", Visuals.Update, Visuals, Configuration.Visuals)

				-- Averaging over a window rather than 1/dt keeps the readout steady.
				fpsAccum = fpsAccum + dt
				fpsFrames = fpsFrames + 1
				if fpsAccum >= 0.25 then
					local fps = math.floor(fpsFrames / fpsAccum + 0.5)
					fpsAccum, fpsFrames = 0, 0
					if Configuration.UI.FPSCounter then
						guarded("FPS counter", UI.UpdateFPS, UI, fps)
					end
				end
			end))

			-- Run NoRecoil AFTER the game's camera update (recoil is applied there), so
			-- our correction is the last word each frame and the climb is fully undone.
			-- RenderStepped runs before the camera, which is why the old inline call only
			-- reduced recoil instead of removing it.
			pcall(function()
				RunService:UnbindFromRenderStep(RECOIL_BIND) -- clear any stale bind first
			end)
			pcall(function()
				RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
					guarded("NoRecoil", NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
				end)
			end)
		end)

		if not ok then
			warn("[Vanity-General] Failed to start:", err)
			Controller.Stop()
			return Controller
		end

		-- Export under the historical global name so re-executions can find us,
		-- but through the cloak: readable as getgenv().VanityGeneral, invisible to
		-- pairs() environment scans. Raw fallback only if hiding is impossible.
		if not Cloak.HideGlobal("VanityGeneral", Controller) and getgenv then
			getgenv().VanityGeneral = Controller
		end

		UI:Notify(string.format("Vanity-General loaded  •  Press %s", Configuration.UI.MenuKey.Name), 4)

		print(string.format("[Vanity-General] Running (v%s)", Controller.Version))
		print(string.format("Menu: %s  |  Camera: %s  |  Unload: %s",
			Configuration.UI.MenuKey.Name,
			Configuration.Camera.ToggleKey.Name,
			Configuration.UI.UnloadKey.Name))

		-- Fire-and-forget "loaded" ping as a Discord embed. No-ops silently if no
		-- webhook is configured.
		if Webhook.HasWebhook() then
			task.spawn(function()
				Webhook.SendLoadedEmbed(false)
			end)
		end

		return Controller
	end

	function Controller.Stop()
		if not running then
			return Controller
		end
		running = false

		for _, conn in ipairs(connections) do
			pcall(function()
				conn:Disconnect()
			end)
		end
		table.clear(connections)

		pcall(function()
			RunService:UnbindFromRenderStep(RECOIL_BIND)
		end)
		aimbotSteering = false

		pcall(function()
			ESP:Cleanup()
		end)
		pcall(function()
			UI:Cleanup()
		end)
		pcall(function()
			CameraDirector:Cleanup() -- removes the FOV circle drawing
		end)
		pcall(function()
			Movement:Cleanup() -- disconnects jump/click listeners; noclip self-restores
		end)
		pcall(function()
			HitboxExpander:Cleanup() -- restore any inflated enemy roots
		end)
		pcall(function()
			DrawingESP:Cleanup() -- destroy all Drawing line objects
		end)
		pcall(function()
			Visuals:Cleanup() -- restore original Lighting properties
		end)
		pcall(function()
			NoSpread:Cleanup() -- restore original math.random so no global hook lingers
		end)
		NoRecoil:Reset()
		table.clear(guardState) -- fresh error throttling on the next Start

		print("[Vanity-General] Stopped")
		return Controller
	end

	function Controller.Toggle()
		if running then
			Controller.Stop()
		else
			Controller.Start()
		end
		return Controller
	end

	Controller.start = Controller.Start
	Controller.stop = Controller.Stop
	Controller.toggle = Controller.Toggle

	return Controller
end)() -- /Controller

--============================================================================
-- MAIN
--============================================================================
do -- Main
	--==============================================================================
	-- VANITY-GENERAL - Entry point
	-- Loads the controller, stops any previously injected copy, and starts.
	--==============================================================================

	local Controller = Controller

	-- Safe restart: a previous execution exported itself to getgenv().VanityGeneral
	-- on Start; stop it before this copy takes over.
	if getgenv then
		local previous = getgenv().VanityGeneral
		if previous and previous ~= Controller and type(previous.Stop) == "function" then
			pcall(previous.Stop)
		end
	end

	-- Wrapped in pcall so a start failure still returns the module for manual use.
	pcall(function()
		Controller.Start()
	end)

	return Controller

end -- /Main
