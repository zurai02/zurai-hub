--[[
	NovaUI  —  Version 3.1.0
	A standalone, dependency-free UI library for Roblox experiences.

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	  CHANGELOG from 3.0.0 → 3.1.0
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	BUG FIXES
	  • CreateDropdown: multi-select logic bug fixed (`not x or nil` → proper nil/true toggle)
	  • CreateDropdown: clicking outside now closes the open dropdown
	  • CreateColorPicker: Set() now correctly updates R/G/B channel fill bars + value labels
	  • CreateKeybind: pressing Escape cancels listening; clicking elsewhere cancels too
	  • CreateProgress: local `track` no longer shadows the connection-tracking table
	  • CreateSpinner: Start() stores its connection correctly; no heartbeat leak
	  • MakeDraggable: connections are now properly tracked and cleaned up in Window:Destroy()
	  • Window maximize/minimize: Shadow position and size stay in sync
	  • PressFeedback: MouseLeave no longer fires scale-up while button is still pressed
	  • TopHighlight: ZIndex arithmetic fixed (number arg treated as number, not frame property)
	  • CreateAlert: icon no longer overlaps the padding boundary
	  • CreateTable: Clear() correctly identifies and removes only data rows
	  • Notification cap: oldest notification is now animated out before being destroyed

	QOL IMPROVEMENTS
	  • SetTheme() now broadcasts to a registered theme-listener list so components
	    can update their colors live (opt-in via Tab._themeListeners)
	  • Slider callback is debounced: fires on mouse-release and on meaningful change
	    (≥ increment), not on every pixel of drag
	  • Tooltip: added ClipsDescendants guard and flips above/below based on screen position
	  • CreateDropdown: Refresh() keeps currently selected values where still valid
	  • CreateConfigManager: export box is shown in a more logical position (after load section)
	  • Window:Destroy() calls cleanup on all tabs' listeners too
	  • CreateAccordion sections remember open state across Refresh calls

	NEW COMPONENTS
	  • Tab:CreateRadioGroup(opts)      — single-select group of labelled options
	  • Tab:CreateChipGroup(opts)       — multi-select chip / tag row
	  • Tab:CreateNumberInput(opts)     — numeric spinbox with +/− buttons and clamping
	  • Tab:CreateAccordion(opts)       — collapsible section with animated open/close
	  • Tab:CreateStatusIndicator(opts) — colored dot + label (live-updatable)
	  • Tab:CreateTabGroup(opts)        — horizontal inline tab switcher inside a page
	  • Tab:CreateSkeleton(opts)        — shimmer loading placeholder
	  • Tab:CreateDividerAction(opts)   — divider line with a right-side action button

	Usage unchanged from 3.0.0:
		local NovaUI = require(path.to.NovaUI)
		local win    = NovaUI:CreateWindow({ Title="My Game", Theme="Dark", … })
		local tab    = win:CreateTab("Main", "rbxassetid://…")
		tab:CreateButton({ Name="Click me", Callback=function() end })

	No external services · no loadstring · pure Luau · MIT-style license
]]

--// ─────────────────────────────── SERVICES ──────────────────────────────── //

local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local HttpService       = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

--// ─────────────────────────────── UTILITIES ──────────────────────────────── //

local function Create(className, props, children)
	local inst = Instance.new(className)
	for k, v in pairs(props or {}) do inst[k] = v end
	for _, child in ipairs(children or {}) do child.Parent = inst end
	return inst
end

-- Cached TweenInfos
local _tweenCache = {}
local function Tween(inst, goal, dur, style, dir)
	dur   = dur   or 0.22
	style = style or Enum.EasingStyle.Quint
	dir   = dir   or Enum.EasingDirection.Out
	local key = tostring(dur).."|"..style.Name.."|"..dir.Name
	if not _tweenCache[key] then
		_tweenCache[key] = TweenInfo.new(dur, style, dir)
	end
	local tw = TweenService:Create(inst, _tweenCache[key], goal)
	tw:Play()
	return tw
end

-- Color helpers
local function Lighten(c, a)
	a = a or 0.07
	local h, s, v = c:ToHSV()
	return Color3.fromHSV(h, math.max(0, s - a*0.25), math.clamp(v+a, 0, 1))
end
local function Darken(c, a)
	a = a or 0.07
	local h, s, v = c:ToHSV()
	return Color3.fromHSV(h, math.min(1, s+a*0.15), math.clamp(v-a, 0, 1))
end
local function ColorToHex(c)
	return string.format("#%02X%02X%02X",
		math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5))
end
local function HexToColor(hex)
	hex = hex:gsub("^#","")
	if #hex~=6 then return Color3.new(1,1,1) end
	return Color3.fromRGB(
		tonumber(hex:sub(1,2),16) or 0,
		tonumber(hex:sub(3,4),16) or 0,
		tonumber(hex:sub(5,6),16) or 0)
end

local function Round(n, places)
	local f = 10^(places or 0)
	return math.floor(n*f+0.5)/f
end

local function Trim(s) return s:match("^%s*(.-)%s*$") end

-- FIX: track whether mouse button is held so MouseLeave doesn't prematurely scale up
local function HoverBg(inst, base, hover)
	inst.MouseEnter:Connect(function() Tween(inst,{BackgroundColor3=hover},0.10) end)
	inst.MouseLeave:Connect(function() Tween(inst,{BackgroundColor3=base},0.14) end)
end

-- FIX: TopHighlight accepts a plain number for zi now
local function TopHighlight(frame, zIndex)
	local z = (type(zIndex)=="number" and zIndex or (frame.ZIndex or 1)) + 1
	Create("Frame", {
		Name="TopHighlight",
		Size=UDim2.new(1,-20,0,1), Position=UDim2.new(0,10,0,0),
		BackgroundColor3=Color3.new(1,1,1), BackgroundTransparency=0.88,
		BorderSizePixel=0, ZIndex=z, Parent=frame,
	})
end

-- FIX: track held state so MouseLeave doesn't fire scale-up mid-press
local function PressFeedback(btn)
	local sc = Create("UIScale",{Scale=1, Parent=btn})
	local held = false
	btn.MouseButton1Down:Connect(function()
		held = true
		Tween(sc,{Scale=0.96},0.07,Enum.EasingStyle.Quad)
	end)
	local function release()
		if not held then return end
		held = false
		Tween(sc,{Scale=1},0.20,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
	end
	btn.MouseButton1Up:Connect(release)
	btn.MouseLeave:Connect(function()
		if not held then
			Tween(sc,{Scale=1},0.20,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
		end
	end)
end

local function Ripple(parent, clickPos, color)
	color = color or Color3.new(1,1,1)
	local abs = parent.AbsolutePosition
	local sz  = parent.AbsoluteSize
	local cx  = clickPos.X - abs.X
	local cy  = clickPos.Y - abs.Y
	local maxR = math.sqrt(sz.X^2+sz.Y^2)*1.2
	local circle = Create("Frame",{
		Name="Ripple", AnchorPoint=Vector2.new(0.5,0.5),
		Position=UDim2.new(0,cx,0,cy), Size=UDim2.new(0,4,0,4),
		BackgroundColor3=color, BackgroundTransparency=0.7,
		BorderSizePixel=0, ZIndex=(parent.ZIndex or 1)+5, Parent=parent,
	},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
	Tween(circle,{Size=UDim2.new(0,maxR*2,0,maxR*2),BackgroundTransparency=1},0.55,Enum.EasingStyle.Quint)
	task.delay(0.56,function() pcall(function() circle:Destroy() end) end)
end

-- FIX: Tooltip flips above if near screen bottom
local function Tooltip(parent, theme, text)
	if not text or text=="" then return end
	local badge = Create("TextLabel",{
		Text="?", Font=Enum.Font.GothamBold, TextSize=10,
		TextColor3=theme.SubText, BackgroundColor3=theme.Elevated,
		AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-10,0.5,0),
		Size=UDim2.new(0,17,0,17), ZIndex=8, Parent=parent,
	},{
		Create("UICorner",{CornerRadius=UDim.new(1,0)}),
		Create("UIStroke",{Color=theme.Stroke, Thickness=1}),
	})
	local tip = Create("Frame",{
		BackgroundColor3=theme.TooltipBg or theme.Elevated,
		Visible=false, AutomaticSize=Enum.AutomaticSize.Y,
		Size=UDim2.new(0,200,0,0),
		AnchorPoint=Vector2.new(0.5,1),
		Position=UDim2.new(0.5,0,0,-10),
		ZIndex=25, Parent=badge,
	},{
		Create("UICorner",{CornerRadius=UDim.new(0,9)}),
		Create("UIStroke",{Color=theme.Stroke, Thickness=1}),
		Create("UIPadding",{
			PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10),
			PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,8),
		}),
		Create("TextLabel",{
			Text=text, Font=Enum.Font.Gotham, TextSize=12,
			TextColor3=theme.Text, TextWrapped=true,
			TextXAlignment=Enum.TextXAlignment.Left,
			BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
			Size=UDim2.new(1,0,0,0), ZIndex=26,
		}),
	})
	badge.MouseEnter:Connect(function()
		-- Flip below if badge is in the upper third of screen
		local screenY = badge.AbsolutePosition.Y
		local vp = workspace.CurrentCamera.ViewportSize
		if screenY < vp.Y * 0.33 then
			tip.AnchorPoint = Vector2.new(0.5,0)
			tip.Position    = UDim2.new(0.5,0,1,10)
		else
			tip.AnchorPoint = Vector2.new(0.5,1)
			tip.Position    = UDim2.new(0.5,0,0,-10)
		end
		tip.Visible = true
	end)
	badge.MouseLeave:Connect(function() tip.Visible=false end)
end

-- FIX: MakeDraggable now takes a plain connections table instead of a trackFn
local function MakeDraggable(handle, target, conns)
	local dragging, dragInput, dragStart, startPos
	local function addConn(c) table.insert(conns,c) end

	addConn(handle.InputBegan:Connect(function(inp)
		if inp.UserInputType==Enum.UserInputType.MouseButton1 or
		   inp.UserInputType==Enum.UserInputType.Touch then
			dragging  = true
			dragStart = inp.Position
			startPos  = target.Position
			inp.Changed:Connect(function()
				if inp.UserInputState==Enum.UserInputState.End then dragging=false end
			end)
		end
	end))
	addConn(handle.InputChanged:Connect(function(inp)
		if inp.UserInputType==Enum.UserInputType.MouseMovement or
		   inp.UserInputType==Enum.UserInputType.Touch then
			dragInput = inp
		end
	end))
	addConn(UserInputService.InputChanged:Connect(function(inp)
		if inp==dragInput and dragging then
			local d = inp.Position - dragStart
			target.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset+d.X,
				startPos.Y.Scale, startPos.Y.Offset+d.Y)
		end
	end))
end

-- Simple debounce wrapper
local function Debounce(fn, interval)
	local last = 0
	return function(...)
		local now = tick()
		if now-last < interval then return end
		last = now
		fn(...)
	end
end

--// ─────────────────────────────── THEMES ────────────────────────────────── //

local Themes = {}

Themes.Dark = {
	Background   = Color3.fromRGB(13, 15, 20),
	Secondary    = Color3.fromRGB(20, 23, 30),
	Elevated     = Color3.fromRGB(28, 32, 42),
	ElevatedHover= Color3.fromRGB(34, 39, 51),
	Accent       = Color3.fromRGB(255, 182, 48),
	AccentLight  = Color3.fromRGB(255, 210, 105),
	AccentDark   = Color3.fromRGB(205, 140, 18),
	AccentBg     = Color3.fromRGB(42, 33, 10),
	Text         = Color3.fromRGB(238, 240, 248),
	SubText      = Color3.fromRGB(138, 144, 160),
	MutedText    = Color3.fromRGB(72, 77, 92),
	Stroke       = Color3.fromRGB(36, 41, 54),
	StrokeStrong = Color3.fromRGB(50, 57, 74),
	Success      = Color3.fromRGB(68, 215, 130),
	SuccessBg    = Color3.fromRGB(10, 36, 22),
	Danger       = Color3.fromRGB(242, 88, 84),
	DangerBg     = Color3.fromRGB(42, 10, 10),
	Warning      = Color3.fromRGB(255, 188, 48),
	WarningBg    = Color3.fromRGB(42, 34, 8),
	Info         = Color3.fromRGB(78, 160, 245),
	InfoBg       = Color3.fromRGB(10, 24, 46),
	TooltipBg    = Color3.fromRGB(24, 28, 38),
	Tooltip      = Color3.fromRGB(52, 60, 76),
}
Themes.Light = {
	Background   = Color3.fromRGB(246, 248, 252),
	Secondary    = Color3.fromRGB(255, 255, 255),
	Elevated     = Color3.fromRGB(237, 240, 246),
	ElevatedHover= Color3.fromRGB(228, 232, 240),
	Accent       = Color3.fromRGB(190, 105, 16),
	AccentLight  = Color3.fromRGB(215, 138, 48),
	AccentDark   = Color3.fromRGB(160, 82, 8),
	AccentBg     = Color3.fromRGB(255, 244, 220),
	Text         = Color3.fromRGB(16, 18, 26),
	SubText      = Color3.fromRGB(88, 95, 112),
	MutedText    = Color3.fromRGB(158, 165, 180),
	Stroke       = Color3.fromRGB(216, 220, 230),
	StrokeStrong = Color3.fromRGB(192, 197, 212),
	Success      = Color3.fromRGB(28, 158, 86),
	SuccessBg    = Color3.fromRGB(222, 248, 232),
	Danger       = Color3.fromRGB(208, 52, 48),
	DangerBg     = Color3.fromRGB(252, 228, 226),
	Warning      = Color3.fromRGB(178, 115, 8),
	WarningBg    = Color3.fromRGB(254, 246, 218),
	Info         = Color3.fromRGB(30, 115, 210),
	InfoBg       = Color3.fromRGB(220, 236, 255),
	TooltipBg    = Color3.fromRGB(255, 255, 255),
	Tooltip      = Color3.fromRGB(216, 220, 230),
}
Themes.Ocean = {
	Background   = Color3.fromRGB(8, 16, 28),
	Secondary    = Color3.fromRGB(12, 24, 40),
	Elevated     = Color3.fromRGB(16, 32, 52),
	ElevatedHover= Color3.fromRGB(20, 40, 65),
	Accent       = Color3.fromRGB(48, 194, 238),
	AccentLight  = Color3.fromRGB(100, 218, 252),
	AccentDark   = Color3.fromRGB(22, 152, 200),
	AccentBg     = Color3.fromRGB(6, 26, 44),
	Text         = Color3.fromRGB(222, 236, 248),
	SubText      = Color3.fromRGB(112, 152, 175),
	MutedText    = Color3.fromRGB(58, 90, 115),
	Stroke       = Color3.fromRGB(18, 44, 66),
	StrokeStrong = Color3.fromRGB(26, 58, 84),
	Success      = Color3.fromRGB(58, 215, 162),
	SuccessBg    = Color3.fromRGB(6, 34, 26),
	Danger       = Color3.fromRGB(232, 88, 88),
	DangerBg     = Color3.fromRGB(40, 10, 10),
	Warning      = Color3.fromRGB(242, 190, 50),
	WarningBg    = Color3.fromRGB(38, 30, 6),
	Info         = Color3.fromRGB(82, 170, 252),
	InfoBg       = Color3.fromRGB(8, 22, 48),
	TooltipBg    = Color3.fromRGB(16, 32, 52),
	Tooltip      = Color3.fromRGB(30, 58, 82),
}
Themes.Amethyst = {
	Background   = Color3.fromRGB(12, 10, 22),
	Secondary    = Color3.fromRGB(18, 15, 32),
	Elevated     = Color3.fromRGB(26, 22, 44),
	ElevatedHover= Color3.fromRGB(32, 28, 56),
	Accent       = Color3.fromRGB(178, 142, 255),
	AccentLight  = Color3.fromRGB(204, 176, 255),
	AccentDark   = Color3.fromRGB(148, 108, 228),
	AccentBg     = Color3.fromRGB(22, 14, 42),
	Text         = Color3.fromRGB(236, 232, 250),
	SubText      = Color3.fromRGB(144, 135, 172),
	MutedText    = Color3.fromRGB(78, 70, 108),
	Stroke       = Color3.fromRGB(36, 30, 58),
	StrokeStrong = Color3.fromRGB(50, 42, 78),
	Success      = Color3.fromRGB(98, 215, 145),
	SuccessBg    = Color3.fromRGB(10, 30, 20),
	Danger       = Color3.fromRGB(238, 94, 115),
	DangerBg     = Color3.fromRGB(40, 10, 16),
	Warning      = Color3.fromRGB(240, 186, 54),
	WarningBg    = Color3.fromRGB(40, 30, 6),
	Info         = Color3.fromRGB(108, 168, 252),
	InfoBg       = Color3.fromRGB(10, 20, 46),
	TooltipBg    = Color3.fromRGB(26, 22, 44),
	Tooltip      = Color3.fromRGB(48, 42, 74),
}
Themes.Emerald = {
	Background   = Color3.fromRGB(8, 16, 13),
	Secondary    = Color3.fromRGB(12, 24, 19),
	Elevated     = Color3.fromRGB(16, 34, 27),
	ElevatedHover= Color3.fromRGB(20, 44, 35),
	Accent       = Color3.fromRGB(62, 220, 148),
	AccentLight  = Color3.fromRGB(105, 238, 178),
	AccentDark   = Color3.fromRGB(36, 178, 112),
	AccentBg     = Color3.fromRGB(6, 28, 18),
	Text         = Color3.fromRGB(222, 240, 230),
	SubText      = Color3.fromRGB(108, 158, 132),
	MutedText    = Color3.fromRGB(54, 96, 74),
	Stroke       = Color3.fromRGB(18, 48, 36),
	StrokeStrong = Color3.fromRGB(26, 64, 48),
	Success      = Color3.fromRGB(92, 222, 152),
	SuccessBg    = Color3.fromRGB(6, 28, 16),
	Danger       = Color3.fromRGB(230, 95, 90),
	DangerBg     = Color3.fromRGB(40, 10, 10),
	Warning      = Color3.fromRGB(240, 186, 54),
	WarningBg    = Color3.fromRGB(36, 28, 6),
	Info         = Color3.fromRGB(78, 168, 252),
	InfoBg       = Color3.fromRGB(8, 22, 46),
	TooltipBg    = Color3.fromRGB(16, 34, 27),
	Tooltip      = Color3.fromRGB(28, 60, 46),
}
Themes.Neon = {
	Background   = Color3.fromRGB(6, 8, 14),
	Secondary    = Color3.fromRGB(10, 12, 20),
	Elevated     = Color3.fromRGB(14, 18, 28),
	ElevatedHover= Color3.fromRGB(18, 24, 38),
	Accent       = Color3.fromRGB(0, 240, 160),
	AccentLight  = Color3.fromRGB(80, 252, 200),
	AccentDark   = Color3.fromRGB(0, 185, 125),
	AccentBg     = Color3.fromRGB(0, 28, 18),
	Text         = Color3.fromRGB(228, 240, 234),
	SubText      = Color3.fromRGB(100, 140, 122),
	MutedText    = Color3.fromRGB(50, 80, 65),
	Stroke       = Color3.fromRGB(14, 38, 28),
	StrokeStrong = Color3.fromRGB(20, 52, 40),
	Success      = Color3.fromRGB(0, 240, 160),
	SuccessBg    = Color3.fromRGB(0, 28, 18),
	Danger       = Color3.fromRGB(240, 60, 100),
	DangerBg     = Color3.fromRGB(40, 6, 14),
	Warning      = Color3.fromRGB(240, 210, 40),
	WarningBg    = Color3.fromRGB(36, 30, 4),
	Info         = Color3.fromRGB(60, 180, 255),
	InfoBg       = Color3.fromRGB(6, 20, 46),
	TooltipBg    = Color3.fromRGB(12, 18, 28),
	Tooltip      = Color3.fromRGB(20, 52, 40),
}
Themes.Rose = {
	Background   = Color3.fromRGB(20, 10, 14),
	Secondary    = Color3.fromRGB(28, 14, 20),
	Elevated     = Color3.fromRGB(38, 20, 28),
	ElevatedHover= Color3.fromRGB(48, 26, 36),
	Accent       = Color3.fromRGB(252, 100, 148),
	AccentLight  = Color3.fromRGB(255, 148, 185),
	AccentDark   = Color3.fromRGB(210, 68, 112),
	AccentBg     = Color3.fromRGB(44, 10, 22),
	Text         = Color3.fromRGB(248, 232, 238),
	SubText      = Color3.fromRGB(170, 125, 145),
	MutedText    = Color3.fromRGB(100, 65, 82),
	Stroke       = Color3.fromRGB(54, 28, 40),
	StrokeStrong = Color3.fromRGB(72, 38, 54),
	Success      = Color3.fromRGB(88, 215, 138),
	SuccessBg    = Color3.fromRGB(10, 32, 20),
	Danger       = Color3.fromRGB(252, 80, 80),
	DangerBg     = Color3.fromRGB(46, 8, 8),
	Warning      = Color3.fromRGB(252, 190, 50),
	WarningBg    = Color3.fromRGB(44, 32, 6),
	Info         = Color3.fromRGB(110, 175, 252),
	InfoBg       = Color3.fromRGB(10, 22, 48),
	TooltipBg    = Color3.fromRGB(34, 18, 26),
	Tooltip      = Color3.fromRGB(60, 36, 50),
}
Themes.Slate = {
	Background   = Color3.fromRGB(14, 16, 22),
	Secondary    = Color3.fromRGB(20, 23, 32),
	Elevated     = Color3.fromRGB(28, 32, 44),
	ElevatedHover= Color3.fromRGB(34, 39, 55),
	Accent       = Color3.fromRGB(120, 145, 248),
	AccentLight  = Color3.fromRGB(158, 180, 255),
	AccentDark   = Color3.fromRGB(88, 112, 220),
	AccentBg     = Color3.fromRGB(14, 18, 48),
	Text         = Color3.fromRGB(232, 234, 246),
	SubText      = Color3.fromRGB(130, 138, 165),
	MutedText    = Color3.fromRGB(70, 76, 102),
	Stroke       = Color3.fromRGB(36, 42, 60),
	StrokeStrong = Color3.fromRGB(50, 58, 80),
	Success      = Color3.fromRGB(72, 210, 130),
	SuccessBg    = Color3.fromRGB(10, 34, 22),
	Danger       = Color3.fromRGB(240, 88, 84),
	DangerBg     = Color3.fromRGB(42, 10, 10),
	Warning      = Color3.fromRGB(246, 188, 50),
	WarningBg    = Color3.fromRGB(40, 32, 6),
	Info         = Color3.fromRGB(80, 160, 248),
	InfoBg       = Color3.fromRGB(10, 22, 48),
	TooltipBg    = Color3.fromRGB(22, 26, 40),
	Tooltip      = Color3.fromRGB(44, 52, 74),
}

local function FinalizeTheme(t)
	t.AccentLight   = t.AccentLight   or Lighten(t.Accent, 0.16)
	t.AccentDark    = t.AccentDark    or Darken(t.Accent,  0.12)
	t.AccentBg      = t.AccentBg      or Darken(t.Accent,  0.42)
	t.ElevatedHover = t.ElevatedHover or Lighten(t.Elevated, 0.06)
	t.StrokeStrong  = t.StrokeStrong  or Lighten(t.Stroke, 0.07)
	t.MutedText     = t.MutedText     or Darken(t.SubText, 0.12)
	t.SuccessBg     = t.SuccessBg     or Darken(t.Success, 0.40)
	t.DangerBg      = t.DangerBg      or Darken(t.Danger,  0.40)
	t.WarningBg     = t.WarningBg     or Darken(t.Warning, 0.40)
	t.Info          = t.Info          or Color3.fromRGB(78,160,245)
	t.InfoBg        = t.InfoBg        or Darken(t.Info,    0.40)
	t.TooltipBg     = t.TooltipBg     or t.Elevated
	t.Tooltip       = t.Tooltip       or t.StrokeStrong
	return t
end

for _, t in pairs(Themes) do FinalizeTheme(t) end

--// ──────────────────────────── LIBRARY ROOT ─────────────────────────────── //

local NovaUI          = {}
NovaUI.__index        = NovaUI
NovaUI.Flags          = {}
NovaUI.Windows        = {}
NovaUI.Version        = "3.1.0"
NovaUI._callbacks     = {}

function NovaUI:GetFlag(flag)   return NovaUI.Flags[flag] end
function NovaUI:SetFlag(flag, value)
	NovaUI.Flags[flag] = value
	if NovaUI._callbacks[flag] then
		for _, cb in ipairs(NovaUI._callbacks[flag]) do task.spawn(cb, value) end
	end
end
function NovaUI:OnFlagChanged(flag, callback)
	if not NovaUI._callbacks[flag] then NovaUI._callbacks[flag] = {} end
	table.insert(NovaUI._callbacks[flag], callback)
end
function NovaUI:ResetFlags()
	for flag in pairs(NovaUI.Flags) do
		NovaUI.Flags[flag] = nil
		if NovaUI._callbacks[flag] then
			for _, cb in ipairs(NovaUI._callbacks[flag]) do task.spawn(cb, nil) end
		end
	end
end

--// ─────────────────────────────── WINDOW ────────────────────────────────── //

function NovaUI:CreateWindow(config)
	config = config or {}

	local theme
	if typeof(config.Theme)=="table" then
		theme = FinalizeTheme(config.Theme)
	else
		theme = Themes[config.Theme] or Themes.Dark
	end

	local title     = config.Title     or "NovaUI"
	local subtitle  = config.Subtitle  or ""
	local size      = config.Size      or UDim2.fromOffset(600,420)
	local toggleKey = config.ToggleKey or Enum.KeyCode.RightControl
	local initPos   = config.Position  or UDim2.new(0.5,-size.X.Offset/2,0.5,-size.Y.Offset/2)

	-- Connection tracking table (replaces trackFn pattern)
	local _conns = {}
	local function track(c) table.insert(_conns,c); return c end

	-- Theme listener registry — components register here so SetTheme() reaches them
	local _themeListeners = {}
	local function onTheme(fn) table.insert(_themeListeners, fn) end

	-- Shared drag dispatcher
	local _dragMove, _dragEnd = nil, nil
	local function beginDrag(onMove, onEnd)
		_dragMove = onMove; _dragEnd = onEnd
	end
	track(UserInputService.InputChanged:Connect(function(inp)
		if _dragMove and (
			inp.UserInputType==Enum.UserInputType.MouseMovement or
			inp.UserInputType==Enum.UserInputType.Touch
		) then _dragMove(inp) end
	end))
	track(UserInputService.InputEnded:Connect(function(inp)
		if _dragEnd and (
			inp.UserInputType==Enum.UserInputType.MouseButton1 or
			inp.UserInputType==Enum.UserInputType.Touch
		) then
			local fn = _dragEnd
			_dragMove, _dragEnd = nil, nil
			fn(inp)
		end
	end))

	-- ── ScreenGui ────────────────────────────────────────────────────────
	local ScreenGui = Create("ScreenGui",{
		Name            = "NovaUI_"..title:gsub("%s+",""),
		ResetOnSpawn    = false,
		ZIndexBehavior  = Enum.ZIndexBehavior.Sibling,
		DisplayOrder    = 100,
		Parent          = PlayerGui,
	})

	-- ── Shadow ───────────────────────────────────────────────────────────
	local Shadow = Create("Frame",{
		Name="Shadow", AnchorPoint=Vector2.new(0.5,0.5),
		Position=UDim2.new(0.5,0,0.5,10),
		Size=UDim2.new(0,size.X.Offset+36,0,size.Y.Offset+36),
		BackgroundTransparency=1, ZIndex=0, Parent=ScreenGui,
	},{
		Create("Frame",{
			Name="Outer", AnchorPoint=Vector2.new(0.5,0.5),
			Position=UDim2.new(0.5,0,0.5,7), Size=UDim2.new(1,30,1,30),
			BackgroundColor3=Color3.new(0,0,0), BackgroundTransparency=0.70, BorderSizePixel=0,
		},{Create("UICorner",{CornerRadius=UDim.new(0,34)})}),
		Create("Frame",{
			Name="Inner", AnchorPoint=Vector2.new(0.5,0.5),
			Position=UDim2.new(0.5,0,0.5,0), Size=UDim2.new(1,0,1,0),
			BackgroundColor3=Color3.new(0,0,0), BackgroundTransparency=0.45, BorderSizePixel=0,
		},{Create("UICorner",{CornerRadius=UDim.new(0,28)})}),
	})
	local ShadowOuter = Shadow:FindFirstChild("Outer")
	local ShadowInner = Shadow:FindFirstChild("Inner")
	local SOHT, SIHT  = 0.70, 0.45

	local function fadeShadow(alpha, dur)
		if not ShadowOuter or not ShadowInner then return end
		Tween(ShadowOuter,{BackgroundTransparency=1-(1-SOHT)*(1-alpha)},dur)
		Tween(ShadowInner,{BackgroundTransparency=1-(1-SIHT)*(1-alpha)},dur)
	end
	local function setShadowI(alpha)
		if not ShadowOuter or not ShadowInner then return end
		ShadowOuter.BackgroundTransparency = 1-(1-SOHT)*(1-alpha)
		ShadowInner.BackgroundTransparency = 1-(1-SIHT)*(1-alpha)
	end

	-- ── Main frame ───────────────────────────────────────────────────────
	local Main = Create("Frame",{
		Name="Main", Size=size, Position=initPos,
		BackgroundColor3=theme.Background, BorderSizePixel=0,
		ClipsDescendants=true, ZIndex=1, Parent=ScreenGui,
	},{
		Create("UICorner",{CornerRadius=UDim.new(0,18)}),
		Create("UIStroke",{Color=theme.StrokeStrong, Thickness=1}),
	})

	local AccentStrip = Create("Frame",{
		Name="AccentStrip", Size=UDim2.new(1,0,0,3),
		BackgroundColor3=theme.Accent, BorderSizePixel=0, ZIndex=10, Parent=Main,
	})
	Create("UIGradient",{
		Color=ColorSequence.new({
			ColorSequenceKeypoint.new(0,   theme.AccentDark),
			ColorSequenceKeypoint.new(0.3, theme.Accent),
			ColorSequenceKeypoint.new(0.7, theme.AccentLight),
			ColorSequenceKeypoint.new(1,   theme.AccentDark),
		}),
		Parent=AccentStrip,
	})

	-- Entrance animation
	do
		local fx = size
		Main.Size = UDim2.new(0,fx.X.Offset*0.88,0,fx.Y.Offset*0.88)
		Main.BackgroundTransparency = 1
		for _,s in ipairs(Main:GetChildren()) do
			if s:IsA("UIStroke") then s.Transparency=1 end
		end
		setShadowI(1)
		Tween(Main,{Size=fx, BackgroundTransparency=0},0.32,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
		fadeShadow(0, 0.40)
		for _,s in ipairs(Main:GetChildren()) do
			if s:IsA("UIStroke") then Tween(s,{Transparency=0},0.34) end
		end
	end

	-- ── Top bar ──────────────────────────────────────────────────────────
	local TopBarH = 50
	local TopBar = Create("Frame",{
		Name="TopBar", Size=UDim2.new(1,0,0,TopBarH),
		BackgroundColor3=theme.Secondary, BorderSizePixel=0, ZIndex=2, Parent=Main,
	},{Create("UICorner",{CornerRadius=UDim.new(0,16)})})
	Create("Frame",{
		Size=UDim2.new(1,0,0,18), Position=UDim2.new(0,0,1,-18),
		BackgroundColor3=theme.Secondary, BorderSizePixel=0, ZIndex=2, Parent=TopBar,
	})
	Create("Frame",{
		Position=UDim2.new(0,0,1,0), Size=UDim2.new(1,0,0,1),
		BackgroundColor3=theme.Stroke, BorderSizePixel=0, ZIndex=3, Parent=TopBar,
	})

	local function WinBtn(x, col, sym, action)
		local btn = Create("TextButton",{
			Text="", Font=Enum.Font.GothamBold, TextSize=14,
			TextColor3=Color3.new(0,0,0), BackgroundColor3=col,
			Size=UDim2.new(0,14,0,14), Position=UDim2.new(0,x,0.5,-7),
			ZIndex=5, Parent=TopBar,
		},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
		btn.MouseEnter:Connect(function() btn.Text=sym end)
		btn.MouseLeave:Connect(function() btn.Text="" end)
		btn.MouseButton1Click:Connect(action)
		return btn
	end

	WinBtn(16, Color3.fromRGB(255,95,87), "✕", function()
		Tween(Main,{Size=UDim2.fromOffset(size.X.Offset,0),BackgroundTransparency=1},0.18)
		fadeShadow(1,0.18)
		task.wait(0.20)
		ScreenGui.Enabled = false
	end)

	local minimized = false
	local exH, exW  = size.Y.Offset, size.X.Offset
	WinBtn(34, Color3.fromRGB(255,189,46), "−", function()
		minimized = not minimized
		if minimized then exH=Main.Size.Y.Offset; exW=Main.Size.X.Offset end
		local tH = minimized and TopBarH or exH
		Tween(Main,   {Size=UDim2.new(0,exW,0,tH)},0.22)
		-- FIX: keep Shadow in sync
		Tween(Shadow,{Size=UDim2.new(0,exW+36,0,tH+36)},0.22)
		local rh = Main:FindFirstChild("ResizeHandle")
		if rh then rh.Visible=not minimized end
	end)

	local maxed = false
	WinBtn(52, Color3.fromRGB(40,205,65), "⊕", function()
		maxed = not maxed
		local vp = workspace.CurrentCamera.ViewportSize
		if maxed then
			exW=Main.Size.X.Offset; exH=Main.Size.Y.Offset
			Tween(Main,  {Size=UDim2.fromOffset(vp.X,vp.Y), Position=UDim2.new(0,0,0,0)},0.24,Enum.EasingStyle.Quint)
			-- FIX: Shadow follows maximize
			Tween(Shadow,{Size=UDim2.new(0,vp.X+36,0,vp.Y+36), Position=UDim2.new(0.5,0,0.5,10)},0.24)
		else
			Tween(Main,  {Size=UDim2.fromOffset(exW,exH), Position=UDim2.new(0.5,-exW/2,0.5,-exH/2)},0.24,Enum.EasingStyle.Quint)
			Tween(Shadow,{Size=UDim2.new(0,exW+36,0,exH+36)},0.24)
		end
	end)

	Create("TextLabel",{
		Name="Title", Text=title,
		Font=Enum.Font.GothamBold, TextSize=15, TextColor3=theme.Text,
		TextXAlignment=Enum.TextXAlignment.Left, BackgroundTransparency=1,
		Position=UDim2.new(0,76,0,8), Size=UDim2.new(1,-100,0,19),
		ZIndex=3, Parent=TopBar,
	})
	if subtitle~="" then
		Create("TextLabel",{
			Name="Subtitle", Text=subtitle,
			Font=Enum.Font.Gotham, TextSize=11, TextColor3=theme.SubText,
			TextXAlignment=Enum.TextXAlignment.Left, BackgroundTransparency=1,
			Position=UDim2.new(0,76,0,28), Size=UDim2.new(1,-100,0,14),
			ZIndex=3, Parent=TopBar,
		})
	end

	-- FIX: pass conns table, not trackFn
	MakeDraggable(TopBar, Main, _conns)

	-- ── Resize handle ─────────────────────────────────────────────────────
	local ResizeHandle = Create("Frame",{
		Name="ResizeHandle",
		AnchorPoint=Vector2.new(1,1), Position=UDim2.new(1,-5,1,-5),
		Size=UDim2.new(0,22,0,22), BackgroundTransparency=1, ZIndex=5, Parent=Main,
	})
	for i=1,3 do
		Create("Frame",{
			AnchorPoint=Vector2.new(1,1),
			Position=UDim2.new(1,-2,1,-2-(i-1)*5),
			Size=UDim2.new(0,10-(i-1)*2,0,2),
			Rotation=-45, BackgroundColor3=theme.StrokeStrong, BorderSizePixel=0,
			Parent=ResizeHandle,
		})
	end
	do
		local sPos, sSize
		local minSz = Vector2.new(420,290)
		track(ResizeHandle.InputBegan:Connect(function(inp)
			if inp.UserInputType==Enum.UserInputType.MouseButton1 or
			   inp.UserInputType==Enum.UserInputType.Touch then
				sPos  = inp.Position
				sSize = Main.Size
				beginDrag(function(mi)
					local d  = mi.Position - sPos
					local nW = math.max(minSz.X, sSize.X.Offset+d.X)
					local nH = math.max(minSz.Y, sSize.Y.Offset+d.Y)
					Main.Size   = UDim2.new(0,nW,0,nH)
					Shadow.Size = UDim2.new(0,nW+36,0,nH+36)
				end, function() end)
			end
		end))
	end

	-- ── Tab rail ──────────────────────────────────────────────────────────
	local RAIL_W = 158
	local TabRail = Create("Frame",{
		Name="TabRail",
		Size=UDim2.new(0,RAIL_W,1,-TopBarH), Position=UDim2.new(0,0,0,TopBarH),
		BackgroundColor3=theme.Secondary, BorderSizePixel=0, ZIndex=1, Parent=Main,
	})
	Create("Frame",{
		Position=UDim2.new(1,0,0,0), Size=UDim2.new(0,1,1,0),
		BackgroundColor3=theme.Stroke, BorderSizePixel=0, ZIndex=2, Parent=TabRail,
	})
	local TabListHolder = Create("Frame",{
		Name="TabListHolder", BackgroundTransparency=1,
		Size=UDim2.new(1,-16,1,-16), Position=UDim2.new(0,8,0,8),
		ZIndex=2, Parent=TabRail,
	})
	Create("UIListLayout",{Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder,Parent=TabListHolder})

	-- ── Page container ────────────────────────────────────────────────────
	local PageContainer = Create("Frame",{
		Name="PageContainer",
		Size=UDim2.new(1,-RAIL_W,1,-TopBarH), Position=UDim2.new(0,RAIL_W,0,TopBarH),
		BackgroundTransparency=1, ZIndex=1, Parent=Main,
	})

	-- ── Notification holder ───────────────────────────────────────────────
	local NotifyHolder = Create("Frame",{
		Name="Notifications",
		AnchorPoint=Vector2.new(1,0), Position=UDim2.new(1,-16,0,16),
		Size=UDim2.new(0,300,1,-32),
		BackgroundTransparency=1, ZIndex=50, Parent=ScreenGui,
	})
	Create("UIListLayout",{
		Padding=UDim.new(0,8),
		HorizontalAlignment=Enum.HorizontalAlignment.Right,
		SortOrder=Enum.SortOrder.LayoutOrder,
		Parent=NotifyHolder,
	})

	-- ── Toggle key ────────────────────────────────────────────────────────
	track(UserInputService.InputBegan:Connect(function(inp, gpe)
		if gpe then return end
		if inp.KeyCode==toggleKey then
			ScreenGui.Enabled = not ScreenGui.Enabled
		end
	end))

	-- ── Window object ─────────────────────────────────────────────────────
	local Window = {
		ScreenGui=ScreenGui, Main=Main, Theme=theme,
		_tabs={}, _firstTab=nil, _connections=_conns,
		_themeListeners=_themeListeners,
	}
	setmetatable(Window,{__index=NovaUI})

	-- FIX: SetTheme now broadcasts to all registered listeners
	function Window:SetTheme(nameOrTable)
		local newTheme
		if typeof(nameOrTable)=="table" then
			newTheme = FinalizeTheme(nameOrTable)
		else
			newTheme = Themes[nameOrTable] or Themes.Dark
		end
		self.Theme = newTheme
		Main.BackgroundColor3        = newTheme.Background
		TopBar.BackgroundColor3      = newTheme.Secondary
		TabRail.BackgroundColor3     = newTheme.Secondary
		AccentStrip.BackgroundColor3 = newTheme.Accent
		local stroke = Main:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = newTheme.StrokeStrong end
		for _, fn in ipairs(self._themeListeners) do
			pcall(fn, newTheme)
		end
	end

	function Window:Destroy()
		for _, c in ipairs(self._connections) do
			if typeof(c)=="RBXScriptConnection" and c.Connected then c:Disconnect() end
		end
		table.clear(self._connections)
		if self.ScreenGui then self.ScreenGui:Destroy() end
		for i, w in ipairs(NovaUI.Windows) do
			if w==self then table.remove(NovaUI.Windows,i); break end
		end
	end

	--// ─────────────────────────── CREATE TAB ──────────────────────────── //

	function Window:CreateTab(tabName, icon)
		local Page = Create("ScrollingFrame",{
			Name=tabName, BackgroundTransparency=1,
			Size=UDim2.new(1,-24,1,-20), Position=UDim2.new(0,12,0,10),
			CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y,
			ScrollBarThickness=3, ScrollBarImageColor3=theme.Accent,
			ScrollingDirection=Enum.ScrollingDirection.Y,
			BorderSizePixel=0, Visible=false, ZIndex=2, Parent=PageContainer,
		})
		Create("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=Page})

		local hasIcon = typeof(icon)=="string" and icon~=""
		local TabBtn  = Create("TextButton",{
			Name=tabName, Text=tabName,
			Font=Enum.Font.GothamMedium, TextSize=13, TextColor3=theme.SubText,
			TextXAlignment=Enum.TextXAlignment.Left,
			BackgroundColor3=theme.Elevated, BackgroundTransparency=1,
			Size=UDim2.new(1,0,0,34), ZIndex=3, Parent=TabListHolder,
		},{
			Create("UICorner",{CornerRadius=UDim.new(0,10)}),
			Create("UIPadding",{PaddingLeft=UDim.new(0,hasIcon and 38 or 14)}),
		})
		local Indicator = Create("Frame",{
			Name="Indicator", AnchorPoint=Vector2.new(0,0.5),
			Position=UDim2.new(0,0,0.5,0), Size=UDim2.new(0,3,0,0),
			BackgroundColor3=theme.Accent, BorderSizePixel=0, ZIndex=4, Parent=TabBtn,
		},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

		if hasIcon then
			Create("ImageLabel",{
				Image=icon, BackgroundTransparency=1, ImageColor3=theme.SubText,
				Position=UDim2.new(0,10,0.5,-9), Size=UDim2.new(0,18,0,18),
				ZIndex=4, Parent=TabBtn,
			})
		end

		local Tab = {Page=Page, Button=TabBtn, Selected=false}

		local function selectTab()
			for _, t in pairs(Window._tabs) do
				t.Page.Visible=false; t.Selected=false
				Tween(t.Button,{BackgroundTransparency=1,TextColor3=theme.SubText},0.14)
				local ind=t.Button:FindFirstChild("Indicator")
				if ind then Tween(ind,{Size=UDim2.new(0,3,0,0)},0.14,Enum.EasingStyle.Quad) end
				local img=t.Button:FindFirstChildOfClass("ImageLabel")
				if img then Tween(img,{ImageColor3=theme.SubText},0.14) end
			end
			Page.Visible=true; Tab.Selected=true
			local orig = Page.Position
			Page.Position = orig+UDim2.fromOffset(0,12)
			Tween(Page,{Position=orig},0.24,Enum.EasingStyle.Quint)
			Tween(TabBtn,{BackgroundTransparency=0,BackgroundColor3=theme.Elevated,TextColor3=theme.Text},0.15)
			Tween(Indicator,{Size=UDim2.new(0,3,0,22)},0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
			local img=TabBtn:FindFirstChildOfClass("ImageLabel")
			if img then Tween(img,{ImageColor3=theme.Accent},0.15) end
		end

		TabBtn.MouseButton1Click:Connect(selectTab)
		TabBtn.MouseEnter:Connect(function()
			if not Tab.Selected then Tween(TabBtn,{BackgroundTransparency=0.55,BackgroundColor3=theme.Elevated},0.10) end
		end)
		TabBtn.MouseLeave:Connect(function()
			if not Tab.Selected then Tween(TabBtn,{BackgroundTransparency=1},0.14) end
		end)

		table.insert(Window._tabs, Tab)
		if not Window._firstTab then Window._firstTab=Tab; selectTab() end

		local function zi() return (Page.ZIndex or 2)+1 end

		--// ─────────────────────────── COMPONENTS ──────────────────────── //

		-- ── Section header ───────────────────────────────────────────────
		function Tab:CreateSection(text)
			local holder = Create("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,32),Parent=Page})
			Create("TextLabel",{
				Text=text:upper(), Font=Enum.Font.GothamBold, TextSize=10,
				TextColor3=theme.Accent, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,2,0,0),
				Size=UDim2.new(1,-4,0,18), LetterSpacing=2, ZIndex=zi(), Parent=holder,
			})
			Create("Frame",{
				Position=UDim2.new(0,0,1,-1), Size=UDim2.new(1,0,0,1),
				BackgroundColor3=theme.Stroke, BorderSizePixel=0, Parent=holder,
			})
		end

		-- ── Plain label ──────────────────────────────────────────────────
		function Tab:CreateLabel(text)
			return Create("TextLabel",{
				Text=text, Font=Enum.Font.Gotham, TextSize=13,
				TextColor3=theme.SubText, TextWrapped=true,
				TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			})
		end

		-- ── Paragraph card ───────────────────────────────────────────────
		function Tab:CreateParagraph(opts)
			opts = opts or {}
			local card = Create("Frame",{
				BackgroundColor3=theme.Elevated, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,16),PaddingRight=UDim.new(0,14),
					PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12),
				}),
				Create("UIListLayout",{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder}),
			})
			TopHighlight(card, zi())
			Create("Frame",{
				Size=UDim2.new(0,3,1,-24), Position=UDim2.new(0,0,0,12),
				BackgroundColor3=theme.Accent, BorderSizePixel=0, ZIndex=zi()+1, Parent=card,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
			if opts.Title then
				Create("TextLabel",{
					Text=opts.Title, Font=Enum.Font.GothamBold, TextSize=13,
					TextColor3=theme.Text, TextWrapped=true,
					TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
					Size=UDim2.new(1,0,0,0), ZIndex=zi()+1, Parent=card,
				})
			end
			Create("TextLabel",{
				Text=opts.Content or "", Font=Enum.Font.Gotham, TextSize=12,
				TextColor3=theme.SubText, TextWrapped=true,
				TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi()+1, Parent=card,
			})
		end

		-- ── Divider ──────────────────────────────────────────────────────
		function Tab:CreateDivider()
			Create("Frame",{
				Size=UDim2.new(1,0,0,1), BackgroundColor3=theme.Stroke,
				BorderSizePixel=0, Parent=Page,
			})
		end

		-- ── Separator label ──────────────────────────────────────────────
		function Tab:CreateSeparatorLabel(text)
			local holder = Create("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,22),Parent=Page})
			Create("Frame",{
				AnchorPoint=Vector2.new(0,0.5), Position=UDim2.new(0,0,0.5,0),
				Size=UDim2.new(0.35,0,0,1), BackgroundColor3=theme.Stroke, BorderSizePixel=0, Parent=holder,
			})
			Create("TextLabel",{
				AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new(0.5,0,0.5,0),
				Size=UDim2.new(0.28,0,1,0), BackgroundTransparency=1,
				Text=text, Font=Enum.Font.GothamMedium, TextSize=11,
				TextColor3=theme.SubText, ZIndex=zi(), Parent=holder,
			})
			Create("Frame",{
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,0,0.5,0),
				Size=UDim2.new(0.35,0,0,1), BackgroundColor3=theme.Stroke, BorderSizePixel=0, Parent=holder,
			})
		end

		-- ── NEW: Divider with right-side action button ───────────────────
		function Tab:CreateDividerAction(opts)
			opts = opts or {}
			local holder = Create("Frame",{
				BackgroundTransparency=1, Size=UDim2.new(1,0,0,28), Parent=Page,
			})
			Create("Frame",{
				AnchorPoint=Vector2.new(0,0.5), Position=UDim2.new(0,0,0.5,0),
				Size=UDim2.new(1,-90,0,1), BackgroundColor3=theme.Stroke, BorderSizePixel=0, Parent=holder,
			})
			local btn = Create("TextButton",{
				Text=opts.Label or "Action",
				Font=Enum.Font.GothamMedium, TextSize=11,
				TextColor3=theme.Accent, BackgroundColor3=theme.AccentBg,
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,0,0.5,0),
				Size=UDim2.new(0,82,0,22), ZIndex=zi(), Parent=holder,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,7)}),
				Create("UIStroke",{Color=theme.AccentDark,Thickness=1}),
			})
			PressFeedback(btn)
			btn.MouseButton1Click:Connect(function()
				Ripple(btn,UserInputService:GetMouseLocation(),Color3.new(1,1,1))
				if opts.Callback then task.spawn(opts.Callback) end
			end)
		end

		-- ── Button ───────────────────────────────────────────────────────
		function Tab:CreateButton(opts)
			opts = opts or {}
			local btn = Create("TextButton",{
				Text=opts.Name or "Button",
				Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, BackgroundColor3=theme.Elevated,
				Size=UDim2.new(1,0,0,38), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(btn, zi())
			PressFeedback(btn)
			HoverBg(btn,theme.Elevated,theme.ElevatedHover)
			Tooltip(btn, theme, opts.Info)

			btn.MouseButton1Click:Connect(function()
				Ripple(btn, UserInputService:GetMouseLocation(), Color3.new(1,1,1))
				local stroke = btn:FindFirstChildOfClass("UIStroke")
				Tween(btn,{BackgroundColor3=theme.AccentBg},0.08)
				if stroke then Tween(stroke,{Color=theme.Accent,Thickness=1.5},0.08) end
				task.delay(0.14,function()
					Tween(btn,{BackgroundColor3=theme.Elevated},0.22)
					if stroke then Tween(stroke,{Color=theme.Stroke,Thickness=1},0.22) end
				end)
				if opts.Callback then task.spawn(opts.Callback) end
			end)
			return btn
		end

		-- ── Accent button ────────────────────────────────────────────────
		function Tab:CreateAccentButton(opts)
			opts = opts or {}
			local btn = Create("TextButton",{
				Text=opts.Name or "Button",
				Font=Enum.Font.GothamBold, TextSize=13,
				TextColor3=Color3.new(0.05,0.05,0.05), BackgroundColor3=theme.Accent,
				Size=UDim2.new(1,0,0,38), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIGradient",{Color=ColorSequence.new(theme.AccentLight,theme.AccentDark),Rotation=90}),
			})
			PressFeedback(btn)
			btn.MouseEnter:Connect(function() Tween(btn,{BackgroundColor3=theme.AccentLight},0.10) end)
			btn.MouseLeave:Connect(function() Tween(btn,{BackgroundColor3=theme.Accent},0.14) end)
			btn.MouseButton1Click:Connect(function()
				Ripple(btn, UserInputService:GetMouseLocation(), Color3.new(1,1,1))
				if opts.Callback then task.spawn(opts.Callback) end
			end)
			Tooltip(btn, theme, opts.Info)
			return btn
		end

		-- ── Toggle ───────────────────────────────────────────────────────
		function Tab:CreateToggle(opts)
			opts = opts or {}
			local state = opts.CurrentValue==true

			local holder = Create("TextButton",{
				Text="", AutoButtonColor=false,
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())
			PressFeedback(holder)
			HoverBg(holder,theme.Elevated,theme.ElevatedHover)

			Create("TextLabel",{
				Text=opts.Name or "Toggle", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
				Size=UDim2.new(1,-68,1,0), ZIndex=zi()+1, Parent=holder,
			})
			Tooltip(holder, theme, opts.Info)

			local pill = Create("Frame",{
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-14,0.5,0),
				Size=UDim2.new(0,42,0,24),
				BackgroundColor3=state and theme.Accent or theme.Stroke,
				ZIndex=zi()+1, Parent=holder,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			local dot = Create("Frame",{
				AnchorPoint=Vector2.new(0,0.5),
				Position=state and UDim2.new(1,-21,0.5,0) or UDim2.new(0,3,0.5,0),
				Size=UDim2.new(0,18,0,18), BackgroundColor3=Color3.new(1,1,1),
				ZIndex=zi()+2, Parent=pill,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			local function setState(new)
				state = new
				Tween(pill,{BackgroundColor3=state and theme.Accent or theme.Stroke},0.18)
				Tween(dot,{Position=state and UDim2.new(1,-21,0.5,0) or UDim2.new(0,3,0.5,0)},
					0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
				NovaUI:SetFlag(opts.Flag, state)
				if opts.Callback then task.spawn(opts.Callback, state) end
			end

			holder.MouseButton1Click:Connect(function() setState(not state) end)
			if opts.Flag then NovaUI.Flags[opts.Flag]=state end
			return {Set=setState, Get=function() return state end}
		end

		-- ── Slider ───────────────────────────────────────────────────────
		-- FIX: callback debounced; fires on release and on increment changes
		function Tab:CreateSlider(opts)
			opts = opts or {}
			local mn  = (opts.Range and opts.Range[1]) or 0
			local mx  = (opts.Range and opts.Range[2]) or 100
			local inc = opts.Increment or 1
			local val = math.clamp(opts.CurrentValue or mn, mn, mx)

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,52),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			Create("TextLabel",{
				Text=opts.Name or "Slider", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,8),
				Size=UDim2.new(1,-28,0,18), ZIndex=zi()+1, Parent=holder,
			})
			Tooltip(holder, theme, opts.Info)

			local valLabel = Create("TextLabel",{
				Text=tostring(val), Font=Enum.Font.GothamBold, TextSize=12,
				TextColor3=theme.Accent, TextXAlignment=Enum.TextXAlignment.Right,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,8),
				Size=UDim2.new(1,-28,0,18), ZIndex=zi()+1, Parent=holder,
			})

			local sliderBar = Create("Frame",{
				Position=UDim2.new(0,14,0,38), Size=UDim2.new(1,-28,0,5),
				BackgroundColor3=theme.Stroke, ZIndex=zi()+1, Parent=holder,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			local fill = Create("Frame",{
				Size=UDim2.new((val-mn)/(mx-mn),0,1,0),
				BackgroundColor3=theme.Accent, ZIndex=zi()+2, Parent=sliderBar,
			},{
				Create("UICorner",{CornerRadius=UDim.new(1,0)}),
				Create("UIGradient",{Color=ColorSequence.new(theme.AccentDark,theme.AccentLight)}),
			})

			local thumb = Create("Frame",{
				AnchorPoint=Vector2.new(0.5,0.5),
				Position=UDim2.new((val-mn)/(mx-mn),0,0.5,0),
				Size=UDim2.new(0,16,0,16), BackgroundColor3=Color3.new(1,1,1),
				ZIndex=zi()+3, Parent=sliderBar,
			},{
				Create("UICorner",{CornerRadius=UDim.new(1,0)}),
				Create("UIStroke",{Color=theme.Accent,Thickness=2.5}),
			})

			-- FIX: debounce so callback only fires on increment boundaries
			local lastCallbackVal = val
			local function fireCallback(v)
				if v~=lastCallbackVal then
					lastCallbackVal = v
					NovaUI:SetFlag(opts.Flag, v)
					if opts.Callback then task.spawn(opts.Callback, v) end
				end
			end

			local function setAlpha(a, immediate)
				a = math.clamp(a,0,1)
				local raw = mn+(mx-mn)*a
				raw = math.floor(raw/inc+0.5)*inc
				raw = math.clamp(raw,mn,mx)
				val = raw
				valLabel.Text = tostring(Round(raw,2))
				local fa = (raw-mn)/(mx-mn)
				if immediate then
					fill.Size  = UDim2.new(fa,0,1,0)
					thumb.Position = UDim2.new(fa,0,0.5,0)
				else
					Tween(fill,  {Size=UDim2.new(fa,0,1,0)},  0.07)
					Tween(thumb, {Position=UDim2.new(fa,0,0.5,0)}, 0.07)
				end
				fireCallback(raw)
			end

			sliderBar.InputBegan:Connect(function(inp)
				if inp.UserInputType==Enum.UserInputType.MouseButton1 or
				   inp.UserInputType==Enum.UserInputType.Touch then
					Tween(thumb,{Size=UDim2.new(0,20,0,20)},0.10)
					setAlpha((inp.Position.X-sliderBar.AbsolutePosition.X)/sliderBar.AbsoluteSize.X, true)
					beginDrag(function(mi)
						setAlpha((mi.Position.X-sliderBar.AbsolutePosition.X)/sliderBar.AbsoluteSize.X, true)
					end, function()
						Tween(thumb,{Size=UDim2.new(0,16,0,16)},0.15)
						fireCallback(val)
					end)
				end
			end)

			if opts.Flag then NovaUI.Flags[opts.Flag]=val end
			return {
				Set=function(v) setAlpha((v-mn)/(mx-mn)) end,
				Get=function() return val end,
			}
		end

		-- ── Dropdown ─────────────────────────────────────────────────────
		-- FIX: multi-select toggle bug, outside-click closes, Refresh preserves selection
		function Tab:CreateDropdown(opts)
			opts = opts or {}
			local options  = opts.Options or {}
			local multi    = opts.MultiSelect==true
			local current  = opts.CurrentOption or options[1]
			local selected = {}
			local open     = false

			if multi then
				for _, v in ipairs(opts.CurrentOptions or {}) do selected[v]=true end
			end

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ClipsDescendants=true, ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			local head = Create("TextButton",{
				Text="", AutoButtonColor=false, BackgroundTransparency=1,
				Size=UDim2.new(1,0,0,38), ZIndex=zi()+1, Parent=holder,
			})
			head.MouseEnter:Connect(function() Tween(holder,{BackgroundColor3=theme.ElevatedHover},0.10) end)
			head.MouseLeave:Connect(function() Tween(holder,{BackgroundColor3=theme.Elevated},0.14) end)

			Create("TextLabel",{
				Text=opts.Name or "Dropdown", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
				Size=UDim2.new(0.55,0,0,38), ZIndex=zi()+2, Parent=head,
			})

			local function multiText()
				local n=0; for _ in pairs(selected) do n+=1 end
				if n==0 then return "None"
				elseif n==1 then for v in pairs(selected) do return tostring(v) end
				else return n.." selected" end
			end

			local valLbl = Create("TextLabel",{
				Text=multi and multiText() or tostring(current or ""),
				Font=Enum.Font.Gotham, TextSize=12, TextColor3=theme.SubText,
				TextXAlignment=Enum.TextXAlignment.Right, BackgroundTransparency=1,
				Position=UDim2.new(0.55,0,0,0), Size=UDim2.new(0.45,-30,0,38),
				ZIndex=zi()+2, Parent=head,
			})

			local chevron = Create("TextLabel",{
				Text="▾", Font=Enum.Font.GothamBold, TextSize=12, TextColor3=theme.SubText,
				BackgroundTransparency=1, AnchorPoint=Vector2.new(1,0.5),
				Position=UDim2.new(1,-14,0.5,0), Size=UDim2.new(0,14,0,14),
				ZIndex=zi()+2, Parent=head,
			})

			Create("Frame",{
				Position=UDim2.new(0,10,0,38), Size=UDim2.new(1,-20,0,1),
				BackgroundColor3=theme.Stroke, BorderSizePixel=0,
				ZIndex=zi()+1, Parent=holder,
			})

			local listHolder = Create("Frame",{
				Position=UDim2.new(0,4,0,42), Size=UDim2.new(1,-8,0,0),
				BackgroundTransparency=1, ZIndex=zi()+1, Parent=holder,
			})
			Create("UIListLayout",{Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder,Parent=listHolder})

			local function rebuild()
				for _,c in ipairs(listHolder:GetChildren()) do
					if c:IsA("TextButton") then c:Destroy() end
				end
				for _, opt in ipairs(options) do
					local isSel = multi and (selected[opt]==true) or (not multi and current==opt)
					local row = Create("TextButton",{
						Text=(isSel and "✓  " or "    ")..tostring(opt),
						Font=Enum.Font.Gotham, TextSize=12,
						TextColor3=isSel and theme.Accent or theme.SubText,
						TextXAlignment=Enum.TextXAlignment.Left,
						BackgroundColor3=theme.Elevated,
						BackgroundTransparency=isSel and 0.55 or 1,
						Size=UDim2.new(1,0,0,28), ZIndex=zi()+2, Parent=listHolder,
					},{
						Create("UICorner",{CornerRadius=UDim.new(0,8)}),
						Create("UIPadding",{PaddingLeft=UDim.new(0,10)}),
					})
					row.MouseEnter:Connect(function() Tween(row,{BackgroundTransparency=0.45,BackgroundColor3=theme.ElevatedHover},0.08) end)
					row.MouseLeave:Connect(function() Tween(row,{BackgroundTransparency=isSel and 0.55 or 1},0.12) end)
					row.MouseButton1Click:Connect(function()
						if multi then
							-- FIX: correct nil/true toggle
							if selected[opt] then selected[opt]=nil else selected[opt]=true end
							valLbl.Text = multiText()
							local list={}; for v in pairs(selected) do table.insert(list,v) end
							NovaUI:SetFlag(opts.Flag, list)
							if opts.Callback then task.spawn(opts.Callback, list) end
							rebuild()
						else
							current = opt
							valLbl.Text = tostring(opt)
							NovaUI:SetFlag(opts.Flag, opt)
							if opts.Callback then task.spawn(opts.Callback, opt) end
							open = false
							Tween(holder,{Size=UDim2.new(1,0,0,38)},0.16)
							Tween(chevron,{Rotation=0},0.16)
							rebuild()
						end
					end)
				end
			end
			rebuild()

			-- FIX: close when clicking outside
			track(UserInputService.InputBegan:Connect(function(inp)
				if not open then return end
				if inp.UserInputType==Enum.UserInputType.MouseButton1 then
					local mp = inp.Position
					local abs = holder.AbsolutePosition
					local sz  = holder.AbsoluteSize
					if mp.X<abs.X or mp.X>abs.X+sz.X or mp.Y<abs.Y or mp.Y>abs.Y+sz.Y then
						open = false
						Tween(holder,{Size=UDim2.new(1,0,0,38)},0.16)
						Tween(chevron,{Rotation=0},0.16)
					end
				end
			end))

			head.MouseButton1Click:Connect(function()
				open = not open
				local h = open and (42+math.min(#options,8)*30+4) or 38
				Tween(holder,{Size=UDim2.new(1,0,0,h)},0.18)
				Tween(chevron,{Rotation=open and 180 or 0},0.18)
			end)

			if opts.Flag then
				if multi then
					local list={}; for v in pairs(selected) do table.insert(list,v) end
					NovaUI.Flags[opts.Flag]=list
				else
					NovaUI.Flags[opts.Flag]=current
				end
			end

			return {
				Set=function(v)
					if multi then selected={}; for _,x in ipairs(v) do selected[x]=true end
					else current=v end
					valLbl.Text=multi and multiText() or tostring(v)
					rebuild()
				end,
				Get=function()
					if multi then
						local list={}; for v in pairs(selected) do table.insert(list,v) end
						return list
					end
					return current
				end,
				-- FIX: Refresh keeps valid selections
				Refresh=function(newOpts)
					options = newOpts
					if not multi then
						local valid=false
						for _,v in ipairs(options) do if v==current then valid=true; break end end
						if not valid then current=options[1] end
					else
						for v in pairs(selected) do
							local found=false
							for _,nv in ipairs(options) do if nv==v then found=true; break end end
							if not found then selected[v]=nil end
						end
					end
					valLbl.Text=multi and multiText() or tostring(current or "")
					rebuild()
				end,
			}
		end

		-- ── Text input ───────────────────────────────────────────────────
		function Tab:CreateInput(opts)
			opts = opts or {}
			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamMedium, TextSize=12,
					TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
					Size=UDim2.new(0.4,0,1,0), ZIndex=zi()+1, Parent=holder,
				})
			end

			local bx = opts.Name and 0.4 or 0
			local box = Create("TextBox",{
				Text=opts.DefaultText or "",
				PlaceholderText=opts.PlaceholderText or (opts.Name and "Enter value…" or "Enter text…"),
				Font=Enum.Font.Gotham, TextSize=13, TextColor3=theme.Text,
				PlaceholderColor3=theme.MutedText, ClearTextOnFocus=false,
				BackgroundTransparency=1,
				Position=UDim2.new(bx, opts.Name and 0 or 14, 0,0),
				Size=UDim2.new(1-bx, opts.Name and -14 or -28, 1,0),
				TextXAlignment=Enum.TextXAlignment.Left,
				ZIndex=zi()+1, Parent=holder,
			})

			local stroke = holder:FindFirstChildOfClass("UIStroke")
			box.Focused:Connect(function()
				if stroke then Tween(stroke,{Color=theme.Accent,Thickness=1.5},0.14) end
			end)
			box.FocusLost:Connect(function(enter)
				if stroke then Tween(stroke,{Color=theme.Stroke,Thickness=1},0.14) end
				NovaUI:SetFlag(opts.Flag, box.Text)
				if opts.Callback then task.spawn(opts.Callback, box.Text, enter) end
			end)

			if opts.Flag then NovaUI.Flags[opts.Flag]=box.Text end
			return {Set=function(v) box.Text=v end, Get=function() return box.Text end}
		end

		-- ── Multi-line text area ─────────────────────────────────────────
		function Tab:CreateTextArea(opts)
			opts = opts or {}
			local height = opts.Height or 80
			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,height+4),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamMedium, TextSize=12,
					TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,14,0,4),
					Size=UDim2.new(1,-28,0,16), ZIndex=zi()+1, Parent=holder,
				})
			end
			local yOff = opts.Name and 22 or 0
			local box = Create("TextBox",{
				Text=opts.DefaultText or "",
				PlaceholderText=opts.PlaceholderText or "Enter text…",
				Font=Enum.Font.Gotham, TextSize=12, TextColor3=theme.Text,
				PlaceholderColor3=theme.MutedText, ClearTextOnFocus=false,
				MultiLine=true, TextWrapped=true,
				TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
				BackgroundTransparency=1,
				Position=UDim2.new(0,14,0,yOff+2), Size=UDim2.new(1,-28,0,height-yOff),
				ZIndex=zi()+1, Parent=holder,
			})
			local stroke = holder:FindFirstChildOfClass("UIStroke")
			box.Focused:Connect(function() if stroke then Tween(stroke,{Color=theme.Accent,Thickness=1.5},0.14) end end)
			box.FocusLost:Connect(function(enter)
				if stroke then Tween(stroke,{Color=theme.Stroke,Thickness=1},0.14) end
				NovaUI:SetFlag(opts.Flag, box.Text)
				if opts.Callback then task.spawn(opts.Callback, box.Text, enter) end
			end)
			if opts.Flag then NovaUI.Flags[opts.Flag]=box.Text end
			return {Set=function(v) box.Text=v end, Get=function() return box.Text end}
		end

		-- ── NEW: Number input (spinbox) ──────────────────────────────────
		-- opts: Name, Min, Max, Step, DefaultValue, Flag, Callback, Info
		function Tab:CreateNumberInput(opts)
			opts = opts or {}
			local mn   = opts.Min  or 0
			local mx   = opts.Max  or 100
			local step = opts.Step or 1
			local val  = math.clamp(opts.DefaultValue or mn, mn, mx)

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())
			Tooltip(holder, theme, opts.Info)

			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamMedium, TextSize=13,
					TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
					Size=UDim2.new(0.5,0,1,0), ZIndex=zi()+1, Parent=holder,
				})
			end

			local function makeSpinBtn(symbol, xAnchor, xPos, action)
				local b = Create("TextButton",{
					Text=symbol, Font=Enum.Font.GothamBold, TextSize=15,
					TextColor3=theme.Accent, BackgroundColor3=theme.AccentBg,
					AnchorPoint=Vector2.new(xAnchor,0.5), Position=UDim2.new(xPos,0,0.5,0),
					Size=UDim2.new(0,26,0,26), ZIndex=zi()+1, Parent=holder,
				},{
					Create("UICorner",{CornerRadius=UDim.new(0,8)}),
				})
				PressFeedback(b)
				b.MouseButton1Click:Connect(action)
				return b
			end

			local box = Create("TextBox",{
				Text=tostring(val),
				Font=Enum.Font.GothamBold, TextSize=13, TextColor3=theme.Text,
				TextXAlignment=Enum.TextXAlignment.Center,
				BackgroundTransparency=1,
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-66,0.5,0),
				Size=UDim2.new(0,60,0,26),
				ZIndex=zi()+1, Parent=holder,
			})

			local function applyVal(v)
				v = math.clamp(math.floor(v/step+0.5)*step, mn, mx)
				val = v
				box.Text = tostring(Round(v,4))
				NovaUI:SetFlag(opts.Flag, v)
				if opts.Callback then task.spawn(opts.Callback, v) end
			end

			makeSpinBtn("−", 1, 1, function() applyVal(val-step) end)
				.Position = UDim2.new(1,-32,0.5,0)
			makeSpinBtn("+", 0, 0, function() applyVal(val+step) end)
				.Position = UDim2.new(1,-96,0.5,0)

			local stroke = holder:FindFirstChildOfClass("UIStroke")
			box.Focused:Connect(function() if stroke then Tween(stroke,{Color=theme.Accent,Thickness=1.5},0.14) end end)
			box.FocusLost:Connect(function()
				if stroke then Tween(stroke,{Color=theme.Stroke,Thickness=1},0.14) end
				local n = tonumber(box.Text)
				if n then applyVal(n) else box.Text=tostring(val) end
			end)

			if opts.Flag then NovaUI.Flags[opts.Flag]=val end
			return {
				Set=function(v) applyVal(v) end,
				Get=function() return val end,
			}
		end

		-- ── Keybind picker ───────────────────────────────────────────────
		-- FIX: Escape cancels; clicking elsewhere cancels
		function Tab:CreateKeybind(opts)
			opts = opts or {}
			local bound    = opts.CurrentKeybind or Enum.KeyCode.Unknown
			local listening = false

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())
			HoverBg(holder,theme.Elevated,theme.ElevatedHover)

			Create("TextLabel",{
				Text=opts.Name or "Keybind", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
				Size=UDim2.new(1,-115,1,0), ZIndex=zi()+1, Parent=holder,
			})
			Tooltip(holder, theme, opts.Info)

			local pill = Create("TextButton",{
				Text=bound==Enum.KeyCode.Unknown and "—" or bound.Name,
				Font=Enum.Font.GothamBold, TextSize=11, TextColor3=theme.Accent,
				BackgroundColor3=theme.AccentBg,
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-12,0.5,0),
				Size=UDim2.new(0,92,0,24), ZIndex=zi()+1, Parent=holder,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,7)}),
				Create("UIStroke",{Color=theme.AccentDark,Thickness=1}),
			})

			local function cancelListen()
				if not listening then return end
				listening = false
				pill.Text = bound==Enum.KeyCode.Unknown and "—" or bound.Name
				Tween(pill,{TextColor3=theme.Accent},0.12)
			end

			pill.MouseButton1Click:Connect(function()
				listening = true
				pill.Text = "…"
				Tween(pill,{TextColor3=theme.SubText},0.10)
			end)

			track(UserInputService.InputBegan:Connect(function(inp, gpe)
				if not listening then return end
				if inp.UserInputType==Enum.UserInputType.Keyboard then
					if inp.KeyCode==Enum.KeyCode.Escape then
						cancelListen(); return
					end
					bound    = inp.KeyCode
					pill.Text = bound.Name
					Tween(pill,{TextColor3=theme.Accent},0.12)
					listening = false
					NovaUI:SetFlag(opts.Flag, bound)
					if opts.Callback then task.spawn(opts.Callback, bound) end
				elseif inp.UserInputType==Enum.UserInputType.MouseButton1 then
					-- clicking elsewhere cancels
					local mp  = inp.Position
					local abs = pill.AbsolutePosition
					local sz  = pill.AbsoluteSize
					if mp.X<abs.X or mp.X>abs.X+sz.X or mp.Y<abs.Y or mp.Y>abs.Y+sz.Y then
						cancelListen()
					end
				end
			end))

			if opts.Flag then NovaUI.Flags[opts.Flag]=bound end
			return {
				Set=function(v) bound=v; pill.Text=v.Name end,
				Get=function() return bound end,
			}
		end

		-- ── Color picker ─────────────────────────────────────────────────
		-- FIX: Set() now correctly updates channel fill bars and value labels
		function Tab:CreateColorPicker(opts)
			opts = opts or {}
			local color = opts.CurrentColor or Color3.fromRGB(255,182,48)
			local open  = false

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ClipsDescendants=true, ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			local head = Create("TextButton",{
				Text="", AutoButtonColor=false, BackgroundTransparency=1,
				Size=UDim2.new(1,0,0,38), ZIndex=zi()+1, Parent=holder,
			})
			head.MouseEnter:Connect(function() Tween(holder,{BackgroundColor3=theme.ElevatedHover},0.10) end)
			head.MouseLeave:Connect(function() Tween(holder,{BackgroundColor3=theme.Elevated},0.14) end)

			Create("TextLabel",{
				Text=opts.Name or "Color", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
				Size=UDim2.new(1,-60,1,0), ZIndex=zi()+2, Parent=head,
			})

			local hexLabel = Create("TextLabel",{
				Text=ColorToHex(color), Font=Enum.Font.GothamMedium, TextSize=10,
				TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Right,
				BackgroundTransparency=1, AnchorPoint=Vector2.new(1,0.5),
				Position=UDim2.new(1,-48,0.5,0), Size=UDim2.new(0,52,0,20),
				ZIndex=zi()+2, Parent=head,
			})

			local swatch = Create("Frame",{
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-14,0.5,0),
				Size=UDim2.new(0,28,0,28), BackgroundColor3=color,
				ZIndex=zi()+2, Parent=head,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,8)}),
				Create("UIStroke",{Color=theme.StrokeStrong,Thickness=1}),
			})

			local panel = Create("Frame",{
				Position=UDim2.new(0,14,0,44), Size=UDim2.new(1,-28,0,112),
				BackgroundTransparency=1, ZIndex=zi()+1, Parent=holder,
			})

			local chanColors = {
				R=Color3.fromRGB(232,88,84),
				G=Color3.fromRGB(68,210,130),
				B=Color3.fromRGB(78,156,248),
			}

			-- FIX: channel returns set() function for external updates
			local function makeChan(lbl, initial, y, onChange)
				local row = Create("Frame",{
					Position=UDim2.new(0,0,0,y), Size=UDim2.new(1,0,0,30),
					BackgroundTransparency=1, ZIndex=zi()+2, Parent=panel,
				})
				Create("TextLabel",{
					Text=lbl, Font=Enum.Font.GothamBold, TextSize=11,
					TextColor3=chanColors[lbl] or theme.SubText, BackgroundTransparency=1,
					Size=UDim2.new(0,14,1,0), ZIndex=zi()+3, Parent=row,
				})
				local vl = Create("TextLabel",{
					Text=tostring(initial), Font=Enum.Font.Gotham, TextSize=10,
					TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Right,
					BackgroundTransparency=1, AnchorPoint=Vector2.new(1,0.5),
					Position=UDim2.new(1,0,0.5,0), Size=UDim2.new(0,28,1,0),
					ZIndex=zi()+3, Parent=row,
				})
				local bar = Create("Frame",{
					Position=UDim2.new(0,18,0.5,-3), Size=UDim2.new(1,-50,0,6),
					BackgroundColor3=theme.Stroke, ZIndex=zi()+3, Parent=row,
				},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
				local fill = Create("Frame",{
					Size=UDim2.new(initial/255,0,1,0),
					BackgroundColor3=chanColors[lbl] or theme.Accent,
					ZIndex=zi()+4, Parent=bar,
				},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
				local cv = initial

				local function setRaw(a)
					a = math.clamp(a,0,1)
					local nv = math.floor(a*255+0.5)
					cv = nv; vl.Text=tostring(nv)
					fill.Size = UDim2.new(a,0,1,0)
					onChange()
				end

				bar.InputBegan:Connect(function(inp)
					if inp.UserInputType==Enum.UserInputType.MouseButton1 or
					   inp.UserInputType==Enum.UserInputType.Touch then
						setRaw((inp.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X)
						beginDrag(function(mi)
							setRaw((mi.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X)
						end, function() end)
					end
				end)
				return {
					get=function() return cv end,
					-- FIX: expose setFromValue so Set() can push updates
					setFromValue=function(v255)
						cv = math.clamp(math.floor(v255+0.5),0,255)
						vl.Text=tostring(cv)
						fill.Size = UDim2.new(cv/255,0,1,0)
					end,
				}
			end

			local r0,g0,b0 = math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255)
			local rCh,gCh,bCh

			local function apply()
				color = Color3.fromRGB(rCh.get(),gCh.get(),bCh.get())
				swatch.BackgroundColor3 = color
				hexLabel.Text = ColorToHex(color)
				NovaUI:SetFlag(opts.Flag, color)
				if opts.Callback then task.spawn(opts.Callback, color) end
			end

			rCh = makeChan("R",r0,  0,  apply)
			gCh = makeChan("G",g0,  38, apply)
			bCh = makeChan("B",b0,  76, apply)

			head.MouseButton1Click:Connect(function()
				open = not open
				Tween(holder,{Size=UDim2.new(1,0,0,open and 168 or 38)},0.18)
			end)

			if opts.Flag then NovaUI.Flags[opts.Flag]=color end
			return {
				Set=function(v)
					color=v
					swatch.BackgroundColor3=v
					hexLabel.Text=ColorToHex(v)
					-- FIX: update channel bars
					rCh.setFromValue(math.floor(v.R*255))
					gCh.setFromValue(math.floor(v.G*255))
					bCh.setFromValue(math.floor(v.B*255))
				end,
				Get=function() return color end,
			}
		end

		-- ── Progress bar ─────────────────────────────────────────────────
		-- FIX: renamed inner `track` variable to avoid shadowing
		function Tab:CreateProgress(opts)
			opts = opts or {}
			local val = math.clamp(opts.Value or 0, 0, 100)

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,52),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			Create("TextLabel",{
				Text=opts.Name or "Progress", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,8),
				Size=UDim2.new(1,-28,0,18), ZIndex=zi()+1, Parent=holder,
			})
			local pctLbl = Create("TextLabel",{
				Text=tostring(val).."%", Font=Enum.Font.GothamBold, TextSize=12,
				TextColor3=theme.Accent, TextXAlignment=Enum.TextXAlignment.Right,
				BackgroundTransparency=1, Position=UDim2.new(0,14,0,8),
				Size=UDim2.new(1,-28,0,18), ZIndex=zi()+1, Parent=holder,
			})

			-- FIX: renamed `track` → `progressTrack` to avoid shadowing
			local progressTrack = Create("Frame",{
				Position=UDim2.new(0,14,0,36), Size=UDim2.new(1,-28,0,8),
				BackgroundColor3=theme.Stroke, ZIndex=zi()+1, Parent=holder,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			local fill = Create("Frame",{
				Size=UDim2.new(val/100,0,1,0), BackgroundColor3=theme.Accent,
				ZIndex=zi()+2, Parent=progressTrack,
			},{
				Create("UICorner",{CornerRadius=UDim.new(1,0)}),
				Create("UIGradient",{Color=ColorSequence.new(theme.AccentDark,theme.AccentLight)}),
			})

			local function setVal(v)
				v = math.clamp(v,0,100)
				val = v
				pctLbl.Text = tostring(Round(v,1)).."%"
				Tween(fill,{Size=UDim2.new(v/100,0,1,0)},0.30)
				Tween(fill,{BackgroundColor3=v>=100 and theme.Success or theme.Accent},0.25)
			end

			return {Set=setVal, Get=function() return val end}
		end

		-- ── Badge ────────────────────────────────────────────────────────
		function Tab:CreateBadge(opts)
			opts = opts or {}
			local badgeType = opts.Type or "Default"
			local function typeColors(tp)
				if     tp=="Success" then return theme.SuccessBg, theme.Success
				elseif tp=="Danger"  then return theme.DangerBg,  theme.Danger
				elseif tp=="Warning" then return theme.WarningBg, theme.Warning
				elseif tp=="Info"    then return theme.InfoBg,    theme.Info
				elseif tp=="Accent"  then return theme.AccentBg,  theme.Accent
				else                      return theme.Elevated,  theme.SubText end
			end
			local bgC, txC = typeColors(badgeType)

			local row = Create("Frame",{
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UIListLayout",{
					FillDirection=Enum.FillDirection.Horizontal,
					Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder,
				}),
			})
			local badge = Create("TextLabel",{
				Text=opts.Name or "Badge", Font=Enum.Font.GothamBold, TextSize=11,
				TextColor3=txC, BackgroundColor3=bgC,
				Size=UDim2.new(0,0,0,22), AutomaticSize=Enum.AutomaticSize.X,
				ZIndex=zi()+1, Parent=row,
			},{
				Create("UICorner",{CornerRadius=UDim.new(1,0)}),
				Create("UIPadding",{PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10)}),
			})
			return {
				SetText=function(t) badge.Text=t end,
				SetType=function(tp)
					local bg,tx=typeColors(tp)
					badge.BackgroundColor3=bg; badge.TextColor3=tx
				end,
			}
		end

		-- ── Image display ────────────────────────────────────────────────
		function Tab:CreateImage(opts)
			opts = opts or {}
			local h = opts.Height or 120
			local frame = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,h),
				ClipsDescendants=true, ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			local img = Create("ImageLabel",{
				Image=opts.Image or "", BackgroundTransparency=1,
				Size=UDim2.new(1,0,1,0), ZIndex=zi()+1,
				ScaleType=Enum.ScaleType.Crop, Parent=frame,
			})
			if opts.Caption then
				local cap = Create("Frame",{
					AnchorPoint=Vector2.new(0,1), Position=UDim2.new(0,0,1,0),
					Size=UDim2.new(1,0,0,30), BackgroundColor3=Color3.new(0,0,0),
					BackgroundTransparency=0.35, ZIndex=zi()+2, Parent=frame,
				})
				Create("TextLabel",{
					Text=opts.Caption, Font=Enum.Font.Gotham, TextSize=12,
					TextColor3=Color3.new(1,1,1), TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,12,0,0),
					Size=UDim2.new(1,-12,1,0), ZIndex=zi()+3, Parent=cap,
				})
			end
			return {
				SetImage=function(id) img.Image=id end,
				GetImage=function() return img.Image end,
			}
		end

		-- ── Data table ───────────────────────────────────────────────────
		-- FIX: Clear() now identifies data rows by Name tag
		function Tab:CreateTable(opts)
			opts = opts or {}
			local cols = opts.Columns or {}
			local rows = opts.Rows    or {}
			local colW  = math.floor(1/#cols*1000)/1000

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIListLayout",{Padding=UDim.new(0,0),SortOrder=Enum.SortOrder.LayoutOrder}),
			})

			local header = Create("Frame",{
				Name="TableHeader",
				BackgroundColor3=theme.Secondary,
				Size=UDim2.new(1,0,0,32), ClipsDescendants=true, ZIndex=zi()+1, Parent=holder,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder}),
			})
			Create("Frame",{
				Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,1,-14),
				BackgroundColor3=theme.Secondary, BorderSizePixel=0, ZIndex=zi()+1, Parent=header,
			})
			for _, col in ipairs(cols) do
				Create("TextLabel",{
					Text=col, Font=Enum.Font.GothamBold, TextSize=11,
					TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Size=UDim2.new(colW,0,1,0),
					ZIndex=zi()+2, Parent=header,
				},{Create("UIPadding",{PaddingLeft=UDim.new(0,12)})})
			end

			local rowCount = 0
			local function addRow(data)
				rowCount += 1
				local even = rowCount%2==0
				local row = Create("Frame",{
					Name="DataRow",
					BackgroundColor3=even and theme.Background or theme.Elevated,
					Size=UDim2.new(1,0,0,30), ZIndex=zi()+1, Parent=holder,
				},{
					Create("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder}),
				})
				for _, cell in ipairs(data) do
					Create("TextLabel",{
						Text=tostring(cell), Font=Enum.Font.Gotham, TextSize=12,
						TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
						BackgroundTransparency=1, Size=UDim2.new(colW,0,1,0),
						ZIndex=zi()+2, Parent=row,
					},{Create("UIPadding",{PaddingLeft=UDim.new(0,12)})})
				end
				local hitbox = Create("TextButton",{
					Text="", AutoButtonColor=false, BackgroundTransparency=1,
					Size=UDim2.new(1,0,1,0), ZIndex=zi()+3, Parent=row,
				})
				hitbox.MouseEnter:Connect(function() Tween(row,{BackgroundColor3=theme.ElevatedHover},0.08) end)
				hitbox.MouseLeave:Connect(function()
					Tween(row,{BackgroundColor3=even and theme.Background or theme.Elevated},0.12)
				end)
				return row
			end

			for _, row in ipairs(rows) do addRow(row) end
			Create("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=theme.Stroke,BorderSizePixel=0,Parent=holder})

			return {
				AddRow=function(data) return addRow(data) end,
				-- FIX: only removes DataRow named children
				Clear=function()
					rowCount = 0
					for _,c in ipairs(holder:GetChildren()) do
						if c.Name=="DataRow" then c:Destroy() end
					end
				end,
			}
		end

		-- ── Search bar ───────────────────────────────────────────────────
		function Tab:CreateSearchBar(opts)
			opts = opts or {}
			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,38),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			Create("TextLabel",{
				Text="⌕", Font=Enum.Font.GothamBold, TextSize=18,
				TextColor3=theme.SubText, BackgroundTransparency=1,
				Position=UDim2.new(0,10,0,0), Size=UDim2.new(0,26,1,0),
				ZIndex=zi()+1, Parent=holder,
			})
			local box = Create("TextBox",{
				Text="", PlaceholderText=opts.Placeholder or "Search…",
				Font=Enum.Font.Gotham, TextSize=13, TextColor3=theme.Text,
				PlaceholderColor3=theme.MutedText, ClearTextOnFocus=false,
				BackgroundTransparency=1,
				Position=UDim2.new(0,36,0,0), Size=UDim2.new(1,-46,1,0),
				TextXAlignment=Enum.TextXAlignment.Left,
				ZIndex=zi()+1, Parent=holder,
			})
			local stroke = holder:FindFirstChildOfClass("UIStroke")
			box.Focused:Connect(function() if stroke then Tween(stroke,{Color=theme.Accent,Thickness=1.5},0.14) end end)
			box.FocusLost:Connect(function() if stroke then Tween(stroke,{Color=theme.Stroke,Thickness=1},0.14) end end)
			box:GetPropertyChangedSignal("Text"):Connect(function()
				if opts.OnChanged then task.spawn(opts.OnChanged, box.Text) end
			end)
			local clearBtn = Create("TextButton",{
				Text="✕", Font=Enum.Font.GothamBold, TextSize=11,
				TextColor3=theme.SubText, BackgroundTransparency=1,
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-8,0.5,0),
				Size=UDim2.new(0,20,0,20), Visible=false,
				ZIndex=zi()+2, Parent=holder,
			})
			clearBtn.MouseButton1Click:Connect(function()
				box.Text=""; clearBtn.Visible=false
				if opts.OnChanged then task.spawn(opts.OnChanged,"") end
			end)
			box:GetPropertyChangedSignal("Text"):Connect(function()
				clearBtn.Visible = box.Text~=""
			end)
			return {
				Get=function() return box.Text end,
				Set=function(v) box.Text=v end,
				Clear=function() box.Text=""; clearBtn.Visible=false end,
			}
		end

		-- ── Grid ─────────────────────────────────────────────────────────
		function Tab:CreateGrid(opts)
			opts = opts or {}
			local items = opts.Items   or {}
			local cols  = opts.Columns or 2

			local holder = Create("Frame",{
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UIGridLayout",{
					CellSize=UDim2.new(1/cols,-4,0,36),
					CellPadding=UDim2.new(0,4,0,4),
					SortOrder=Enum.SortOrder.LayoutOrder,
				}),
			})
			local cells = {}
			for i, item in ipairs(items) do
				local btn = Create("TextButton",{
					Text=item.Name or tostring(i), Font=Enum.Font.GothamMedium, TextSize=12,
					TextColor3=theme.Text, BackgroundColor3=theme.Elevated,
					Size=UDim2.new(0,0,0,0), ZIndex=zi()+1, Parent=holder,
				},{
					Create("UICorner",{CornerRadius=UDim.new(0,10)}),
					Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				})
				PressFeedback(btn)
				HoverBg(btn,theme.Elevated,theme.ElevatedHover)
				if item.Callback then
					btn.MouseButton1Click:Connect(function()
						Ripple(btn,UserInputService:GetMouseLocation(),Color3.new(1,1,1))
						task.spawn(item.Callback)
					end)
				end
				table.insert(cells,btn)
			end
			return {Cells=cells}
		end

		-- ── Spinner ──────────────────────────────────────────────────────
		-- FIX: Start() stores its connection; no heartbeat leak
		function Tab:CreateSpinner(opts)
			opts = opts or {}
			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,48),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			Create("TextLabel",{
				Text=opts.Name or "Loading…", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, Position=UDim2.new(0,54,0,0),
				Size=UDim2.new(1,-68,1,0), ZIndex=zi()+1, Parent=holder,
			})
			local arcTrack = Create("Frame",{
				AnchorPoint=Vector2.new(0,0.5), Position=UDim2.new(0,14,0.5,0),
				Size=UDim2.new(0,28,0,28), BackgroundTransparency=1,
				ZIndex=zi()+1, Parent=holder,
			})
			local arc = Create("ImageLabel",{
				Image="rbxassetid://14304827265",
				BackgroundTransparency=1, ImageColor3=theme.Accent,
				Size=UDim2.new(1,0,1,0), ZIndex=zi()+2, Parent=arcTrack,
			})
			local dot = Create("Frame",{
				AnchorPoint=Vector2.new(0.5,0), Position=UDim2.new(0.5,0,0,0),
				Size=UDim2.new(0,5,0,5), BackgroundColor3=theme.Accent,
				ZIndex=zi()+3, Parent=arcTrack,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			-- FIX: single shared conn variable; Start() replaces it cleanly
			local spinConn = nil
			local function startSpin()
				if spinConn then pcall(function() spinConn:Disconnect() end) end
				spinConn = RunService.Heartbeat:Connect(function(dt)
					arc.Rotation = arc.Rotation + dt*240
					dot.Rotation = dot.Rotation + dt*240
				end)
				track(spinConn)
			end
			startSpin()

			return {
				SetText=function(t)
					local lbl=holder:FindFirstChildOfClass("TextLabel")
					if lbl then lbl.Text=t end
				end,
				Stop=function()
					if spinConn then spinConn:Disconnect(); spinConn=nil end
				end,
				Start=startSpin,
			}
		end

		-- ── Alert box ────────────────────────────────────────────────────
		-- FIX: icon no longer overlaps padding boundary
		function Tab:CreateAlert(opts)
			opts = opts or {}
			local alertType = opts.Type or "Info"
			local bgC,icC,lnC
			if     alertType=="Success" then bgC=theme.SuccessBg; icC=theme.Success; lnC=theme.Success
			elseif alertType=="Danger"  then bgC=theme.DangerBg;  icC=theme.Danger;  lnC=theme.Danger
			elseif alertType=="Warning" then bgC=theme.WarningBg; icC=theme.Warning; lnC=theme.Warning
			else                             bgC=theme.InfoBg;    icC=theme.Info;    lnC=theme.Info end

			local icons = {Info="ℹ",Success="✓",Danger="✕",Warning="⚠"}

			local holder = Create("Frame",{
				BackgroundColor3=bgC, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=lnC,Thickness=1}),
				-- FIX: icon goes in left padding zone explicitly; content gets its own left pad
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,44), PaddingRight=UDim.new(0,14),
					PaddingTop=UDim.new(0,10),  PaddingBottom=UDim.new(0,10),
				}),
				Create("UIListLayout",{Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder}),
			})

			-- Left border strip (outside content padding)
			Create("Frame",{
				Size=UDim2.new(0,4,1,-20), Position=UDim2.new(0,0,0,10),
				BackgroundColor3=lnC, BorderSizePixel=0, ZIndex=zi()+1, Parent=holder,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			-- FIX: icon positioned in absolute coords, not inside the padded layout
			Create("TextLabel",{
				Text=icons[alertType] or "ℹ",
				Font=Enum.Font.GothamBold, TextSize=16,
				TextColor3=icC, BackgroundTransparency=1,
				AnchorPoint=Vector2.new(0,0), Position=UDim2.new(0,10,0,10),
				Size=UDim2.new(0,24,0,24), ZIndex=zi()+2, Parent=holder,
			})

			if opts.Title then
				Create("TextLabel",{
					Text=opts.Title, Font=Enum.Font.GothamBold, TextSize=13,
					TextColor3=icC, TextWrapped=true,
					TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
					Size=UDim2.new(1,0,0,0), ZIndex=zi()+1, Parent=holder,
				})
			end
			local msgLbl = Create("TextLabel",{
				Text=opts.Message or "", Font=Enum.Font.Gotham, TextSize=12,
				TextColor3=icC, TextWrapped=true,
				TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi()+1, Parent=holder,
			})
			return {SetMessage=function(t) msgLbl.Text=t end}
		end

		-- ── Star rating ──────────────────────────────────────────────────
		function Tab:CreateRating(opts)
			opts = opts or {}
			local maxStars = opts.Max or 5
			local current  = opts.Value or 0

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,44),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamMedium, TextSize=13,
					TextColor3=theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
					Size=UDim2.new(0.5,0,1,0), ZIndex=zi()+1, Parent=holder,
				})
			end

			local starHolder = Create("Frame",{
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-14,0.5,0),
				Size=UDim2.new(0,maxStars*26,0,26),
				BackgroundTransparency=1, ZIndex=zi()+1, Parent=holder,
			})
			Create("UIListLayout",{
				FillDirection=Enum.FillDirection.Horizontal,
				Padding=UDim.new(0,4), SortOrder=Enum.SortOrder.LayoutOrder,
				Parent=starHolder,
			})

			local stars = {}
			local function updateStars(v)
				for i,star in ipairs(stars) do
					star.TextColor3 = i<=v and theme.Accent or theme.Stroke
				end
			end
			for i=1,maxStars do
				local star = Create("TextButton",{
					Text="★", Font=Enum.Font.GothamBold, TextSize=20,
					TextColor3=i<=current and theme.Accent or theme.Stroke,
					BackgroundTransparency=1, Size=UDim2.new(0,22,0,26),
					ZIndex=zi()+2, Parent=starHolder,
				})
				star.MouseEnter:Connect(function() updateStars(i) end)
				star.MouseLeave:Connect(function() updateStars(current) end)
				star.MouseButton1Click:Connect(function()
					current=i; updateStars(current)
					NovaUI:SetFlag(opts.Flag,current)
					if opts.Callback then task.spawn(opts.Callback,current) end
				end)
				table.insert(stars,star)
			end
			if opts.Flag then NovaUI.Flags[opts.Flag]=current end
			return {
				Set=function(v) current=v; updateStars(v) end,
				Get=function() return current end,
			}
		end

		-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		--  NEW COMPONENTS (3.1.0)
		-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

		-- ── NEW: Radio group ─────────────────────────────────────────────
		-- opts: Name, Options={string,...}, DefaultOption, Flag, Callback, Info
		function Tab:CreateRadioGroup(opts)
			opts = opts or {}
			local options = opts.Options or {}
			local current = opts.DefaultOption or options[1]

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated,
				AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,14),PaddingRight=UDim.new(0,14),
					PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10),
				}),
				Create("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder}),
			})
			TopHighlight(holder, zi())

			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamBold, TextSize=12,
					TextColor3=theme.Accent, LetterSpacing=1,
					TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Size=UDim2.new(1,0,0,18),
					ZIndex=zi()+1, Parent=holder,
				})
			end
			Tooltip(holder, theme, opts.Info)

			local btns = {}
			local function updateRadio(sel)
				for opt, row in pairs(btns) do
					local isMe = (opt==sel)
					Tween(row.outer,{BackgroundColor3=isMe and theme.Accent or theme.Stroke},0.15)
					Tween(row.inner,{BackgroundColor3=isMe and Color3.new(1,1,1) or theme.Stroke,
						Size=isMe and UDim2.new(0,8,0,8) or UDim2.new(0,0,0,0)},0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
					row.lbl.TextColor3 = isMe and theme.Text or theme.SubText
				end
			end

			for _, opt in ipairs(options) do
				local row = Create("TextButton",{
					Text="", AutoButtonColor=false, BackgroundTransparency=1,
					Size=UDim2.new(1,0,0,26), ZIndex=zi()+1, Parent=holder,
				})
				local outer = Create("Frame",{
					AnchorPoint=Vector2.new(0,0.5), Position=UDim2.new(0,0,0.5,0),
					Size=UDim2.new(0,18,0,18),
					BackgroundColor3=opt==current and theme.Accent or theme.Stroke,
					ZIndex=zi()+2, Parent=row,
				},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
				local inner = Create("Frame",{
					AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new(0.5,0,0.5,0),
					Size=opt==current and UDim2.new(0,8,0,8) or UDim2.new(0,0,0,0),
					BackgroundColor3=Color3.new(1,1,1),
					ZIndex=zi()+3, Parent=outer,
				},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
				local lbl = Create("TextLabel",{
					Text=tostring(opt), Font=Enum.Font.Gotham, TextSize=13,
					TextColor3=opt==current and theme.Text or theme.SubText,
					TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,26,0,0),
					Size=UDim2.new(1,-26,1,0), ZIndex=zi()+2, Parent=row,
				})
				btns[opt] = {outer=outer, inner=inner, lbl=lbl}
				row.MouseEnter:Connect(function() if opt~=current then lbl.TextColor3=theme.Text end end)
				row.MouseLeave:Connect(function() if opt~=current then lbl.TextColor3=theme.SubText end end)
				row.MouseButton1Click:Connect(function()
					current = opt
					updateRadio(opt)
					NovaUI:SetFlag(opts.Flag, opt)
					if opts.Callback then task.spawn(opts.Callback, opt) end
				end)
			end

			if opts.Flag then NovaUI.Flags[opts.Flag]=current end
			return {
				Set=function(v) current=v; updateRadio(v) end,
				Get=function() return current end,
			}
		end

		-- ── NEW: Chip / tag group ────────────────────────────────────────
		-- opts: Name, Options={string,...}, DefaultSelected={string,...}, MultiSelect,
		--       MaxSelect, Flag, Callback
		function Tab:CreateChipGroup(opts)
			opts = opts or {}
			local options   = opts.Options or {}
			local multi     = opts.MultiSelect~=false
			local maxSel    = opts.MaxSelect or math.huge
			local selected  = {}

			for _, v in ipairs(opts.DefaultSelected or {}) do selected[v]=true end

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),
					PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10),
				}),
				Create("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder}),
			})
			TopHighlight(holder, zi())

			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamBold, TextSize=12,
					TextColor3=theme.Accent, LetterSpacing=1,
					TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Size=UDim2.new(1,0,0,18),
					ZIndex=zi()+1, Parent=holder,
				})
			end

			local chipRow = Create("Frame",{
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi()+1, Parent=holder,
			},{
				Create("UIGridLayout",{
					CellSize=UDim2.new(0,0,0,26),
					CellPadding=UDim2.new(0,6,0,6),
					FillDirection=Enum.FillDirection.Horizontal,
					SortOrder=Enum.SortOrder.LayoutOrder,
				}),
			})

			local chips = {}
			local function updateChip(opt)
				local chip = chips[opt]
				if not chip then return end
				local sel = selected[opt]==true
				Tween(chip,{
					BackgroundColor3=sel and theme.AccentBg or theme.Stroke,
					TextColor3=sel and theme.Accent or theme.SubText,
				},0.12)
				local sk = chip:FindFirstChildOfClass("UIStroke")
				if sk then Tween(sk,{Color=sel and theme.Accent or theme.StrokeStrong},0.12) end
			end

			for _, opt in ipairs(options) do
				local sel = selected[opt]==true
				local chip = Create("TextButton",{
					Text=" "..tostring(opt).." ",
					Font=Enum.Font.GothamMedium, TextSize=12,
					TextColor3=sel and theme.Accent or theme.SubText,
					BackgroundColor3=sel and theme.AccentBg or theme.Stroke,
					AutomaticSize=Enum.AutomaticSize.X,
					Size=UDim2.new(0,0,0,26), ZIndex=zi()+2, Parent=chipRow,
				},{
					Create("UICorner",{CornerRadius=UDim.new(1,0)}),
					Create("UIStroke",{Color=sel and theme.Accent or theme.StrokeStrong,Thickness=1}),
				})
				PressFeedback(chip)
				chips[opt] = chip

				chip.MouseButton1Click:Connect(function()
					if multi then
						local n=0; for _ in pairs(selected) do n+=1 end
						if not selected[opt] and n>=maxSel then return end
						if selected[opt] then selected[opt]=nil else selected[opt]=true end
					else
						selected = {}; selected[opt]=true
					end
					for _, o in ipairs(options) do updateChip(o) end
					local list={}; for v in pairs(selected) do table.insert(list,v) end
					NovaUI:SetFlag(opts.Flag, list)
					if opts.Callback then task.spawn(opts.Callback, list) end
				end)
			end

			if opts.Flag then
				local list={}; for v in pairs(selected) do table.insert(list,v) end
				NovaUI.Flags[opts.Flag]=list
			end
			return {
				Get=function()
					local list={}; for v in pairs(selected) do table.insert(list,v) end; return list
				end,
				Set=function(vals)
					selected={}; for _,v in ipairs(vals) do selected[v]=true end
					for _,o in ipairs(options) do updateChip(o) end
				end,
			}
		end

		-- ── NEW: Accordion (collapsible section) ─────────────────────────
		-- opts: Title, Content (string OR function(frame)), DefaultOpen, Icon
		function Tab:CreateAccordion(opts)
			opts = opts or {}
			local isOpen = opts.DefaultOpen==true

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, ClipsDescendants=true,
				Size=UDim2.new(1,0,0,40), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			local head = Create("TextButton",{
				Text="", AutoButtonColor=false, BackgroundTransparency=1,
				Size=UDim2.new(1,0,0,40), ZIndex=zi()+1, Parent=holder,
			})
			head.MouseEnter:Connect(function() Tween(holder,{BackgroundColor3=theme.ElevatedHover},0.10) end)
			head.MouseLeave:Connect(function() Tween(holder,{BackgroundColor3=theme.Elevated},0.14) end)

			if opts.Icon then
				Create("ImageLabel",{
					Image=opts.Icon, BackgroundTransparency=1, ImageColor3=theme.Accent,
					Position=UDim2.new(0,12,0.5,-9), Size=UDim2.new(0,18,0,18),
					ZIndex=zi()+2, Parent=head,
				})
			end

			Create("TextLabel",{
				Text=opts.Title or "Section",
				Font=Enum.Font.GothamMedium, TextSize=13, TextColor3=theme.Text,
				TextXAlignment=Enum.TextXAlignment.Left,
				BackgroundTransparency=1,
				Position=UDim2.new(0,opts.Icon and 38 or 14,0,0),
				Size=UDim2.new(1,-50,1,0), ZIndex=zi()+2, Parent=head,
			})

			local chevron = Create("TextLabel",{
				Text="▸", Font=Enum.Font.GothamBold, TextSize=13,
				TextColor3=theme.SubText, BackgroundTransparency=1,
				AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-14,0.5,0),
				Size=UDim2.new(0,14,0,14), ZIndex=zi()+2, Parent=head,
			})

			-- Content frame
			local content = Create("Frame",{
				BackgroundTransparency=1,
				Position=UDim2.new(0,0,0,42),
				Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
				ZIndex=zi()+1, Parent=holder,
			},{
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,14),PaddingRight=UDim.new(0,14),
					PaddingBottom=UDim.new(0,10),
				}),
				Create("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder}),
			})

			-- Divider below header
			Create("Frame",{
				Position=UDim2.new(0,10,0,40), Size=UDim2.new(1,-20,0,1),
				BackgroundColor3=theme.Stroke, BorderSizePixel=0, ZIndex=zi()+1, Parent=holder,
			})

			-- Populate content
			if type(opts.Content)=="string" then
				Create("TextLabel",{
					Text=opts.Content, Font=Enum.Font.Gotham, TextSize=12,
					TextColor3=theme.SubText, TextWrapped=true,
					TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
					Size=UDim2.new(1,0,0,0), ZIndex=zi()+2, Parent=content,
				})
			elseif type(opts.Content)=="function" then
				task.defer(function() opts.Content(content) end)
			end

			local contentH = 0
			local function measure()
				-- defer to let AutomaticSize settle
				task.defer(function()
					contentH = content.AbsoluteSize.Y + 52
					if isOpen then holder.Size = UDim2.new(1,0,0,contentH) end
				end)
			end
			measure()

			local function toggle()
				isOpen = not isOpen
				Tween(chevron,{Rotation=isOpen and 90 or 0},0.18)
				if isOpen then
					task.defer(function()
						contentH = content.AbsoluteSize.Y + 52
						Tween(holder,{Size=UDim2.new(1,0,0,contentH)},0.22,Enum.EasingStyle.Quint)
					end)
				else
					Tween(holder,{Size=UDim2.new(1,0,0,40)},0.18,Enum.EasingStyle.Quint)
				end
			end

			if isOpen then
				chevron.Rotation = 90
				task.defer(function()
					contentH = content.AbsoluteSize.Y + 52
					holder.Size = UDim2.new(1,0,0,contentH)
				end)
			end

			head.MouseButton1Click:Connect(toggle)
			return {
				Open    = function() if not isOpen then toggle() end end,
				Close   = function() if isOpen then toggle() end end,
				Toggle  = toggle,
				Content = content,
			}
		end

		-- ── NEW: Status indicator ────────────────────────────────────────
		-- opts: Label, Status ("Online"|"Offline"|"Busy"|"Away"|custom),
		--       Color (overrides status color), Flag
		function Tab:CreateStatusIndicator(opts)
			opts = opts or {}
			local statusColors = {
				Online  = theme.Success,
				Offline = theme.MutedText,
				Busy    = theme.Danger,
				Away    = theme.Warning,
			}
			local function resolveColor(s)
				return statusColors[s] or theme.Accent
			end

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated, Size=UDim2.new(1,0,0,36),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(holder, zi())

			if opts.Name then
				Create("TextLabel",{
					Text=opts.Name, Font=Enum.Font.GothamMedium, TextSize=13,
					TextColor3=theme.SubText, TextXAlignment=Enum.TextXAlignment.Left,
					BackgroundTransparency=1, Position=UDim2.new(0,14,0,0),
					Size=UDim2.new(0.5,0,1,0), ZIndex=zi()+1, Parent=holder,
				})
			end

			local dotColor = opts.Color or resolveColor(opts.Status)
			local dot = Create("Frame",{
				AnchorPoint=Vector2.new(1,0.5),
				Position=UDim2.new(1,-36,0.5,0),
				Size=UDim2.new(0,10,0,10),
				BackgroundColor3=dotColor, ZIndex=zi()+1, Parent=holder,
			},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

			local statusLbl = Create("TextLabel",{
				Text=opts.Status or "Unknown",
				Font=Enum.Font.Gotham, TextSize=12,
				TextColor3=dotColor, TextXAlignment=Enum.TextXAlignment.Right,
				BackgroundTransparency=1, AnchorPoint=Vector2.new(1,0.5),
				Position=UDim2.new(1,-52,0.5,0), Size=UDim2.new(0,80,0,20),
				ZIndex=zi()+1, Parent=holder,
			})

			-- Pulse animation for Online
			local pulseConn = nil
			local function setPulse(on)
				if pulseConn then pulseConn:Disconnect(); pulseConn=nil end
				if on then
					local t = 0
					pulseConn = RunService.Heartbeat:Connect(function(dt)
						t += dt
						local alpha = (math.sin(t*3)+1)/2
						dot.BackgroundTransparency = alpha*0.5
					end)
					track(pulseConn)
				else
					dot.BackgroundTransparency = 0
				end
			end

			local currentStatus = opts.Status or "Unknown"
			if currentStatus=="Online" then setPulse(true) end

			return {
				SetStatus=function(s, c)
					currentStatus = s
					local col = c or resolveColor(s)
					Tween(dot,{BackgroundColor3=col},0.20)
					Tween(statusLbl,{TextColor3=col},0.20)
					statusLbl.Text = s
					setPulse(s=="Online")
					NovaUI:SetFlag(opts.Flag, s)
				end,
				GetStatus=function() return currentStatus end,
			}
		end

		-- ── NEW: Inline tab group ────────────────────────────────────────
		-- opts: Tabs={{Name,Content(frame→nil)},...}, DefaultTab
		function Tab:CreateTabGroup(opts)
			opts = opts or {}
			local tabs       = opts.Tabs or {}
			local defaultTab = opts.DefaultTab or (tabs[1] and tabs[1].Name)

			local wrapper = Create("Frame",{
				BackgroundColor3=theme.Elevated,
				AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIListLayout",{Padding=UDim.new(0,0),SortOrder=Enum.SortOrder.LayoutOrder}),
			})
			TopHighlight(wrapper, zi())

			-- Header pill row
			local pillRow = Create("Frame",{
				BackgroundColor3=theme.Secondary,
				Size=UDim2.new(1,0,0,36), ZIndex=zi()+1, Parent=wrapper,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIListLayout",{
					FillDirection=Enum.FillDirection.Horizontal,
					HorizontalAlignment=Enum.HorizontalAlignment.Left,
					Padding=UDim.new(0,4),
					SortOrder=Enum.SortOrder.LayoutOrder,
				}),
				Create("UIPadding",{PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6)}),
			})
			-- bottom mask for rounded top-only
			Create("Frame",{
				Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,1,-14),
				BackgroundColor3=theme.Secondary, BorderSizePixel=0, ZIndex=zi()+1, Parent=pillRow,
			})

			-- Content area
			local contentArea = Create("Frame",{
				BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi()+1, Parent=wrapper,
			},{
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),
					PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10),
				}),
			})

			local pages  = {}
			local pillBtns = {}
			local current = nil

			local function selectInline(name)
				for n,page in pairs(pages) do
					page.Visible = (n==name)
				end
				current = name
				for n, btn in pairs(pillBtns) do
					local sel = (n==name)
					Tween(btn,{
						BackgroundColor3=sel and theme.Accent or theme.Secondary,
						TextColor3=sel and Color3.new(0.06,0.06,0.06) or theme.SubText,
						BackgroundTransparency=sel and 0 or 1,
					},0.14)
				end
			end

			for _, t in ipairs(tabs) do
				local page = Create("Frame",{
					Name=t.Name, BackgroundTransparency=1,
					AutomaticSize=Enum.AutomaticSize.Y,
					Size=UDim2.new(1,0,0,0), Visible=false,
					ZIndex=zi()+2, Parent=contentArea,
				},{
					Create("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder}),
				})
				pages[t.Name] = page

				local pill = Create("TextButton",{
					Text=t.Name, Font=Enum.Font.GothamMedium, TextSize=12,
					TextColor3=theme.SubText, BackgroundColor3=theme.Accent,
					BackgroundTransparency=1,
					AutomaticSize=Enum.AutomaticSize.X, Size=UDim2.new(0,0,0,26),
					ZIndex=zi()+2, Parent=pillRow,
				},{
					Create("UICorner",{CornerRadius=UDim.new(0,8)}),
					Create("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12)}),
				})
				pillBtns[t.Name] = pill
				pill.MouseButton1Click:Connect(function() selectInline(t.Name) end)

				if t.Content and type(t.Content)=="function" then
					task.defer(function() t.Content(page) end)
				end
			end

			selectInline(defaultTab)

			return {
				Select=selectInline,
				GetCurrent=function() return current end,
				Pages=pages,
			}
		end

		-- ── NEW: Skeleton / shimmer loader ───────────────────────────────
		-- opts: Lines (number of shimmer lines), Height (of each), Name
		function Tab:CreateSkeleton(opts)
			opts = opts or {}
			local lineCount = opts.Lines  or 3
			local lineH     = opts.Height or 16

			local holder = Create("Frame",{
				BackgroundColor3=theme.Elevated,
				AutomaticSize=Enum.AutomaticSize.Y,
				Size=UDim2.new(1,0,0,0), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,14),PaddingRight=UDim.new(0,14),
					PaddingTop=UDim.new(0,12),PaddingBottom=UDim.new(0,12),
				}),
				Create("UIListLayout",{Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder}),
			})

			local widths = {0.85, 0.65, 0.75, 0.55, 0.80}
			for i=1,lineCount do
				local w = widths[(i-1)%#widths+1]
				local line = Create("Frame",{
					BackgroundColor3=theme.Stroke, Size=UDim2.new(w,0,0,lineH),
					ClipsDescendants=true, ZIndex=zi()+1, Parent=holder,
				},{Create("UICorner",{CornerRadius=UDim.new(0,6)})})

				-- Shimmer sweep via UIGradient animated by offset
				local grad = Create("UIGradient",{
					Color=ColorSequence.new({
						ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,255,255)),
						ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255,255,255)),
						ColorSequenceKeypoint.new(0.5,  Lighten(theme.Stroke,0.18)),
						ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255,255,255)),
						ColorSequenceKeypoint.new(1,   Color3.fromRGB(255,255,255)),
					}),
					Transparency=NumberSequence.new({
						NumberSequenceKeypoint.new(0,   0.55),
						NumberSequenceKeypoint.new(0.45, 0.55),
						NumberSequenceKeypoint.new(0.5,  0.1),
						NumberSequenceKeypoint.new(0.55, 0.55),
						NumberSequenceKeypoint.new(1,   0.55),
					}),
					Rotation=10,
					Parent=line,
				})

				-- Animate the gradient offset to sweep across
				local t0 = tick() + i*0.15
				local shimConn = RunService.Heartbeat:Connect(function()
					local t = (tick()-t0)%2/2  -- 0→1 every 2s
					grad.Offset = Vector2.new(t*2-0.5, 0)
				end)
				track(shimConn)
			end

			return {
				-- Replace skeleton with actual content
				Replace=function(buildFn)
					holder:ClearAllChildren()
					local layout = Create("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=holder})
					local stroke = holder:FindFirstChildOfClass("UIStroke")
					if stroke then stroke:Destroy() end
					buildFn(holder)
				end,
				Destroy=function() holder:Destroy() end,
			}
		end

		-- ── Config manager ───────────────────────────────────────────────
		function Tab:CreateConfigManager()
			self:CreateSection("Configuration")

			local saveBtn = Create("TextButton",{
				Text="Export Config", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, BackgroundColor3=theme.Elevated,
				Size=UDim2.new(1,0,0,38), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(saveBtn, zi())
			PressFeedback(saveBtn)
			HoverBg(saveBtn,theme.Elevated,theme.ElevatedHover)

			self:CreateSeparatorLabel("Import")

			local importBox = Create("TextBox",{
				Text="", PlaceholderText="Paste config string here…",
				Font=Enum.Font.Code, TextSize=11,
				TextColor3=theme.Text, PlaceholderColor3=theme.MutedText,
				ClearTextOnFocus=false, MultiLine=true, TextWrapped=true,
				TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
				BackgroundColor3=theme.Background, Size=UDim2.new(1,0,0,68),
				ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,10)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10),
					PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,8),
				}),
			})
			local impStroke = importBox:FindFirstChildOfClass("UIStroke")
			importBox.Focused:Connect(function() if impStroke then Tween(impStroke,{Color=theme.Accent},0.14) end end)
			importBox.FocusLost:Connect(function() if impStroke then Tween(impStroke,{Color=theme.Stroke},0.14) end end)

			local loadBtn = Create("TextButton",{
				Text="Load Config", Font=Enum.Font.GothamMedium, TextSize=13,
				TextColor3=theme.Text, BackgroundColor3=theme.Elevated,
				Size=UDim2.new(1,0,0,38), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
			})
			TopHighlight(loadBtn, zi())
			PressFeedback(loadBtn)
			HoverBg(loadBtn,theme.Elevated,theme.ElevatedHover)

			-- Export box shown below load area (logical order: export appears after you hit Save)
			local exportBox = Create("TextBox",{
				Text="", PlaceholderText='Exported config appears here after clicking "Export Config".',
				Font=Enum.Font.Code, TextSize=11,
				TextColor3=theme.SubText, PlaceholderColor3=theme.MutedText,
				ClearTextOnFocus=false, MultiLine=true, TextWrapped=true,
				TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top,
				BackgroundColor3=theme.Background, Size=UDim2.new(1,0,0,68),
				Visible=false, ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,10)}),
				Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
				Create("UIPadding",{
					PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10),
					PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,8),
				}),
			})

			saveBtn.MouseButton1Click:Connect(function()
				local str = NovaUI:ExportConfig()
				if str then
					exportBox.Text=str; exportBox.Visible=true
					NovaUI:Notify({Title="Config",Type="Success",Content="Exported — select all and copy.",Duration=4})
				else
					NovaUI:Notify({Title="Config",Type="Danger",Content="Nothing to export yet.",Duration=3})
				end
			end)

			loadBtn.MouseButton1Click:Connect(function()
				if Trim(importBox.Text)=="" then
					NovaUI:Notify({Title="Config",Type="Warning",Content="Paste a config string first.",Duration=3})
					return
				end
				if NovaUI:ImportConfig(importBox.Text) then
					NovaUI:Notify({Title="Config",Type="Success",Content="Loaded — call Set() on components to apply.",Duration=5})
				else
					NovaUI:Notify({Title="Config",Type="Danger",Content="Couldn't parse that string.",Duration=4})
				end
			end)

			local resetBtn = Create("TextButton",{
				Text="Reset All Flags", Font=Enum.Font.GothamMedium, TextSize=12,
				TextColor3=theme.Danger, BackgroundColor3=theme.DangerBg,
				Size=UDim2.new(1,0,0,32), ZIndex=zi(), Parent=Page,
			},{
				Create("UICorner",{CornerRadius=UDim.new(0,12)}),
				Create("UIStroke",{Color=theme.Danger,Thickness=1}),
			})
			PressFeedback(resetBtn)
			resetBtn.MouseButton1Click:Connect(function()
				NovaUI:ResetFlags()
				importBox.Text=""; exportBox.Text=""; exportBox.Visible=false
				NovaUI:Notify({Title="Config",Type="Warning",Content="All flags reset to nil.",Duration=3})
			end)
		end

		return Tab
	end -- Window:CreateTab

	table.insert(NovaUI.Windows, Window)
	return Window
end

--// ─────────────────────────── CONFIRM DIALOG ────────────────────────────── //

function NovaUI:CreateConfirmDialog(opts)
	opts = opts or {}
	local target = NovaUI.Windows[#NovaUI.Windows]
	if not target then return end
	local theme = target.Theme or Themes.Dark
	local sg    = target.ScreenGui

	local overlay = Create("Frame",{
		Name="ConfirmOverlay",
		Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.new(0,0,0),
		BackgroundTransparency=1, ZIndex=60, Parent=sg,
	})
	Tween(overlay,{BackgroundTransparency=0.55},0.18)

	local dialog = Create("Frame",{
		Name="ConfirmDialog",
		AnchorPoint=Vector2.new(0.5,0.5),
		Position=UDim2.new(0.5,0,0.48,0),
		Size=UDim2.new(0,320,0,0), AutomaticSize=Enum.AutomaticSize.Y,
		BackgroundColor3=theme.Secondary, BackgroundTransparency=1,
		ZIndex=61, Parent=sg,
	},{
		Create("UICorner",{CornerRadius=UDim.new(0,16)}),
		Create("UIStroke",{Color=theme.StrokeStrong,Thickness=1}),
		Create("UIPadding",{
			PaddingLeft=UDim.new(0,20),PaddingRight=UDim.new(0,20),
			PaddingTop=UDim.new(0,20),PaddingBottom=UDim.new(0,18),
		}),
		Create("UIListLayout",{Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder}),
	})
	TopHighlight(dialog, 62)

	dialog.Size = UDim2.new(0,300,0,0)
	Tween(dialog,{BackgroundTransparency=0,Size=UDim2.new(0,320,0,0)},0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

	Create("TextLabel",{
		Text=opts.Title or "Are you sure?",
		Font=Enum.Font.GothamBold, TextSize=15, TextColor3=theme.Text,
		TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
		BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
		Size=UDim2.new(1,0,0,0), ZIndex=62, Parent=dialog,
	})
	Create("TextLabel",{
		Text=opts.Message or "This action cannot be undone.",
		Font=Enum.Font.Gotham, TextSize=13, TextColor3=theme.SubText,
		TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
		BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
		Size=UDim2.new(1,0,0,0), ZIndex=62, Parent=dialog,
	})

	local btnRow = Create("Frame",{
		BackgroundTransparency=1, Size=UDim2.new(1,0,0,36), ZIndex=62, Parent=dialog,
	})
	Create("UIListLayout",{
		FillDirection=Enum.FillDirection.Horizontal,
		HorizontalAlignment=Enum.HorizontalAlignment.Right,
		Padding=UDim.new(0,8), SortOrder=Enum.SortOrder.LayoutOrder,
		Parent=btnRow,
	})

	local function closeDialog()
		Tween(overlay,{BackgroundTransparency=1},0.14)
		Tween(dialog, {BackgroundTransparency=1},0.14)
		task.wait(0.15)
		overlay:Destroy(); dialog:Destroy()
	end

	local cancelBtn = Create("TextButton",{
		Text=opts.CancelText or "Cancel",
		Font=Enum.Font.GothamMedium, TextSize=13,
		TextColor3=theme.SubText, BackgroundColor3=theme.Elevated,
		Size=UDim2.new(0,90,0,36), ZIndex=63, Parent=btnRow,
	},{
		Create("UICorner",{CornerRadius=UDim.new(0,10)}),
		Create("UIStroke",{Color=theme.Stroke,Thickness=1}),
	})
	PressFeedback(cancelBtn)
	cancelBtn.MouseButton1Click:Connect(function()
		closeDialog()
		if opts.OnCancel then task.spawn(opts.OnCancel) end
	end)

	local confirmBtn = Create("TextButton",{
		Text=opts.ConfirmText or "Confirm",
		Font=Enum.Font.GothamBold, TextSize=13,
		TextColor3=opts.Danger and Color3.new(1,1,1) or Color3.new(0.06,0.06,0.06),
		BackgroundColor3=opts.Danger and theme.Danger or theme.Accent,
		Size=UDim2.new(0,100,0,36), ZIndex=63, Parent=btnRow,
	},{Create("UICorner",{CornerRadius=UDim.new(0,10)})})
	PressFeedback(confirmBtn)
	confirmBtn.MouseButton1Click:Connect(function()
		closeDialog()
		if opts.OnConfirm then task.spawn(opts.OnConfirm) end
	end)

	return {Close=closeDialog}
end

--// ─────────────────────────── SERIALIZATION ─────────────────────────────── //

local function serializeVal(v)
	local t = typeof(v)
	if     t=="Color3"  then return {__type="Color3",  r=v.R,  g=v.G,  b=v.B}
	elseif t=="EnumItem"then return {__type="Enum", enum=tostring(v.EnumType), name=v.Name}
	elseif t=="Vector2" then return {__type="Vector2", x=v.X, y=v.Y}
	elseif t=="Vector3" then return {__type="Vector3", x=v.X, y=v.Y, z=v.Z}
	else                      return v end
end

local function deserializeVal(v)
	if typeof(v)~="table" then return v end
	if v.__type=="Color3"  then return Color3.new(v.r, v.g, v.b) end
	if v.__type=="Vector2" then return Vector2.new(v.x, v.y) end
	if v.__type=="Vector3" then return Vector3.new(v.x, v.y, v.z) end
	if v.__type=="Enum" then
		local ok, item = pcall(function() return Enum[v.enum][v.name] end)
		return ok and item or nil
	end
	return v
end

function NovaUI:ExportConfig()
	local s = {}
	for flag, val in pairs(NovaUI.Flags) do s[flag]=serializeVal(val) end
	local ok, enc = pcall(function() return HttpService:JSONEncode(s) end)
	return ok and enc or nil
end

function NovaUI:ImportConfig(json)
	local ok, dec = pcall(function() return HttpService:JSONDecode(json) end)
	if not ok or typeof(dec)~="table" then return false end
	for flag, val in pairs(dec) do NovaUI:SetFlag(flag, deserializeVal(val)) end
	return true
end

--// ──────────────────────────── NOTIFICATIONS ────────────────────────────── //

function NovaUI:Notify(opts)
	opts = opts or {}
	local target = (self.ScreenGui and self) or NovaUI.Windows[#NovaUI.Windows]
	if not target then return end
	local theme  = target.Theme or Themes.Dark
	local holder = target.ScreenGui:FindFirstChild("Notifications")
	if not holder then return end

	-- FIX: animate out oldest before destroying
	local MAX = 6
	local existing = {}
	for _, c in ipairs(holder:GetChildren()) do
		if c:IsA("Frame") then table.insert(existing,c) end
	end
	if #existing>=MAX then
		local oldest = existing[1]
		Tween(oldest,{BackgroundTransparency=1, Size=UDim2.new(1,0,0,0)},0.16)
		task.delay(0.17,function() pcall(function() oldest:Destroy() end) end)
	end

	local accent = theme.Accent
	local acBg   = theme.AccentBg
	if     opts.Type=="Success"           then accent=theme.Success; acBg=theme.SuccessBg
	elseif opts.Type=="Danger" or opts.Type=="Error" then accent=theme.Danger; acBg=theme.DangerBg
	elseif opts.Type=="Warning"           then accent=theme.Warning; acBg=theme.WarningBg
	elseif opts.Type=="Info"              then accent=theme.Info;    acBg=theme.InfoBg end

	local typeIcons = {Success="✓",Danger="✕",Warning="⚠",Info="ℹ"}
	local iconText  = typeIcons[opts.Type] or "●"
	local dur       = opts.Duration or 4

	local wrapper = Create("Frame",{
		BackgroundTransparency=1, ClipsDescendants=true,
		Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
		ZIndex=50, Parent=holder,
	})

	local card = Create("Frame",{
		BackgroundColor3=theme.Secondary,
		Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
		Position=UDim2.new(1,50,0,0), BackgroundTransparency=1,
		ZIndex=51, Parent=wrapper,
	},{
		Create("UICorner",{CornerRadius=UDim.new(0,14)}),
		Create("UIStroke",{Color=theme.StrokeStrong,Thickness=1,Transparency=1}),
		Create("UIPadding",{
			PaddingLeft=UDim.new(0,42),PaddingRight=UDim.new(0,14),
			PaddingTop=UDim.new(0,11),PaddingBottom=UDim.new(0,11),
		}),
		Create("UIListLayout",{Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder}),
	})

	Create("Frame",{
		Size=UDim2.new(0,4,1,-22), Position=UDim2.new(0,0,0,11),
		BackgroundColor3=accent, BorderSizePixel=0, ZIndex=53, Parent=card,
	},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

	Create("TextLabel",{
		Text=iconText, Font=Enum.Font.GothamBold, TextSize=13,
		TextColor3=accent, BackgroundColor3=acBg,
		AnchorPoint=Vector2.new(0,0.5), Position=UDim2.new(0,8,0.5,0),
		Size=UDim2.new(0,24,0,24), ZIndex=53, Parent=card,
	},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

	Create("TextLabel",{
		Text=opts.Title or "Notification",
		Font=Enum.Font.GothamBold, TextSize=13, TextColor3=theme.Text,
		TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
		BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
		Size=UDim2.new(1,0,0,0), ZIndex=52, Parent=card,
	})
	Create("TextLabel",{
		Text=opts.Content or "",
		Font=Enum.Font.Gotham, TextSize=12, TextColor3=theme.SubText,
		TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
		BackgroundTransparency=1, AutomaticSize=Enum.AutomaticSize.Y,
		Size=UDim2.new(1,0,0,0), ZIndex=52, Parent=card,
	})

	local pTrack = Create("Frame",{
		Size=UDim2.new(1,0,0,2), BackgroundColor3=theme.Stroke,
		BorderSizePixel=0, ZIndex=53, Parent=card,
	},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})
	local pFill = Create("Frame",{
		Size=UDim2.new(1,0,1,0), BackgroundColor3=accent,
		BorderSizePixel=0, ZIndex=54, Parent=pTrack,
	},{Create("UICorner",{CornerRadius=UDim.new(1,0)})})

	local catcher = Create("TextButton",{
		Text="", AutoButtonColor=false, BackgroundTransparency=1,
		Size=UDim2.new(1,0,1,0), ZIndex=55, Parent=card,
	})
	local xBtn = Create("TextButton",{
		Text="✕", Font=Enum.Font.GothamBold, TextSize=10,
		TextColor3=theme.SubText, BackgroundTransparency=1,
		AnchorPoint=Vector2.new(1,0), Position=UDim2.new(1,0,0,0),
		Size=UDim2.new(0,20,0,20), ZIndex=56, Parent=card,
	})

	local stroke = card:FindFirstChildOfClass("UIStroke")
	Tween(card,  {Position=UDim2.new(0,0,0,0),BackgroundTransparency=0},0.32,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
	if stroke then Tween(stroke,{Transparency=0},0.28) end
	Tween(pFill,{Size=UDim2.new(0,0,1,0)},dur,Enum.EasingStyle.Linear)

	local dismissed = false
	local function dismiss()
		if dismissed then return end
		dismissed = true
		Tween(card,{Position=UDim2.new(1,50,0,0),BackgroundTransparency=1},0.20,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
		if stroke then Tween(stroke,{Transparency=1},0.16) end
		task.wait(0.21)
		wrapper.AutomaticSize = Enum.AutomaticSize.None
		wrapper.Size = UDim2.new(1,0,0,wrapper.AbsoluteSize.Y)
		Tween(wrapper,{Size=UDim2.new(1,0,0,0)},0.18)
		task.wait(0.19)
		pcall(function() wrapper:Destroy() end)
	end

	catcher.MouseButton1Click:Connect(function() task.spawn(dismiss) end)
	xBtn.MouseButton1Click:Connect(function() task.spawn(dismiss) end)
	task.delay(dur, function() task.spawn(dismiss) end)
end

--// ───────────────────────────── EXPOSE API ──────────────────────────────── //

NovaUI.Themes = Themes

return NovaUI
