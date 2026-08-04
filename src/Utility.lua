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
