--==============================================================================
-- VANITY-GENERAL - Entry point
-- Loads the controller, stops any previously injected copy, and starts.
--==============================================================================

local Controller = require(script.Controller)

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
