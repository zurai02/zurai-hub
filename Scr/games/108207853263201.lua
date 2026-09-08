local Yield = task.wait
local plr = game:GetService("Players").LocalPlayer

getgenv().WinFarm = false
getgenv().AutoCollect = false
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Rizz Tower",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "Rizz Tower Utility",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrainrotPolice",
      FileName = "RizzTowerConfig"
   }
})

local FarmTab = Window:CreateTab("Farming", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

FarmTab:CreateSection("Auto Farm Options")

FarmTab:CreateToggle({
   Name = "Win Farm",
   CurrentValue = false,
   Flag = "WinFarmToggle",
   Callback = function(bool)
      getgenv().WinFarm = bool
      if bool then
         task.spawn(function()
            while getgenv().WinFarm do
               pcall(function()
                  if plr.Character and plr.Character:FindFirstChild("Head") then
                     plr.Character:MoveTo(Vector3.new(1, 477, -315))
                     Yield()
                     local teleportWin = workspace:FindFirstChild("TeleportWin")
                     local reward = teleportWin and teleportWin:FindFirstChild("Reward")
                     if reward and typeof(firetouchinterest) == "function" then
                        firetouchinterest(plr.Character.Head, reward, 0)
                        Yield()
                        firetouchinterest(plr.Character.Head, reward, 1)
                        Yield()
                     end
                  end
               end)
               Yield()
            end
         end)
      end
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Collect Rewards / Prompts",
   CurrentValue = false,
   Flag = "AutoCollectToggle",
   Callback = function(bool)
      getgenv().AutoCollect = bool
      if bool then
         task.spawn(function()
            while getgenv().AutoCollect do
               pcall(function()
                  for _, desc in pairs(workspace:GetDescendants()) do
                     if not getgenv().AutoCollect then break end
                     if desc:IsA("ProximityPrompt") then
                        if typeof(fireproximityprompt) == "function" then
                           fireproximityprompt(desc)
                        end
                     end
                  end
               end)
               Yield(1)
            end
         end)
      end
   end,
})

PlayerTab:CreateSection("Movement Modifications")

PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 250},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(val)
      getgenv().WalkSpeed = val
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
      getgenv().JumpPower = val
      if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
         local hum = plr.Character:FindFirstChildOfClass("Humanoid")
         hum.UseJumpPower = true
         hum.JumpPower = val
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Teleport To Top",
   Callback = function()
      if plr.Character then
         plr.Character:MoveTo(Vector3.new(1, 477, -315))
      end
   end,
})

plr.CharacterAdded:Connect(function(char)
   local hum = char:WaitForChild("Humanoid", 5)
   if hum then
      hum.WalkSpeed = getgenv().WalkSpeed
      hum.UseJumpPower = true
      hum.JumpPower = getgenv().JumpPower
   end
end)
