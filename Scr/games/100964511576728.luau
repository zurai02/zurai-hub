return function(section, data)
    local function getgitpath(user, repo, branch, path)
        return string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", user, repo, branch, path)
    end

    local C = loadstring(game:HttpGet(getgitpath("zurai02", "zurai-hub", "main", "Scr/modules/C.luau")))()
    
    local HttpService = C.HttpService
    local ReplicatedStorage = C.ReplicatedStorage
    local Players = C.Players
    local Workspace = C.Workspace
    local yield = task.wait

    local plr = Players.LocalPlayer
    local visualCrates = Workspace:WaitForChild("Crates", 5)
    local serverCrates = Workspace:WaitForChild("ServerInfo", 5)

    local state = {
        Farming = false,
        CrateRarity = "common"
    }

    data = data or {}
    local placeId = tostring(game.PlaceId)
    local setdata = data[placeId] or { farming = false, CrateRarity = "common" }
    data[placeId] = setdata

    local function saveConfig(key, value)
        setdata[key] = value
        if writefile then
            pcall(function()
                writefile("BrainrotPolice/Config.json", HttpService:JSONEncode(data))
            end)
        end
    end

    elements:Textbox("Crate Rarity", section, setdata.CrateRarity, function(str)
        local val = str:lower()
        state.CrateRarity = val
        saveConfig("CrateRarity", val)
    end)

    elements:Toggle("Farm Brainrots", section, setdata.farming, function(v)
        state.Farming = v
        saveConfig("farming", v)
        if not v or not visualCrates or not serverCrates then return end

        task.spawn(function()
            local event = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("HammerActivated")

            while state.Farming do
                pcall(function()
                    for _, crate in ipairs(visualCrates:GetChildren()) do
                        if not state.Farming then break end

                        local rarityAttr = crate:GetAttribute("Rarity")
                        if rarityAttr and rarityAttr:lower() == state.CrateRarity then
                            local char = plr.Character
                            if char and char:FindFirstChild("PrimaryPart") and crate.PrimaryPart then
                                char:MoveTo(crate.PrimaryPart.Position + Vector3.new(0, 4, 0))

                                local crateServer = serverCrates:FindFirstChild("1") and serverCrates["1"].Crates:FindFirstChild(crate.Name)
                                if crateServer then
                                    local backpack = plr:FindFirstChild("Backpack")
                                    local humanoid = char:FindFirstChildOfClass("Humanoid")

                                    if backpack and humanoid then
                                        for _, tool in ipairs(backpack:GetChildren()) do
                                            if tool:GetAttribute("Cooldown") ~= nil then
                                                humanoid:EquipTool(tool)
                                            end
                                        end
                                    end

                                    yield()

                                    if event then
                                        repeat
                                            event:FireServer(crateServer)
                                            yield()
                                        until not state.Farming or not crate or crate.Parent ~= visualCrates
                                    end

                                    yield(0.5)

                                    local enterSpawn = Workspace:FindFirstChild("Scripted") and Workspace.Scripted:FindFirstChild("EnterSpawnTouch")
                                    if enterSpawn and firetouchinterest and char:FindFirstChild("Head") then
                                        firetouchinterest(char.Head, enterSpawn, true)
                                        yield()
                                        firetouchinterest(char.Head, enterSpawn, false)
                                    end

                                    yield(1)

                                    if humanoid then
                                        humanoid:UnequipTools()
                                    end
                                end
                            end
                        end
                    end
                end)

                yield(0.1)
            end
        end)
    end)
end
