local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local cam = workspace.CurrentCamera

local dmgEvent = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("DamagePlayer")
if dmgEvent then
    dmgEvent:FireServer(-math.huge)
    print("worked!")
else
    warn("You Haven't loaded in!")
end

task.wait(1)

local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local settings = {
    autoHunger = false,
    autoFarm = false,
    autoBreak = false,
    noclipActive = false,
    playerEsp = false,
    itemEsp = false,
    hitboxes = {
        wolves = false,
        rabbits = false,
        cultists = false,
        size = 15,
        visible = false
    }
}

local function notify(title, msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = msg,
        Duration = 3
    })
end

local function getRoot()
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
end

local function bringItems(itemName)
    local root = getRoot()
    if not root then return end
    for _, v in pairs(workspace.Items:GetChildren()) do
        if string.find(string.lower(v.Name), string.lower(itemName)) then
            local part = v:FindFirstChildOfClass("BasePart")
            if part then
                part.CFrame = root.CFrame * CFrame.new(math.random(-3, 3), 2, math.random(-3, 3))
            end
        end
    end
end

local function makeEsp(obj, color, text)
    if not obj then return end

    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = color
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj

    local gui = Instance.new("BillboardGui")
    gui.Size = UDim2.new(0, 100, 0, 50)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.Parent = obj

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextScaled = true
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.Parent = gui
end

local function removeEsp(obj)
    if not obj then return end
    local highlight = obj:FindFirstChild("Highlight")
    if highlight then highlight:Destroy() end
    local gui = obj:FindFirstChild("BillboardGui")
    if gui then gui:Destroy() end
end

local function updateHitboxes()
    for _, v in pairs(workspace.Characters:GetChildren()) do
        local hrp = v:FindFirstChild("HumanoidRootPart")
        if hrp then
            local name = string.lower(v.Name)
            local shouldExpand = 
                (settings.hitboxes.wolves and (name:find("wolf") or name:find("alpha"))) or
                (settings.hitboxes.rabbits and name:find("bunny")) or
                (settings.hitboxes.cultists and name:find("cultist"))

            if shouldExpand then
                hrp.Size = Vector3.new(settings.hitboxes.size, settings.hitboxes.size, settings.hitboxes.size)
                hrp.Transparency = settings.hitboxes.visible and 0.7 or 1
                hrp.CanCollide = false
                hrp.Color = Color3.new(1, 0, 0)
                hrp.Material = Enum.Material.ForceField
            end
        end
    end
end

local window = ui:CreateWindow({
    Title = "99 nights helper",
    Size = UDim2.fromOffset(600, 450),
    Theme = "Dark"
})

local mainTab    = window:Tab({ Title = "Main",   Icon = "home"     })
local playerTab  = window:Tab({ Title = "Player", Icon = "user"     })
local farmTab    = window:Tab({ Title = "Farm",   Icon = "zap"      })
local itemTab    = window:Tab({ Title = "Items",  Icon = "package"  })
local espTab     = window:Tab({ Title = "ESP",    Icon = "eye"      })
local hitboxTab  = window:Tab({ Title = "Hitbox", Icon = "target"   })
local miscTab    = window:Tab({ Title = "Misc",   Icon = "settings" })

mainTab:Toggle({
    Title = "Auto Feed",
    Default = false,
    Callback = function(state)
        settings.autoHunger = state
        if not state then return end
        task.spawn(function()
            local remote = ReplicatedStorage.RemoteEvents:FindFirstChild("RequestConsumeItem")
            while settings.autoHunger and remote do
                pcall(function()
                    remote:InvokeServer(Instance.new("Model"))
                end)
                task.wait(1.5)
            end
        end)
    end
})

mainTab:Button({
    Title = "Cook All Meat",
    Callback = function()
        local campfire = Vector3.new(1.87, 4.33, -3.67)
        for _, v in pairs(workspace.Items:GetChildren()) do
            if string.find(string.lower(v.Name), "meat") then
                local part = v:FindFirstChildOfClass("BasePart")
                if part then
                    part.CFrame = CFrame.new(campfire + Vector3.new(math.random(-1, 1), 1, math.random(-1, 1)))
                end
            end
        end
        notify("Cooking", "moved meat to campfire")
    end
})

playerTab:Slider({
    Title = "Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(val)
        local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
})

playerTab:Slider({
    Title = "Jump",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(val)
        local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
        if hum then hum.JumpPower = val end
    end
})

playerTab:Toggle({
    Title = "Noclip",
    Default = false,
    Callback = function(state)
        settings.noclipActive = state
        if not state then return end
        task.spawn(function()
            while settings.noclipActive do
                if plr.Character then
                    for _, v in pairs(plr.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
                RunService.Heartbeat:Wait()
            end
        end)
    end
})

playerTab:Toggle({
    Title = "God Mode",
    Default = false,
    Callback = function(state)
        local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
        if not hum then return end
        if state then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
        else
            hum.MaxHealth = 100
            hum.Health = 100
        end
    end
})

farmTab:Toggle({
    Title = "Auto Tree Farm",
    Default = false,
    Callback = function(state)
        settings.autoFarm = state
        if not state then return end
        task.spawn(function()
            local toolDamage = ReplicatedStorage.RemoteEvents:FindFirstChild("ToolDamageObject")
            while settings.autoFarm do
                local trees = {}
                if workspace:FindFirstChild("Map") then
                    local landmarks = workspace.Map:FindFirstChild("Landmarks") or workspace.Map:FindFirstChild("Foliage")
                    if landmarks then
                        for _, v in pairs(landmarks:GetChildren()) do
                            if v.Name == "Small Tree" and v:FindFirstChild("Trunk") then
                                table.insert(trees, v)
                            end
                        end
                    end
                end

                for _, tree in pairs(trees) do
                    if not settings.autoFarm then break end
                    if tree and tree.Parent then
                        local myChar = plr.Character
                        local root = myChar and myChar:FindFirstChild("HumanoidRootPart")
                        if root and tree:FindFirstChild("Trunk") then
                            root.CFrame = tree.Trunk.CFrame * CFrame.new(3, 0, 0)
                            task.wait(0.3)

                            local axe = nil
                            if plr:FindFirstChild("Inventory") then
                                axe = plr.Inventory:FindFirstChild("Old Axe") or plr.Inventory:FindFirstChild("Good Axe")
                            end

                            if axe then
                                if axe.Parent == plr.Backpack then
                                    axe.Parent = myChar
                                    task.wait(0.2)
                                end

                                while tree.Parent and settings.autoFarm do
                                    pcall(function()
                                        axe:Activate()
                                        if toolDamage then
                                            toolDamage:InvokeServer(tree, axe, "1_8264699301", tree.Trunk.CFrame)
                                        end
                                    end)
                                    task.wait(0.8)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
                task.wait(2)
            end
        end)
    end
})

farmTab:Toggle({
    Title = "Auto Break (look at tree)",
    Default = false,
    Callback = function(state)
        settings.autoBreak = state
        if not state then return end
        task.spawn(function()
            while settings.autoBreak do
                local weapon = nil
                if plr:FindFirstChild("Inventory") then
                    weapon = plr.Inventory:FindFirstChild("Old Axe")
                        or plr.Inventory:FindFirstChild("Good Axe")
                        or plr.Inventory:FindFirstChild("Strong Axe")
                end

                if weapon then
                    local ray = workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 20)
                    if ray and ray.Instance and ray.Instance.Name == "Trunk" then
                        pcall(function()
                            ReplicatedStorage.RemoteEvents.ToolDamageObject:InvokeServer(
                                ray.Instance.Parent, weapon, "4_7591937906", CFrame.new(ray.Position)
                            )
                        end)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})

local itemList = {
    "Log", "Stone", "Rope", "Nails", "Scrap", "Wood", "Cloth",
    "Bandage", "Meat", "Spear", "Knife", "Revolver", "Rifle",
    "Ammo", "Coal", "Oil", "Radio"
}

for _, item in pairs(itemList) do
    itemTab:Button({
        Title = "Get " .. item,
        Callback = function()
            bringItems(item)
            notify("Items", "brought " .. item)
        end
    })
end

itemTab:Button({
    Title = "Bring Everything",
    Callback = function()
        local root = getRoot()
        if not root then return end
        for _, v in pairs(workspace.Items:GetChildren()) do
            local part = v:FindFirstChildOfClass("BasePart")
            if part then
                part.CFrame = root.CFrame * CFrame.new(math.random(-8, 8), 0, math.random(-8, 8))
            end
        end
        notify("Items", "brought all items")
    end
})

espTab:Toggle({
    Title = "Player ESP",
    Default = false,
    Callback = function(state)
        settings.playerEsp = state
        task.spawn(function()
            while settings.playerEsp do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= plr and player.Character and not player.Character:FindFirstChild("Highlight") then
                        makeEsp(player.Character, Color3.new(0, 1, 0), player.Name)
                    end
                end
                task.wait(1)
            end
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then removeEsp(player.Character) end
            end
        end)
    end
})

espTab:Toggle({
    Title = "Item ESP",
    Default = false,
    Callback = function(state)
        settings.itemEsp = state
        task.spawn(function()
            while settings.itemEsp do
                for _, item in pairs(workspace.Items:GetChildren()) do
                    if item:IsA("Model") and not item:FindFirstChild("Highlight") then
                        makeEsp(item, Color3.new(1, 1, 0), item.Name)
                    end
                end
                task.wait(2)
            end
            for _, item in pairs(workspace.Items:GetChildren()) do
                removeEsp(item)
            end
        end)
    end
})

hitboxTab:Toggle({ Title = "Wolf Hitbox",    Default = false, Callback = function(state) settings.hitboxes.wolves   = state end })
hitboxTab:Toggle({ Title = "Rabbit Hitbox",  Default = false, Callback = function(state) settings.hitboxes.rabbits  = state end })
hitboxTab:Toggle({ Title = "Cultist Hitbox", Default = false, Callback = function(state) settings.hitboxes.cultists = state end })

hitboxTab:Slider({
    Title = "Hitbox Size",
    Min = 5,
    Max = 50,
    Default = 15,
    Callback = function(val)
        settings.hitboxes.size = val
    end
})

hitboxTab:Toggle({
    Title = "Show Hitboxes",
    Default = false,
    Callback = function(state)
        settings.hitboxes.visible = state
    end
})

miscTab:Toggle({
    Title = "Fast Interact",
    Default = false,
    Callback = function(state)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = state and 0 or 0.5
            end
        end
    end
})

miscTab:Button({
    Title = "Kill Rabbits",
    Callback = function()
        for _, v in pairs(workspace.Characters:GetChildren()) do
            local hum = v.Name == "Bunny" and v:FindFirstChild("Humanoid")
            if hum then hum.Health = 0 end
        end
        notify("Combat", "killed all rabbits")
    end
})

miscTab:Button({
    Title = "Kill Wolves",
    Callback = function()
        for _, v in pairs(workspace.Characters:GetChildren()) do
            local hum = v.Name == "Wolf" and v:FindFirstChild("Humanoid")
            if hum then hum.Health = 0 end
        end
        notify("Combat", "killed all wolves")
    end
})

miscTab:Button({
    Title = "Teleport to Camp",
    Callback = function()
        local root = getRoot()
        if root then root.CFrame = CFrame.new(13.287, 3.999, 0.362) end
    end
})

task.spawn(function()
    while true do
        updateHitboxes()
        task.wait(1)
    end
end)

notify("zurai hub", "loaded successfully")
print("zurai hub - have fun!")
