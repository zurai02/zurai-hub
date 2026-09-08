local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DarkHubTrollGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.7
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(0,0,0)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topText = Instance.new("TextLabel")
topText.Size = UDim2.new(1,0,1,0)
topText.BackgroundTransparency = 1
topText.Text = "Troll is a Pinning Tower 2"
topText.TextColor3 = Color3.fromRGB(255,255,255)
topText.TextScaled = true
topText.Font = Enum.Font.GothamBold
topText.Parent = topBar

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        update(dragInput)
    end
end)

local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.Position = UDim2.new(0.5, -100, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,8)
    btnCorner.Parent = btn

    return btn
end

local tpButton = createButton("Troll Button", 60)
local trollButton = createButton("Troll: OFF", 120)
local winButton = createButton("Win", 180)
local bridgeButton = createButton("Bridge Troll: OFF", 240)

tpButton.MouseButton1Click:Connect(function()
    root.CFrame = CFrame.new(-78.82, 147.17, -81.17)
end)

local trollActive = false
local trollCoords = {
    Vector3.new(-23.29, 143.65, -81.20),
    Vector3.new(-34.29, 143.65, -81.20),
    Vector3.new(-45.29, 143.65, -81.20),
    Vector3.new(-78.82, 147.17, -81.17)
}

trollButton.MouseButton1Click:Connect(function()
    trollActive = not trollActive
    trollButton.Text = "Troll: "..(trollActive and "ON" or "OFF")
    trollButton.BackgroundColor3 = trollActive and Color3.fromRGB(0,120,0) or Color3.fromRGB(40,40,40)

    if trollActive then
        spawn(function()
            while trollActive do
                for _,v in ipairs(trollCoords) do
                    root.CFrame = CFrame.new(v)
                    wait(0.1)
                    if not trollActive then break end
                end
            end
        end)
    end
end)

winButton.MouseButton1Click:Connect(function()
    root.CFrame = CFrame.new(282.21, 348.65, -33.70)
end)

local bridgeStart = Vector3.new(-75.29, 142.65, -66.70)
local bridgeEnd = Vector3.new(-75.29, 143.65, 0.80)
local bridgeActive = false

bridgeButton.MouseButton1Click:Connect(function()
    bridgeActive = not bridgeActive
    bridgeButton.Text = "Bridge: "..(bridgeActive and "ON" or "OFF")
    bridgeButton.BackgroundColor3 = bridgeActive and Color3.fromRGB(0,120,0) or Color3.fromRGB(40,40,40)

    if bridgeActive then
        spawn(function()
            while bridgeActive do
                local tween1 = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame=CFrame.new(bridgeEnd)})
                tween1:Play()
                tween1.Completed:Wait()
                if not bridgeActive then break end
                local tween2 = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame=CFrame.new(bridgeStart)})
                tween2:Play()
                tween2.Completed:Wait()
            end
        end)
    end
end)
