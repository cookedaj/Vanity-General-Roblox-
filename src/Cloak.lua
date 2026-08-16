--==============================================================================
-- CLOAK
-- Keeps the script out of a game's environment integrity checks:
--  * Instances the script creates are registered via Protect(); when the GAME
--    (not one of our threads) calls GetChildren/GetDescendants/FindFirstChild*,
--    the results are filtered of registered instances and their descendants.
--    This is what hides the head BillboardGui tags, which live inside player
--    characters and are otherwise visible to any character scan.
--  * RandomName() gives DataModel objects throwaway names, so nothing carries
--    a "Vanity*" string for name-signature scans.
-- The getgenv __index export-hiding was REMOVED: on executors with a fragile
-- C __index it caused C stack overflows / uncatchable delegate errors.
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

-- Recorded hidden names (this copy only). The getgenv metatable wrapper that
-- used to serve these is DISABLED — see the note above HideGlobal.
local hiddenGlobals = {}

-- Registry key the (now disabled) env wrapper used; still read at load so a
-- wrapper left by an earlier build this session can be uninstalled.
local REGISTRY_KEY = "\226\128\139vg_rt"

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

-- ENVIRONMENT METATABLE WRAPPING IS DISABLED.
-- The stealth wrapper (serving the getgenv().VanityGeneral export through an
-- __index so pairs() scans never see it) proved fatal on executors whose
-- original __index is a fragile C closure: delegating a miss through our
-- wrapper could cycle (wrapper -> C __index -> wrapper -> ... = C stack
-- overflow) or throw straight through pcall ("attempt to call a nil value").
-- Multiple crash reports traced back to it. Reliability beats hiding one
-- global, so HideGlobal now just records the name and returns false, and
-- Controller falls back to the plain raw export every pre-cloak build used.

-- Uninstalls the __index wrapper a previous (fixed) copy of this script left
-- on getgenv() earlier in the session; its registry key survives, which lets
-- us recognize the wrapper and restore the original __index. Wrappers from
-- pre-registry builds can't be recognized — rejoining clears those.
local function uninstallStaleEnvWrapper()
	if type(getgenv) ~= "function" then
		return
	end
	pcall(function()
		local env = getgenv()
		if type(env) ~= "table" then
			return
		end
		local registry = rawget(env, REGISTRY_KEY)
		if type(registry) ~= "table" or type(registry.wrapper) ~= "function" then
			return
		end
		local mt = getmetatable(env)
		if mt and rawget(mt, "__index") == registry.wrapper then
			local newMt = {}
			for k, v in pairs(mt) do
				newMt[k] = v
			end
			newMt.__index = registry.original
			setmetatable(env, newMt)
		end
		registry.wrapper = nil
	end)
end

-- Kept for API compatibility. Records the name for this copy's own use and
-- returns false so the caller uses a raw export — see the disabled-wrapper
-- note above.
function Cloak.HideGlobal(name, value)
	hiddenGlobals[name] = value
	return false
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

-- Uninstall the env wrapper a previous fixed build left behind this session
-- (Cloak is the first module in the bundle, so this runs before anything else
-- can trip over it). Pre-registry wrappers can't be recognized; rejoin clears
-- them.
uninstallStaleEnvWrapper()

return Cloak
