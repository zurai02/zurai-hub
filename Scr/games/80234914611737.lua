local Yield = task.wait
local plr = game:GetService("Players").LocalPlayer
local repStorage = game:GetService("ReplicatedStorage")
local env = getgenv()

env.Farming = false

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "zurai02",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by zurai02",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "zurai02",
      FileName = "JetpackForBrainrotsConfig"
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

MainTab:CreateSection("Farming Options")

local endPositions = {
    Vector3.new(-93, 59, -9943),
    Vector3.new(-104, 59, -7863)
}

local function processBrainrots()
    local brainrotsFolder = workspace:FindFirstChild("Brainrots")
    if not brainrotsFolder then return end

    for _, fold in pairs(brainrotsFolder:GetChildren()) do
        if not env.Farming then break end

        for _, br in pairs(fold:GetChildren()) do
            if not env.Farming then break end

            if br.PrimaryPart and plr.Character then
               plr.Character:MoveTo(br.PrimaryPart.Position)
            end

            local attach = br:FindFirstChild("AttachmentProximityPrompt")
            local prox = attach and attach:FindFirstChildOfClass("ProximityPrompt")

            if prox then
               repeat
                  if typeof(fireproximityprompt) == "function" then
                     fireproximityprompt(prox)
                  end
                  Yield()
               until not br or br.Parent ~= fold or not env.Farming

               Yield()

               local packages = repStorage:FindFirstChild("Packages")
               local index = packages and packages:FindFirstChild("_Index")
               local sleitnick = index and index:FindFirstChild("sleitnick_knit@1.7.0")
               local knit = sleitnick and sleitnick:FindFirstChild("knit")
               local services = knit and knit:FindFirstChild("Services")
               local gameService = services and services:FindFirstChild("Game")
               local rf = gameService and gameService:FindFirstChild("RF")
               local claimRemote = rf and rf:FindFirstChild("ClaimRewards")

               if claimRemote then
                  claimRemote:InvokeServer()
               end

               Yield()
            end
        end
    end
end

MainTab:CreateToggle({
   Name = "Farm Brainrots",
   CurrentValue = false,
   Flag = "JetpackFarmToggle",
   Callback = function(v)
      env.Farming = v
      if not v then return end

      task.spawn(function()
         while env.Farming do
            pcall(function()
               for _, pos in ipairs(endPositions) do
                  if not env.Farming then break end

                  if plr.Character then
                     plr.Character:MoveTo(pos)
                  end
                  Yield(1)

                  processBrainrots()
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
