--==============================================================================
-- TRIGGERBOT
-- Fires when the crosshair is over a living player.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local Triggerbot = {}
local tb_click -- resolved click function
local tb_resolved = false
local tb_warned = false
local tb_onTargetSince = nil -- os.clock when the crosshair first landed on a target
local tb_currentDelay -- humanized reaction time, re-sampled per target landing
local tb_rng = Random.new()
local tb_lastFire = 0
local TB_REFIRE = 0.08 -- min seconds between shots so it can't spam every frame

local function tb_resolveClick()
	if tb_resolved then
		return
	end
	tb_resolved = true

	if type(mouse1click) == "function" then
		tb_click = function()
			mouse1click()
		end
	elseif type(mouse1press) == "function" and type(mouse1release) == "function" then
		tb_click = function()
			mouse1press()
			task.delay(0.04, function()
				pcall(mouse1release)
			end)
		end
	end
end

-- Returns the character model under the crosshair (living, not you), else nil.
local function tb_targetUnderCrosshair(config, cameraConfig)
	local cam = Workspace.CurrentCamera
	if not cam then
		return nil
	end

	local vs = cam.ViewportSize
	local ray = cam:ViewportPointToRay(vs.X / 2, vs.Y / 2)

	local params = RaycastParams.new()
	if config.WallCheck then
		-- Vischeck ON: hit the first thing, so walls between you and the target block.
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { LocalPlayer.Character }
	else
		-- Vischeck OFF: only collide with other players' characters, so the ray
		-- passes straight through walls and still registers a target behind them.
		local chars = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character then
				table.insert(chars, plr.Character)
			end
		end
		params.FilterType = Enum.RaycastFilterType.Include
		params.FilterDescendantsInstances = chars
	end

	local result = Workspace:Raycast(ray.Origin, ray.Direction * (config.MaxDistance or 1000), params)
	if not result then
		return nil
	end

	local model = result.Instance:FindFirstAncestorOfClass("Model")
	local plr = model and Players:GetPlayerFromCharacter(model)
	if not plr or plr == LocalPlayer then
		return nil
	end

	-- Team Check (lives in the Camera config): never fire on teammates.
	-- Teamless players (Team == nil) stay fair game.
	if cameraConfig and cameraConfig.TeamCheck and plr.Team ~= nil and plr.Team == LocalPlayer.Team then
		return nil
	end

	local hum = model:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then
		return nil
	end

	return model
end

function Triggerbot:Update(config, cameraConfig)
	if not config.Enabled then
		tb_onTargetSince = nil
		return
	end

	tb_resolveClick()
	if not tb_click then
		if not tb_warned then
			warn("[Vanity-General] Triggerbot needs a mouse-click function (mouse1click) — not available in this executor.")
			tb_warned = true
		end
		return
	end

	local target = tb_targetUnderCrosshair(config, cameraConfig)
	if not target then
		tb_onTargetSince = nil -- reset the reaction timer when off-target
		return
	end

	local now = os.clock()
	if not tb_onTargetSince then
		tb_onTargetSince = now
		-- Humanized reaction time, sampled fresh each time the crosshair lands.
		local lo = math.min(config.MinDelay or 0.1, config.MaxDelay or 0.25)
		local hi = math.max(config.MinDelay or 0.1, config.MaxDelay or 0.25)
		tb_currentDelay = tb_rng:NextNumber(lo, hi)
	end

	if (now - tb_onTargetSince) >= (tb_currentDelay or 0) and (now - tb_lastFire) >= TB_REFIRE then
		tb_lastFire = now
		tb_click()
	end
end

return Triggerbot
