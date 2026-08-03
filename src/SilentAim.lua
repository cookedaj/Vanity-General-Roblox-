--==============================================================================
-- SILENT AIM
-- Redirects your shots onto the aimbot's current target WITHOUT moving the
-- camera, by hooking game's metatable. Requires an executor with
-- hookmetamethod/getnamecallmethod — support varies, so both hooks are guarded
-- and independent of each other; without them the feature simply no-ops.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local CameraDirector = require(script.CameraDirector)

local SilentAim = {}
local sa_installed = false
local sa_warned = false

-- The part the aimbot is currently locked onto, or nil.
local function sa_targetPart()
	local target = CameraDirector:GetCurrentTarget()
	local part = target and target.Part
	if part and part.Parent then
		return part
	end
	return nil
end

-- Only rewrite calls from game scripts. If the executor can't tell (no
-- checkcaller), we don't rewrite at all — bending our own raycasts would break
-- the script itself.
local function sa_fromGameScript()
	return type(checkcaller) == "function" and not checkcaller()
end

function SilentAim:Init(config)
	if sa_installed then
		return
	end
	if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" then
		if not sa_warned then
			warn("[Vanity-General] Silent Aim needs hookmetamethod — not available in this executor.")
			sa_warned = true
		end
		return
	end
	sa_installed = true

	-- __namecall: remote fires and Workspace.Raycast.
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		if config.Enabled and sa_fromGameScript() then
			local method = getnamecallmethod()
			local part = sa_targetPart()
			if part then
				if method == "FireServer" or method == "InvokeServer" then
					-- Rewrite only position-like args; everything else passes through.
					local args = { ... }
					for i, value in ipairs(args) do
						if typeof(value) == "Vector3" then
							args[i] = part.Position
						elseif typeof(value) == "CFrame" then
							args[i] = part.CFrame
						end
					end
					return oldNamecall(self, table.unpack(args))
				end
				if method == "Raycast" and self == Workspace then
					-- Raycast(origin, direction, params): keep the original cast
					-- length, bend the direction onto the target.
					local origin, direction, params = ...
					if typeof(origin) == "Vector3" and typeof(direction) == "Vector3" then
						local bent = (part.Position - origin).Unit * direction.Magnitude
						return oldNamecall(self, origin, bent, params)
					end
				end
			end
		end
		return oldNamecall(self, ...)
	end)

	-- __index: the classic Mouse.Hit / Mouse.Target spoof.
	local mouse = LocalPlayer:GetMouse()
	local oldIndex
	oldIndex = hookmetamethod(game, "__index", function(self, key)
		if config.Enabled and sa_fromGameScript() and self == mouse then
			local part = sa_targetPart()
			if part then
				if key == "Hit" then
					return part.CFrame
				end
				if key == "Target" then
					return part
				end
			end
		end
		return oldIndex(self, key)
	end)
end

return SilentAim
