local Yield = task.wait
local plr = game:GetService("Players").LocalPlayer
local repStorage = game:GetService("ReplicatedStorage")
local env = getgenv()

env.Farming = false
env.Fakee = "Tim Cheese"

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "zurai02",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by zurai02",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "zurai-hub",
      FileName = "FakeBrainrotConfig"
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

MainTab:CreateSection("Fake Steal Settings")

MainTab:CreateInput({
   Name = "Brainrot to Fake",
   PlaceholderText = "Tim Cheese",
   RemoveTextOnFocus = false,
   Callback = function(text)
      env.Fakee = text
   end,
})

MainTab:CreateToggle({
   Name = "Farm Stealing",
   CurrentValue = false,
   Flag = "FakeStealToggle",
   Callback = function(v)
      env.Farming = v
      if not v then return end

      task.spawn(function()
         local events = repStorage:FindFirstChild("Events")
         local fakeEvent = events and events:FindFirstChild("FakeSystem_StartFake")
         local lazerEvent = events and events:FindFirstChild("LaserVisibility")
         local plots = workspace:FindFirstChild("Plots")

         while env.Farming do
            pcall(function()
               if fakeEvent then
                  fakeEvent:FireServer(env.Fakee)
               end

               local connection
               local complete = false

               task.spawn(function()
                  while not complete and env.Farming do
                     if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                        plr.Character:FindFirstChildOfClass("Humanoid"):MoveTo(Vector3.new(
                           math.random(-37, 80),
                           0,
                           math.random(-399, -119)
                        ))
                     end
                     Yield(math.random(1, 5))
                  end
               end)

               if lazerEvent and plots then
                  connection = lazerEvent.OnClientEvent:Connect(function(userId, isOn)
                     if isOn or complete then return end

                     for _, v in pairs(plots:GetChildren()) do
                        if v:GetAttribute("OwnerUserId") == userId then
                           local hasBr = false
                           local slots = v:FindFirstChild("Slots")

                           if slots then
                              for _, br in pairs(slots:GetChildren()) do
                                 local placedBr = br:FindFirstChild("PlacedBrainrot")
                                 local stealPrompt = br:FindFirstChild("StealPrompt")

                                 if placedBr and stealPrompt then
                                    hasBr = true
                                    
                                    if placedBr.PrimaryPart and plr.Character then
                                       plr.Character:MoveTo(placedBr.PrimaryPart.Position)
                                    end

                                    repeat
                                       if typeof(fireproximityprompt) == "function" then
                                          fireproximityprompt(stealPrompt)
                                       end
                                       Yield()
                                    until not stealPrompt.Enabled or not env.Farming

                                    local collectZone = v:FindFirstChild("CollectAllZone")
                                    if collectZone and plr.Character then
                                       plr.Character:MoveTo(collectZone.Position)
                                    end

                                    Yield(1)
                                    complete = true
                                 end
                              end
                           end

                           if not hasBr then
                              complete = true
                           end
                        end
                     end

                     if connection then
                        connection:Disconnect()
                     end
                  end)
               end

               repeat
                  Yield(0.5)
               until complete or not env.Farming

               if connection then
                  connection:Disconnect()
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
