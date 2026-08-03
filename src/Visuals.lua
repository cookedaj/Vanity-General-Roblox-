-- Visuals Module
-- Lighting overrides (Fullbright / No Fog) and small client utilities
-- (Anti-AFK). Lighting originals are captured on first application and
-- restored when every override is off or on Cleanup.

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

local Visuals = {}

local config
local connections = {}

-- Originals captured on the enable edge; nil while no override is applied.
local originals

-- Properties we override and therefore need to restore
local TRACKED = {
	"Brightness",
	"ClockTime",
	"GlobalShadows",
	"FogEnd",
	"FogStart",
	"Ambient",
	"OutdoorAmbient",
}

-- Which properties each toggle overrides. Fullbright = daylight + no
-- shadows; No Fog = push the fog out. Independent so No Fog doesn't
-- force daytime and vice versa.
local OVERRIDES = {
	Fullbright = {
		Brightness = 2,
		ClockTime = 14,
		GlobalShadows = false,
	},
	NoFog = {
		FogEnd = 1e5,
		FogStart = 1e5,
	},
}

local function captureOriginals()
	originals = {}
	for _, prop in ipairs(TRACKED) do
		originals[prop] = Lighting[prop]
	end
end

local function restoreOriginals()
	if not originals then
		return
	end
	for prop, value in pairs(originals) do
		Lighting[prop] = value
	end
	originals = nil
end

local function applyOverrides()
	-- Desired value per property: the toggle's override when active, the
	-- captured original otherwise. Re-applied every frame so an external
	-- change (game scripts, other lighting effects) can't silently undo it.
	for _, prop in ipairs(TRACKED) do
		local desired = originals[prop]
		for toggle, props in pairs(OVERRIDES) do
			if config.Visuals[toggle] and props[prop] ~= nil then
				desired = props[prop]
			end
		end
		if Lighting[prop] ~= desired then
			Lighting[prop] = desired
		end
	end
end

-- Edge-triggered enable/disable, driven from the controller's render loop
function Visuals:Update()
	if not config then
		return
	end

	local wantOverride = config.Visuals.Fullbright or config.Visuals.NoFog

	if wantOverride then
		if not originals then
			captureOriginals()
		end
		applyOverrides()
	else
		restoreOriginals()
	end
end

function Visuals:Init(fullConfig)
	config = fullConfig

	-- Anti-AFK: fake a tiny input whenever Roblox would flag us idle, so the
	-- 20-minute kick never fires. VirtualUser input is client-synthesized and
	-- invisible to other players.
	table.insert(connections, LocalPlayer.Idled:Connect(function()
		if not config.Utility.AntiAFK then
			return
		end
		pcall(function()
			local virtualUser = game:GetService("VirtualUser")
			virtualUser:CaptureController()
			virtualUser:ClickButton2(Vector2.new())
		end)
	end))
end

function Visuals:Cleanup()
	restoreOriginals()

	for _, conn in ipairs(connections) do
		conn:Disconnect()
	end
	table.clear(connections)
	config = nil
end

return Visuals
