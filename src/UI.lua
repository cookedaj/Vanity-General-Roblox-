--==============================================================================
-- UI
-- Modern tabbed interface with dark theme, smooth animations, keybind customization
--==============================================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local ConfigManager = require(script.ConfigManager)
local Utility = require(script.Utility)

local UI = {}

-- Deep purple + black theme.
local COLORS = {
	bg = Color3.fromRGB(10, 8, 14),        -- near-black window
	bar = Color3.fromRGB(16, 12, 22),      -- title bar / sidebar
	panel = Color3.fromRGB(19, 15, 26),    -- group box fill
	row = Color3.fromRGB(26, 20, 36),      -- control rows
	rowHover = Color3.fromRGB(38, 29, 52), -- hover lift
	accent = Color3.fromRGB(132, 62, 190), -- deep purple
	accentDim = Color3.fromRGB(92, 44, 134),
	border = Color3.fromRGB(44, 34, 60),   -- group outlines
	off = Color3.fromRGB(36, 28, 48),      -- unchecked / inactive
	text = Color3.fromRGB(226, 220, 238),
	textSub = Color3.fromRGB(138, 124, 160),
	danger = Color3.fromRGB(188, 52, 88),
}

local FADE_TIME = 0.18
local ANIM = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local gui
local mainWindow
local windowScale
local currentTab = "Combat"
local layoutOrder = 0
local visible = false
local activeConfig -- stored by Init so visibility can be written back to config
local onUnloadCallback -- stored by Init; the Unload button calls it (controller's Stop)

local uisConnections = {}
local moveHandlers = {}
local releaseHandlers = {}
local syncHandlers = {}

local targetPanel, targetPanelLabel -- floating "who you're locked onto" popup
local targetDisplayOn = false
local keybindPanel -- standalone keybind window (Settings > Interface toggle)
local watermark -- bottom-left watermark logo
local fpsPanel, fpsLabel -- bottom-right fps readout
local activeCapture
local capturingKey = false
local activeDropdown = nil -- { frame, close, contains } for the one open dropdown

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

	-- Click anywhere outside an open dropdown closes it.
	table.insert(uisConnections, UserInputService.InputBegan:Connect(function(input)
		if not activeDropdown or not isPointer(input) then
			return
		end
		local pos = Vector2.new(input.Position.X, input.Position.Y)
		if not activeDropdown.contains(pos) then
			activeDropdown.close()
		end
	end))

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

-- Compact checkbox row: small square on the left, label beside it.
local function makeToggle(parent, text, getValue, onChange)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	})

	local box = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(13, 13),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 3) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.border, Thickness = 1 })

	local label = newInstance("TextLabel", {
		Parent = btn,
		Position = UDim2.fromOffset(21, 0),
		Size = UDim2.new(1, -21, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = getValue() and COLORS.text or COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local function refresh()
		local on = getValue()
		TweenService:Create(box, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
		TweenService:Create(label, ANIM, { TextColor3 = on and COLORS.text or COLORS.textSub }):Play()
	end

	btn.MouseButton1Click:Connect(function()
		onChange()
		refresh()
	end)

	btn.MouseEnter:Connect(function()
		if not getValue() then
			box.BackgroundColor3 = COLORS.rowHover
		end
	end)

	btn.MouseLeave:Connect(function()
		if not getValue() then
			box.BackgroundColor3 = COLORS.off
		end
	end)

	table.insert(syncHandlers, refresh)
end

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

	table.insert(syncHandlers, function()
		apply(getValue())
	end)
end

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

-- Clickable action button with hover feedback. `color` defaults to the accent.
local function makeButton(parent, text, onClick, color)
	local base = color or COLORS.accent
	local hover = Color3.new(
		math.min(base.R + 0.1, 1),
		math.min(base.G + 0.1, 1),
		math.min(base.B + 0.1, 1)
	)

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
		TweenService:Create(btn, ANIM, { BackgroundColor3 = hover }):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, ANIM, { BackgroundColor3 = base }):Play()
	end)

	return btn
end

-- Single-line text input. Returns the TextBox so callers can read/set .Text.
local function makeTextBox(parent, placeholder)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
	local stroke = newInstance("UIStroke", {
		Parent = holder,
		Color = COLORS.border,
		Thickness = 1,
		Transparency = 0.3,
	})

	local box = newInstance("TextBox", {
		Parent = holder,
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		PlaceholderText = placeholder or "",
		PlaceholderColor3 = COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Text = "",
	})

	box.Focused:Connect(function()
		TweenService:Create(stroke, ANIM, { Transparency = 0, Color = COLORS.accent }):Play()
	end)

	box.FocusLost:Connect(function()
		TweenService:Create(stroke, ANIM, { Transparency = 0.3, Color = COLORS.border }):Play()
	end)

	return box
end

-- Small section header ("TARGET SETTINGS", "HITBOX") to group related controls.
local function makeHeader(parent, text)
	newInstance("TextLabel", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 18),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = string.upper(text),
	})
end

-- Filled-row slider: the accent fill grows with the value and the label sits on
-- top, e.g. "Head Weight: 85/100%". showMax appends "/<max><unit>".
local function makeFillSlider(parent, text, min, max, getValue, setValue, isInt, unit, showMax)
	unit = unit or ""

	local holder = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		ClipsDescendants = true,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })

	local fill = newInstance("Frame", {
		Parent = holder,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = COLORS.accent,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		ZIndex = 1,
	})

	newInstance("UICorner", { Parent = fill, CornerRadius = UDim.new(0, 6) })

	local label = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
		ZIndex = 3,
	})

	local function fmt(v)
		local s = isInt and tostring(math.floor(v + 0.5)) or string.format("%.2f", v)
		if showMax then
			local m = isInt and tostring(math.floor(max + 0.5)) or string.format("%.2f", max)
			return s .. "/" .. m .. unit
		end
		return s .. unit
	end

	local function apply(v)
		v = math.clamp(v, min, max)
		if isInt then
			v = math.floor(v + 0.5)
		end
		local alpha = (max > min) and (v - min) / (max - min) or 0
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		label.Text = text .. ": " .. fmt(v)
		setValue(v)
	end

	apply(getValue())

	local dragging = false

	local function fromInput(px)
		local alpha = math.clamp((px - holder.AbsolutePosition.X) / holder.AbsoluteSize.X, 0, 1)
		apply(min + alpha * (max - min))
	end

	holder.InputBegan:Connect(function(input)
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

	table.insert(syncHandlers, function()
		apply(getValue())
	end)
end

-- Full-width dropdown. The option list expands INLINE (growing the panel and
-- pushing whatever follows down) rather than floating over the layout — floating
-- got clipped by the scroll panel and drawn over by sibling group boxes.
local function makeDropdownFull(parent, options, getValue, onChange)
	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	newInstance("UIListLayout", {
		Parent = holder,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
	})

	local dropdown = newInstance("TextButton", {
		Parent = holder,
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	})

	newInstance("UICorner", { Parent = dropdown, CornerRadius = UDim.new(0, 6) })
	local dropStroke = newInstance("UIStroke", {
		Parent = dropdown,
		Color = COLORS.border,
		Thickness = 1,
		Transparency = 0.3,
	})

	local valueLabel = newInstance("TextLabel", {
		Parent = dropdown,
		Size = UDim2.new(1, -34, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Text = getValue(),
	})

	local caret = newInstance("TextLabel", {
		Parent = dropdown,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.accent,
		Text = "▾",
	})

	local open = false
	local ROW_H = 26
	local fullSize = #options * ROW_H
	local listSize = math.min(fullSize, 6 * ROW_H)

	local list = newInstance("ScrollingFrame", {
		Parent = holder,
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Visible = false,
		CanvasSize = UDim2.fromOffset(0, fullSize),
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = COLORS.accent,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Active = true,
	})

	newInstance("UICorner", { Parent = list, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = list, Color = COLORS.border, Thickness = 1, Transparency = 0.2 })

	local optionButtons = {}

	-- Repaints every row so the active choice reads as selected.
	local function paintOptions()
		local current = getValue()
		for option, btn in pairs(optionButtons) do
			local selected = (option == current)
			btn.BackgroundColor3 = selected and COLORS.accent or COLORS.panel
			btn.BackgroundTransparency = selected and 0 or 1
			btn.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or COLORS.textSub
			btn.Font = selected and Enum.Font.GothamBold or Enum.Font.Gotham
		end
	end

	local function collapse()
		if not open then
			return
		end
		open = false
		if activeDropdown and activeDropdown.frame == dropdown then
			activeDropdown = nil
		end
		TweenService:Create(caret, ANIM, { Rotation = 0 }):Play()
		TweenService:Create(dropStroke, ANIM, { Transparency = 0.3 }):Play()
		TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, 0) }):Play()
		task.delay(FADE_TIME, function()
			if not open then
				list.Visible = false
			end
		end)
	end

	local function expand()
		if open then
			return
		end
		if activeDropdown and activeDropdown.close then
			activeDropdown.close() -- only one open at a time
		end
		open = true
		paintOptions()
		list.Visible = true
		TweenService:Create(caret, ANIM, { Rotation = 180 }):Play()
		TweenService:Create(dropStroke, ANIM, { Transparency = 0 }):Play()
		TweenService:Create(list, ANIM, { Size = UDim2.new(1, 0, 0, listSize) }):Play()

		activeDropdown = {
			frame = dropdown,
			close = collapse,
			contains = function(pos)
				local function inside(obj)
					local p, s = obj.AbsolutePosition, obj.AbsoluteSize
					return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
				end
				return inside(dropdown) or (list.Visible and inside(list))
			end,
		}
	end

	for i, option in ipairs(options) do
		local optionBtn = newInstance("TextButton", {
			Parent = list,
			Size = UDim2.new(1, 0, 0, ROW_H),
			Position = UDim2.fromOffset(0, (i - 1) * ROW_H),
			BackgroundColor3 = COLORS.panel,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextColor3 = COLORS.textSub,
			Text = option,
			AutoButtonColor = false,
		})

		optionButtons[option] = optionBtn

		optionBtn.MouseButton1Click:Connect(function()
			onChange(option)
			valueLabel.Text = option
			paintOptions()
			collapse()
		end)

		optionBtn.MouseEnter:Connect(function()
			if option ~= getValue() then
				optionBtn.BackgroundTransparency = 0
				optionBtn.BackgroundColor3 = COLORS.rowHover
				optionBtn.TextColor3 = COLORS.text
			end
		end)

		optionBtn.MouseLeave:Connect(function()
			paintOptions()
		end)
	end

	paintOptions()

	dropdown.MouseButton1Click:Connect(function()
		if open then
			collapse()
		else
			expand()
		end
	end)

	dropdown.MouseEnter:Connect(function()
		if not open then
			TweenService:Create(dropdown, ANIM, { BackgroundColor3 = COLORS.rowHover }):Play()
		end
	end)

	dropdown.MouseLeave:Connect(function()
		if not open then
			TweenService:Create(dropdown, ANIM, { BackgroundColor3 = COLORS.row }):Play()
		end
	end)

	table.insert(syncHandlers, function()
		valueLabel.Text = getValue()
		paintOptions()
	end)
end

-- HSV color picker: saturation/value square + hue strip + hex readout.
local function makeColorPicker(parent, title, getColor, setColor)
	local h, s, v = getColor():ToHSV()
	local SQ_H, HUE_W, GAP = 120, 16, 8

	local holder = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, SQ_H + 74),
		BackgroundColor3 = COLORS.panel,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = holder, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
	newInstance("UIPadding", {
		Parent = holder,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	local heading = newInstance("TextLabel", {
		Parent = holder,
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = title or "Color",
	})

	local body = newInstance("Frame", {
		Parent = holder,
		Position = UDim2.fromOffset(0, 20),
		Size = UDim2.new(1, 0, 1, -20),
		BackgroundTransparency = 1,
	})

	local sq = newInstance("Frame", {
		Parent = body,
		Size = UDim2.new(1, -(HUE_W + GAP), 0, SQ_H), -- responsive: fits any column width
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

	local hue = newInstance("Frame", {
		Parent = body,
		Size = UDim2.fromOffset(HUE_W, SQ_H),
		Position = UDim2.new(1, -HUE_W, 0, 0),
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

	local preview = newInstance("Frame", {
		Parent = body,
		Size = UDim2.fromOffset(22, 22),
		Position = UDim2.fromOffset(0, SQ_H + 6),
		BackgroundColor3 = getColor(),
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = preview, CornerRadius = UDim.new(0, 4) })
	newInstance("UIStroke", { Parent = preview, Color = COLORS.off, Thickness = 1 })

	local hexLabel = newInstance("TextLabel", {
		Parent = body,
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
		hexLabel.Text = string.format("#%02X%02X%02X  (%d, %d, %d)", r, g, b, r, g, b)
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

	table.insert(syncHandlers, function()
		h, s, v = getColor():ToHSV()
		refresh(false)
	end)
end

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
			activeCapture = nil
			task.defer(function()
				capturingKey = false
			end)
			capture.cancel()
			return
		end
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
-- Fields: menu, aimbot, esp, fovcircle, norecoil, nospread, clicktp, unload.
local function keyConflict(config, key, field)
	if field ~= "menu" and config.UI.MenuKey == key then
		return "Menu"
	end
	if field ~= "aimbot" and config.Camera.ToggleKey == key then
		return "Aimbot"
	end
	if field ~= "esp" and config.ESP.ToggleKey == key then
		return "ESP"
	end
	if field ~= "fovcircle" and config.Camera.FOVCircleKey == key then
		return "FOV Circle"
	end
	if field ~= "norecoil" and config.NoRecoil.ToggleKey == key then
		return "No Recoil"
	end
	if field ~= "nospread" and config.NoSpread.ToggleKey == key then
		return "No Spread"
	end
	if field ~= "triggerbot" and config.Triggerbot.ToggleKey == key then
		return "Triggerbot"
	end
	if field ~= "clicktp" and config.Movement.ClickTPKey == key then
		return "Click TP"
	end
	if field ~= "unload" and config.UI.UnloadKey == key then
		return "Unload"
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
-- Checkbox row with an inline keybind box on the right. The row toggles; the key
-- box captures its own clicks (it sits on top) so rebinding never flips it.
local function makeToggleWithKeybind(parent, text, getValue, onChange, keyLabel, getKey, setKey, conflictCheck)
	local btn = newInstance("TextButton", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	})

	local check = newInstance("Frame", {
		Parent = btn,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(13, 13),
		BackgroundColor3 = getValue() and COLORS.accent or COLORS.off,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = check, CornerRadius = UDim.new(0, 3) })
	newInstance("UIStroke", { Parent = check, Color = COLORS.border, Thickness = 1 })

	local label = newInstance("TextLabel", {
		Parent = btn,
		Position = UDim2.fromOffset(21, 0),
		Size = UDim2.new(1, -76, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = getValue() and COLORS.text or COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text,
	})

	local box = newInstance("TextButton", {
		Parent = btn,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(0, 20),
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
		PaddingLeft = UDim.new(0, 7),
		PaddingRight = UDim.new(0, 7),
	})
	newInstance("UISizeConstraint", { Parent = box, MinSize = Vector2.new(44, 20) })

	local function refresh()
		local on = getValue()
		TweenService:Create(check, ANIM, { BackgroundColor3 = on and COLORS.accent or COLORS.off }):Play()
		TweenService:Create(label, ANIM, { TextColor3 = on and COLORS.text or COLORS.textSub }):Play()
	end

	btn.MouseButton1Click:Connect(function()
		onChange()
		refresh()
	end)

	table.insert(syncHandlers, refresh)

	wireKeybindBox(box, keyLabel, getKey, setKey, conflictCheck)
end

-- Splits a tab panel into two side-by-side columns (the tab's own layout is
-- horizontal). Groups get distributed between them for the two-column look.
local function makeColumns(parent)
	local function column(order)
		local col = newInstance("Frame", {
			Parent = parent,
			LayoutOrder = order,
			Size = UDim2.new(0.5, -4, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UIListLayout", {
			Parent = col,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		})
		return col
	end
	return column(1), column(2)
end

-- Bordered, titled panel. Returns:
--   content   -- parent controls to this
--   setEnabled(bool) -- greys the panel out and blocks input when false
local function makeGroup(parent, title)
	-- Wrapper holds the panel plus the disabled veil. It deliberately has NO
	-- AutomaticSize: AutomaticSize measures the veil too, so the veil (sized off
	-- the wrapper) and the wrapper would inflate each other into a giant box. Its
	-- height is instead synced from the panel below, which nothing else depends on.
	local wrapper = newInstance("Frame", {
		Parent = parent,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	local box = newInstance("Frame", {
		Parent = wrapper,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = COLORS.panel,
		BorderSizePixel = 0,
	})

	newInstance("UICorner", { Parent = box, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = box, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
	newInstance("UIPadding", {
		Parent = box,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})
	newInstance("UIListLayout", {
		Parent = box,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
	})

	newInstance("TextLabel", {
		Parent = box,
		LayoutOrder = -1,
		Size = UDim2.new(1, 0, 0, 15),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = title,
	})

	-- Disabled veil: dims the panel AND hatches it with diagonal lines so it reads
	-- as unusable. It's a TextButton (not a Frame+Active) because only a button
	-- reliably swallows the press that starts a slider drag.
	local veil = newInstance("TextButton", {
		Parent = wrapper,
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = COLORS.bg,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		Visible = false,
		Active = true,
		AutoButtonColor = false,
		Text = "",
		ClipsDescendants = true,
		ZIndex = 50,
	})
	newInstance("UICorner", { Parent = veil, CornerRadius = UDim.new(0, 6) })

	-- Diagonal hatching drawn with a rotated GRADIENT, not rotated frames:
	-- ClipsDescendants does not clip rotated children in Roblox, so the old stripe
	-- frames escaped the panel and smeared across the whole menu. A gradient is
	-- painted inside its own frame, so it can never spill.
	local STRIPE, GAP = 0.72, 1 -- transparency of a stripe vs the space between
	local hatch = newInstance("Frame", {
		Parent = veil,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = COLORS.textSub,
		BorderSizePixel = 0,
		ZIndex = 51,
	})
	newInstance("UICorner", { Parent = hatch, CornerRadius = UDim.new(0, 6) })
	newInstance("UIGradient", {
		Parent = hatch,
		Rotation = 35,
		-- Alternating hard bands (paired keypoints make the edges crisp).
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0.000, GAP),
			NumberSequenceKeypoint.new(0.119, GAP),
			NumberSequenceKeypoint.new(0.120, STRIPE),
			NumberSequenceKeypoint.new(0.199, STRIPE),
			NumberSequenceKeypoint.new(0.200, GAP),
			NumberSequenceKeypoint.new(0.319, GAP),
			NumberSequenceKeypoint.new(0.320, STRIPE),
			NumberSequenceKeypoint.new(0.399, STRIPE),
			NumberSequenceKeypoint.new(0.400, GAP),
			NumberSequenceKeypoint.new(0.519, GAP),
			NumberSequenceKeypoint.new(0.520, STRIPE),
			NumberSequenceKeypoint.new(0.599, STRIPE),
			NumberSequenceKeypoint.new(0.600, GAP),
			NumberSequenceKeypoint.new(0.719, GAP),
			NumberSequenceKeypoint.new(0.720, STRIPE),
			NumberSequenceKeypoint.new(0.799, STRIPE),
			NumberSequenceKeypoint.new(0.800, GAP),
			NumberSequenceKeypoint.new(0.919, GAP),
			NumberSequenceKeypoint.new(0.920, STRIPE),
			NumberSequenceKeypoint.new(1.000, STRIPE),
		}),
	})

	-- Keep the wrapper exactly as tall as the panel. AbsoluteSize is already
	-- post-UIScale while Size offsets get scaled again, so divide it back out.
	local function syncWrapper()
		local sc = (windowScale and windowScale.Scale) or 1
		if sc <= 0 then
			sc = 1
		end
		wrapper.Size = UDim2.new(1, 0, 0, box.AbsoluteSize.Y / sc)
	end

	box:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncWrapper)
	syncWrapper()

	local function setEnabled(enabled)
		veil.Visible = not enabled
	end

	return box, setEnabled
end

-- Sub-tab bar across the top of a section, with one scrolling two-column panel
-- per sub-tab below it. Returns a host whose :add(name) creates a sub-tab and
-- returns its content frame (pass that to makeColumns). First added shows first.
local function makeSubTabHost(parent)
	local bar = newInstance("Frame", {
		Parent = parent,
		Size = UDim2.new(1, 0, 0, 24),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIListLayout", {
		Parent = bar,
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 14),
	})

	-- Thin divider under the bar.
	local divider = newInstance("Frame", {
		Parent = parent,
		Position = UDim2.fromOffset(0, 27),
		Size = UDim2.new(1, -6, 0, 1),
		BackgroundColor3 = COLORS.border,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
	})

	local area = newInstance("Frame", {
		Parent = parent,
		Position = UDim2.fromOffset(0, 34),
		Size = UDim2.new(1, 0, 1, -34),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	local host = { frames = {}, buttons = {}, order = 0, current = nil }

	local function select(name)
		host.current = name
		for n, f in pairs(host.frames) do
			f.Visible = (n == name)
		end
		for n, b in pairs(host.buttons) do
			local active = (n == name)
			TweenService:Create(b.btn, ANIM, { TextColor3 = active and COLORS.text or COLORS.textSub }):Play()
			TweenService:Create(b.underline, ANIM, { BackgroundTransparency = active and 0 or 1 }):Play()
		end
	end

	function host:add(name)
		self.order = self.order + 1

		local btn = newInstance("TextButton", {
			Parent = bar,
			LayoutOrder = self.order,
			Size = UDim2.fromOffset(0, 24),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = COLORS.textSub,
			Text = name,
		})

		local underline = newInstance("Frame", {
			Parent = btn,
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, 1),
			Size = UDim2.new(1, 0, 0, 2),
			BackgroundColor3 = COLORS.accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})
		newInstance("UICorner", { Parent = underline, CornerRadius = UDim.new(1, 0) })

		local frame = newInstance("ScrollingFrame", {
			Parent = area,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Visible = false,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 5,
			ScrollBarImageColor3 = COLORS.accent,
			ScrollBarImageTransparency = 0.25,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Active = true,
		})
		newInstance("UIListLayout", {
			Parent = frame,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, 8),
		})
		newInstance("UIPadding", { Parent = frame, PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8) })

		self.buttons[name] = { btn = btn, underline = underline }
		self.frames[name] = frame

		btn.MouseButton1Click:Connect(function()
			select(name)
		end)
		btn.MouseEnter:Connect(function()
			if host.current ~= name then
				btn.TextColor3 = COLORS.text
			end
		end)
		btn.MouseLeave:Connect(function()
			if host.current ~= name then
				btn.TextColor3 = COLORS.textSub
			end
		end)

		if not self.current then
			select(name)
		end
		return frame
	end

	return host
end

local function buildCameraTab(parent, config)
	layoutOrder = 0
	local host = makeSubTabHost(parent)
	local left, right = makeColumns(host:add("Aimbot"))

	local aim = makeGroup(left, "Aimbot")

	makeToggleWithKeybind(aim, "Enabled", function()
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

	makeToggle(aim, "Vischeck", function()
		return config.Camera.WallCheck
	end, function()
		config.Camera.WallCheck = not config.Camera.WallCheck
	end)

	makeToggle(aim, "Sticky Target", function()
		return config.Camera.StickyTarget
	end, function()
		config.Camera.StickyTarget = not config.Camera.StickyTarget
	end)

	makeToggle(aim, "Target Bots", function()
		return config.Camera.TargetBots
	end, function()
		config.Camera.TargetBots = not config.Camera.TargetBots
	end)

	makeToggle(aim, "Team Check", function()
		return config.Camera.TeamCheck
	end, function()
		config.Camera.TeamCheck = not config.Camera.TeamCheck
	end)

	makeToggle(aim, "Humanize", function()
		return config.Camera.Humanize
	end, function()
		config.Camera.Humanize = not config.Camera.Humanize
	end)

	makeToggleWithKeybind(aim, "FOV Circle", function()
		return config.Camera.FOVCircle
	end, function()
		config.Camera.FOVCircle = not config.Camera.FOVCircle
	end, "FOV Circle Key", function()
		return config.Camera.FOVCircleKey
	end, function(key)
		config.Camera.FOVCircleKey = key
	end, function(key)
		return keyConflict(config, key, "fovcircle")
	end)

	makeFillSlider(aim, "Smoothness", 0.05, 1, function()
		return config.Camera.Smoothness
	end, function(val)
		config.Camera.Smoothness = val
	end, false)

	makeFillSlider(aim, "Prediction", 0, 1, function()
		return config.Camera.Prediction
	end, function(val)
		config.Camera.Prediction = val
	end, false)

	-- FOV drives both the targeting cone and the on-screen circle.
	makeFillSlider(aim, "FOV", 20, 800, function()
		return config.Camera.FOV
	end, function(val)
		config.Camera.FOV = val
	end, true, "px", true)

	makeFillSlider(aim, "Max Distance", 100, 2000, function()
		return config.Camera.MaxDistance
	end, function(val)
		config.Camera.MaxDistance = val
	end, true, "m", true)

	-- Declared up front so the dropdown's callback can refresh the weights gate,
	-- which is created just below it.
	local refreshWeightGate

	local hitbox = makeGroup(right, "Hitbox")
	makeDropdownFull(hitbox, config.Camera.HitboxOptions, function()
		return config.Camera.Hitbox
	end, function(val)
		config.Camera.Hitbox = val
		if refreshWeightGate then
			refreshWeightGate()
		end
	end)

	-- Per-region weights live with the Hitbox mode that uses them, on the right.
	local weights, setWeightsEnabled = makeGroup(right, "Target Settings")

	local function weightRow(name)
		makeFillSlider(weights, name .. " Weight", 0, 100, function()
			return config.Camera.TargetWeights[name]
		end, function(val)
			config.Camera.TargetWeights[name] = val
		end, true, "%", true)
	end

	weightRow("Head")
	weightRow("Torso")
	weightRow("Arms")
	weightRow("Legs")

	-- Weights only do anything in Random (Weighted); grey the panel out and block
	-- input when a specific body part is picked instead.
	refreshWeightGate = function()
		setWeightsEnabled(config.Camera.Hitbox == "Random (Weighted)")
	end
	refreshWeightGate()
	table.insert(syncHandlers, refreshWeightGate)

	-- Triggerbot lives with the Aimbot on this sub-tab.
	local trigger = makeGroup(right, "Triggerbot")

	makeToggleWithKeybind(trigger, "Enabled", function()
		return config.Triggerbot.Enabled
	end, function()
		config.Triggerbot.Enabled = not config.Triggerbot.Enabled
	end, "Triggerbot Key", function()
		return config.Triggerbot.ToggleKey
	end, function(key)
		config.Triggerbot.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "triggerbot")
	end)

	makeFillSlider(trigger, "Min Delay", 0, 500, function()
		return config.Triggerbot.MinDelay * 1000
	end, function(val)
		config.Triggerbot.MinDelay = val / 1000
	end, true, "ms", true)

	makeFillSlider(trigger, "Max Delay", 0, 500, function()
		return config.Triggerbot.MaxDelay * 1000
	end, function(val)
		config.Triggerbot.MaxDelay = val / 1000
	end, true, "ms", true)

	makeFillSlider(trigger, "Max Distance", 100, 2000, function()
		return config.Triggerbot.MaxDistance
	end, function(val)
		config.Triggerbot.MaxDistance = val
	end, true, "m", true)

	makeToggle(trigger, "Vischeck", function()
		return config.Triggerbot.WallCheck
	end, function()
		config.Triggerbot.WallCheck = not config.Triggerbot.WallCheck
	end)

	-- Silent Aim redirects shots without moving the camera. On executors without
	-- hookmetamethod the toggle simply does nothing (see the SILENT AIM section).
	local silent = makeGroup(right, "Silent Aim")

	makeToggle(silent, "Enabled", function()
		return config.SilentAim.Enabled
	end, function()
		config.SilentAim.Enabled = not config.SilentAim.Enabled
	end)

	-- Client-side root inflation; originals restore when toggled back off.
	local expander = makeGroup(right, "Hitbox Expander")

	makeToggle(expander, "Enabled", function()
		return config.Hitbox.Enabled
	end, function()
		config.Hitbox.Enabled = not config.Hitbox.Enabled
	end)

	makeFillSlider(expander, "Size", 1, 20, function()
		return config.Hitbox.Size
	end, function(val)
		config.Hitbox.Size = val
	end, true)

	makeFillSlider(expander, "Transparency", 0, 1, function()
		return config.Hitbox.Transparency
	end, function(val)
		config.Hitbox.Transparency = val
	end, false)

	------------------------------------------------------------------- Weapons --
	left, right = makeColumns(host:add("Weapons"))

	local recoil = makeGroup(left, "No Recoil")

	makeToggleWithKeybind(recoil, "Enabled", function()
		return config.NoRecoil.Enabled
	end, function()
		config.NoRecoil.Enabled = not config.NoRecoil.Enabled
	end, "No Recoil Key", function()
		return config.NoRecoil.ToggleKey
	end, function(key)
		config.NoRecoil.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "norecoil")
	end)

	makeToggle(recoil, "Only While Firing", function()
		return config.NoRecoil.RequireMouseDown
	end, function()
		config.NoRecoil.RequireMouseDown = not config.NoRecoil.RequireMouseDown
	end)

	makeToggle(recoil, "Allow Aim Down", function()
		return config.NoRecoil.AllowAim
	end, function()
		config.NoRecoil.AllowAim = not config.NoRecoil.AllowAim
	end)

	makeFillSlider(recoil, "Strength", 0, 100, function()
		return config.NoRecoil.Strength * 100
	end, function(val)
		config.NoRecoil.Strength = val / 100
	end, true, "%", true)

	local spread = makeGroup(left, "No Spread")

	makeToggleWithKeybind(spread, "Enabled", function()
		return config.NoSpread.Enabled
	end, function()
		config.NoSpread.Enabled = not config.NoSpread.Enabled
	end, "No Spread Key", function()
		return config.NoSpread.ToggleKey
	end, function(key)
		config.NoSpread.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "nospread")
	end)

	makeToggle(spread, "Only While Firing", function()
		return config.NoSpread.RequireMouseDown
	end, function()
		config.NoSpread.RequireMouseDown = not config.NoSpread.RequireMouseDown
	end)

	makeFillSlider(spread, "Strength", 0, 100, function()
		return config.NoSpread.Strength * 100
	end, function(val)
		config.NoSpread.Strength = val / 100
	end, true, "%", true)
end

local function buildESPTab(parent, config)
	layoutOrder = 0
	local host = makeSubTabHost(parent)
	local left, right = makeColumns(host:add("ESP"))

	local esp = makeGroup(left, "ESP")

	makeToggleWithKeybind(esp, "Enabled", function()
		return config.ESP.Enabled
	end, function()
		config.ESP.Enabled = not config.ESP.Enabled
	end, "ESP Key", function()
		return config.ESP.ToggleKey
	end, function(key)
		config.ESP.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "esp")
	end)

	makeToggle(esp, "NPCs", function()
		return config.ESP.NPCs
	end, function()
		config.ESP.NPCs = not config.ESP.NPCs
	end)

	makeFillSlider(esp, "Max Distance", 100, 2000, function()
		return config.ESP.MaxDistance
	end, function(val)
		config.ESP.MaxDistance = val
	end, true, "m", true)

	-- Appearance: render style, fill toggle, then the opacities at the bottom.
	local look = makeGroup(left, "Appearance")

	makeToggle(look, "Outlines", function()
		return config.ESP.Outlines
	end, function()
		config.ESP.Outlines = not config.ESP.Outlines
	end)

	makeToggle(look, "Boxes", function()
		return config.ESP.Boxes
	end, function()
		config.ESP.Boxes = not config.ESP.Boxes
	end)

	makeToggle(look, "Names", function()
		return config.ESP.Names
	end, function()
		config.ESP.Names = not config.ESP.Names
	end)

	makeToggle(look, "Distance", function()
		return config.ESP.Distance
	end, function()
		config.ESP.Distance = not config.ESP.Distance
	end)

	makeToggle(look, "Health Bars", function()
		return config.ESP.HealthBars
	end, function()
		config.ESP.HealthBars = not config.ESP.HealthBars
	end)

	makeToggle(look, "Filled", function()
		return config.ESP.Filled
	end, function()
		config.ESP.Filled = not config.ESP.Filled
	end)

	makeFillSlider(look, "Outline Opacity", 0, 1, function()
		return config.ESP.OutlineOpacity
	end, function(val)
		config.ESP.OutlineOpacity = val
	end, false)

	makeFillSlider(look, "Fill Opacity", 0, 1, function()
		return config.ESP.FillOpacity
	end, function(val)
		config.ESP.FillOpacity = val
	end, false)

	-- Executor Drawing-library boxes/tracers (no-op where Drawing is missing).
	local drawing = makeGroup(right, "Drawing ESP")

	makeToggle(drawing, "Boxes", function()
		return config.Drawing.Boxes
	end, function()
		config.Drawing.Boxes = not config.Drawing.Boxes
	end)

	makeToggle(drawing, "Tracers", function()
		return config.Drawing.Tracers
	end, function()
		config.Drawing.Tracers = not config.Drawing.Tracers
	end)

	local world = makeGroup(right, "World")

	makeToggle(world, "Fullbright", function()
		return config.Visuals.Fullbright
	end, function()
		config.Visuals.Fullbright = not config.Visuals.Fullbright
	end)

	makeToggle(world, "No Fog", function()
		return config.Visuals.NoFog
	end, function()
		config.Visuals.NoFog = not config.Visuals.NoFog
	end)

	----------------------------------------------------------------- Colors -----
	left, right = makeColumns(host:add("Colors"))

	makeColorPicker(left, "Outline Color", function()
		return config.ESP.OutlineColor
	end, function(c)
		config.ESP.OutlineColor = c
	end)

	makeColorPicker(right, "Fill Color", function()
		return config.ESP.FillColor
	end, function(c)
		config.ESP.FillColor = c
	end)

	makeColorPicker(left, "Box Color", function()
		return config.Drawing.BoxColor
	end, function(c)
		config.Drawing.BoxColor = c
	end)

	makeColorPicker(right, "Tracer Color", function()
		return config.Drawing.TracerColor
	end, function(c)
		config.Drawing.TracerColor = c
	end)
end

local function buildMovementTab(parent, config)
	layoutOrder = 0
	local host = makeSubTabHost(parent)
	local left, right = makeColumns(host:add("Movement"))

	local fly = makeGroup(left, "Fly")

	makeToggle(fly, "Enabled", function()
		return config.Movement.FlyEnabled
	end, function()
		config.Movement.FlyEnabled = not config.Movement.FlyEnabled
	end)

	makeFillSlider(fly, "Fly Speed", 10, 200, function()
		return config.Movement.FlySpeed
	end, function(val)
		config.Movement.FlySpeed = val
	end, true)

	local speed = makeGroup(left, "Speed")

	makeToggle(speed, "Enabled", function()
		return config.Movement.SpeedEnabled
	end, function()
		config.Movement.SpeedEnabled = not config.Movement.SpeedEnabled
	end)

	makeFillSlider(speed, "Speed", 16, 100, function()
		return config.Movement.Speed
	end, function(val)
		config.Movement.Speed = val
	end, true)

	local misc = makeGroup(left, "Other")

	makeToggle(misc, "Pulse (Anti-Lagback)", function()
		return config.Movement.Pulse
	end, function()
		config.Movement.Pulse = not config.Movement.Pulse
	end)

	makeToggle(misc, "Noclip", function()
		return config.Movement.NoclipEnabled
	end, function()
		config.Movement.NoclipEnabled = not config.Movement.NoclipEnabled
	end)

	makeToggle(misc, "Infinite Jump", function()
		return config.Movement.InfJumpEnabled
	end, function()
		config.Movement.InfJumpEnabled = not config.Movement.InfJumpEnabled
	end)

	local tp = makeGroup(right, "Click TP")

	makeToggle(tp, "Enabled", function()
		return config.Movement.ClickTPEnabled
	end, function()
		config.Movement.ClickTPEnabled = not config.Movement.ClickTPEnabled
	end)

	makeKeybind(tp, "Modifier Key", function()
		return config.Movement.ClickTPKey
	end, function(key)
		config.Movement.ClickTPKey = key
	end, function(key)
		return keyConflict(config, key, "clicktp")
	end)
end

local function buildSettingsTab(parent, config)
	layoutOrder = 0
	local host = makeSubTabHost(parent)
	local left, right = makeColumns(host:add("General"))

	local iface = makeGroup(left, "Interface")
	makeFillSlider(iface, "UI Scale", 0.8, 1.5, function()
		return config.UI.Scale
	end, function(val)
		config.UI.Scale = val
		if windowScale then
			windowScale.Scale = val
		end
	end, false)

	-- Opens the standalone keybind window (built by buildKeybindPanel).
	makeToggle(iface, "Keybind Panel", function()
		return config.UI.KeybindPanel
	end, function()
		config.UI.KeybindPanel = not config.UI.KeybindPanel
		if keybindPanel then
			keybindPanel.Visible = config.UI.KeybindPanel
		end
	end)

	makeToggle(iface, "Target Display", function()
		return config.UI.TargetDisplay
	end, function()
		config.UI.TargetDisplay = not config.UI.TargetDisplay
		targetDisplayOn = config.UI.TargetDisplay
		if not targetDisplayOn and targetPanel then
			targetPanel.Visible = false
		end
	end)

	makeToggle(iface, "FPS Counter", function()
		return config.UI.FPSCounter
	end, function()
		config.UI.FPSCounter = not config.UI.FPSCounter
		if fpsPanel then
			fpsPanel.Visible = config.UI.FPSCounter
		end
	end)

	makeToggle(iface, "Watermark", function()
		return config.UI.Watermark
	end, function()
		config.UI.Watermark = not config.UI.Watermark
		if watermark then
			watermark.Visible = config.UI.Watermark
		end
	end)

	local account = makeGroup(right, "Account")
	makeLabel(account, "Username", LocalPlayer and LocalPlayer.Name or "—")
	makeLabel(account, "Display Name", LocalPlayer and LocalPlayer.DisplayName or "—")
	makeLabel(account, "User ID", LocalPlayer and tostring(LocalPlayer.UserId) or "—")

	makeToggle(account, "Anti-AFK", function()
		return config.Utility.AntiAFK
	end, function()
		config.Utility.AntiAFK = not config.Utility.AntiAFK
	end)

	makeButton(account, "Server Hop", function()
		Utility:ServerHop()
	end)

	makeButton(account, "Rejoin Server", function()
		Utility:Rejoin()
	end)

	------------------------------------------------------------------ Configs ---
	-- Save / load / delete named setting profiles.
	left, right = makeColumns(host:add("Configs"))
	local cfg = makeGroup(left, "Configs")

	if not ConfigManager.isSupported() then
		makeLabel(cfg, "Status", "Unsupported")
		return
	end

	local nameBox = makeTextBox(cfg, "config name…")

	-- Scrollable list of saved configs; clicking one selects it into the box.
	local listHolder = newInstance("Frame", {
		Parent = cfg,
		LayoutOrder = nextOrder(),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIListLayout", {
		Parent = listHolder,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
	})

	local refreshList

	local function selectName(name)
		nameBox.Text = name
		refreshList()
	end

	refreshList = function()
		for _, child in ipairs(listHolder:GetChildren()) do
			if not child:IsA("UIListLayout") then
				child:Destroy()
			end
		end

		local names = ConfigManager.list()
		if #names == 0 then
			newInstance("TextLabel", {
				Parent = listHolder,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 22),
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham,
				TextSize = 11,
				TextColor3 = COLORS.textSub,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = "no saved configs",
			})
			return
		end

		for i, name in ipairs(names) do
			local selected = (nameBox.Text == name)
			local row = newInstance("TextButton", {
				Parent = listHolder,
				LayoutOrder = i,
				Size = UDim2.new(1, 0, 0, 22),
				BackgroundColor3 = selected and COLORS.accent or COLORS.row,
				BackgroundTransparency = selected and 0 or 0.35,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Font = Enum.Font.Gotham,
				TextSize = 11,
				TextColor3 = selected and Color3.fromRGB(255, 255, 255) or COLORS.textSub,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = "  " .. name,
			})
			newInstance("UICorner", { Parent = row, CornerRadius = UDim.new(0, 4) })

			row.MouseButton1Click:Connect(function()
				selectName(name)
			end)

			row.MouseEnter:Connect(function()
				if nameBox.Text ~= name then
					row.BackgroundTransparency = 0
					row.BackgroundColor3 = COLORS.rowHover
				end
			end)

			row.MouseLeave:Connect(function()
				if nameBox.Text ~= name then
					row.BackgroundTransparency = 0.35
					row.BackgroundColor3 = COLORS.row
				end
			end)
		end
	end

	makeButton(cfg, "Save", function()
		local ok, res = ConfigManager.save(nameBox.Text, config)
		if ok then
			UI:Notify("Saved config '" .. res .. "'", 2)
			refreshList()
		else
			UI:Notify(tostring(res), 3)
		end
	end)

	makeButton(cfg, "Load", function()
		local ok, res = ConfigManager.load(nameBox.Text, config)
		if ok then
			-- Push every loaded value back into the controls, and re-apply UI scale.
			if windowScale then
				windowScale.Scale = config.UI.Scale
			end
			UI:SyncControls()
			UI:Notify("Loaded config '" .. res .. "'", 2)
		else
			UI:Notify(tostring(res), 3)
		end
	end)

	makeButton(cfg, "Delete", function()
		local ok, res = ConfigManager.delete(nameBox.Text)
		if ok then
			UI:Notify("Deleted config '" .. res .. "'", 2)
			nameBox.Text = ""
			refreshList()
		else
			UI:Notify(tostring(res), 3)
		end
	end, COLORS.danger)

	refreshList()
end

-- Bottom-right watermark: brand, player name and a live FPS readout. Toggled by
-- the "Watermark" switch under Settings > Interface.
-- Floating popup naming whoever the aimbot is currently locked onto. Only shows
-- while there IS a target, so it behaves like a callout rather than a static row.
-- Draggable; toggled by "Target Display" under Settings > Interface.
local function buildTargetPanel(config)
	targetPanel = newInstance("Frame", {
		Parent = gui,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 90),
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = COLORS.panel,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		Visible = false,
	})

	newInstance("UICorner", { Parent = targetPanel, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = targetPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
	newInstance("UIPadding", {
		Parent = targetPanel,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 12),
	})
	newInstance("UIListLayout", {
		Parent = targetPanel,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
	})

	local dot = newInstance("Frame", {
		Parent = targetPanel,
		LayoutOrder = 0,
		Size = UDim2.fromOffset(6, 6),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

	targetPanelLabel = newInstance("TextLabel", {
		Parent = targetPanel,
		LayoutOrder = 1,
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		RichText = true,
		Text = "",
	})

	local dragging, dragStart, startPos
	targetPanel.InputBegan:Connect(function(input)
		if isPointer(input) then
			dragging = true
			dragStart = input.Position
			startPos = targetPanel.Position
		end
	end)

	table.insert(moveHandlers, function(input)
		if dragging and targetPanel then
			local delta = input.Position - dragStart
			targetPanel.Position = UDim2.new(
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

	table.insert(syncHandlers, function()
		targetDisplayOn = config.UI.TargetDisplay
		if not targetDisplayOn and targetPanel then
			targetPanel.Visible = false
		end
	end)

	targetDisplayOn = config.UI.TargetDisplay
end

-- Bottom-right fps readout. Toggled by "FPS Counter" under Settings > Interface.
local function buildFpsPanel(config)
	fpsPanel = newInstance("Frame", {
		Parent = gui,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -14, 1, -14),
		Size = UDim2.fromOffset(0, 26),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = COLORS.panel,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		Visible = false,
	})

	newInstance("UICorner", { Parent = fpsPanel, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = fpsPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.4 })
	newInstance("UIPadding", {
		Parent = fpsPanel,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 12),
	})
	newInstance("UIListLayout", {
		Parent = fpsPanel,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
	})

	local dot = newInstance("Frame", {
		Parent = fpsPanel,
		LayoutOrder = 0,
		Size = UDim2.fromOffset(6, 6),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

	fpsLabel = newInstance("TextLabel", {
		Parent = fpsPanel,
		LayoutOrder = 1,
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		RichText = true,
		Text = "-- fps",
	})

	table.insert(syncHandlers, function()
		if fpsPanel then
			fpsPanel.Visible = config.UI.FPSCounter
		end
	end)

	fpsPanel.Visible = config.UI.FPSCounter
end

local function buildWatermark(config)
	-- Just the logo: no panel, border or text. ScaleType.Fit letterboxes inside
	-- the box, so any source aspect ratio stays undistorted. Sits bottom-LEFT so
	-- it doesn't collide with the fps counter in the bottom-right.
	watermark = newInstance("ImageLabel", {
		Parent = gui,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 14, 1, -14),
		Size = UDim2.fromOffset(180, 64),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScaleType = Enum.ScaleType.Fit,
		Image = "",
		Visible = false,
	})

	UI:SetWatermarkImage(config.UI.WatermarkImageId)

	table.insert(syncHandlers, function()
		if watermark then
			watermark.Visible = config.UI.Watermark
		end
	end)

	watermark.Visible = config.UI.Watermark
end

-- Standalone, draggable window listing every bound key. Each row is a live
-- keybind control, so you can rebind straight from here. Toggled by the
-- "Keybind Panel" switch under Settings > Interface.
local function buildKeybindPanel(config)
	layoutOrder = 0

	keybindPanel = newInstance("Frame", {
		Parent = gui,
		Size = UDim2.fromOffset(230, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromOffset(680, 100),
		BackgroundColor3 = COLORS.bg,
		BorderSizePixel = 0,
		Visible = false,
	})

	newInstance("UICorner", { Parent = keybindPanel, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = keybindPanel, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })
	newInstance("UIListLayout", {
		Parent = keybindPanel,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
	})
	newInstance("UIPadding", {
		Parent = keybindPanel,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	-- Title bar doubles as the drag handle.
	local bar = newInstance("Frame", {
		Parent = keybindPanel,
		LayoutOrder = 0,
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = bar, CornerRadius = UDim.new(0, 6) })

	newInstance("TextLabel", {
		Parent = bar,
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "Keybinds",
	})

	local dragging, dragStart, startPos
	bar.InputBegan:Connect(function(input)
		if isPointer(input) then
			dragging = true
			dragStart = input.Position
			startPos = keybindPanel.Position
		end
	end)

	table.insert(moveHandlers, function(input)
		if dragging and keybindPanel then
			local delta = input.Position - dragStart
			keybindPanel.Position = UDim2.new(
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

	makeKeybind(keybindPanel, "Menu", function()
		return config.UI.MenuKey
	end, function(key)
		config.UI.MenuKey = key
	end, function(key)
		return keyConflict(config, key, "menu")
	end)

	makeKeybind(keybindPanel, "Aimbot", function()
		return config.Camera.ToggleKey
	end, function(key)
		config.Camera.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "aimbot")
	end)

	makeKeybind(keybindPanel, "ESP", function()
		return config.ESP.ToggleKey
	end, function(key)
		config.ESP.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "esp")
	end)

	makeKeybind(keybindPanel, "FOV Circle", function()
		return config.Camera.FOVCircleKey
	end, function(key)
		config.Camera.FOVCircleKey = key
	end, function(key)
		return keyConflict(config, key, "fovcircle")
	end)

	makeKeybind(keybindPanel, "No Recoil", function()
		return config.NoRecoil.ToggleKey
	end, function(key)
		config.NoRecoil.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "norecoil")
	end)

	makeKeybind(keybindPanel, "No Spread", function()
		return config.NoSpread.ToggleKey
	end, function(key)
		config.NoSpread.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "nospread")
	end)

	makeKeybind(keybindPanel, "Triggerbot", function()
		return config.Triggerbot.ToggleKey
	end, function(key)
		config.Triggerbot.ToggleKey = key
	end, function(key)
		return keyConflict(config, key, "triggerbot")
	end)

	makeKeybind(keybindPanel, "Unload", function()
		return config.UI.UnloadKey
	end, function(key)
		config.UI.UnloadKey = key
	end, function(key)
		return keyConflict(config, key, "unload")
	end)

	-- Keeps the window in step with the config (e.g. after a Reset).
	table.insert(syncHandlers, function()
		if keybindPanel then
			keybindPanel.Visible = config.UI.KeybindPanel
		end
	end)

	keybindPanel.Visible = config.UI.KeybindPanel
end

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
			if not visible and mainWindow then
				mainWindow.Visible = false
			end
		end)
		tween:Play()
	end
end

-- onUnload: called by the Settings > Unload button (the controller passes its
-- own Stop, so the UI never needs a forward reference to the controller).
function UI:Init(config, onUnload)
	if gui then
		return
	end

	activeConfig = config
	onUnloadCallback = onUnload

	startInputRouter()

	gui = newInstance("ScreenGui", {
		Name = "VanityGeneralUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})

	local ok = pcall(function()
		gui.Parent = Utility.getGuiParent()
	end)
	if not ok or not gui.Parent then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	mainWindow = newInstance("CanvasGroup", {
		Parent = gui,
		Size = UDim2.fromOffset(580, 400),
		Position = UDim2.fromOffset(60, 80),
		BackgroundColor3 = COLORS.bg,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		Visible = false,
	})

	windowScale = newInstance("UIScale", { Parent = mainWindow, Scale = config.UI.Scale })
	newInstance("UICorner", { Parent = mainWindow, CornerRadius = UDim.new(0, 8) })
	newInstance("UIStroke", { Parent = mainWindow, Color = COLORS.accent, Thickness = 1, Transparency = 0.35 })

	-- Title bar spans the top; it's the drag handle.
	local titleBar = newInstance("Frame", {
		Parent = mainWindow,
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
	newInstance("Frame", { -- square off the lower edge of the rounded bar
		Parent = titleBar,
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.new(0, 0, 1, -12),
		BackgroundColor3 = COLORS.bar,
		BorderSizePixel = 0,
	})

	local dot = newInstance("Frame", {
		Parent = titleBar,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 12, 0.5, 0),
		Size = UDim2.fromOffset(8, 8),
		BackgroundColor3 = COLORS.accent,
		BorderSizePixel = 0,
		ZIndex = 2,
	})
	newInstance("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

	newInstance("TextLabel", {
		Parent = titleBar,
		Size = UDim2.new(1, -34, 1, 0),
		Position = UDim2.fromOffset(28, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = COLORS.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		-- RichText so ".dev" picks up the accent colour.
		RichText = true,
		Text = 'Vanity<font color="#843EBE">.dev</font> General'
			.. '<font color="#8A7CA0">   ·   v0</font>',
		ZIndex = 2,
	})

	newInstance("TextLabel", { -- local player name on the right, like the reference
		Parent = titleBar,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.new(0, 140, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = COLORS.textSub,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = LocalPlayer and LocalPlayer.Name or "",
		ZIndex = 2,
	})

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

	-- Left sidebar: an inset panel of its own (rounded + outlined to match the
	-- content groups), tabs stacked at the top, Unload pinned to the bottom.
	local sidebar = newInstance("Frame", {
		Parent = mainWindow,
		Position = UDim2.fromOffset(10, 44),
		Size = UDim2.new(0, 120, 1, -54),
		BackgroundColor3 = COLORS.panel,
		BorderSizePixel = 0,
	})
	newInstance("UICorner", { Parent = sidebar, CornerRadius = UDim.new(0, 6) })
	newInstance("UIStroke", { Parent = sidebar, Color = COLORS.border, Thickness = 1, Transparency = 0.15 })
	newInstance("UIPadding", {
		Parent = sidebar,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	-- Tabs live in their own list so the Unload button can sit at the bottom.
	local tabList = newInstance("Frame", {
		Parent = sidebar,
		Size = UDim2.new(1, 0, 1, -40),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIListLayout", { Parent = tabList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })

	local unloadBtn = newInstance("TextButton", {
		Parent = sidebar,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = COLORS.row,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = COLORS.danger,
		Text = "Unload",
	})
	newInstance("UICorner", { Parent = unloadBtn, CornerRadius = UDim.new(0, 6) })
	local unloadStroke = newInstance("UIStroke", {
		Parent = unloadBtn,
		Color = COLORS.danger,
		Thickness = 1,
		Transparency = 0.55,
	})

	unloadBtn.MouseButton1Click:Connect(function()
		if onUnloadCallback then
			onUnloadCallback()
		end
	end)

	unloadBtn.MouseEnter:Connect(function()
		TweenService:Create(unloadBtn, ANIM, {
			BackgroundColor3 = COLORS.danger,
			TextColor3 = Color3.fromRGB(255, 255, 255),
		}):Play()
		TweenService:Create(unloadStroke, ANIM, { Transparency = 0 }):Play()
	end)

	unloadBtn.MouseLeave:Connect(function()
		TweenService:Create(unloadBtn, ANIM, {
			BackgroundColor3 = COLORS.row,
			TextColor3 = COLORS.danger,
		}):Play()
		TweenService:Create(unloadStroke, ANIM, { Transparency = 0.55 }):Play()
	end)

	-- Right content area: one scrolling panel per tab, layered and toggled.
	-- Starts after the inset sidebar (10 margin + 120 wide + 10 gutter).
	local content = newInstance("Frame", {
		Parent = mainWindow,
		Position = UDim2.fromOffset(140, 44),
		Size = UDim2.new(1, -150, 1, -54),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	newInstance("UIPadding", {
		Parent = content,
		PaddingRight = UDim.new(0, 4),
	})

	local tabs = { "Combat", "Visual", "Movement", "Settings" }
	local tabFrames = {}

	for i, tabName in ipairs(tabs) do
		local isActive = currentTab == tabName

		local tabBtn = newInstance("TextButton", {
			Parent = tabList,
			LayoutOrder = i,
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = COLORS.rowHover,
			BackgroundTransparency = isActive and 0 or 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = isActive and COLORS.text or COLORS.textSub,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = "    " .. tabName,
		})

		newInstance("UICorner", { Parent = tabBtn, CornerRadius = UDim.new(0, 6) })

		local stripe = newInstance("Frame", {
			Parent = tabBtn,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 5, 0.5, 0),
			Size = UDim2.fromOffset(3, 16),
			BackgroundColor3 = COLORS.accent,
			BorderSizePixel = 0,
			Visible = isActive,
			ZIndex = 2,
		})
		newInstance("UICorner", { Parent = stripe, CornerRadius = UDim.new(1, 0) })

		-- Fixed-height scroll panel + AutomaticCanvasSize = reliable vertical scroll.
		-- Plain container; the sub-tab host (makeSubTabHost) fills it with a
		-- sub-tab bar plus one scrolling two-column panel per sub-tab.
		local tabFrame = newInstance("Frame", {
			Parent = content,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Visible = isActive,
		})

		tabFrames[tabName] = { btn = tabBtn, frame = tabFrame, stripe = stripe }

		tabBtn.MouseButton1Click:Connect(function()
			currentTab = tabName
			for name, tab in pairs(tabFrames) do
				local active = name == tabName
				tab.frame.Visible = active
				tab.stripe.Visible = active
				TweenService:Create(tab.btn, ANIM, {
					BackgroundTransparency = active and 0 or 1,
					TextColor3 = active and COLORS.text or COLORS.textSub,
				}):Play()
			end
		end)

		tabBtn.MouseEnter:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, ANIM, { BackgroundTransparency = 0.6 }):Play()
			end
		end)

		tabBtn.MouseLeave:Connect(function()
			if currentTab ~= tabName then
				TweenService:Create(tabBtn, ANIM, { BackgroundTransparency = 1 }):Play()
			end
		end)
	end

	buildCameraTab(tabFrames["Combat"].frame, config)
	buildESPTab(tabFrames["Visual"].frame, config)
	buildMovementTab(tabFrames["Movement"].frame, config)
	buildSettingsTab(tabFrames["Settings"].frame, config)
	buildKeybindPanel(config)
	buildTargetPanel(config)
	buildFpsPanel(config)
	buildWatermark(config)

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

-- Called every frame by the controller. Stays visible whenever the option is on,
-- showing "UnKnown" when nobody is in view.
function UI:SetCurrentTarget(name)
	if not targetPanel then
		return
	end

	if targetPanel.Visible ~= targetDisplayOn then
		targetPanel.Visible = targetDisplayOn
	end
	if not targetDisplayOn or not targetPanelLabel then
		return
	end

	local shown, colour
	if name and name ~= "" and name ~= "None" then
		shown, colour = name, "#843EBE"
	else
		shown, colour = "UnKnown", "#8A7CA0" -- muted, so it reads as "nobody"
	end

	local text = 'Target: <font color="' .. colour .. '">' .. shown .. "</font>"
	if targetPanelLabel.Text ~= text then
		targetPanelLabel.Text = text
	end
end

-- Refreshes the fps readout. No-ops when the counter is off or not built.
function UI:UpdateFPS(fps)
	if not fpsLabel or not fpsPanel or not fpsPanel.Visible then
		return
	end
	local text = string.format('<font color="#843EBE">%d</font> fps', fps or 0)
	if fpsLabel.Text ~= text then
		fpsLabel.Text = text
	end
end

-- Points the watermark at an uploaded image. Accepts a bare id,
-- "rbxassetid://123", or a number; "" (or nil) clears it.
function UI:SetWatermarkImage(id)
	if not watermark then
		return
	end

	local digits = tostring(id or ""):match("%d+")
	watermark.Image = digits and ("rbxassetid://" .. digits) or ""
end

function UI:SyncControls()
	for _, fn in ipairs(syncHandlers) do
		fn()
	end
end

function UI:IsCapturingKey()
	return capturingKey
end

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
	activeDropdown = nil
	targetPanel, targetPanelLabel = nil, nil
	targetDisplayOn = false
	keybindPanel = nil -- destroyed with the ScreenGui below
	watermark = nil
	fpsPanel, fpsLabel = nil, nil
	windowScale = nil

	if gui then
		gui:Destroy()
		gui = nil
		mainWindow = nil
	end
	visible = false
end

return UI
