--==============================================================================
-- NO RECOIL
-- Hard vertical aim-lock plus Humanoid.CameraOffset zeroing.
--==============================================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local NoRecoil = {}
local function isFiring()
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
local basePitch = nil

local function cameraPitch(cam)
	local look = cam.CFrame.LookVector
	return math.asin(math.clamp(look.Y, -1, 1))
end


-- aimbotActive: when the camera director is actively steering the view, skip the
-- pitch lock (which also steers the CFrame) so the two don't fight. The
-- CameraOffset kill still runs, since it doesn't touch the aim direction.
function NoRecoil:Update(config, aimbotActive)
	if not config.Enabled then
		basePitch = nil
		return
	end

	local cam = Workspace.CurrentCamera
	if not cam then
		basePitch = nil
		return
	end

	if config.RequireMouseDown and not isFiring() then
		basePitch = nil -- re-lock on the first firing frame
		return
	end

	-- Always kill recoil/shake applied through Humanoid.CameraOffset. This is a
	-- very common Roblox recoil source (the whole view kicks) and zeroing it
	-- removes kick on every axis at once — the piece the pitch lock alone can't
	-- catch. There's no reason to want No Recoil on but this off, so it's not a
	-- switch; it just runs whenever No Recoil is active.
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.CameraOffset = Vector3.new(0, 0, 0)
	end

	-- Pitch lock steers the camera CFrame, so hand off to the aimbot when it's on.
	if aimbotActive then
		basePitch = nil
		return
	end

	local strength = math.clamp(config.Strength, 0, 1)
	if strength <= 0 then
		basePitch = nil
		return
	end

	local pitch = cameraPitch(cam)
	if basePitch == nil then
		basePitch = pitch -- lock to wherever you started firing
		return
	end

	local drift = pitch - basePitch
	if config.AllowAim and drift < 0 then
		-- Pulled below the lock (aiming down) — adopt the lower baseline instead of
		-- fighting it, so you keep downward control while the climb stays blocked.
		basePitch = pitch
		return
	end

	if drift ~= 0 then
		-- Force the view straight back to the locked pitch.
		cam.CFrame = cam.CFrame * CFrame.Angles(-drift * strength, 0, 0)
	end
end

function NoRecoil:Reset()
	basePitch = nil
end
NoRecoil.IsFiring = isFiring

return NoRecoil
