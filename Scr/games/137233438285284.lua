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
      FolderName = "zurai-hub",
      FileName = "ChickenFarmConfig"
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

MainTab:CreateSection("Chicken Farm Options")

MainTab:CreateParagraph({
   Title = "Warning",
   Content = "BUY YOUR FIRST CHICKEN BEFORE AUTOFARMING (OTHERWISE WHOLE GAME BREAKS)"
})

local suffixes = {
    "K","M","B","T","Qd","Qn","Sx","Sp","Oc","No","De",
    "UDe","DDe","TDe","QdDe","QnDe","SxDe","SpDe","OcDe","NoDe","Vt",
    "UVt","DVt","TVt","QdVt","QnVt","SxVt","SpVt","OcVt","NoVt","Tg",
    "UTg","DTg","TTg","QdTg","QnTg","SxTg","SpTg","OcTg","NoTg","qg",
    "Uqg","Dqg","Tqg","Qdqg","Qnqg","Sxqg","Spqg","Ocqg","Noqg","Qg",
    "UQg","DQg","TQg","QdQg","QnQg","SxQg","SpQg","OcQg","NoQg","sg",
    "Usg","Dsg","Tsg","Qdsg","Qnsg","Sxsg","Spsg","Ocsg","Nosg","Sg",
    "USg","DSg","TSg","QdSg","QnSg","SxSg","SpSg","OcSg","NoSg","Og",
    "UOg","DOg","TOg","QdOg","QnOg","SxOg","SpOg","OcOg","NoOg","Ng",
    "UNg","DNg","TNg","QdNg","QnNg","SxNg","SpNg","OcNg","NoNg","Ce","UCe"
}

local suffixValue = {}
for i, suf in ipairs(suffixes) do
    suffixValue[suf] = 1000 ^ i
end

local function parseSuffixedNumber(str)
    if not str or type(str) ~= "string" then return 0 end
    str = str:gsub("[%$,%s]", "")
    local numberPart, suffixPart = str:match("^(-?%d*%.?%d+)(%a*)$")
    local base = tonumber(numberPart) or 0

    if not suffixPart or suffixPart == "" then
        return base
    end

    local multiplier = suffixValue[suffixPart] or 1
    return base * multiplier
end

local addedCon

MainTab:CreateToggle({
   Name = "Autofarm",
   CurrentValue = false,
   Flag = "ChickenFarmToggle",
   Callback = function(v)
      env.Farming = v

      if not env.Farming then
         if addedCon then
            addedCon:Disconnect()
            addedCon = nil
         end
         return
      end

      task.spawn(function()
         local paper = repStorage:FindFirstChild("Paper")
         local remotes = paper and paper:FindFirstChild("Remotes")
         local mainEvent = remotes and remotes:FindFirstChild("__remoteevent")
         local mainFunction = remotes and remotes:FindFirstChild("__remotefunction")

         local eggsFolder = workspace:FindFirstChild("Eggs")
         if eggsFolder and mainEvent and mainFunction then
            for _, egg in pairs(eggsFolder:GetChildren()) do
               if not env.Farming then break end
               pcall(function()
                  mainEvent:FireServer("Collect Egg", egg.Name)
                  Yield()
                  egg:Destroy()
               end)
            end

            Yield()

            pcall(function()
               mainFunction:InvokeServer("Deposit Eggs")
            end)

            addedCon = eggsFolder.ChildAdded:Connect(function(c)
               if not env.Farming then return end
               Yield(1)
               pcall(function()
                  mainEvent:FireServer("Collect Egg", c.Name)
                  Yield()
                  c:Destroy()
                  mainFunction:InvokeServer("Deposit Eggs")
               end)
            end)
         end

         while env.Farming do
            pcall(function()
               if mainFunction then
                  mainFunction:InvokeServer("Collect Cash")
                  Yield()
                  mainFunction:InvokeServer("Upgrade Process Level")
                  Yield()

                  local plots = workspace:FindFirstChild("Plots")
                  local myPlot = plots and plots:FindFirstChild(plr.Name)
                  local buyBtns = myPlot and myPlot:FindFirstChild("Buttons") and myPlot.Buttons:FindFirstChild("BuyChickens")

                  local cashValObj = plr:FindFirstChild("PlayerGui") 
                     and plr.PlayerGui:FindFirstChild("Main") 
                     and plr.PlayerGui.Main:FindFirstChild("Currencies") 
                     and plr.PlayerGui.Main.Currencies:FindFirstChild("Cash") 
                     and plr.PlayerGui.Main.Currencies.Cash:FindFirstChild("List") 
                     and plr.PlayerGui.Main.Currencies.Cash.List:FindFirstChild("Amount")

                  if buyBtns and cashValObj then
                     local tobuy = 0
                     local currentCash = parseSuffixedNumber(cashValObj.Text)

                     local cost100 = buyBtns:FindFirstChild("Buy100") and parseSuffixedNumber(buyBtns.Buy100.Button.UI.Cost.Text) or math.huge
                     local cost25 = buyBtns:FindFirstChild("Buy25") and parseSuffixedNumber(buyBtns.Buy25.Button.UI.Cost.Text) or math.huge
                     local cost5 = buyBtns:FindFirstChild("Buy5") and parseSuffixedNumber(buyBtns.Buy5.Button.UI.Cost.Text) or math.huge
                     local cost1 = buyBtns:FindFirstChild("Buy1") and parseSuffixedNumber(buyBtns.Buy1.Button.UI.Cost.Text) or math.huge

                     if cost100 <= currentCash then
                        tobuy = 100
                     elseif cost25 <= currentCash then
                        tobuy = 25
                     elseif cost5 <= currentCash then
                        tobuy = 5
                     elseif cost1 <= currentCash then
                        tobuy = 1
                     end

                     if tobuy > 0 then
                        mainFunction:InvokeServer("Buy Chickens", tobuy)
                     end
                  end

                  Yield()
                  mainFunction:InvokeServer("Merge Chickens")
               end
            end)
            Yield(1)
         end

         if addedCon then
            addedCon:Disconnect()
            addedCon = nil
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
