-- Main Controller
-- Orchestrates Camera Director, ESP, and UI systems
-- Single RenderStepped loop for optimal performance

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Load modules
local Configuration = require(script.Configuration)
local CameraDirector = require(script.CameraDirector)
local ESP = require(script.ESP)
local UI = require(script.UI)

local renderConnection
local playerAddedConnection
local playerRemovingConnection
local inputConnection
local selfRemovingConnection

-- Forward-declared so init()'s input handler can capture it as an upvalue
-- (the definition lives below).
local cleanup

-- Initialize all systems
local function init()
	ESP:Init()

	-- Reset defaults live in the Configuration module (single source of truth);
	-- the UI just re-syncs its controls afterward.
	UI:Init(Configuration, function()
		Configuration.reset()
		UI:SyncControls()
	end)

	-- Player tracking
	playerAddedConnection = Players.PlayerAdded:Connect(function(player)
		ESP:OnPlayerAdded(player)
	end)

	playerRemovingConnection = Players.PlayerRemoving:Connect(function(player)
		ESP:OnPlayerRemoving(player)
	end)

	-- Input handling: menu key opens the UI, camera key toggles tracking,
	-- unload key tears everything down.
	inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		-- A keybind box is armed: this press is a rebind, not a hotkey.
		if UI:IsCapturingKey() then
			return
		end

		if input.KeyCode == Configuration.UI.MenuKey then
			UI:Toggle()
		elseif input.KeyCode == Configuration.UI.UnloadKey then
			cleanup()
		elseif input.KeyCode == Configuration.Camera.ToggleKey then
			Configuration.Camera.Enabled = not Configuration.Camera.Enabled
			UI:SyncControls() -- keep the on-screen toggle in sync with the keybind
		end
	end)

	-- Single RenderStepped loop drives both systems
	renderConnection = RunService.RenderStepped:Connect(function()
		ESP:Update(Configuration.ESP)

		local target = CameraDirector:Update(Configuration.Camera, Configuration.Debug)

		-- Feed the live target name into the Camera tab's "Current Target" row
		if Configuration.Camera.Enabled and target then
			UI:SetCurrentTarget(target.Player and target.Player.Name or target.Character.Name)
		else
			UI:SetCurrentTarget("None")
		end
	end)

	UI:Notify(string.format("Vanity-General loaded  •  Press %s", Configuration.UI.MenuKey.Name), 4)

	print("[Vanity-General] Systems initialized")
	print(string.format("Menu: %s  |  Camera: %s  |  Unload: %s",
		Configuration.UI.MenuKey.Name, Configuration.Camera.ToggleKey.Name, Configuration.UI.UnloadKey.Name))
end

-- Cleanup all systems (assigns to the forward-declared local above)
function cleanup()
	if renderConnection then
		renderConnection:Disconnect()
		renderConnection = nil
	end

	if playerAddedConnection then
		playerAddedConnection:Disconnect()
		playerAddedConnection = nil
	end

	if playerRemovingConnection then
		playerRemovingConnection:Disconnect()
		playerRemovingConnection = nil
	end

	if inputConnection then
		inputConnection:Disconnect()
		inputConnection = nil
	end

	if selfRemovingConnection then
		selfRemovingConnection:Disconnect()
		selfRemovingConnection = nil
	end

	ESP:Cleanup()
	UI:Cleanup()

	print("[Vanity-General] Systems cleaned up")
end

-- Handle cleanup on player leaving (tracked so cleanup() can disconnect it;
-- otherwise this connection would survive an UnloadKey teardown)
selfRemovingConnection = Players.PlayerRemoving:Connect(function(player)
	if player == LocalPlayer then
		cleanup()
	end
end)

-- Start everything
init()

-- Make controller accessible for debugging
if getgenv then
	getgenv().VanityGeneral = {
		Config = Configuration,
		Cleanup = cleanup,
	}
end
