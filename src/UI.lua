-- UI Module
-- Modern tabbed interface with dark theme, smooth animations, and a
-- centralized input router so drag/slider handlers never leak connections.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local UI = {}

-- Purple + black theme.
local COLORS = {
	bg = Color3.fromRGB(12, 8, 16),        -- near-black window
	bar = Color3.fromRGB(22, 14, 32),      -- dark purple-black bars
	row = Color3.fromRGB(28, 18, 40),      -- control rows
	rowHover = Color3.fromRGB(48, 30, 68), -- hover lift
	accent = Color3.fromRGB(165, 75, 255), -- vivid purple
	off = Color3.fromRGB(52, 38, 72),      -- muted purple (off state)
	text = Color3.fromRGB(240, 235, 250),  -- near-white
	textSub = Color3.fromRGB(175, 155, 200),
	danger = Color3.fromRGB(215, 55, 95),  -- pink-red
}

local FADE_TIME = 0.18
local ANIM = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Module state
local gui
local mainWindow
local windowScale -- UIScale instance for the UI Scale setting
local currentTab = "Aimbot"
local layoutOrder = 0
local visible = false
local activeConfig -- stored by Init so visibility can be written back to config

-- Centralized input routing. Every draggable control registers a callback here
-- instead of opening its own UserInputService connection. This keeps the total
-- number of global connections at exactly two, all disconnected on Cleanup.
local uisConnections = {}
local moveHandlers = {}
local releaseHandlers = {}
local syncHandlers = {} -- re-reads config into each control (used after reset / keybind)

-- References that outside code needs to update live
local targetLabel

-- Keybind capture state. When a keybind box is armed, the next key press is
-- consumed as its new binding. The controller checks UI:IsCapturingKey() so the
-- captured press never also fires a normal hotkey (e.g. rebinding to the menu
-- key must not toggle the menu on the same press).
local activeCapture -- { finish = fn, cancel = fn } or nil while a box is armed
local capturingKey = false

-- Create instance with a properties table
local function newInstance(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		inst[k] = v
	end
	return inst
end

local function nextOrder()
	layoutOrder = layoutOrder + 1
	return layoutOrder
end

local function isPointer(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

local function isMovement(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
end

-- Start the two shared connections that fan out to registered handlers.
local function startInputRouter()
	table.insert(uisConnections, UserInputService.InputChanged:Connect(function(input)
		if not isMovement(input) then
			return
		end
		for _, fn in ipairs(moveHandlers) do
			fn(input)
		end
	end))

	table.insert(uisConnections, UserInputService.InputEnded:Connect(function(input)
		if not isPointer(input) then
			return
		end
		for _, fn in ipairs(releaseHandlers) do
			fn(input)
		end
	end))

	-- Keybind capture: while a box is armed, the next keyboard press becomes its
	-- new binding (Escape cancels). Ignores gameProcessed so a focused control
	-- can't swallow the rebind.
	table.insert(uisConnections, UserInputService.InputBegan:Connect(function(input)
		if not activeCapture then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		local key = input.KeyCode
		if key == Enum.KeyCode.Unknown then
			return
		end
		if key == Enum.KeyCode.Escape then
			activeCapture.finish(nil)
		else
			activeCapture.finish(key)
		end
	end))
end

--==============================================================================
-- Control builders
--==============================================================================

-- Animated on/off toggle
local function makeToggle(parent, text, getValue, onChange)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = " " .. text,
	})

	newInstance("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

	local pill = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(38, 18),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = pill, CornerRadius = UDim.new(1, 0) })

	local knob = newInstance("Frame", {
		Parent = pill,
		Size = UDim2.fromOffset(14, 14),
		Position = getValue() and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = knob, CornerRadius = UDim.new(1, 0) })

	local function refresh()
		local on = getValue()
		TweenService:Create(pill, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
		TweenService:Create(knob, ANIM, {
			Position = on and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		}):Play()
	end

	btn.MouseButton1Click:Connect(function()
		onChange()
		refresh()
	end)

	table.insert(syncHandlers, refresh)
end

-- Slider with a shared drag handler (no per-slider global connection)
local function makeSlider(parent, text, min, max, getValue, setValue, isInt, suffix)
	suffix = suffix or ""
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	local label = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, -16, 0, 18),
		Position = UDim2.fromOffset(8, 3),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local track = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.new(1, -16, 0, 6),
		Position = UDim2.new(0, 8, 0, 26),
		BackgroundColor3 = COLORS.off,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) })

	local fill = newInstance("Frame", {
		Parent = track,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(1, 0) })

	local function format(v)
		local base = isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
		return base .. suffix
	end

	local function apply(v)
		v = math.clamp(v, min, max)
		if isInt then
			v = math.floor(v + 0.5)
		end
		local alpha = (max > min) and (v - min) / (max - min) or 0
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		label.Text = text .. ": " .. format(v)
		setValue(v)
	end

	apply(getValue())

	local dragging = false

	local function fromInput(px)
		local alpha = math.clamp((px - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		apply(min + alpha * (max - min))
	end

	track.InputBegan:Connect(function(input)
		if isPointer(input) then
			dragging = true
			fromInput(input.Position.X)
		end
	end)

	table.insert(moveHandlers, function(input)
		if dragging then
			fromInput(input.Position.X)
		end
	end)

	table.insert(releaseHandlers, function()
		dragging = false
	end)

	-- Re-sync visual from config (e.g. after a settings reset)
	table.insert(syncHandlers, function()
		apply(getValue())
	end)
end

-- Dropdown with an animated expand/collapse list
local function makeDropdown(parent, text, options, getValue, onChange)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.6, 0, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local dropdown = newInstance("TextButton", {
		Parent = holder,
		Size = UDim2.new(0.38, -8, 1, 0),
		Position = UDim2.new(0.6, 4, 0, 0),
		BackgroundColor3 = COLORS.off,
		BorderSizePixel = 0,
		Font = Enum.Font.Gotham,
		TextSize = 11,
		TextColor3 = COLORS.text,
		Text = getValue(),
		ZIndex = 3,
	})

	newInstance("UICorner", { Parent = dropdown, CornerRadius = UDim.new(0, 4) })

	local open = false
	local ROW_H = 24
	local fullSize = #options * ROW_H
	-- Cap the open height so long lists (e.g. every body part) stay on-screen and
	-- scroll instead of running off the bottom.
	local listSize = math.min(fullSize, 7 * ROW_H)

	local list = newInstance("ScrollingFrame", {
		Parent = dropdown,
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.fromOffset(0, 30),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Visible = false,
		ZIndex = 10,
		CanvasSize = UDim2.fromOffset(0, fullSize),
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = COLORS.accent,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Active = true,
	})

	newInstance("UICorner", { Parent = list, CornerRadius = UDim.new(0, 4) })

	for i, option in ipairs(options) do
		local optionBtn = newInstance("TextButton", {
			Parent = list,
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.fromOffset(0, (i - 1) * 24),
			BackgroundColor3 = COLORS.off,
			BorderSizePixel = 0,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextColor3 = COLORS.text,
			Text = option,
			AutoButtonColor = false,
			ZIndex = 11,
		})

		optionBtn.MouseButton1Click:Connect(function()
			onChange(option)
			dropdown.Text = option
			open = false
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
			task.delay(FADE_TIME, function()
				if not open then
					list.Visible = false
				end
			end)
		end)

		optionBtn.MouseEnter:Connect(function()
			optionBtn.BackgroundColor3 = COLORS.rowHover
		end)

		optionBtn.MouseLeave:Connect(function()
			optionBtn.BackgroundColor3 = COLORS.off
		end)
	end

	dropdown.MouseButton1Click:Connect(function()
		open = not open
		if open then
			list.Visible = true
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, listSize) }):Play()
		else
			TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
			task.delay(FADE_TIME, function()
				if not open then
					list.Visible = false
				end
			end)
		end
	end)

	table.insert(syncHandlers, function()
		dropdown.Text = getValue()
	end)
end

-- HSV color picker
local function makeColorPicker(parent, getColor, setColor)
	local h, s, v = getColor():ToHSV()
	local SQ_W, SQ_H, HUE_W, GAP = 178, 120, 16, 8

	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, SQ_H + 52),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
	newInstance("UIPadding", {
		Parent = holder,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	-- Saturation/Value square
	local sq = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.fromOffset(SQ_W, SQ_H),
		BackgroundColor3 = Color3.fromHSV(h, 1, 1),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = sq, CornerRadius = UDim.new(0, 4) })

	local satLayer = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = satLayer, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = satLayer,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1),
		}),
	})

	local valLayer = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = valLayer, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = valLayer,
		Rotation = 90,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0),
		}),
	})

	local svDot = newInstance("Frame", {
		Parent = sq,
		Size = UDim2.fromOffset(10, 10),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
	})

	newInstance("UICorner", { Parent = svDot, CornerRadius = UDim.new(1, 0) })
	newInstance("UIStroke", { Parent = svDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })

	-- Hue strip
	local hue = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.fromOffset(HUE_W, SQ_H),
		Position = UDim2.fromOffset(SQ_W + GAP, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = hue, CornerRadius = UDim.new(0, 4) })
	newInstance("UIGradient", {
		Parent = hue,
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
		}),
	})

	local hueDot = newInstance("Frame", {
		Parent = hue,
		Size = UDim2.new(1, 4, 0, 4),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, h, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
	})

	newInstance("UIStroke", { Parent = hueDot, Color = Color3.fromRGB(0, 0, 0), Thickness = 1 })

	-- Preview swatch + hex readout
	local preview = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.fromOffset(22, 22),
		Position = UDim2.fromOffset(0, SQ_H + 6),
		BackgroundColor3 = getColor(),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = preview, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = preview, Color = COLORS.off, Thickness = 1 })

	local hexLabel = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, -30, 0, 22),
		Position = UDim2.fromOffset(30, SQ_H + 6),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "",
	})

	local function refresh(writeBack)
		local col = Color3.fromHSV(h, s, v)
		if writeBack ~= false then
			setColor(col)
		end
		sq.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		svDot.Position = UDim2.new(s, 0, 1 - v, 0)
		hueDot.Position = UDim2.new(0.5, 0, h, 0)
		preview.BackgroundColor3 = col

		local r = math.floor(col.R * 255 + 0.5)
		local g = math.floor(col.G * 255 + 0.5)
		local b = math.floor(col.B * 255 + 0.5)
		hexLabel.Text = string.format("#%02X%02X%02X\n(%d, %d, %d)", r, g, b, r, g, b)
	end

	refresh(false)

	local svDrag, hueDrag = false, false

	local function svFrom(px, py)
		s = math.clamp((px - sq.AbsolutePosition.X) / sq.AbsoluteSize.X, 0, 1)
		v = 1 - math.clamp((py - sq.AbsolutePosition.Y) / sq.AbsoluteSize.Y, 0, 1)
		refresh()
	end

	local function hueFrom(py)
		h = math.clamp((py - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
		refresh()
	end

	sq.InputBegan:Connect(function(input)
		if isPointer(input) then
			svDrag = true
			svFrom(input.Position.X, input.Position.Y)
		end
	end)

	hue.InputBegan:Connect(function(input)
		if isPointer(input) then
			hueDrag = true
			hueFrom(input.Position.Y)
		end
	end)

	table.insert(moveHandlers, function(input)
		if svDrag then
			svFrom(input.Position.X, input.Position.Y)
		end
		if hueDrag then
			hueFrom(input.Position.Y)
		end
	end)

	table.insert(releaseHandlers, function()
		svDrag, hueDrag = false, false
	end)

	-- Re-sync from config (after reset) without writing back
	table.insert(syncHandlers, function()
		h, s, v = getColor():ToHSV()
		refresh(false)
	end)
end

-- Read-only display row; returns the value label so callers can update it live
local function makeLabel(parent, text, initialValue)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local value = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.48, -8, 1, 0),
		Position = UDim2.new(0.5, 4, 0, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = COLORS.accent,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = initialValue,
	})

	return value
end

-- Clickable action button row (Server Hop, Rejoin). Matches makeToggle's row
-- layout; `color` defaults to the accent, hover lifts it slightly.
local function makeButton(parent, text, onClick, color)
	local base = color or COLORS.accent

	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = base,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Text = text,
	})

	newInstance("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

	btn.MouseButton1Click:Connect(onClick)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, ANIM, { BackgroundColor3 = COLORS.rowHover }):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, ANIM, { BackgroundColor3 = base }):Play()
	end)

	return btn
end

-- Clickable keybind row: shows the current key in a box on the right. Click it to
-- arm capture ("Press a key…"), then the next key press rebinds it. Escape or a
-- second click cancels. `conflictCheck(key)` may return the name of another action
-- already using that key to reject the bind.
-- Wires capture/refresh/sync behavior onto an already-created keybind box
-- (a TextButton). Shared by the standalone keybind row and the inline
-- toggle+keybind control so the capture state machine lives in one place.
local function wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
	local listening = false

	local function refresh()
		if listening then
			box.Text = "Press…"
			box.TextColor3 = Color3.fromRGB(255, 255, 255)
			box.BackgroundColor3 = COLORS.accent
		else
			box.Text = getKey().Name
			box.TextColor3 = COLORS.accent
			box.BackgroundColor3 = COLORS.bar
		end
	end

	local capture = {}

	function capture.finish(key)
		listening = false
		activeCapture = nil
		-- Defer so the controller's InputBegan (same press) still sees capturing
		-- and skips its hotkey handling before we clear the flag.
		task.defer(function()
			capturingKey = false
		end)

		if key then
			local conflict = conflictCheck and conflictCheck(key)
			if conflict then
				UI:Notify(string.format("%s is already bound to %s", key.Name, conflict), 2.5)
			else
				setKey(key)
				UI:Notify(string.format("%s bound to %s", labelText, key.Name), 2)
			end
		end
		refresh()
	end

	function capture.cancel()
		listening = false
		refresh()
	end

	box.MouseButton1Click:Connect(function()
		if listening then
			-- Second click cancels.
			activeCapture = nil
			task.defer(function()
				capturingKey = false
			end)
			capture.cancel()
			return
		end
		-- Arming this box disarms any other listening box.
		if activeCapture then
			activeCapture.cancel()
		end
		activeCapture = capture
		capturingKey = true
		listening = true
		refresh()
	end)

	box.MouseEnter:Connect(function()
		if not listening then
			box.BackgroundColor3 = COLORS.rowHover
		end
	end)

	box.MouseLeave:Connect(function()
		if not listening then
			box.BackgroundColor3 = COLORS.bar
		end
	end)

	table.insert(syncHandlers, function()
		if activeCapture == capture then
			activeCapture = nil
			task.defer(function()
				capturingKey = false
			end)
			listening = false
		end
		refresh()
	end)

	refresh()
end

-- Returns the name of the action already using `key` (excluding `field`), or nil.
-- Fields: "menu", "aimbot", "unload", "clicktp".
local function keyConflict(config, key, field)
	if field ~= "menu" and config.UI.MenuKey == key then
		return "Menu"
	end
	if field ~= "aimbot" and config.Camera.ToggleKey == key then
		return "Aimbot"
	end
	if field ~= "unload" and config.UI.UnloadKey == key then
		return "Unload"
	end
	if field ~= "clicktp" and config.Movement.ClickTPKey == key then
		return "Click TP"
	end
	return nil
end

-- Standalone keybind row: a label on the left and a clickable key box on the right.
local function makeKeybind(parent, labelText, getKey, setKey, conflictCheck)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = labelText,
	})

	local box = newInstance("TextButton", {
		Parent = holder,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -6, 0.5, 0),
		Size = UDim2.fromOffset(0, 22),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = COLORS.accent,
		Text = getKey().Name,
	})

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})
	newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(54, 22) })

	wireKeybindBox(box, labelText, getKey, setKey, conflictCheck)
end

-- Toggle row with an inline keybind box sitting just left of the switch. The row
-- itself toggles on click; the key box captures its own clicks (it's on top) so
-- rebinding never flips the toggle.
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = " " .. text,
	})

	newInstance("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

	local pill = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(38, 18),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = pill, CornerRadius = UDim.new(1, 0) })

	local knob = newInstance("Frame", {
		Parent = pill,
		Size = UDim2.fromOffset(14, 14),
		Position = getValue() and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = knob, CornerRadius = UDim.new(1, 0) })

	-- Key box: anchored to the right, just left of the pill (8 margin + 38 pill + 8 gap).
	local box = newInstance("TextButton", {
		Parent = btn,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -54, 0.5, 0),
		Size = UDim2.fromOffset(0, 22),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = COLORS.accent,
		Text = getKey().Name,
		ZIndex = 3,
	})

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.accent, Thickness = 1, Transparency = 0.5 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})
	newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(46, 22) })

	local function refresh()
		local on = getValue()
		TweenService:Create(pill, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
		TweenService:Create(knob, ANIM, {
			Position = on and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		}):Play()
	end

	btn.MouseButton1Click:Connect(function()
		onChange()
		refresh()
	end)

	table.insert(syncHandlers, refresh)

	wireKeybindBox(box, keyLabel, getKey, setKey, conflictCheck)
end

--==============================================================================
-- Tab content
--==============================================================================

local function buildCameraTab(parent, config)
	layoutOrder = 0

	makeToggleWithKeybind(parent, "Camera Tracking", function()
		return config.Camera.Enabled
	end, function()
		config.Camera.Enabled = not config.Camera.Enabled
	end, "Aimbot Key", function()
		return config.Camera.ToggleKey
	end, function(key)
		config.Camera.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "aimbot")
	end)

	makeToggle(parent, "Target Bots", function()
		return config.Camera.TargetBots
	end, function()
		config.Camera.TargetBots = not config.Camera.TargetBots
	end)

	makeToggle(parent, "Team Check", function()
		return config.Camera.TeamCheck
	end, function()
		config.Camera.TeamCheck = not config.Camera.TeamCheck
	end)

	makeToggle(parent, "Humanize", function()
		return config.Camera.Humanize
	end, function()
		config.Camera.Humanize = not config.Camera.Humanize
	end)

	makeSlider(parent, "Smoothness", 0.05, 1, function()
		return config.Camera.Smoothness
	end, function(v)
		config.Camera.Smoothness = v
	end, false)

	makeSlider(parent, "Prediction", 0, 1, function()
		return config.Camera.Prediction
	end, function(v)
		config.Camera.Prediction = v
	end, false)

	makeSlider(parent, "Max Distance", 100, 500, function()
		return config.Camera.MaxDistance
	end, function(v)
		config.Camera.MaxDistance = v
	end, true, "m")

	makeDropdown(parent, "Target Part", config.Camera.TargetPartOptions, function()
		return config.Camera.TargetPart
	end, function(v)
		config.Camera.TargetPart = v
	end)

	-- Kept as a module reference so MainController can push the live target name
	targetLabel = makeLabel(parent, "Current Target", "None")
end

local function buildMovementTab(parent, config)
	layoutOrder = 0

	makeToggle(parent, "Fly", function()
		return config.Movement.FlyEnabled
	end, function()
		config.Movement.FlyEnabled = not config.Movement.FlyEnabled
	end)

	makeToggle(parent, "Noclip", function()
		return config.Movement.NoclipEnabled
	end, function()
		config.Movement.NoclipEnabled = not config.Movement.NoclipEnabled
	end)

	makeToggle(parent, "Speed", function()
		return config.Movement.SpeedEnabled
	end, function()
		config.Movement.SpeedEnabled = not config.Movement.SpeedEnabled
	end)

	makeToggle(parent, "Infinite Jump", function()
		return config.Movement.InfJumpEnabled
	end, function()
		config.Movement.InfJumpEnabled = not config.Movement.InfJumpEnabled
	end)

	makeToggle(parent, "Click TP", function()
		return config.Movement.ClickTPEnabled
	end, function()
		config.Movement.ClickTPEnabled = not config.Movement.ClickTPEnabled
	end)

	makeToggle(parent, "Fat Walk", function()
		return config.Movement.FatWalk
	end, function()
		config.Movement.FatWalk = not config.Movement.FatWalk
	end)

	makeSlider(parent, "Fat Scale", 1, 5, function()
		return config.Movement.FatScale
	end, function(v)
		config.Movement.FatScale = v
	end, false)

	makeSlider(parent, "Fly Speed", 10, 200, function()
		return config.Movement.FlySpeed
	end, function(v)
		config.Movement.FlySpeed = v
	end, true)

	makeSlider(parent, "Walk Speed", 16, 100, function()
		return config.Movement.Speed
	end, function(v)
		config.Movement.Speed = v
	end, true)

	makeKeybind(parent, "Click TP Key", function()
		return config.Movement.ClickTPKey
	end, function(key)
		config.Movement.ClickTPKey = key
	end, function(key)
		return keyConflict(config, key, "clicktp")
	end)
end

local function buildESPTab(parent, config)
	layoutOrder = 0

	makeToggle(parent, "ESP Enabled", function()
		return config.ESP.Enabled
	end, function()
		config.ESP.Enabled = not config.ESP.Enabled
	end)

	makeToggle(parent, "Filled", function()
		return config.ESP.Filled
	end, function()
		config.ESP.Filled = not config.ESP.Filled
	end)

	makeToggle(parent, "Name Tags", function()
		return config.ESP.NameTags
	end, function()
		config.ESP.NameTags = not config.ESP.NameTags
	end)

	makeToggle(parent, "Health", function()
		return config.ESP.HealthBars
	end, function()
		config.ESP.HealthBars = not config.ESP.HealthBars
	end)

	makeToggle(parent, "Distance", function()
		return config.ESP.DistanceTags
	end, function()
		config.ESP.DistanceTags = not config.ESP.DistanceTags
	end)

	makeSlider(parent, "Thickness", 1, 6, function()
		return config.ESP.Thickness
	end, function(v)
		config.ESP.Thickness = v
	end, true)

	makeSlider(parent, "Outline Opacity", 0, 1, function()
		return config.ESP.OutlineOpacity
	end, function(v)
		config.ESP.OutlineOpacity = v
	end, false)

	makeSlider(parent, "Fill Opacity", 0, 1, function()
		return config.ESP.FillOpacity
	end, function(v)
		config.ESP.FillOpacity = v
	end, false)

	makeSlider(parent, "Max Distance", 100, 2000, function()
		return config.ESP.MaxDistance
	end, function(v)
		config.ESP.MaxDistance = v
	end, true, "m")

	makeColorPicker(parent, function()
		return config.ESP.Color
	end, function(c)
		config.ESP.Color = c
	end)

	-- Lighting overrides live on the ESP tab (visuals, not movement)
	makeLabel(parent, "Lighting", "")

	makeToggle(parent, "Fullbright", function()
		return config.Visuals.Fullbright
	end, function()
		config.Visuals.Fullbright = not config.Visuals.Fullbright
	end)

	makeToggle(parent, "No Fog", function()
		return config.Visuals.NoFog
	end, function()
		config.Visuals.NoFog = not config.Visuals.NoFog
	end)
end

local function buildSettingsTab(parent, config, resetCallback)
	layoutOrder = 0

	makeSlider(parent, "UI Scale", 0.8, 1.5, function()
		return config.UI.Scale
	end, function(v)
		config.UI.Scale = v
		if windowScale then
			windowScale.Scale = v -- apply immediately
		end
	end, false)

	local resetBtn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.danger,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Text = "Reset Settings",
	})

	newInstance("UICorner", { Parent = resetBtn, CornerRadius = UDim.new(0, 6) })

	resetBtn.MouseButton1Click:Connect(function()
		resetCallback()
	end)

	resetBtn.MouseEnter:Connect(function()
		TweenService:Create(resetBtn, ANIM, { BackgroundColor3 = Color3.fromRGB(225, 65, 65) }):Play()
	end)

	resetBtn.MouseLeave:Connect(function()
		TweenService:Create(resetBtn, ANIM, { BackgroundColor3 = COLORS.danger }):Play()
	end)

	-- Rejects a key that's already bound to another action so one press can't
	-- trigger two hotkeys. Enum.KeyCode values are singletons, so == is safe.
	-- (The Aimbot toggle key lives inline on the Aimbot tab; Menu/Unload here.)
	makeKeybind(parent, "Menu Key", function()
		return config.UI.MenuKey
	end, function(key)
		config.UI.MenuKey = key
	end, function(key)
		return keyConflict(config, key, "menu")
	end)

	makeKeybind(parent, "Unload Key", function()
		return config.UI.UnloadKey
	end, function(key)
		config.UI.UnloadKey = key
	end, function(key)
		return keyConflict(config, key, "unload")
	end)

	makeToggle(parent, "Anti-AFK", function()
		return config.Utility.AntiAFK
	end, function()
		config.Utility.AntiAFK = not config.Utility.AntiAFK
	end)

	makeButton(parent, "Server Hop", function()
		local ok, err = pcall(function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
		end)
		if not ok then
			warn("[Vanity-General] Server hop failed:", err)
		end
	end)

	makeButton(parent, "Rejoin Server", function()
		local ok, err = pcall(function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end)
		if not ok then
			warn("[Vanity-General] Rejoin failed:", err)
		end
	end)
end

--==============================================================================
-- Fade animation
--==============================================================================

local function setVisible(state)
	if not mainWindow or state == visible then
		return
	end
	visible = state

	-- Keep Configuration.UI.Visible in sync with the actual window state
	if activeConfig and activeConfig.UI then
		activeConfig.UI.Visible = state
	end

	if state then
		mainWindow.Visible = true
		mainWindow.GroupTransparency = 1
		TweenService:Create(mainWindow, TweenInfo.new(FADE_TIME), { GroupTransparency = 0 }):Play()
	else
		local tween = TweenService:Create(mainWindow, TweenInfo.new(FADE_TIME), { GroupTransparency = 1 })
		tween.Completed:Once(function()
			-- Only hide if we haven't been re-opened mid-fade
			if not visible and mainWindow then
				mainWindow.Visible = false
			end
		end)
		tween:Play()
	end
end

--==============================================================================
-- Public API
--==============================================================================

function UI:Init(config, resetCallback)
	if gui then
		return
	end

	activeConfig = config

	startInputRouter()

	gui = newInstance("ScreenGui", {
		Name = "VanityGeneralUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})

	pcall(function()
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui", 5)
	end)

	if not gui.Parent then
		gui.Parent = game:GetService("CoreGui")
	end

	-- CanvasGroup lets us fade the whole window with a single GroupTransparency
	mainWindow = newInstance("CanvasGroup", {
		Parent = gui,
		Size = UDim2.fromOffset(240, 0),
		Position = UDim2.fromOffset(40, 120),
		BackgroundColor3 = COLORS.bg,
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.Y,
		GroupTransparency = 1,
		Visible = false,
	})

	windowScale = newInstance("UIScale", { Parent = mainWindow, Scale = config.UI.Scale })
	newInstance("UICorner", { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
	newInstance("UIListLayout", { Parent = mainWindow, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
	newInstance("UIPadding", {
		Parent = mainWindow,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	-- Title bar (drag handle)
	local titleBar = newInstance("Frame", {
		Parent = mainWindow,
		LayoutOrder = 0,
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = titleBar, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = titleBar,
		Size = UDim2.new(1, -10, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "Vanity-General",
	})

	-- Dragging via the shared input router
	local dragging, dragStart, startPos

	titleBar.InputBegan:Connect(function(input)
		if isPointer(input) then
			dragging = true
			dragStart = input.Position
			startPos = mainWindow.Position
		end
	end)

	table.insert(moveHandlers, function(input)
		if dragging then
			local delta = input.Position - dragStart
			mainWindow.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	table.insert(releaseHandlers, function()
		dragging = false
	end)

	-- Tab bar
	local tabContainer = newInstance("Frame", {
		Parent = mainWindow,
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = tabContainer, CornerRadius = UDim.new(0, 6) })
	newInstance("UIListLayout", {
		Parent = tabContainer,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 4),
	})
	newInstance("UIPadding", {
		Parent = tabContainer,
		PaddingTop = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		PaddingLeft = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 4),
	})

	local tabs = { "Aimbot", "Movement", "ESP", "Settings" }
	local tabFrames = {}

	for i, tabName in ipairs(tabs) do
		local tabBtn = newInstance("TextButton", {
			Parent = tabContainer,
			LayoutOrder = i,
			-- Fill the bar evenly regardless of tab count (the -4 absorbs
			-- the UIListLayout padding between buttons)
			Size = UDim2.new(1 / #tabs, -4, 1, 0),
			BackgroundColor3 = currentTab == tabName and COLORS.accent or COLORS.off,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = tabName,
		})

		newInstance("UICorner", { Parent = tabBtn, CornerRadius = UDim.new(0, 4) })

		local tabFrame = newInstance("Frame", {
			Parent = mainWindow,
			LayoutOrder = 1 + i,
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			Visible = currentTab == tabName,
		})

		newInstance("UIListLayout", { Parent = tabFrame, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })

		tabFrames[tabName] = { btn = tabBtn, frame = tabFrame }

		tabBtn.MouseButton1Click:Connect(function()
			currentTab = tabName
			for name, tab in pairs(tabFrames) do
				tab.frame.Visible = name == tabName
				TweenService:Create(tab.btn, ANIM, {
					BackgroundColor3 = name == tabName and COLORS.accent or COLORS.off,
				}):Play()
			end
		end)

		-- Hover lift for inactive tabs (the active tab stays accent).
		tabBtn.MouseEnter:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, ANIM, { BackgroundColor3 = COLORS.rowHover }):Play()
			end
		end)

		tabBtn.MouseLeave:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, ANIM, { BackgroundColor3 = COLORS.off }):Play()
			end
		end)
	end

	buildCameraTab(tabFrames["Aimbot"].frame, config)
	buildMovementTab(tabFrames["Movement"].frame, config)
	buildESPTab(tabFrames["ESP"].frame, config)
	buildSettingsTab(tabFrames["Settings"].frame, config, resetCallback)

	-- Respect initial visibility from config
	if config.UI.Visible then
		setVisible(true)
	end
end

function UI:Toggle()
	setVisible(not visible)
end

function UI:Show()
	setVisible(true)
end

function UI:Hide()
	setVisible(false)
end

-- Update the "Current Target" readout on the Camera tab
function UI:SetCurrentTarget(name)
	if targetLabel then
		local text = name or "None"
		if targetLabel.Text ~= text then
			targetLabel.Text = text
		end
	end
end

-- Re-read every control's value from config (after a reset or a keybind toggle)
function UI:SyncControls()
	for _, fn in ipairs(syncHandlers) do
		fn()
	end
end

-- True while a keybind box is armed and waiting for a key. The controller uses
-- this to skip its hotkey handling so the captured press isn't double-processed.
function UI:IsCapturingKey()
	return capturingKey
end

-- Transient top-of-screen toast for load confirmation and other events.
function UI:Notify(text, duration)
	if not gui then
		return
	end
	duration = duration or 3

	local toast = newInstance("TextLabel", {
		Parent = gui,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 12),
		Size = UDim2.fromOffset(math.max(200, #text * 8 + 28), 34),
		BackgroundColor3 = COLORS.bar,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = COLORS.text,
		Text = text,
	})

	newInstance("UICorner", { Parent = toast, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = toast, Color = COLORS.accent, Thickness = 1, Transparency = 0.3 })

	TweenService:Create(toast, TweenInfo.new(0.2), { BackgroundTransparency = 0.1 }):Play()

	task.delay(duration, function()
		if toast and toast.Parent then
			local out = TweenService:Create(toast, TweenInfo.new(0.3), {
				BackgroundTransparency = 1,
				TextTransparency = 1,
			})
			out.Completed:Once(function()
				if toast then
					toast:Destroy()
				end
			end)
			out:Play()
		end
	end)
end

function UI:Cleanup()
	for _, conn in ipairs(uisConnections) do
		conn:Disconnect()
	end
	table.clear(uisConnections)
	table.clear(moveHandlers)
	table.clear(releaseHandlers)
	table.clear(syncHandlers)

	activeCapture = nil
	capturingKey = false
	targetLabel = nil
	windowScale = nil

	if gui then
		gui:Destroy()
		gui = nil
		mainWindow = nil
	end
	visible = false
end

return UI
