--==============================================================================
-- CONFIG MANAGER
-- Saves/loads the whole Configuration to the executor's filesystem as JSON, so
-- settings survive between sessions. Color3 and EnumItem (keybinds) can't be
-- represented in JSON, so they're tagged and rebuilt on load.
-- Profiles are per-game (PlaceId in the file name) with a legacy-path fallback.
--==============================================================================


local ConfigManager = {}
local CONFIG_FOLDER = "VanityGeneral"
local SAVED_SECTIONS = { "Camera", "ESP", "NoRecoil", "NoSpread", "Movement", "SilentAim", "Hitbox", "Drawing", "Visuals", "Utility", "UI" }

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
