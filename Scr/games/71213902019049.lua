local Yield = task.wait
local plr = game:GetService("Players").LocalPlayer
local env = getgenv()

env.Farming = false
env.Upgrade = false
env.Collect = false

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Cross Rivers",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by Assistant",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrainrotPolice",
      FileName = "CrossRiversConfig"
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

MainTab:CreateSection("Automation")

local function getPlayerPlot()
   local plots = workspace:FindFirstChild("MainGame") and workspace.MainGame:FindFirstChild("Plots")
   if plots then
      for _, v in pairs(plots:GetChildren()) do
         local nameTxt = v:FindFirstChild("PlotOwner") and v.PlotOwner:FindFirstChild("UIPart") and v.PlotOwner.UIPart:FindFirstChild("SGUI_Name") and v.PlotOwner.UIPart.SGUI_Name:FindFirstChild("Frame") and v.PlotOwner.UIPart.SGUI_Name.Frame:FindFirstChild("NameTxt")
         if nameTxt and nameTxt.Text:find(plr.Name) then
            return v
         end
      end
   end
   return nil
end

MainTab:CreateToggle({
   Name = "Farm Brainrots",
   CurrentValue = false,
   Flag = "FarmRotsToggle",
   Callback = function(v)
      env.Farming = v
      if not env.Farming then return end

      task.spawn(function()
         while env.Farming do
            pcall(function()
               local brainrotsFolder = workspace:FindFirstChild("SpawnedBrainrots")
               local crossWall = workspace:FindFirstChild("MainGame") and workspace.MainGame:FindFirstChild("Map") and workspace.MainGame.Map:FindFirstChild("Model") and workspace.MainGame.Map.Model:FindFirstChild("CrossWall")

               if brainrotsFolder and crossWall then
                  for _, item in pairs(brainrotsFolder:GetChildren()) do
                     if not env.Farming then break end

                     if item:GetAttribute("_ZoneIndex") == 10 and item.PrimaryPart then
                        local proximityPrompt = item.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
                        if proximityPrompt then
                           if plr.Character then
                              plr.Character:MoveTo(item.PrimaryPart.Position)
                           end

                           repeat
                              if typeof(fireproximityprompt) == "function" then
                                 fireproximityprompt(proximityPrompt)
                              end
                              Yield()
                           until not proximityPrompt or proximityPrompt.Parent ~= item.PrimaryPart or not proximityPrompt.Enabled or not env.Farming

                           Yield(0.5)

                           if plr.Character and plr.Character:FindFirstChild("Head") and typeof(firetouchinterest) == "function" then
                              firetouchinterest(plr.Character.Head, crossWall, 0)
                              Yield()
                              firetouchinterest(plr.Character.Head, crossWall, 1)
                           end

                           Yield(0.5)
                        end
                     end
                  end
               end
            end)
            Yield(1)
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Upgrade",
   CurrentValue = false,
   Flag = "UpgradeToggle",
   Callback = function(v)
      env.Upgrade = v
      if not env.Upgrade then return end

      task.spawn(function()
         while env.Upgrade do
            pcall(function()
               local upgradeRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Packages") and game.ReplicatedStorage.Packages:FindFirstChild("Knit") and game.ReplicatedStorage.Packages.Knit:FindFirstChild("Services") and game.ReplicatedStorage.Packages.Knit.Services:FindFirstChild("PadService") and game.ReplicatedStorage.Packages.Knit.Services.PadService:FindFirstChild("RF") and game.ReplicatedStorage.Packages.Knit.Services.PadService.RF:FindFirstChild("UpgradePad")

               if upgradeRemote then
                  for i = 1, 30 do
                     if not env.Upgrade then break end
                     upgradeRemote:InvokeServer(tostring(i))
                  end
               end
            end)
            Yield(0.1)
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Collect",
   CurrentValue = false,
   Flag = "CollectToggle",
   Callback = function(v)
      env.Collect = v
      if not env.Collect then return end

      task.spawn(function()
         while env.Collect do
            pcall(function()
               local plrPlot = getPlayerPlot()
               if plrPlot and plrPlot:FindFirstChild("Pads") and plr.Character and plr.Character:FindFirstChild("Head") then
                  for _, pad in pairs(plrPlot.Pads:GetChildren()) do
                     if not env.Collect then break end
                     local collectPart = pad:FindFirstChild("CollectPart")
                     if collectPart and typeof(firetouchinterest) == "function" then
                        firetouchinterest(plr.Character.Head, collectPart, 0)
                        Yield()
                        firetouchinterest(plr.Character.Head, collectPart, 1)
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

PlayerTab:CreateButton({
   Name = "Teleport to My Plot",
   Callback = function()
      local plrPlot = getPlayerPlot()
      if plrPlot and plrPlot.PrimaryPart and plr.Character then
         plr.Character:MoveTo(plrPlot.PrimaryPart.Position)
      end
   end,
})
