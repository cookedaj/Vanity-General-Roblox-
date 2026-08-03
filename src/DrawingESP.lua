--==============================================================================
-- DRAWING ESP
-- Screen-space boxes + tracers via the executor's Drawing library.
--==============================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local DrawingESP = {}
local de_available = type(Drawing) == "table" and type(Drawing.new) == "function"
local de_warned = false
local de_entries = {} -- player -> { box = {4 Lines}, tracer = Line }

local function de_newLine()
	local line = Drawing.new("Line")
	line.Thickness = 1
	line.Visible = false
	return line
end

local function de_newEntry(player)
	local entry = {
		box = { de_newLine(), de_newLine(), de_newLine(), de_newLine() },
		tracer = de_newLine(),
	}
	de_entries[player] = entry
	return entry
end

local function de_hide(entry)
	for _, line in ipairs(entry.box) do
		line.Visible = false
	end
	entry.tracer.Visible = false
end

local function de_removePlayer(player)
	local entry = de_entries[player]
	if not entry then
		return
	end
	de_entries[player] = nil
	for _, line in ipairs(entry.box) do
		line:Remove()
	end
	entry.tracer:Remove()
end

local function de_updatePlayer(player, config, cam)
	local entry = de_entries[player]
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")

	if not (config.Boxes or config.Tracers) or not root or not (humanoid and humanoid.Health > 0) then
		if entry then
			de_hide(entry)
		end
		return
	end

	-- Same bounding math as the UI-stroke box ESP: head top to below the root.
	local head = character:FindFirstChild("Head")
	local topWorld = head and (head.Position + Vector3.new(0, head.Size.Y, 0))
		or (root.Position + Vector3.new(0, 3, 0))
	local botWorld = root.Position - Vector3.new(0, 3.2, 0)

	local topV, onScreen = cam:WorldToViewportPoint(topWorld)
	local botV = cam:WorldToViewportPoint(botWorld)
	-- Behind the camera or off-screen: nothing to draw.
	if not onScreen or topV.Z <= 0 or botV.Z <= 0 then
		if entry then
			de_hide(entry)
		end
		return
	end

	entry = entry or de_newEntry(player)

	local height = math.abs(botV.Y - topV.Y)
	local width = height * 0.62
	local cx = (topV.X + botV.X) * 0.5
	local left, right = cx - width * 0.5, cx + width * 0.5
	local top, bottom = topV.Y, botV.Y

	local box = entry.box
	-- top, bottom, left, right edges
	box[1].From = Vector2.new(left, top)
	box[1].To = Vector2.new(right, top)
	box[2].From = Vector2.new(left, bottom)
	box[2].To = Vector2.new(right, bottom)
	box[3].From = Vector2.new(left, top)
	box[3].To = Vector2.new(left, bottom)
	box[4].From = Vector2.new(right, top)
	box[4].To = Vector2.new(right, bottom)
	for _, line in ipairs(box) do
		line.Color = config.BoxColor
		line.Visible = config.Boxes
	end

	entry.tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
	entry.tracer.To = Vector2.new(cx, bottom)
	entry.tracer.Color = config.TracerColor
	entry.tracer.Visible = config.Tracers
end

-- Candidates mirror the aimbot's team rule (camera config drives Team Check).
function DrawingESP:Update(config, cameraConfig)
	if not de_available then
		if (config.Boxes or config.Tracers) and not de_warned then
			warn("[Vanity-General] Box/Tracer ESP needs the Drawing library — not available in this executor.")
			de_warned = true
		end
		return
	end

	local cam = Workspace.CurrentCamera
	if not cam then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer
			and not (cameraConfig.TeamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team)
		then
			de_updatePlayer(player, config, cam)
		end
	end

	-- Drawing objects can't be parented, so leavers must be cleaned up by hand.
	for player in pairs(de_entries) do
		if player.Parent ~= Players then
			de_removePlayer(player)
		end
	end
end

function DrawingESP:Cleanup()
	for player in pairs(de_entries) do
		de_removePlayer(player)
	end
end

return DrawingESP
