local Yield = task.wait
local plr = game:GetService("Players").LocalPlayer
local repStorage = game:GetService("ReplicatedStorage")
local env = getgenv()

env.farming = false

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "zurai02",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by zurai02",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "zurai-hub",
      FileName = "ParkourRunConfig"
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

MainTab:CreateSection("Farming Options")

MainTab:CreateToggle({
   Name = "Farming",
   CurrentValue = false,
   Flag = "ParkourFarmToggle",
   Callback = function(v)
      env.farming = v
      if not v then return end

      task.spawn(function()
         while env.farming do
            pcall(function()
               if plr.Character then
                  plr.Character:MoveTo(Vector3.new(12738, 1490, 231))
               end

               local spawner = workspace:FindFirstChild("BG_BrainrotSpawner")
               if spawner then
                  for _, v in pairs(spawner:GetChildren()) do
                     if not env.farming then break end

                     local br = v:FindFirstChildOfClass("Model")
                     if v.Name == "Mythical" and br and br.PrimaryPart then
                        local prompt = br.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                           repeat
                              if typeof(fireproximityprompt) == "function" then
                                 fireproximityprompt(prompt)
                              end
                              Yield()
                           until not br or br.Parent ~= v or not env.farming

                           local packages = repStorage:FindFirstChild("Packages")
                           local index = packages and packages:FindFirstChild("_Index")
                           local sleitnick = index and index:FindFirstChild("sleitnick_net@0.2.0")
                           local net = sleitnick and sleitnick:FindFirstChild("net")
                           local returnRemote = net and net:FindFirstChild("RE/BG_ReturnToBase")

                           if returnRemote then
                              returnRemote:FireServer()
                           end

                           Yield(1)
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
