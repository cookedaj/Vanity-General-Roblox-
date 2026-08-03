--==============================================================================
-- VISUALS
-- World lighting tweaks (Fullbright / No Fog) with original-state restore.
--==============================================================================

local Lighting = game:GetService("Lighting")

local Visuals = {}
local Lighting = game:GetService("Lighting")
local vs_originals -- captured the first time either feature turns on
local vs_fullbrightOn = false
local vs_noFogOn = false
local vs_lastCheck = 0
local VS_CHECK_INTERVAL = 1

local function vs_captureOriginals()
	if vs_originals then
		return
	end
	vs_originals = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		GlobalShadows = Lighting.GlobalShadows,
		FogEnd = Lighting.FogEnd,
		FogStart = Lighting.FogStart,
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
	}
end

local function vs_applyFullbright()
	Lighting.Brightness = 2
	Lighting.ClockTime = 14 -- noon
	Lighting.GlobalShadows = false
end

local function vs_applyNoFog()
	Lighting.FogEnd = 100000
end

local function vs_restoreFullbright()
	Lighting.Brightness = vs_originals.Brightness
	Lighting.ClockTime = vs_originals.ClockTime
	Lighting.GlobalShadows = vs_originals.GlobalShadows
end

local function vs_restoreNoFog()
	Lighting.FogEnd = vs_originals.FogEnd
	Lighting.FogStart = vs_originals.FogStart
end

function Visuals:Update(config)
	if not (config.Fullbright or config.NoFog or vs_fullbrightOn or vs_noFogOn) then
		return
	end
	vs_captureOriginals()

	if config.Fullbright ~= vs_fullbrightOn then
		vs_fullbrightOn = config.Fullbright
		if vs_fullbrightOn then
			vs_applyFullbright()
		else
			vs_restoreFullbright()
		end
	end

	if config.NoFog ~= vs_noFogOn then
		vs_noFogOn = config.NoFog
		if vs_noFogOn then
			vs_applyNoFog()
		else
			vs_restoreNoFog()
		end
	end

	-- The game may re-write lighting (new area, weather script); push back ~1/s.
	if (vs_fullbrightOn or vs_noFogOn) and os.clock() - vs_lastCheck >= VS_CHECK_INTERVAL then
		vs_lastCheck = os.clock()
		if vs_fullbrightOn
			and (Lighting.Brightness ~= 2 or Lighting.ClockTime ~= 14 or Lighting.GlobalShadows)
		then
			vs_applyFullbright()
		end
		if vs_noFogOn and Lighting.FogEnd < 100000 then
			vs_applyNoFog()
		end
	end
end

function Visuals:Cleanup()
	if vs_originals then
		if vs_fullbrightOn then
			vs_restoreFullbright()
		end
		if vs_noFogOn then
			vs_restoreNoFog()
		end
	end
	vs_fullbrightOn = false
	vs_noFogOn = false
end

return Visuals
