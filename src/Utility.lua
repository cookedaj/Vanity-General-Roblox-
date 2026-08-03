--==============================================================================
-- UTILITY
-- Small quality-of-life features: Anti-AFK, server hop / rejoin, GUI parent helper.
--==============================================================================

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

local Utility = {}
local TeleportService = game:GetService("TeleportService")
local ut_idleConnection

-- Anti-AFK: Roblox kicks after ~20 minutes without input. VirtualUser fakes
-- input at the engine level — it's an executor global on most executors and a
-- real (normally script-inaccessible) service otherwise, so try both.
function Utility:Init(config)
	if ut_idleConnection then
		return
	end

	local vu = (type(VirtualUser) ~= "nil" and VirtualUser) or nil
	if not vu then
		pcall(function()
			vu = game:GetService("VirtualUser")
		end)
	end
	if not vu then
		return -- no way to simulate input on this executor
	end

	ut_idleConnection = LocalPlayer.Idled:Connect(function()
		if config.AntiAFK then
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end
	end)
end

function Utility:Cleanup()
	if ut_idleConnection then
		ut_idleConnection:Disconnect()
		ut_idleConnection = nil
	end
end

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
