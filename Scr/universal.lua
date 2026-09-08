local Rayfield
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not result then
    warn("[Zurai Hub] Failed to load Rayfield. Using fallback.")
    return
end

Rayfield = result

local Window = Rayfield:CreateWindow({
    Name = "Zurai Hub | Universal",
    Icon = 0,
    LoadingTitle = "Zurai Hub Loading...",
    LoadingSubtitle = "by zurai02",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "ZuraiHub"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local WalkSpeedValue = 16
local JumpPowerValue = 50
local InfJumpEnabled = false
local NoclipEnabled = false
local ESPEnabled = false

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

UserInputService.JumpRequest:Connect(function()
    if not InfJumpEnabled then return end
    local hum = getHumanoid()
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RunService.Stepped:Connect(function()
    if not NoclipEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

local function setupESP(player, char)
    if not char then return end

    if not char:FindFirstChild("ZuraiESP_Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ZuraiESP_Highlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Adornee = char
        highlight.Parent = char
    end

    local head = char:WaitForChild("Head", 5)
    if head and not head:FindFirstChild("ZuraiESP_Tag") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ZuraiESP_Tag"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = player.Name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
        label.Parent = billboard

        billboard.Parent = head
    end
end

local function applyESP(player)
    if player == LocalPlayer then return end
    if player.Character then setupESP(player, player.Character) end
    player.CharacterAdded:Connect(function(char) setupESP(player, char) end)
end

local function removeESP(player)
    local char = player.Character
    if not char then return end

    local highlight = char:FindFirstChild("ZuraiESP_Highlight")
    if highlight then highlight:Destroy() end

    local head = char:FindFirstChild("Head")
    if head then
        local tag = head:FindFirstChild("ZuraiESP_Tag")
        if tag then tag:Destroy() end
    end
end

local function toggleESP(state)
    ESPEnabled = state
    for _, player in ipairs(Players:GetPlayers()) do
        if ESPEnabled then applyESP(player) else removeESP(player) end
    end
end

Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then applyESP(player) end
end)

local MainTab    = Window:CreateTab("Player",  4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(val)
        WalkSpeedValue = val
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = val end
    end
})

MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(val)
        JumpPowerValue = val
        local hum = getHumanoid()
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = val
        end
    end
})

MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(val)
        InfJumpEnabled = val
    end
})

MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(val)
        NoclipEnabled = val
    end
})

VisualsTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(val)
        toggleESP(val)
    end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = WalkSpeedValue
    hum.UseJumpPower = true
    hum.JumpPower = JumpPowerValue
end)
