-- Vanity-General Loader
-- Place this script in: StarterPlayer > StarterCharacterScripts > LocalScript
-- Or: StarterPlayer > StarterPlayerScripts > LocalScript

-- Module location setup: modules sit next to this script, or in a
-- "VanityGeneral" folder in ReplicatedStorage.
local moduleLocation

if script.Parent:FindFirstChild("Configuration") then
	moduleLocation = script.Parent
elseif game:GetService("ReplicatedStorage"):FindFirstChild("VanityGeneral") then
	moduleLocation = game:GetService("ReplicatedStorage"):WaitForChild("VanityGeneral")
else
	warn("[Vanity-General] Modules not found next to this script or in ReplicatedStorage.VanityGeneral")
	return
end

-- Load all modules
local Configuration
local CameraDirector
local ESP
local UI

local success, err = pcall(function()
	Configuration = require(moduleLocation:WaitForChild("Configuration", 5))
	CameraDirector = require(moduleLocation:WaitForChild("CameraDirector", 5))
	ESP = require(moduleLocation:WaitForChild("ESP", 5))
	UI = require(moduleLocation:WaitForChild("UI", 5))
end)

if not success then
	warn("[Vanity-General] Failed to load modules:", err)
	return
end

-- Initialize systems
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- NOTE: Loader and MainController are alternative entry points for different
-- install layouts. Use ONE of them, never both, or systems will initialize twice.

local function init()
	ESP:Init()

	-- Reset defaults live in Configuration (single source of truth)
	UI:Init(Configuration, function()
		Configuration.reset()
		UI:SyncControls()
	end)

	-- Player tracking
	Players.PlayerAdded:Connect(function(player)
		ESP:OnPlayerAdded(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		ESP:OnPlayerRemoving(player)
	end)

	-- Input handling: menu key opens the UI, camera key toggles tracking
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		-- A keybind box is armed: this press is a rebind, not a hotkey.
		if UI:IsCapturingKey() then
			return
		end

		if input.KeyCode == Configuration.UI.MenuKey then
			UI:Toggle()
		elseif input.KeyCode == Configuration.Camera.ToggleKey then
			Configuration.Camera.Enabled = not Configuration.Camera.Enabled
			UI:SyncControls()
		end
	end)

	UI:Notify(string.format("Vanity-General loaded  •  Press %s", Configuration.UI.MenuKey.Name), 4)

	-- Single RenderStepped loop drives both systems
	RunService.RenderStepped:Connect(function()
		ESP:Update(Configuration.ESP)

		local target = CameraDirector:Update(Configuration.Camera, Configuration.Debug)
		if Configuration.Camera.Enabled and target then
			UI:SetCurrentTarget(target.Player and target.Player.Name or target.Character.Name)
		else
			UI:SetCurrentTarget("None")
		end
	end)

	print("[Vanity-General] Running")
	print(string.format("Menu: %s  |  Camera tracking: %s",
		Configuration.UI.MenuKey.Name, Configuration.Camera.ToggleKey.Name))
end

init()
