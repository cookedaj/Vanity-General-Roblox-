-- Configuration Module
-- Centralized settings and single source of truth for all systems.
-- Also owns the default snapshot so reset logic lives in exactly one place.

local Config = {}

Config.Camera = {
	Enabled = false,
	Smoothness = 0.15,
	MaxDistance = 300,
	TargetPart = "Head",
	-- Every standard rig part (R15 + R6). CameraDirector resolves whichever the
	-- target actually has, falling back through this list, so any of these can be
	-- aimed at regardless of rig type.
	TargetPartOptions = {
		"Head",
		"HumanoidRootPart",
		-- R15 torso
		"UpperTorso",
		"LowerTorso",
		-- R15 arms
		"LeftUpperArm",
		"LeftLowerArm",
		"LeftHand",
		"RightUpperArm",
		"RightLowerArm",
		"RightHand",
		-- R15 legs
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot",
		"RightUpperLeg",
		"RightLowerLeg",
		"RightFoot",
		-- R6
		"Torso",
		"Left Arm",
		"Right Arm",
		"Left Leg",
		"Right Leg",
	},
	-- Separate keybind for toggling camera tracking (independent of the menu key).
	ToggleKey = Enum.KeyCode.LeftAlt,
}

Config.ESP = {
	Enabled = false,
	Color = Color3.fromRGB(165, 75, 255),
	Filled = false,
	Thickness = 1,
	OutlineOpacity = 1,
	FillOpacity = 0.4,
	MaxDistance = 1000,
}

Config.UI = {
	Scale = 1,
	MenuKey = Enum.KeyCode.RightShift,
	UnloadKey = Enum.KeyCode.End, -- panic key: fully tears down and unloads
	Visible = false,
}

Config.Debug = false

-- Default values used by reset(). Keybinds and option lists are intentionally
-- excluded so a reset restores tunables without wiping user bindings.
local DEFAULTS = {
	Camera = { Enabled = false, Smoothness = 0.15, MaxDistance = 300, TargetPart = "Head" },
	ESP = {
		Enabled = false,
		Color = Color3.fromRGB(165, 75, 255),
		Filled = false,
		Thickness = 1,
		OutlineOpacity = 1,
		FillOpacity = 0.4,
		MaxDistance = 1000,
	},
	UI = { Scale = 1 },
}

-- Restore all tunable settings to their defaults.
function Config.reset()
	for section, values in pairs(DEFAULTS) do
		for key, value in pairs(values) do
			Config[section][key] = value
		end
	end
end

return Config
