local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local configPath = "zurai-hub/Config.json"
local data = {}
if pcall(function() return readfile(configPath) end) then
    local success, decoded = pcall(function() return HttpService:JSONDecode(readfile(configPath)) end)
    if success then data = decoded end
end

local placeIdKey = tostring(game.PlaceId)
data[placeIdKey] = data[placeIdKey] or {}
data[placeIdKey].farmrots = data[placeIdKey].farmrots or false
data[placeIdKey].upgr = data[placeIdKey].upgr or false
data[placeIdKey].col = data[placeIdKey].col or false
data[placeIdKey].Rebirth = data[placeIdKey].Rebirth or false
writefile(configPath, HttpService:JSONEncode(data))

local env = getgenv()
env.Farming = false
env.Upgrade = false
env.Collect = false
env.Rebirth = false

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Obby as a Brainrot",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Interface",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "zurai-hub",
        FileName = "Config"
    }
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateToggle({
    Name = "Farm Disco Meowl",
    CurrentValue = data[placeIdKey].farmrots,
    Flag = "FarmRots",
    Callback = function(v)
        data[placeIdKey].farmrots = v
        writefile(configPath, HttpService:JSONEncode(data))
        env.Farming = v
        if v then
            task.spawn(function()
                while env.Farming do
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character:MoveTo(Vector3.new(9, 19, -493))
                    end
                    task.wait(0.5)
                    ReplicatedStorage.ThrowLuckyBlockRemotes.ThrowZoneBatVisual:FireServer(true)
                    task.wait()
                    ReplicatedStorage.ThrowLuckyBlockRemotes.ThrowStarted:FireServer()
                    task.wait()
                    ReplicatedStorage.ThrowLuckyBlockRemotes.ThrowBatHit:FireServer(nil, false)
                    task.wait()
                    ReplicatedStorage.ThrowLuckyBlockRemotes.ThrowBatTimingVfxCleanup:FireServer()
                    task.wait()
                    ReplicatedStorage.ThrowLuckyBlockRemotes.LuckyBlockLanded:FireServer({
                        LandingPosition = Vector3.new(4, -99, 4514),
                        ItemName = "Meowl",
                        Rarity = "OG",
                        BlockName = "Uncommon Lucky Block",
                        LandingRarity = "OG",
                        Mutation = "Disco",
                        Power = 10.642112568062
                    })
                    task.wait(0.5)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character:MoveTo(Vector3.new(8, 21, -558))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})

Tab:CreateToggle({
    Name = "Auto Upgrade",
    CurrentValue = data[placeIdKey].upgr,
    Flag = "AutoUpgrade",
    Callback = function(v)
        data[placeIdKey].upgr = v
        writefile(configPath, HttpService:JSONEncode(data))
        env.Upgrade = v
        if v then
            task.spawn(function()
                while env.Upgrade do
                    for i = 1, 10 do
                        ReplicatedStorage.Events.RequestSlotUpgrade:FireServer("Floor1", "Slot" .. tostring(i))
                    end
                    for i = 1, 10 do
                        ReplicatedStorage.Events.RequestSlotUpgrade:FireServer("Floor2", "Slot" .. tostring(i))
                    end
                    for i = 1, 10 do
                        ReplicatedStorage.Events.RequestSlotUpgrade:FireServer("Floor3", "Slot" .. tostring(i))
                    end
                    task.wait(0.1)
                end
            end)
        end
    end,
})

Tab:CreateToggle({
    Name = "Auto Collect",
    CurrentValue = data[placeIdKey].col,
    Flag = "AutoCollect",
    Callback = function(v)
        data[placeIdKey].col = v
        writefile(configPath, HttpService:JSONEncode(data))
        env.Collect = v
        if v then
            task.spawn(function()
                while env.Collect do
                    local plot = workspace:FindFirstChild("Plot_" .. LocalPlayer.Name)
                    if plot then
                        for _, floorName in ipairs({"Floor1", "Floor2", "Floor3"}) do
                            local floor = plot:FindFirstChild(floorName)
                            if floor and floor:FindFirstChild("Slots") then
                                for _, slot in pairs(floor.Slots:GetChildren()) do
                                    local touch = slot:FindFirstChild("CollectTouch")
                                    local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                                    if touch and head then
                                        firetouchinterest(head, touch, true)
                                        task.wait()
                                        firetouchinterest(head, touch, false)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end,
})

Tab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = data[placeIdKey].Rebirth,
    Flag = "AutoRebirth",
    Callback = function(v)
        data[placeIdKey].Rebirth = v
        writefile(configPath, HttpService:JSONEncode(data))
        env.Rebirth = v
        if v then
            task.spawn(function()
                while env.Rebirth do
                    ReplicatedStorage.Events.RequestRebirth:FireServer()
                    task.wait(3)
                end
            end)
        end
    end,
})

Rayfield:LoadConfiguration()
