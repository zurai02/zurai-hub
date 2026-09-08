local Yield = task.wait
local plr = game:GetService("Players").LocalPlayer
local env = getgenv()

env.farming = false

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "zurai02",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by zurai02",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrainrotPolice",
      FileName = "PoleObbyConfig"
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

MainTab:CreateSection("Farming Options")

MainTab:CreateToggle({
   Name = "Farm Brainrots",
   CurrentValue = false,
   Flag = "FarmBrainrotsToggle",
   Callback = function(v)
      env.farming = v
      if not v then return end

      task.spawn(function()
         while env.farming do
            pcall(function()
               local mobsFolder = workspace:FindFirstChild("Mobs")
               if mobsFolder then
                  for _, mob in pairs(mobsFolder:GetChildren()) do
                     if not env.farming then break end

                     if mob.PrimaryPart then
                        local rarityLabel = mob.PrimaryPart:FindFirstChild("OverheadAttach") 
                           and mob.PrimaryPart.OverheadAttach:FindFirstChild("AnimalOverhead") 
                           and mob.PrimaryPart.OverheadAttach.AnimalOverhead:FindFirstChild("Rarity")

                        if rarityLabel and rarityLabel:IsA("TextLabel") then
                           local rarity = rarityLabel.Text
                           if rarity == "OG" or rarity == "Admin" then
                              if plr.Character then
                                 plr.Character:MoveTo(mob.PrimaryPart.Position)
                              end

                              repeat
                                 local prompt = mob.PrimaryPart:FindFirstChild("ProximityPrompt")
                                 if prompt and typeof(fireproximityprompt) == "function" then
                                    fireproximityprompt(prompt)
                                 end
                                 Yield()
                              until not mob or not mob.PrimaryPart or mob.PrimaryPart:FindFirstChild("MobCarryWeld") or not env.farming

                              local net = game:GetService("ReplicatedStorage"):FindFirstChild("Packages") and game.ReplicatedStorage.Packages:FindFirstChild("Net")
                              local safeZoneRemote = net and net:FindFirstChild("RE/SafeZoneEvent")
                              
                              if safeZoneRemote then
                                 safeZoneRemote:FireServer()
                              end
                              
                              Yield(0.1)
                           end
                        end
                     end
                  end
               end
            end)
            Yield(0.1)
         end
      end)
   end,
})

PlayerTab:CreateSection("Player Tweaks")

PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 250},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(val)
      if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
         plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(val)
      if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
         local hum = plr.Character:FindFirstChildOfClass("Humanoid")
         hum.UseJumpPower = true
         hum.JumpPower = val
      end
   end,
})
