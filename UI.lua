--[[
	NovaUI v2.0.0
	A standalone, dependency-free UI library for Roblox experiences.
	
	NEW in v2.0:
	- Fixed: Paragraph now properly wraps text with AutomaticSize
	- Added: Built-in configuration save/load system
	- Added: Window flags persistent storage
	- Added: Improved responsive layout

	Install:
		Place this file as a ModuleScript (e.g. ReplaceableGui.NovaUI) and require it
		from a LocalScript:

			local NovaUI = require(path.to.NovaUI)
			local Window = NovaUI:CreateWindow({ Title = "My Game" })

	No external services (except HttpService for JSON), no loadstring, pure Luau.
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// ================= UTILITIES ================= //

local function Create(className, properties, children)
	local inst = Instance.new(className)
	for prop, value in pairs(properties or {}) do
		inst[prop] = value
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	return inst
end

-- TweenInfo caching
local _tweenInfoCache = {}
local function Tween(instance, goal, duration, style, direction)
	duration = duration or 0.22
	style = style or Enum.EasingStyle.Quint
	direction = direction or Enum.EasingDirection.Out
	local key = duration .. "|" .. style.Name .. "|" .. direction.Name
	local info = _tweenInfoCache[key]
	if not info then
		info = TweenInfo.new(duration, style, direction)
		_tweenInfoCache[key] = info
	end
	local tw = TweenService:Create(instance, info, goal)
	tw:Play()
	return tw
end

local function Lighten(color, amount)
	amount = amount or 0.06
	local h, s, v = color:ToHSV()
	return Color3.fromHSV(h, s, math.clamp(v + amount, 0, 1))
end

local function Hover(instance, baseColor, hoverColor)
	instance.MouseEnter:Connect(function() Tween(instance, { BackgroundColor3 = hoverColor }, 0.12) end)
	instance.MouseLeave:Connect(function() Tween(instance, { BackgroundColor3 = baseColor }, 0.15) end)
end

local function AddTopHighlight(frame)
	Create("Frame", {
		Name = "TopHighlight",
		Size = UDim2.new(1, -16, 0, 1),
		Position = UDim2.new(0, 8, 0, 0),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 0.94,
		BorderSizePixel = 0,
		Parent = frame,
	})
end

local function AttachTooltip(parent, theme, text)
	if not text or text == "" then return end

	local badge = Create("TextLabel", {
		Text = "i",
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextColor3 = theme.SubText,
		BackgroundColor3 = theme.Background,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		ZIndex = 5,
		Parent = parent,
	}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

	local tooltip = Create("TextLabel", {
		Text = text,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = theme.Text,
		BackgroundColor3 = theme.Elevated,
		TextWrapped = true,
		Visible = false,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(0, 200, 0, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 0, -6),
		ZIndex = 10,
		Parent = badge,
	}, {
		Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
		Create("UIStroke", { Color = theme.Stroke, Thickness = 1 }),
		Create("UIPadding", {
			PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
			PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6),
		}),
	})

	badge.MouseEnter:Connect(function() tooltip.Visible = true end)
	badge.MouseLeave:Connect(function() tooltip.Visible = false end)
end

local function MakeDraggable(handle, target, track)
	track = track or function(c) return c end
	local dragging, dragInput, dragStart, startPos

	track(handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end))

	track(handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end))

	track(UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			target.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end))
end

--// ================= CONFIG SYSTEM ================= //

local ConfigManager = {}

function ConfigManager:new(fileName)
	local self = setmetatable({}, { __index = ConfigManager })
	self.FileName = fileName or "NovaUI_Config"
	self.Data = {}
	return self
end

function ConfigManager:Load()
	local success, data = pcall(function()
		local fileContent = readfile(self.FileName .. ".json")
		return HttpService:JSONDecode(fileContent)
	end)
	if success and data then
		self.Data = data
		return true
	end
	self.Data = {}
	return false
end

function ConfigManager:Save()
	local success = pcall(function()
		local jsonData = HttpService:JSONEncode(self.Data)
		writefile(self.FileName .. ".json", jsonData)
	end)
	return success
end

function ConfigManager:Set(key, value)
	self.Data[key] = value
	self:Save()
end

function ConfigManager:Get(key, defaultValue)
	return self.Data[key] or defaultValue
end

function ConfigManager:Clear()
	self.Data = {}
	self:Save()
end

--// ================= THEMES ================= //

local Themes = {
	Dark = {
		Background   = Color3.fromRGB(24, 26, 32),
		Secondary    = Color3.fromRGB(31, 34, 41),
		Elevated     = Color3.fromRGB(38, 41, 49),
		Accent       = Color3.fromRGB(242, 169, 59),
		Text         = Color3.fromRGB(235, 236, 240),
		SubText      = Color3.fromRGB(150, 154, 163),
		Stroke       = Color3.fromRGB(52, 56, 65),
		Success      = Color3.fromRGB(90, 200, 130),
		Danger       = Color3.fromRGB(230, 95, 90),
	},
	Light = {
		Background   = Color3.fromRGB(246, 247, 249),
		Secondary    = Color3.fromRGB(255, 255, 255),
		Elevated     = Color3.fromRGB(237, 238, 241),
		Accent       = Color3.fromRGB(200, 120, 30),
		Text         = Color3.fromRGB(28, 30, 34),
		SubText      = Color3.fromRGB(100, 104, 112),
		Stroke       = Color3.fromRGB(220, 222, 227),
		Success      = Color3.fromRGB(45, 150, 90),
		Danger       = Color3.fromRGB(200, 60, 55),
	},
	Ocean = {
		Background   = Color3.fromRGB(16, 24, 32),
		Secondary    = Color3.fromRGB(21, 32, 42),
		Elevated     = Color3.fromRGB(28, 42, 54),
		Accent       = Color3.fromRGB(76, 175, 210),
		Text         = Color3.fromRGB(230, 238, 242),
		SubText      = Color3.fromRGB(140, 160, 172),
		Stroke       = Color3.fromRGB(42, 58, 70),
		Success      = Color3.fromRGB(80, 195, 160),
		Danger       = Color3.fromRGB(224, 100, 100),
	},
	Amethyst = {
		Background   = Color3.fromRGB(24, 20, 32),
		Secondary    = Color3.fromRGB(31, 26, 41),
		Elevated     = Color3.fromRGB(40, 33, 52),
		Accent       = Color3.fromRGB(170, 130, 235),
		Text         = Color3.fromRGB(236, 232, 242),
		SubText      = Color3.fromRGB(160, 150, 172),
		Stroke       = Color3.fromRGB(56, 47, 68),
		Success      = Color3.fromRGB(110, 200, 140),
		Danger       = Color3.fromRGB(230, 100, 120),
	},
	Emerald = {
		Background   = Color3.fromRGB(16, 26, 22),
		Secondary    = Color3.fromRGB(21, 34, 29),
		Elevated     = Color3.fromRGB(28, 44, 38),
		Accent       = Color3.fromRGB(90, 200, 140),
		Text         = Color3.fromRGB(230, 240, 235),
		SubText      = Color3.fromRGB(140, 168, 156),
		Stroke       = Color3.fromRGB(40, 60, 52),
		Success      = Color3.fromRGB(110, 210, 150),
		Danger       = Color3.fromRGB(224, 110, 100),
	},
}

--// ================= LIBRARY ================= //

local NovaUI = {}
NovaUI.__index = NovaUI
NovaUI.Flags = {}
NovaUI.Windows = {}
NovaUI.ConfigManager = ConfigManager

function NovaUI:CreateWindow(config)
	config = config or {}
	local theme
	if typeof(config.Theme) == "table" then
		theme = config.Theme
	else
		theme = Themes[config.Theme] or Themes.Dark
	end
	local title = config.Title or "NovaUI"
	local subtitle = config.Subtitle or ""
	local size = config.Size or UDim2.fromOffset(560, 380)
	local toggleKey = config.ToggleKey or Enum.KeyCode.RightControl

	-- Initialize config manager
	local configManager = ConfigManager:new(title)
	configManager:Load()

	local _connections = {}
	local function track(conn)
		table.insert(_connections, conn)
		return conn
	end

	local activeDragMove = nil
	local activeDragEnd = nil
	local function beginDrag(onMove, onEnd)
		activeDragMove = onMove
		activeDragEnd = onEnd
	end
	track(UserInputService.InputChanged:Connect(function(input)
		if activeDragMove and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			activeDragMove(input)
		end
	end))
	track(UserInputService.InputEnded:Connect(function(input)
		if activeDragEnd and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			local fn = activeDragEnd
			activeDragMove = nil
			activeDragEnd = nil
			fn(input)
		end
	end))

	local ScreenGui = Create("ScreenGui", {
		Name = "NovaUI_" .. title:gsub("%s+", ""),
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 100,
		Parent = PlayerGui,
	})

	Create("Frame", {
		Name = "Shadow",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 6),
		Size = UDim2.new(0, size.X.Offset + 24, 0, size.Y.Offset + 24),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		ZIndex = 0,
		Parent = ScreenGui,
	}, { Create("UICorner", { CornerRadius = UDim.new(0, 24) }) })

	local Main = Create("Frame", {
		Name = "Main",
		Size = size,
		Position = UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2),
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = ScreenGui,
	}, {
		Create("UICorner", { CornerRadius = UDim.new(0, 16) }),
		Create("UIStroke", { Color = theme.Stroke, Thickness = 1 }),
	})

	-- Entrance animation
	do
		local finalSize = size
		Main.Size = UDim2.new(0, finalSize.X.Offset * 0.92, 0, finalSize.Y.Offset * 0.92)
		local shadow = ScreenGui:FindFirstChild("Shadow")
		Main.BackgroundTransparency = 1
		for _, s in ipairs(Main:GetChildren()) do
			if s:IsA("UIStroke") then s.Transparency = 1 end
		end
		if shadow then shadow.BackgroundTransparency = 1 end
		Tween(Main, { Size = finalSize, BackgroundTransparency = 0 }, 0.28)
		if shadow then Tween(shadow, { BackgroundTransparency = 0.55 }, 0.35) end
		for _, s in ipairs(Main:GetChildren()) do
			if s:IsA("UIStroke") then Tween(s, { Transparency = 0 }, 0.3) end
		end
	end

	-- Top bar
	local TopBar = Create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = theme.Secondary,
		BorderSizePixel = 0,
		Parent = Main,
	}, {
		Create("UICorner", { CornerRadius = UDim.new(0, 16) }),
	})
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 16),
		Position = UDim2.new(0, 0, 1, -16),
		BackgroundColor3 = theme.Secondary,
		BorderSizePixel = 0,
		Parent = TopBar,
	})

	Create("TextLabel", {
		Name = "Title",
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 5),
		Size = UDim2.new(1, -80, 0, 18),
		Parent = TopBar,
	})

	Create("TextLabel", {
		Name = "Subtitle",
		Text = subtitle,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = theme.SubText,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 23),
		Size = UDim2.new(1, -80, 0, 16),
		Parent = TopBar,
	})

	local CloseBtn = Create("TextButton", {
		Name = "Close",
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = theme.SubText,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 30, 0, 30),
		Position = UDim2.new(1, -38, 0, 7),
		Parent = TopBar,
	}, { Create("UICorner", { CornerRadius = UDim.new(0, 8) }) })
	CloseBtn.MouseButton1Click:Connect(function()
		local shadow = ScreenGui:FindFirstChild("Shadow")
		Tween(Main, { Size = UDim2.fromOffset(size.X.Offset, 0), BackgroundTransparency = 1 }, 0.18)
		if shadow then Tween(shadow, { BackgroundTransparency = 1 }, 0.18) end
		task.wait(0.18)
		ScreenGui.Enabled = false
	end)
	CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, { TextColor3 = theme.Danger, BackgroundColor3 = theme.Elevated, BackgroundTransparency = 0 }, 0.12) end)
	CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, { TextColor3 = theme.SubText, BackgroundTransparency = 1 }, 0.12) end)

	local minimized = false
	local expandedHeight = size.Y.Offset
	local expandedWidth = size.X.Offset
	local MinimizeBtn = Create("TextButton", {
		Name = "Minimize",
		Text = "–",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = theme.SubText,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 30, 0, 30),
		Position = UDim2.new(1, -72, 0, 7),
		Parent = TopBar,
	}, { Create("UICorner", { CornerRadius = UDim.new(0, 8) }) })
	MinimizeBtn.MouseEnter:Connect(function() Tween(MinimizeBtn, { TextColor3 = theme.Text, BackgroundColor3 = theme.Elevated, BackgroundTransparency = 0 }, 0.12) end)
	MinimizeBtn.MouseLeave:Connect(function() Tween(MinimizeBtn, { TextColor3 = theme.SubText, BackgroundTransparency = 1 }, 0.12) end)
	MinimizeBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		MinimizeBtn.Text = minimized and "+" or "–"
		local shadow = ScreenGui:FindFirstChild("Shadow")
		if minimized then
			expandedHeight = Main.Size.Y.Offset
			expandedWidth = Main.Size.X.Offset
		end
		local targetHeight = minimized and 44 or expandedHeight
		Tween(Main, { Size = UDim2.new(0, expandedWidth, 0, targetHeight) }, 0.22)
		if shadow then
			Tween(shadow, { Size = UDim2.new(0, expandedWidth + 24, 0, targetHeight + 24) }, 0.22)
		end
		local resizeHandle = Main:FindFirstChild("ResizeHandle")
		if resizeHandle then resizeHandle.Visible = not minimized end
	end)
	MakeDraggable(TopBar, Main, track)

	-- Resize handle (bottom-right corner)
	local ResizeHandle = Create("Frame", {
		Name = "ResizeHandle",
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -4, 1, -4),
		Size = UDim2.new(0, 18, 0, 18),
		BackgroundTransparency = 1,
		Parent = Main,
	})
	for i = 1, 3 do
		Create("Frame", {
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -2, 1, -2 - (i - 1) * 5),
			Size = UDim2.new(0, 10 - (i - 1) * 3, 0, 2),
			Rotation = -45,
			BackgroundColor3 = theme.Stroke,
			BorderSizePixel = 0,
			Parent = ResizeHandle,
		})
	end

	do
		local startInputPos, startSize
		local minSize = Vector2.new(380, 260)

		track(ResizeHandle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				startInputPos = input.Position
				startSize = Main.Size
				beginDrag(function(moveInput)
					local delta = moveInput.Position - startInputPos
					local newW = math.max(minSize.X, startSize.X.Offset + delta.X)
					local newH = math.max(minSize.Y, startSize.Y.Offset + delta.Y)
					Main.Size = UDim2.new(0, newW, 0, newH)
					local shadow = ScreenGui:FindFirstChild("Shadow")
					if shadow then shadow.Size = UDim2.new(0, newW + 24, 0, newH + 24) end
				end, function() end)
			end
		end))
	end

	-- Tab rail (left)
	local TabRail = Create("Frame", {
		Name = "TabRail",
		Size = UDim2.new(0, 140, 1, -44),
		Position = UDim2.new(0, 0, 0, 44),
		BackgroundColor3 = theme.Secondary,
		BorderSizePixel = 0,
		Parent = Main,
	})
	local TabList = Create("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = Create("Frame", {
			Name = "TabListHolder",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -16, 1, -16),
			Position = UDim2.new(0, 8, 0, 8),
			Parent = TabRail,
		}),
	})
	local TabListHolder = TabList.Parent

	-- Page container (right)
	local PageContainer = Create("Frame", {
		Name = "PageContainer",
		Size = UDim2.new(1, -140, 1, -44),
		Position = UDim2.new(0, 140, 0, 44),
		BackgroundTransparency = 1,
		Parent = Main,
	})

	-- Notification stack (top-right of screen)
	local NotifyHolder = Create("Frame", {
		Name = "Notifications",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -16, 0, 16),
		Size = UDim2.new(0, 280, 1, -32),
		BackgroundTransparency = 1,
		Parent = ScreenGui,
	})
	Create("UIListLayout", {
		Padding = UDim.new(0, 8),
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = NotifyHolder,
	})

	-- Toggle-visibility keybind
	track(UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == toggleKey then
			ScreenGui.Enabled = not ScreenGui.Enabled
		end
	end))

	local Window = { 
		ScreenGui = ScreenGui, Main = Main, Theme = theme, _tabs = {}, _firstTab = nil, _connections = _connections,
		ConfigManager = configManager
	}
	setmetatable(Window, { __index = NovaUI })

	function Window:Destroy()
		for _, conn in ipairs(self._connections) do
			if conn.Connected then conn:Disconnect() end
		end
		table.clear(self._connections)
		if self.ScreenGui then self.ScreenGui:Destroy() end
		for i, w in ipairs(NovaUI.Windows) do
			if w == self then table.remove(NovaUI.Windows, i); break end
		end
	end

	function Window:CreateTab(name, icon)
		local Page = Create("ScrollingFrame", {
			Name = name,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -24, 1, -24),
			Position = UDim2.new(0, 12, 0, 12),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = theme.Accent,
			BorderSizePixel = 0,
			Visible = false,
			Parent = PageContainer,
		})
		Create("UIListLayout", {
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = Page,
		})

		local hasIcon = typeof(icon) == "string" and icon ~= ""
		local TabButton = Create("TextButton", {
			Name = name,
			Text = name,
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
			TextColor3 = theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundColor3 = theme.Elevated,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 32),
			Parent = TabListHolder,
		}, {
			Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
			Create("UIPadding", { PaddingLeft = UDim.new(0, hasIcon and 34 or 14) }),
		})

		-- Accent indicator that grows in on the left edge of the selected tab
		local indicator = Create("Frame", {
			Name = "Indicator",
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.new(0, 3, 0, 0),
			BackgroundColor3 = theme.Accent,
			BorderSizePixel = 0,
			Parent = TabButton,
		}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

		if hasIcon then
			Create("ImageLabel", {
				Image = icon,
				BackgroundTransparency = 1,
				ImageColor3 = theme.SubText,
				Position = UDim2.new(0, 8, 0.5, -8),
				Size = UDim2.new(0, 16, 0, 16),
				Parent = TabButton,
			})
		end

		local Tab = { Page = Page, Button = TabButton, Selected = false }

		local function selectTab()
			for _, t in pairs(Window._tabs) do
				t.Page.Visible = false
				t.Selected = false
				Tween(t.Button, { BackgroundTransparency = 1, TextColor3 = theme.SubText }, 0.15)
				local ind = t.Button:FindFirstChild("Indicator")
				if ind then Tween(ind, { Size = UDim2.new(0, 3, 0, 0) }, 0.15) end
			end
			Page.Visible = true
			Tab.Selected = true
			Tween(TabButton, { BackgroundTransparency = 0.4, BackgroundColor3 = theme.Elevated, TextColor3 = theme.Text }, 0.15)
			Tween(indicator, { Size = UDim2.new(0, 3, 0, 18) }, 0.18)
		end

		TabButton.MouseButton1Click:Connect(selectTab)
		TabButton.MouseEnter:Connect(function()
			if not Tab.Selected then Tween(TabButton, { BackgroundTransparency = 0.6, BackgroundColor3 = theme.Elevated }, 0.12) end
		end)
		TabButton.MouseLeave:Connect(function()
			if not Tab.Selected then Tween(TabButton, { BackgroundTransparency = 1 }, 0.15) end
		end)

		table.insert(Window._tabs, Tab)
		if not Window._firstTab then
			Window._firstTab = Tab
			selectTab()
		end

		--// ---------- Components ---------- //

		function Tab:CreateSection(text)
			local holder = Create("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 26),
				Parent = Page,
			})
			Create("TextLabel", {
				Text = text,
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				TextColor3 = theme.SubText,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 18),
				Parent = holder,
			})
			Create("Frame", {
				Position = UDim2.new(0, 0, 1, -2),
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = theme.Stroke,
				BorderSizePixel = 0,
				Parent = holder,
			})
		end

		function Tab:CreateLabel(text)
			Create("TextLabel", {
				Text = text,
				Font = Enum.Font.Gotham,
				TextSize = 13,
				TextColor3 = theme.Text,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				Parent = Page,
			})
		end

		-- FIXED: Paragraph now properly uses TextWrapped + AutomaticSize
		function Tab:CreateParagraph(opts)
			opts = opts or {}
			local holder = Create("Frame", {
				BackgroundColor3 = theme.Elevated,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				Parent = Page,
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
				Create("UIPadding", {
					PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14),
					PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),
				}),
				Create("UIListLayout", { 
					Padding = UDim.new(0, 4), 
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Vertical,
				}),
			})
			AddTopHighlight(holder)

			if opts.Title then
				Create("TextLabel", {
					Text = opts.Title,
					Font = Enum.Font.GothamBold,
					TextSize = 13,
					TextColor3 = theme.Text,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.new(1, 0, 0, 0),
					Parent = holder,
				})
			end

			Create("TextLabel", {
				Text = opts.Content or "",
				Font = Enum.Font.Gotham,
				TextSize = 12.5,
				TextColor3 = theme.SubText,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				Parent = holder,
			})
		end

		function Tab:CreateDivider()
			Create("Frame", {
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = theme.Stroke,
				BorderSizePixel = 0,
				Parent = Page,
			})
		end

		function Tab:CreateButton(opts)
			opts = opts or {}
			local btn = Create("TextButton", {
				Text = opts.Name or "Button",
				Font = Enum.Font.GothamMedium,
				TextSize = 13,
				TextColor3 = theme.Text,
				BackgroundColor3 = theme.Elevated,
				Size = UDim2.new(1, 0, 0, 36),
				Parent = Page,
			}, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })
			AddTopHighlight(btn)

			Hover(btn, theme.Elevated, Lighten(theme.Elevated))
			AttachTooltip(btn, theme, opts.Info)
			btn.MouseButton1Click:Connect(function()
				Tween(btn, { BackgroundColor3 = theme.Accent }, 0.1)
				task.delay(0.1, function() Tween(btn, { BackgroundColor3 = theme.Elevated }, 0.2) end)
				if opts.Callback then task.spawn(opts.Callback) end
			end)
			return btn
		end

		function Tab:CreateToggle(opts)
			opts = opts or {}
			local state = opts.CurrentValue or false
			local flagKey = opts.Flag
			if flagKey and Window.ConfigManager:Get(flagKey) ~= nil then
				state = Window.ConfigManager:Get(flagKey)
			end

			local holder = Create("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundColor3 = theme.Elevated,
				Size = UDim2.new(1, 0, 0, 36),
				Parent = Page,
			}, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })
			AddTopHighlight(holder)
			Hover(holder, theme.Elevated, Lighten(theme.Elevated))

			Create("TextLabel", {
				Text = opts.Name or "Toggle",
				Font = Enum.Font.GothamMedium,
				TextSize = 13,
				TextColor3 = theme.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0, 0),
				Size = UDim2.new(1, -60, 1, 0),
				Parent = holder,
			})

			local track = Create("Frame", {
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -12, 0.5, 0),
				Size = UDim2.new(0, 38, 0, 20),
				BackgroundColor3 = state and theme.Accent or theme.Stroke,
				Parent = holder,
			}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

			local dot = Create("Frame", {
				Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
				AnchorPoint = Vector2.new(0, 0),
				Size = UDim2.new(0, 16, 0, 16),
				BackgroundColor3 = Color3.new(1, 1, 1),
				Parent = track,
			}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

			local function setState(new)
				state = new
				Tween(track, { BackgroundColor3 = state and theme.Accent or theme.Stroke }, 0.15)
				Tween(dot, { Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8) }, 0.15)
				if flagKey then
					NovaUI.Flags[flagKey] = state
					Window.ConfigManager:Set(flagKey, state)
				end
				if opts.Callback then task.spawn(opts.Callback, state) end
			end

			holder.MouseButton1Click:Connect(function() setState(not state) end)
			if flagKey then NovaUI.Flags[flagKey] = state end
			return { Set = setState, Get = function() return state end }
		end

		function Tab:CreateSlider(opts)
			opts = opts or {}
			local min = (opts.Range and opts.Range[1]) or 0
			local max = (opts.Range and opts.Range[2]) or 100
			local increment = opts.Increment or 1
			local value = math.clamp(opts.CurrentValue or min, min, max)
			local flagKey = opts.Flag
			if flagKey and Window.ConfigManager:Get(flagKey) then
				value = math.clamp(Window.ConfigManager:Get(flagKey), min, max)
			end

			local holder = Create("Frame", {
				BackgroundColor3 = theme.Elevated,
				Size = UDim2.new(1, 0, 0, 46),
				Parent = Page,
			}, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })
			AddTopHighlight(holder)

			Create("TextLabel", {
				Text = opts.Name or "Slider",
				Font = Enum.Font.GothamMedium,
				TextSize = 13,
				TextColor3 = theme.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0, 4),
				Size = UDim2.new(1, -24, 0, 16),
				Parent = holder,
			})

			local valueLabel = Create("TextLabel", {
				Text = tostring(value),
				Font = Enum.Font.Gotham,
				TextSize = 12,
				TextColor3 = theme.SubText,
				TextXAlignment = Enum.TextXAlignment.Right,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0, 4),
				Size = UDim2.new(1, -24, 0, 16),
				Parent = holder,
			})

			local bar = Create("Frame", {
				Position = UDim2.new(0, 12, 0, 30),
				Size = UDim2.new(1, -24, 0, 6),
				BackgroundColor3 = theme.Stroke,
				Parent = holder,
			}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

			local fill = Create("Frame", {
				Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
				BackgroundColor3 = theme.Accent,
				Parent = bar,
			}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

			local thumb = Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new((value - min) / (max - min), 0, 0.5, 0),
				Size = UDim2.new(0, 14, 0, 14),
				BackgroundColor3 = Color3.new(1, 1, 1),
				ZIndex = 2,
				Parent = bar,
			}, {
				Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
				Create("UIStroke", { Color = theme.Accent, Thickness = 2 }),
			})

			local function setFromAlpha(alpha)
				alpha = math.clamp(alpha, 0, 1)
				local raw = min + (max - min) * alpha
				raw = math.floor(raw / increment + 0.5) * increment
				raw = math.clamp(raw, min, max)
				if raw == value then return end
				value = raw
				valueLabel.Text = tostring(raw)
				local finalAlpha = (raw - min) / (max - min)
				Tween(fill, { Size = UDim2.new(finalAlpha, 0, 1, 0) }, 0.08)
				Tween(thumb, { Position = UDim2.new(finalAlpha, 0, 0.5, 0) }, 0.08)
				if flagKey then
					NovaUI.Flags[flagKey] = raw
					Window.ConfigManager:Set(flagKey, raw)
				end
				if opts.Callback then task.spawn(opts.Callback, raw) end
			end

			local function growThumb() Tween(thumb, { Size = UDim2.new(0, 18, 0, 18) }, 0.1) end
			local function shrinkThumb() Tween(thumb, { Size = UDim2.new(0, 14, 0, 14) }, 0.15) end

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					growThumb()
					local alpha = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
					setFromAlpha(alpha)
					beginDrag(function(moveInput)
						local a = (moveInput.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
						setFromAlpha(a)
					end, shrinkThumb)
				end
			end)

			if flagKey then NovaUI.Flags[flagKey] = value end
			return { Set = function(v) setFromAlpha((v - min) / (max - min)) end, Get = function() return value end }
		end

		function Tab:CreateDropdown(opts)
			opts = opts or {}
			local options = opts.Options or {}
			local multi = opts.MultiSelect == true
			local current = opts.CurrentOption or options[1]
			local selected = {}
			if multi then
				for _, v in ipairs(opts.CurrentOptions or {}) do selected[v] = true end
			end
			local open = false

			local holder = Create("Frame", {
				BackgroundColor3 = theme.Elevated,
				Size = UDim2.new(1, 0, 0, 36),
				ClipsDescendants = true,
				Parent = Page,
			}, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })
			AddTopHighlight(holder)

			local head = Create("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 36),
				Parent = holder,
			})
			head.MouseEnter:Connect(function() Tween(holder, { BackgroundColor3 = Lighten(theme.Elevated) }, 0.12) end)
			head.MouseLeave:Connect(function() Tween(holder, { BackgroundColor3 = theme.Elevated }, 0.15) end)

			Create("TextLabel", {
				Name = "Label",
				Text = opts.Name or "Dropdown",
				Font = Enum.Font.GothamMedium,
				TextSize = 13,
				TextColor3 = theme.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0, 0),
				Size = UDim2.new(0.5, 0, 0, 36),
				Parent = head,
			})

			local function multiLabelText()
				local count = 0
				for _ in pairs(selected) do count += 1 end
				if count == 0 then return "None" end
				if count == 1 then
					for v in pairs(selected) do return tostring(v) end
				end
				return count .. " selected"
			end

			local valueLabel = Create("TextLabel", {
				Text = multi and multiLabelText() or tostring(current),
				Font = Enum.Font.Gotham,
				TextSize = 13,
				TextColor3 = theme.SubText,
				TextXAlignment = Enum.TextXAlignment.Right,
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, -30, 0, 0),
				Size = UDim2.new(0.5, -20, 0, 36),
				Parent = head,
			})

			local chevron = Create("TextLabel", {
				Text = "▾",
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				TextColor3 = theme.SubText,
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -12, 0.5, 0),
				Size = UDim2.new(0, 14, 0, 14),
				Parent = head,
			})

			local listHolder = Create("Frame", {
				Position = UDim2.new(0, 0, 0, 36),
				Size = UDim2.new(1, 0, 0, 0),
				BackgroundTransparency = 1,
				Parent = holder,
			})
			Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = listHolder })

			local function rebuild()
				for _, c in ipairs(listHolder:GetChildren()) do
					if c:IsA("TextButton") then c:Destroy() end
				end
				for _, option in ipairs(options) do
					local optBtn = Create("TextButton", {
						Text = (multi and selected[option] and "✓  " or "") .. tostring(option),
						Font = Enum.Font.Gotham,
						TextSize = 12,
						TextColor3 = (multi and selected[option]) and theme.Accent or theme.SubText,
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 26),
						Parent = listHolder,
					}, { Create("UIPadding", { PaddingLeft = UDim.new(0, 4) }) })

					optBtn.MouseButton1Click:Connect(function()
						if multi then
							selected[option] = not selected[option] or nil
							valueLabel.Text = multiLabelText()
						else
							current = option
							valueLabel.Text = tostring(current)
							open = false
							listHolder.Size = UDim2.new(1, 0, 0, 0)
						end
						if opts.Flag then NovaUI.Flags[opts.Flag] = multi and selected or current end
						if opts.Callback then task.spawn(opts.Callback, multi and selected or current) end
					end)
				end
			end

			rebuild()

			head.MouseButton1Click:Connect(function()
				open = not open
				local targetHeight = open and (#options * 26) or 0
				Tween(listHolder, { Size = UDim2.new(1, 0, 0, targetHeight) }, 0.15)
				Tween(chevron, { Rotation = open and 180 or 0 }, 0.15)
			end)

			if opts.Flag then NovaUI.Flags[opts.Flag] = multi and selected or current end
			return { Set = function(v) current = v; valueLabel.Text = tostring(v) end, Get = function() return multi and selected or current end }
		end

		return Tab
	end

	table.insert(NovaUI.Windows, Window)
	return Window
end

return NovaUI
