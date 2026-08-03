--==============================================================================
-- VanityGeneral — executor bootstrap
--
-- Paste THIS into your executor. It loads VanityGeneral_INTEGRATED.lua and
-- starts it. VanityGeneral_INTEGRATED.lua must be in your executor's workspace
-- folder (where readfile looks). Re-running this is safe: the script tears
-- down any previous copy before starting a fresh one.
--
-- Keys once running:   RightShift = menu   |   LeftAlt = camera   |   End = unload
--==============================================================================

-- Option A — load from a local file (default; matches `readfile`).
local SOURCE = function()
	return readfile("VanityGeneral_INTEGRATED.lua")
end

-- Option B — load from a hosted URL instead. Comment out Option A above and
-- uncomment this, replacing the URL with your raw script link.
-- local SOURCE = function()
-- 	return game:HttpGet("https://example.com/VanityGeneral_INTEGRATED.lua")
-- end

local ok, result = pcall(function()
	local source = SOURCE()
	local chunk = loadstring(source)
	if not chunk then
		error("loadstring returned nil (source failed to compile)")
	end
	return chunk()
end)

if not ok then
	warn("[VanityGeneral] Failed to load:", result)
	return
end

local VanityGeneral = result
VanityGeneral.Start()

-- Handy later (also reachable via getgenv().VanityGeneral):
--   VanityGeneral.Stop()     -- tear everything down
--   VanityGeneral.Toggle()   -- start/stop in one call
