--==============================================================================
-- NO SPREAD
-- Best-effort removal of client-side bullet spread via function hooking.
--==============================================================================

local NoRecoil = require(script.NoRecoil)
local Cloak = require(script.Cloak)

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
	local ok, ret = pcall(hook, math.random, Cloak.CClosure(function(...)
		local original = ns_origMathRandom(...)
		if ns_active and ns_strength > 0 then
			local a, b = ...
			-- math.random() returns a float; the (n) and (a,b) forms return integers.
			return ns_pull(original, ns_mathMid(a, b), a ~= nil)
		end
		return original
	end))
	if ok then
		ns_origMathRandom = ret
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

		ns_origNextNumber = hook(sample.NextNumber, Cloak.CClosure(function(self, ...)
			local original = ns_origNextNumber(self, ...)
			if ns_active and ns_strength > 0 then
				local mn, mx = ...
				local centre = (mn == nil) and 0.5 or ((mn + mx) / 2)
				return ns_pull(original, centre, false)
			end
			return original
		end))

		ns_origNextInteger = hook(sample.NextInteger, Cloak.CClosure(function(self, ...)
			local original = ns_origNextInteger(self, ...)
			if ns_active and ns_strength > 0 then
				local mn, mx = ...
				return ns_pull(original, (mn + mx) / 2, true)
			end
			return original
		end))
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
	if ns_mathHooked and ns_origMathRandom then
		pcall(hook, math.random, ns_origMathRandom)
		ns_mathHooked = false
	end
	if ns_randHooked then
		pcall(function()
			local sample = Random.new()
			if ns_origNextNumber then
				hook(sample.NextNumber, ns_origNextNumber)
			end
			if ns_origNextInteger then
				hook(sample.NextInteger, ns_origNextInteger)
			end
		end)
		ns_randHooked = false
	end
end

return NoSpread
