--==============================================================================
-- SILENT AIM
-- Redirects your shots onto a target WITHOUT moving the camera, by hooking the
-- game's metatable. When something (a hill, a wall, a building) sits between
-- you and the target, the shot is CURVED over it: the launch direction is
-- raised toward an arc apex computed above the obstruction, so a gravity-
-- affected projectile arcs up and drops onto the target instead of burying
-- itself in the hillside. Clear line of sight still takes a flat shot.
--
-- Target resolution: the aimbot's current lock first; with no lock, whoever
-- the crosshair is nearest (the same pick the Target Display makes — no wall
-- check, so targets behind terrain still register).
--
-- Network plausibility: before any rewrite, the target must pass a gate —
-- within MaxAngle of the real camera aim (so the server can reconcile the
-- shot with your look direction) and a HitChance roll (so your hit rate
-- stays statistically human). Failing shots go out unbent as legit misses.
--
-- Requires an executor with hookmetamethod/getnamecallmethod — support varies,
-- so both hooks are guarded and independent of each other; without them the
-- feature simply no-ops.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local CameraDirector = require(script.CameraDirector)
local Cloak = require(script.Cloak)

local SilentAim = {}
local sa_installed = false
local sa_warned = false
local sa_config -- the full Configuration table, stored by Init

-- Arc tuning. The apex is found by probing straight down from high above the
-- shot's midpoint; the shot is then lobbed CLEARANCE studs above whatever that
-- probe hits (the hilltop), capped at MAX_LIFT above the higher endpoint so we
-- never mortar rounds into orbit.
local ARC_PROBE_HEIGHT = 500
local ARC_CLEARANCE = 12
local ARC_MAX_LIFT = 200

-- Local muzzle approximation: the head when we have one, else the root, else
-- the camera. Used to aim rewritten remote args (the Raycast hook gets the
-- game's own origin passed in).
local function sa_muzzle()
	local character = LocalPlayer.Character
	if character then
		local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
		if head then
			return head.Position
		end
	end
	local camera = Workspace.CurrentCamera
	return camera and camera.CFrame.Position or Vector3.zero
end

-- Resolve a BodyPart to shoot at from a Player or character model.
local function sa_anchorPart(character)
	if not character then
		return nil
	end
	return character:FindFirstChild("Head")
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
end

-- The part to curve shots onto: the aimbot's lock when it has one, else
-- whoever the crosshair is nearest (Target Display pick — deliberately no wall
-- check, so someone behind a mountain still counts).
local function sa_targetPart()
	local target = CameraDirector:GetCurrentTarget()
	if target and target.Part and target.Part.Parent then
		return target.Part
	end

	if not sa_config then
		return nil
	end
	local look = CameraDirector:GetLookTarget(sa_config.ESP, sa_config.Camera)
	if typeof(look) ~= "Instance" then
		return nil
	end
	local character = look:IsA("Player") and look.Character or look
	local part = sa_anchorPart(character)
	if part and part.Parent then
		return part
	end
	return nil
end

-- Where a shot from `origin` should be aimed to land on `part`. Flat when the
-- line is clear; raised over the obstruction's apex when it isn't, so gravity
-- carries the projectile over the top and down onto the target.
local function sa_aimPoint(origin, part)
	local targetPos = part.Position

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	-- Excluding the target's own character too: a ray that would reach the
	-- target then hits nothing, which reads as a clear line.
	params.FilterDescendantsInstances = { LocalPlayer.Character, part:FindFirstAncestorOfClass("Model") or part }

	if not Workspace:Raycast(origin, targetPos - origin, params) then
		return targetPos -- clear line: flat shot
	end

	-- Blocked. Probe down from high above the midpoint to find the top of
	-- whatever is in the way, then aim CLEARANCE studs over it.
	local mid = (origin + targetPos) / 2
	local probeTop = mid + Vector3.new(0, ARC_PROBE_HEIGHT, 0)
	local floorY = math.min(origin.Y, targetPos.Y)
	local hit = Workspace:Raycast(probeTop, Vector3.new(0, floorY - 5 - probeTop.Y, 0), params)

	local ceilingY = math.max(origin.Y, targetPos.Y)
	local apexY
	if hit then
		apexY = hit.Position.Y + ARC_CLEARANCE
	else
		apexY = ceilingY + ARC_MAX_LIFT -- nothing found: assume it's tall
	end
	apexY = math.clamp(apexY, ceilingY + 5, ceilingY + ARC_MAX_LIFT)

	return Vector3.new(mid.X, apexY, mid.Z)
end

-- Only rewrite calls from game scripts. If the executor can't tell (no
-- checkcaller), we don't rewrite at all — bending our own raycasts would break
-- the script itself.
local function sa_fromGameScript()
	return type(checkcaller) == "function" and not checkcaller()
end

local sa_rng = Random.new()

-- Network-plausibility gate. The server can reconcile a rewritten shot against
-- your replicated look direction and your hit rate, so a target is only
-- returned when a hit on it is a claim a legitimate player could have made:
-- within MaxAngle of the real camera aim, and passing the HitChance roll.
local function sa_plausiblePart()
	local part = sa_targetPart()
	if not part or not sa_config then
		return nil
	end

	-- Streaming guard: don't rewrite shots at streamed-out parts.
	if not part:IsDescendantOf(Workspace) then
		return nil
	end

	local maxAngle = sa_config.SilentAim.MaxAngle or 30
	if maxAngle < 180 then
		local cam = Workspace.CurrentCamera
		if cam then
			local toTarget = (part.Position - cam.CFrame.Position).Unit
			if cam.CFrame.LookVector:Dot(toTarget) < math.cos(math.rad(maxAngle)) then
				return nil -- too far off-aim: a hit here can't reconcile server-side
			end
		end
	end

	local chance = sa_config.SilentAim.HitChance or 100
	if chance < 100 and sa_rng:NextNumber(0, 100) > chance then
		return nil
	end

	return part
end

function SilentAim:Init(config)
	-- Deliberately stores config ONLY: the metatable hooks install lazily on
	-- the first Update with the feature enabled, so loading the script with
	-- Silent Aim off leaves the game's metatable completely untouched.
	sa_config = config
end

-- Per-frame hook point from the controller's loop. The installed hooks do the
-- real work passively; this exists only to defer installation until enable.
function SilentAim:Update(config)
	if sa_installed or not config.SilentAim.Enabled then
		return
	end
	self:_install()
end

function SilentAim:_install()
	if sa_installed then
		return
	end
	if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" then
		if not sa_warned then
			warn("[Vanity-General] Silent Aim needs hookmetamethod — not available in this executor.")
			sa_warned = true
		end
		sa_installed = true -- tried and failed; don't retry every frame
		return
	end
	sa_installed = true

	local function enabled()
		return sa_config.SilentAim.Enabled
	end

	-- __namecall: remote fires and Workspace.Raycast. CClosure-wrapped so the
	-- metamethod still looks like a C function to islclosure/getinfo checks.
	--
	-- sa_busy re-entry guard: sa_aimPoint does its OWN Workspace:Raycast probes
	-- and sa_plausiblePart does IsDescendantOf/FindFirstChild namecalls, all of
	-- which fire this hook again. On executors where checkcaller can't recognize
	-- a call made from inside a hook as ours, that recursion never terminates
	-- (namecall -> hook -> namecall -> ...) and kills the executor with a
	-- C stack overflow. The guard therefore covers the WHOLE hook body —
	-- target resolution included, not just the rewrite — and while it is set,
	-- everything passes through raw.
	local sa_busy = false

	-- Applies the rewrite for one call. Returns a packed result list when the
	-- call was rewritten, or nil to let the original call through untouched.
	local function rewrite(oldNamecall, self, method, part, ...)
		if method == "FireServer" or method == "InvokeServer" then
			-- Rewrite position-like args onto the target and direction-like
			-- args (unit-ish vectors) onto the arc's launch direction;
			-- everything else passes through untouched.
			local muzzle = sa_muzzle()
			local aimPoint = sa_aimPoint(muzzle, part)
			local args = { ... }
			for i, value in ipairs(args) do
				if typeof(value) == "Vector3" then
					local magnitude = value.Magnitude
					if magnitude > 0.5 and magnitude < 1.5 then
						args[i] = (aimPoint - muzzle).Unit
					else
						args[i] = part.Position
					end
				elseif typeof(value) == "CFrame" then
					args[i] = part.CFrame
				end
			end
			return table.pack(oldNamecall(self, table.unpack(args)))
		end
		if method == "Raycast" and self == Workspace then
			-- Raycast(origin, direction, params): keep the original cast
			-- length, bend the direction along the arc's launch heading.
			local origin, direction, params = ...
			if typeof(origin) == "Vector3" and typeof(direction) == "Vector3" then
				local aimPoint = sa_aimPoint(origin, part)
				local bent = (aimPoint - origin).Unit * direction.Magnitude
				return table.pack(oldNamecall(self, origin, bent, params))
			end
		end
		return nil
	end

	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", Cloak.CClosure(function(self, ...)
		-- Busy: a namecall issued by our own hook logic (target resolution,
		-- arc probes). Pass it straight through so it can never re-enter.
		if sa_busy then
			return oldNamecall(self, ...)
		end
		if enabled() and sa_fromGameScript() then
			-- Capture the varargs BEFORE the pcall closure — a nested function
			-- is not vararg, so '...' cannot be referenced inside it.
			local args = table.pack(...)
			sa_busy = true
			local ok, packed = pcall(function()
				local part = sa_plausiblePart()
				if not part then
					return nil
				end
				return rewrite(oldNamecall, self, getnamecallmethod(), part, table.unpack(args, 1, args.n))
			end)
			sa_busy = false
			if ok and packed then
				return table.unpack(packed, 1, packed.n)
			end
		end
		return oldNamecall(self, ...)
	end))

	-- __index: the classic Mouse.Hit / Mouse.Target spoof. Same re-entry
	-- guard: sa_plausiblePart reads properties off instances, and on
	-- executors that can't tell hook-internal reads from game reads those
	-- would fire this hook again.
	local mouse = LocalPlayer:GetMouse()
	local oldIndex
	oldIndex = hookmetamethod(game, "__index", Cloak.CClosure(function(self, key)
		if sa_busy then
			return oldIndex(self, key)
		end
		if enabled() and sa_fromGameScript() and self == mouse then
			sa_busy = true
			local ok, part = pcall(sa_plausiblePart)
			sa_busy = false
			if ok and part then
				if key == "Hit" then
					return part.CFrame
				end
				if key == "Target" then
					return part
				end
			end
		end
		return oldIndex(self, key)
	end))
end

return SilentAim
