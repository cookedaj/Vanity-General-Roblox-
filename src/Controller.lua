--==============================================================================
-- MAIN CONTROLLER - Entry Point
-- Orchestrates all systems (ESP, Camera, UI, Movement, Webhook, etc).
-- Exported as getgenv().VanityGeneral on Start — through the Cloak, so the
-- name reads normally but never enumerates in an environment scan.
--==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local Configuration = require(script.Configuration)
local ConfigManager = require(script.ConfigManager)
local Candidates = require(script.Candidates)
local CameraDirector = require(script.CameraDirector)
local HitboxExpander = require(script.Hitbox)
local SilentAim = require(script.SilentAim)
local NoRecoil = require(script.NoRecoil)
local NoSpread = require(script.NoSpread)
local Triggerbot = require(script.Triggerbot)
local ESP = require(script.ESP)
local DrawingESP = require(script.DrawingESP)
local Visuals = require(script.Visuals)
local Utility = require(script.Utility)
local UI = require(script.UI)
local Movement = require(script.Movement)
local Webhook = require(script.Webhook)
local Cloak = require(script.Cloak)

local Controller = {}
Controller.Version = "0"
Controller.Config = Configuration

-- Injected rather than required by the UI (would be a UI <-> Movement cycle):
-- the Players tab's "Teleport To" button calls this.
UI.TeleportTo = Movement.TeleportTo

Webhook.Version = Controller.Version -- stamped for the "loaded" embed

local running = false
local connections = {}
local aimbotSteering = false -- set each frame; tells NoRecoil to stand down
-- Randomized so the BindToRenderStep name carries no script signature.
local RECOIL_BIND = Cloak.RandomName() -- BindToRenderStep name (runs after camera)

-- Per-frame crash guard. A raw error inside a RenderStepped handler repeats every
-- frame, flooding the console and tanking FPS. This swallows the error, keeps the
-- rest of the frame running, and reports at most once every few seconds per site.
local guardState = {}
local GUARD_WARN_INTERVAL = 5

local function guarded(name, fn, ...)
	local ok, res = pcall(fn, ...)
	if ok then
		local st = guardState[name]
		if st then
			st.failures = 0
		end
		return true, res
	end

	local st = guardState[name]
	if not st then
		st = { failures = 0, lastWarn = -math.huge }
		guardState[name] = st
	end
	st.failures = st.failures + 1

	local now = os.clock()
	if now - st.lastWarn >= GUARD_WARN_INTERVAL then
		st.lastWarn = now
		warn(string.format("[Vanity-General] %s failed (x%d): %s", name, st.failures, tostring(res)))
	end
	return false, nil
end

function Controller.IsRunning()
	return running
end

-- Config profiles, also usable from the console:
--   VanityGeneral.SaveConfig("legit") / .LoadConfig("legit") / .ListConfigs()
function Controller.SaveConfig(name)
	return ConfigManager.save(name, Configuration)
end

function Controller.LoadConfig(name)
	local ok, res = ConfigManager.load(name, Configuration)
	if ok then
		pcall(function()
			UI:SyncControls()
		end)
	end
	return ok, res
end

function Controller.ListConfigs()
	return ConfigManager.list()
end

function Controller.DeleteConfig(name)
	return ConfigManager.delete(name)
end

-- Teleport helpers (also on the Settings > Account buttons).
function Controller.ServerHop()
	return Utility:ServerHop()
end

function Controller.Rejoin()
	return Utility:Rejoin()
end

-- Sets the watermark logo from an uploaded image id (bare id or rbxassetid://).
-- Persists into config so it survives a menu rebuild.
function Controller.SetWatermarkImage(id)
	Configuration.UI.WatermarkImageId = tostring(id or "")
	UI:SetWatermarkImage(Configuration.UI.WatermarkImageId)
	return Controller
end

-- Webhook passthroughs (implementation lives in the Webhook module).
function Controller.SetWebhook(url)
	return Webhook.SetWebhook(url)
end

function Controller.HasWebhook()
	return Webhook.HasWebhook()
end

function Controller.SendWebhook(content, opts)
	return Webhook.SendWebhook(content, opts)
end

function Controller.SendLoadedEmbed(isDebugged)
	return Webhook.SendLoadedEmbed(isDebugged)
end

function Controller.Start()
	if running then
		return Controller
	end

	running = true

	-- Note: no global hooks are installed here. The Cloak filter installs
	-- itself on the first Protect() of a game-visible instance, and Silent Aim
	-- installs on first enable — so simply loading the script with everything
	-- off leaves the game's metatable completely untouched.
	local ok, err = pcall(function()
		ESP:Init()

		UI:Init(Configuration, function()
			Controller.Stop()
		end)

		Movement:Init(Configuration.Movement)

		-- Full config: Silent Aim reads its own toggle plus the ESP/Camera
		-- sections for its crosshair (look-target) fallback.
		SilentAim:Init(Configuration)

		table.insert(connections, Players.PlayerAdded:Connect(function(player)
			guarded("PlayerAdded", ESP.OnPlayerAdded, ESP, player)
		end))

		table.insert(connections, Players.PlayerRemoving:Connect(function(player)
			guarded("PlayerRemoving", ESP.OnPlayerRemoving, ESP, player)
		end))

		table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed or UI:IsCapturingKey() then
				return
			end

			-- Guarded so a bad SyncControls/toggle can't kill the input connection.
			guarded("Keybinds", function()
				-- Data-driven so adding a bind is one row, not another elseif branch.
				local key = input.KeyCode
				if key == Configuration.UI.MenuKey then
					UI:Toggle()
				elseif key == Configuration.UI.UnloadKey then
					Controller.Stop()
				else
					local toggles = {
						{ Configuration.Camera, "Enabled", Configuration.Camera.ToggleKey },
						{ Configuration.ESP, "Enabled", Configuration.ESP.ToggleKey },
						{ Configuration.Camera, "FOVCircle", Configuration.Camera.FOVCircleKey },
						{ Configuration.NoRecoil, "Enabled", Configuration.NoRecoil.ToggleKey },
						{ Configuration.NoSpread, "Enabled", Configuration.NoSpread.ToggleKey },
						{ Configuration.Triggerbot, "Enabled", Configuration.Triggerbot.ToggleKey },
					}
					for _, t in ipairs(toggles) do
						if key == t[3] then
							t[1][t[2]] = not t[1][t[2]]
							UI:SyncControls()
							break
						end
					end
				end
			end)
		end))

		-- Rolling FPS sample for the counter, refreshed ~4x a second.
		local fpsAccum, fpsFrames = 0, 0

		-- Every subsystem runs behind `guarded`, so one throwing (a destroyed part,
		-- a nil character mid-respawn) can't kill the loop or spam the console.
		table.insert(connections, RunService.RenderStepped:Connect(function(dt)
			-- Shared per-frame candidate pool FIRST: CameraDirector, ESP,
			-- DrawingESP and Hitbox all read it below instead of re-walking
			-- players and re-resolving parts/projections themselves.
			guarded("Candidates", Candidates.Update, Candidates, Configuration.Camera, Configuration.ESP)

			guarded("ESP", ESP.Update, ESP, Configuration.ESP)

			-- While spectating (Players tab), the aimbot must not steer the
			-- camera away from the spectate target.
			local okAim, target = true, nil
			if not (UI.IsSpectating and UI.IsSpectating()) then
				okAim, target = guarded("Aimbot", CameraDirector.Update, CameraDirector, Configuration.Camera, Configuration.Debug)
			end
			if not okAim then
				target = nil
			end

			-- Target Display names whoever you're LOOKING at (walls ignored, ESP
			-- render distance), independent of whether the aimbot has a lock. Only
			-- resolved while the popup is on, so it costs nothing when off.
			if Configuration.UI.TargetDisplay then
				guarded("Target display", function()
					local looking = CameraDirector:GetLookTarget(Configuration.ESP, Configuration.Camera)
					UI:SetCurrentTarget(looking and looking.Name or nil)
				end)
			end

			-- Record whether the aimbot owns the camera this frame (NoRecoil reads it).
			aimbotSteering = Configuration.Camera.Enabled and target ~= nil

			-- Neutralize client-side bullet spread rolls when enabled.
			guarded("NoSpread", NoSpread.Update, NoSpread, Configuration.NoSpread)

			-- Installs the Silent Aim hooks on first enable (kept out of Init so
			-- loading the script never touches the game's metatable).
			guarded("Silent Aim", SilentAim.Update, SilentAim, Configuration)

			-- Auto-fire when the crosshair is on a target.
			guarded("Triggerbot", Triggerbot.Update, Triggerbot, Configuration.Triggerbot, Configuration.Camera)

			-- CFrame movement suite (fly / noclip / speed); event halves run on
			-- their own connections from Movement:Init.
			guarded("Movement", Movement.Update, Movement, dt, Configuration.Movement)

			-- Client-side root inflation on the aimbot's candidate set.
			guarded("Hitbox", HitboxExpander.Update, HitboxExpander, Configuration.Hitbox, Configuration.Camera)

			-- Executor Drawing boxes/tracers (no-op without the Drawing library).
			guarded("Drawing ESP", DrawingESP.Update, DrawingESP, Configuration.Drawing, Configuration.Camera)

			-- Fullbright / No Fog lighting watches.
			guarded("Visuals", Visuals.Update, Visuals, Configuration.Visuals)

			-- Averaging over a window rather than 1/dt keeps the readout steady.
			fpsAccum = fpsAccum + dt
			fpsFrames = fpsFrames + 1
			if fpsAccum >= 0.25 then
				local fps = math.floor(fpsFrames / fpsAccum + 0.5)
				fpsAccum, fpsFrames = 0, 0
				if Configuration.UI.FPSCounter then
					guarded("FPS counter", UI.UpdateFPS, UI, fps)
				end
			end
		end))

		-- Run NoRecoil AFTER the game's camera update (recoil is applied there), so
		-- our correction is the last word each frame and the climb is fully undone.
		-- RenderStepped runs before the camera, which is why the old inline call only
		-- reduced recoil instead of removing it.
		pcall(function()
			RunService:UnbindFromRenderStep(RECOIL_BIND) -- clear any stale bind first
		end)
		pcall(function()
			RunService:BindToRenderStep(RECOIL_BIND, Enum.RenderPriority.Camera.Value + 1, function()
				guarded("NoRecoil", NoRecoil.Update, NoRecoil, Configuration.NoRecoil, aimbotSteering)
			end)
		end)
	end)

	if not ok then
		warn("[Vanity-General] Failed to start:", err)
		Controller.Stop()
		return Controller
	end

	-- Export under the historical global name so re-executions can find us,
	-- but through the cloak: readable as getgenv().VanityGeneral, invisible to
	-- pairs() environment scans. Raw fallback only if hiding is impossible.
	if not Cloak.HideGlobal("VanityGeneral", Controller) and getgenv then
		getgenv().VanityGeneral = Controller
	end

	UI:Notify(string.format("Vanity-General loaded  •  Press %s", Configuration.UI.MenuKey.Name), 4)

	print(string.format("[Vanity-General] Running (v%s)", Controller.Version))
	print(string.format("Menu: %s  |  Camera: %s  |  Unload: %s",
		Configuration.UI.MenuKey.Name,
		Configuration.Camera.ToggleKey.Name,
		Configuration.UI.UnloadKey.Name))

	-- Fire-and-forget "loaded" ping as a Discord embed. No-ops silently if no
	-- webhook is configured.
	if Webhook.HasWebhook() then
		task.spawn(function()
			Webhook.SendLoadedEmbed(false)
		end)
	end

	return Controller
end

function Controller.Stop()
	if not running then
		return Controller
	end
	running = false

	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disconnect()
		end)
	end
	table.clear(connections)

	pcall(function()
		RunService:UnbindFromRenderStep(RECOIL_BIND)
	end)
	aimbotSteering = false

	pcall(function()
		ESP:Cleanup()
	end)
	pcall(function()
		UI:Cleanup()
	end)
	pcall(function()
		CameraDirector:Cleanup() -- removes the FOV circle drawing
	end)
	pcall(function()
		Movement:Cleanup() -- disconnects jump/click listeners; noclip self-restores
	end)
	pcall(function()
		HitboxExpander:Cleanup() -- restore any inflated enemy roots
	end)
	pcall(function()
		DrawingESP:Cleanup() -- destroy all Drawing line objects
	end)
	pcall(function()
		Visuals:Cleanup() -- restore original Lighting properties
	end)
	pcall(function()
		NoSpread:Cleanup() -- restore original math.random so no global hook lingers
	end)
	NoRecoil:Reset()
	table.clear(guardState) -- fresh error throttling on the next Start

	print("[Vanity-General] Stopped")
	return Controller
end

function Controller.Toggle()
	if running then
		Controller.Stop()
	else
		Controller.Start()
	end
	return Controller
end

Controller.start = Controller.Start
Controller.stop = Controller.Stop
Controller.toggle = Controller.Toggle

return Controller
