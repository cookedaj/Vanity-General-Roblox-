--==============================================================================
-- CONFIGURATION
-- Centralized settings and single source of truth.
--==============================================================================


local Configuration = {}

Configuration.Camera = {
	Enabled = false,
	-- LOWER = harder/snappier lock, HIGHER = slower, smoother follow.
	Smoothness = 0.85,
	-- Targeting cone radius in PIXELS from the crosshair (what the FOV circle draws).
	FOV = 200,
	-- World range limit in studs from your character.
	MaxDistance = 1000,
	-- Velocity lead: 0 = off, 1 = full lead using a rough time-of-flight model.
	Prediction = 0,
	-- Subtle per-frame jitter so the aim path isn't a perfect straight line.
	Humanize = true,

	-- Hitbox mode: "Random (Weighted)" uses TargetWeights below; otherwise a
	-- specific region ("Head" / "Torso" / "Arms" / "Legs") is aimed at directly.
	Hitbox = "Random (Weighted)",
	HitboxOptions = { "Random (Weighted)", "Head", "Torso", "Arms", "Legs" },

	-- 0-100 chance weights per body region, used only in Random (Weighted) mode.
	-- They don't need to sum to 100 — they're relative.
	TargetWeights = {
		Head = 85,
		Torso = 15,
		Arms = 0,
		Legs = 0,
	},

	WallCheck = true,     -- require line of sight to the target
	StickyTarget = false, -- keep the current target until it dies / leaves / exits FOV
	TargetBots = false,   -- also target NPCs (non-player models with a Humanoid)
	TeamCheck = true,     -- never target players on your own team
	FOVCircle = false,    -- draw the targeting radius on screen

	ToggleKey = Enum.KeyCode.LeftAlt,
	FOVCircleKey = Enum.KeyCode.F1,
}

Configuration.NoRecoil = {
	Enabled = false,
	-- 0..1 hold strength (1 = fully locked to where you started firing).
	Strength = 1,
	-- Only lock while the fire button (LMB) is held.
	RequireMouseDown = true,
	-- Still allow pulling the aim downward while firing (climb stays blocked).
	AllowAim = false,
	ToggleKey = Enum.KeyCode.F2,
}

Configuration.NoSpread = {
	Enabled = false,
	-- 0..1 how far each spread roll is pulled toward centre. 1 = dead centre
	-- (no spread at all), 0.5 = half the cone, 0 = untouched.
	Strength = 1,
	-- Only suppress spread rolls while the fire button (LMB) is held. Leaving this
	-- on keeps the rest of the game's randomness untouched except while shooting.
	RequireMouseDown = true,
	ToggleKey = Enum.KeyCode.F3,
}

Configuration.Triggerbot = {
	Enabled = false,
	-- Humanized reaction time: each shot waits a random delay sampled between
	-- MinDelay and MaxDelay (seconds the crosshair must sit on the target).
	MinDelay = 0.1,
	MaxDelay = 0.25,
	MaxDistance = 1000, -- studs; shots past this are ignored
	WallCheck = true,   -- "Vischeck": require line of sight (off = fire through walls)
	ToggleKey = Enum.KeyCode.F4,
}

Configuration.Movement = {
	FlyEnabled = false,
	FlySpeed = 50,
	NoclipEnabled = false,
	SpeedEnabled = false,
	-- 16 = stock WalkSpeed, i.e. no boost. Only the surplus over 16 is applied.
	Speed = 16,
	InfJumpEnabled = false,
	ClickTPEnabled = false,
	ClickTPKey = Enum.KeyCode.LeftControl, -- hold this + left click to teleport
}

Configuration.SilentAim = {
	Enabled = false,
}

Configuration.Hitbox = {
	Enabled = false,
	Size = 5,
	Transparency = 0.5,
}

Configuration.Drawing = {
	Boxes = false,
	Tracers = false,
	BoxColor = Color3.fromRGB(165, 75, 255),
	TracerColor = Color3.fromRGB(255, 255, 255),
}

Configuration.Visuals = {
	Fullbright = false,
	NoFog = false,
}

Configuration.Utility = {
	AntiAFK = true, -- simulates input on Idled so Roblox never kicks for inactivity
}

Configuration.ESP = {
	Enabled = false,
	-- Render styles; independent, so any combination can be on at once.
	Outlines = true, -- Highlight silhouette
	Boxes = false,   -- 2D screen-space box
	Names = false,   -- player name floating above the head
	Distance = false, -- meters from your character, under the name
	-- Tag-suite keys: NameTags/DistanceTags alias Names/Distance (same head
	-- billboard); HealthBars adds a health bar line to it.
	NameTags = false,
	HealthBars = false,
	DistanceTags = false,
	NPCs = false,    -- also highlight non-player characters (mobs/dummies)
	OutlineColor = Color3.fromRGB(165, 75, 255),
	FillColor = Color3.fromRGB(165, 75, 255),
	Filled = false,
	OutlineOpacity = 1,
	FillOpacity = 0.4,
	MaxDistance = 1000,
	ToggleKey = Enum.KeyCode.RightAlt, -- keybind for toggling ESP, like the aimbot
}

Configuration.UI = {
	Scale = 1,
	MenuKey = Enum.KeyCode.RightShift,
	UnloadKey = Enum.KeyCode.End,
	Visible = false, -- the menu itself; opened with MenuKey, not an Interface toggle
	-- Interface overlays all start ON.
	KeybindPanel = true,  -- standalone keybind window
	TargetDisplay = true, -- popup naming whoever you're looking at
	FPSCounter = true,    -- bottom-right fps readout
	Watermark = true,     -- bottom-left watermark logo
	-- Uploaded image id for the watermark logo. Leave "" to hide it.
	-- This is the IMAGE id (a Decal id renders as nothing) — resolved from
	-- decal 123653124904094 via InsertService:LoadAsset -> Decal.Texture.
	WatermarkImageId = "139845693858856",
}

-- Discord webhook URL in plaintext. The old single-file build kept this
-- encrypted via StringObfuscation/ProtectedSecrets; those modules left the
-- bundle (obfuscation happens at release build time), so the URL is plain
-- config now. Deliberately NOT in DEFAULTS, so Reset Settings keeps it.
Configuration.Webhook = {
	Url = "",
}

Configuration.Debug = false

local DEFAULTS = {
	Camera = {
		Enabled = false,
		Smoothness = 0.85,
		FOV = 200,
		MaxDistance = 1000,
		Prediction = 0,
		Humanize = true,
		Hitbox = "Random (Weighted)",
		TargetWeights = { Head = 85, Torso = 15, Arms = 0, Legs = 0 },
		WallCheck = true,
		StickyTarget = false,
		TargetBots = false,
		TeamCheck = true,
		FOVCircle = false,
	},
	ESP = {
		Enabled = false,
		Outlines = true,
		Boxes = false,
		Names = false,
		Distance = false,
		NameTags = false,
		HealthBars = false,
		DistanceTags = false,
		NPCs = false,
		OutlineColor = Color3.fromRGB(165, 75, 255),
		FillColor = Color3.fromRGB(165, 75, 255),
		Filled = false,
		OutlineOpacity = 1,
		FillOpacity = 0.4,
		MaxDistance = 1000,
	},
	NoRecoil = { Enabled = false, Strength = 1, RequireMouseDown = true, AllowAim = false },
	NoSpread = { Enabled = false, Strength = 1, RequireMouseDown = true },
	Triggerbot = { Enabled = false, MinDelay = 0.1, MaxDelay = 0.25, MaxDistance = 1000, WallCheck = true },
	Movement = {
		FlyEnabled = false,
		FlySpeed = 50,
		NoclipEnabled = false,
		SpeedEnabled = false,
		Speed = 16,
		InfJumpEnabled = false,
		ClickTPEnabled = false,
	},
	SilentAim = { Enabled = false },
	Hitbox = { Enabled = false, Size = 5, Transparency = 0.5 },
	Drawing = {
		Boxes = false,
		Tracers = false,
		BoxColor = Color3.fromRGB(165, 75, 255),
		TracerColor = Color3.fromRGB(255, 255, 255),
	},
	Visuals = { Fullbright = false, NoFog = false },
	Utility = { AntiAFK = true },
	UI = {
		Scale = 1,
		KeybindPanel = true,
		TargetDisplay = true,
		FPSCounter = true,
		Watermark = true,
	},
}

function Configuration.reset()
	for section, values in pairs(DEFAULTS) do
		for key, value in pairs(values) do
			if type(value) == "table" then
				-- Copy nested defaults (e.g. TargetWeights) into the existing table
				-- so we never alias the DEFAULTS table itself.
				local target = Configuration[section][key]
				if type(target) ~= "table" then
					target = {}
					Configuration[section][key] = target
				end
				for k, v in pairs(value) do
					target[k] = v
				end
			else
				Configuration[section][key] = value
			end
		end
	end
end

return Configuration
