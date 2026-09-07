local Rayfield
local success, result = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
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

UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled then
        local char = getCharacter()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RunService.Stepped:Connect(function()
    if NoclipEnabled then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

local function applyESP(player)
    if player == LocalPlayer then return end
    
    local function setupChar(char)
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

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = player.Name
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.Parent = billboard

            billboard.Parent = head
        end
    end

    if player.Character then
        setupChar(player.Character)
    end
    player.CharacterAdded:Connect(setupChar)
end

local function removeESP(player)
    if player.Character then
        local highlight = player.Character:FindFirstChild("ZuraiESP_Highlight")
        if highlight then highlight:Destroy() end
        
        local head = player.Character:FindFirstChild("Head")
        if head then
            local tag = head:FindFirstChild("ZuraiESP_Tag")
            if tag then tag:Destroy() end
        end
    end
end

local function toggleESP(state)
    ESPEnabled = state
    if ESPEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            applyESP(player)
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            removeESP(player)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        applyESP(player)
    end
end)

local MainTab = Window:CreateTab("Player", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 250},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      WalkSpeedValue = Value
      local char = LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
          char:FindFirstChildOfClass("Humanoid").WalkSpeed = WalkSpeedValue
      end
   end,
})

MainTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      JumpPowerValue = Value
      local char = LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
          local hum = char:FindFirstChildOfClass("Humanoid")
          hum.UseJumpPower = true
          hum.JumpPower = JumpPowerValue
      end
   end,
})

MainTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
      InfJumpEnabled = Value
   end,
})

MainTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      NoclipEnabled = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      toggleESP(Value)
   end,
})

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = WalkSpeedValue
    hum.UseJumpPower = true
    hum.JumpPower = JumpPowerValue
end)
