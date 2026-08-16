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

-- Values served through the getgenv metatable wrapper. The table is SHARED
-- across executions via the registry (see installEnvGuard below), so replacing
-- the wrapper never loses names a previous copy hid — that is how Main still
-- finds the previous Controller to stop it.
local hiddenGlobals = {}

-- Raw-key registry shared across executions in the same session: lets a later
-- copy recognize (and replace, never wrap) an earlier copy's __index wrapper.
-- Zero-width-space prefix keeps it out of casual eyeball scans; it is a raw
-- key, so pairs() CAN see it — accepted tradeoff for crash-proof re-execution.
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

-- Installs (or replaces) the getgenv __index wrapper that serves hiddenGlobals.
-- Installed EAGERLY at module load — modules loaded after Cloak probe missing
-- globals (syn/delta/fluxus/...), and a stale UNGUARDED wrapper left by a
-- crashed copy would cycle on the very first miss.
--
-- Two crash-proofing rules:
--  1. Never wrap one of our own wrappers. Every past execution (including
--     crashed copies whose metatable changes linger in the session) would
--     otherwise add another link to the delegation chain — and if any link
--     ever resolves a miss by re-reading this same environment, the chain
--     becomes a cycle: wrapper -> original __index (a C function, invisible
--     in stack traces) -> wrapper -> ... until C stack overflow. The registry
--     tracks the installed wrapper and the REAL __index under it, so the
--     chain stays exactly one wrapper deep.
--  2. resolving re-entry guard: covers executors whose original __index
--     resolves a miss by indexing THIS environment again, firing this wrapper
--     again (wrapper -> C __index -> wrapper -> ...). While a resolution is
--     in flight, nested misses answer nil and the cycle dies.
local RUN_ID = Cloak.RandomName(16)
local function installEnvGuard()
	if type(getgenv) ~= "function" then
		return false
	end
	local ok, env = pcall(getgenv)
	if not ok or type(env) ~= "table" then
		return false
	end

	local registry = rawget(env, REGISTRY_KEY)
	if type(registry) ~= "table" then
		registry = {}
		rawset(env, REGISTRY_KEY, registry)
	end
	if registry.runId ~= nil and registry.runId == RUN_ID then
		return true -- this copy already installed its wrapper
	end

	-- Share the names table across executions (see the hiddenGlobals comment).
	if type(registry.names) ~= "table" then
		registry.names = {}
	end
	hiddenGlobals = registry.names

	local ok2 = pcall(function()
		local mt = getmetatable(env)
		local oldIndex = mt and rawget(mt, "__index")
		if type(registry.wrapper) == "function" and oldIndex == registry.wrapper then
			oldIndex = registry.original -- replace our old wrapper; never wrap it
		else
			-- A foreign wrapper (or a pre-fix build's): keep it as the delegate
			-- so names it hid still resolve; our busy guard bounds the chain.
			registry.original = oldIndex
		end

		local newMt = {}
		if mt then
			for k, v in pairs(mt) do
				newMt[k] = v
			end
		end

		local resolving = false
		local wrapper
		wrapper = function(_, key)
			local hidden = hiddenGlobals[key]
			if hidden ~= nil then
				return hidden
			end
			if resolving then
				return nil
			end
			resolving = true
			local okCall, result = true, nil
			if type(oldIndex) == "function" then
				okCall, result = pcall(oldIndex, env, key)
			elseif type(oldIndex) == "table" then
				result = oldIndex[key]
			end
			resolving = false
			-- A delegate that ERRORS on a miss must not take the script down:
			-- some executors' C __index throws (e.g. "attempt to call a nil
			-- value") instead of answering nil. Treat it as an ordinary miss.
			if not okCall then
				return nil
			end
			return result
		end
		newMt.__index = wrapper
		registry.wrapper = wrapper
		setmetatable(env, newMt)
	end)
	if ok2 then
		registry.runId = RUN_ID
	end
	return ok2
end

-- Stores value under getgenv()[name] WITHOUT a raw key: reads still work, but
-- pairs()/next() scans of the environment never enumerate it. Returns false
-- when the environment can't take a metatable (caller may fall back to a raw
-- assignment if the export matters more than the hiding).
function Cloak.HideGlobal(name, value)
	hiddenGlobals[name] = value

	-- A pre-cloak build may have left a raw key behind; drop it.
	if type(getgenv) == "function" then
		pcall(function()
			local env = getgenv()
			if type(env) == "table" and rawget(env, name) ~= nil then
				rawset(env, name, nil)
			end
		end)
	end

	return installEnvGuard()
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

-- Install the environment guard NOW, at load time: Cloak is the first module
-- in the bundle, and every module loaded after it probes missing globals
-- (syn/delta/fluxus/...). If a crashed copy left an unguarded __index wrapper
-- on the environment, the very first miss would cycle wrapper -> C __index ->
-- wrapper until a C stack overflow — before Controller.Start ever runs.
installEnvGuard()

return Cloak
