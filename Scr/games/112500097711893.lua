return function(section, data)
    local HttpService = game:GetService("HttpService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local yield = task.wait

    local plr = Players.LocalPlayer
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)

    local state = {
        Farming = false,
        Strength = false
    }

    data = data or {}
    local placeId = tostring(game.PlaceId)
    local setdata = data[placeId] or { farming = false, strength = false }
    data[placeId] = setdata

    local function saveConfig(key, value)
        setdata[key] = value
        if writefile then
            pcall(function()
                writefile("BrainrotPolice/Config.json", HttpService:JSONEncode(data))
            end)
        end
    end

    elements:Toggle("Farm Brainrots", section, setdata.farming, function(v)
        state.Farming = v
        saveConfig("farming", v)
        if not v or not remotes then return end

        task.spawn(function()
            local onCast = remotes:FindFirstChild("OnCast")
            local startRun = remotes:FindFirstChild("StartRun")
            local finishRun = remotes:FindFirstChild("FinishRun")

            while state.Farming do
                if onCast and startRun and finishRun then
                    pcall(function()
                        onCast:InvokeServer(1)
                        startRun:InvokeServer()
                        finishRun:InvokeServer(true)
                    end)
                end
                yield(0.1)
            end
        end)
    end)

    elements:Toggle("Farm Strength", section, setdata.strength, function(v)
        state.Strength = v
        saveConfig("strength", v)
        if not v or not remotes then return end

        task.spawn(function()
            local doubleStrength = remotes:FindFirstChild("doubleStrength")

            while state.Strength do
                local char = plr.Character
                local backpack = plr:FindFirstChild("Backpack")

                if char and backpack then
                    local gym = backpack:FindFirstChild("Gym")
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if gym and humanoid then
                        pcall(function()
                            humanoid:EquipTool(gym)
                        end)
                    end
                end

                if doubleStrength then
                    pcall(function()
                        doubleStrength:FireServer()
                    end)
                end

                yield(1)
            end
        end)
    end)
end
