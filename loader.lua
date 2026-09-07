local repoOwner = "zurai02"
local repoName = "zurai-hub"
local branch = "main"
local folder = "Scr"

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local function notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

local function fetchScript(fileName)
    local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s/%s", repoOwner, repoName, branch, folder, fileName)
    print("[Zurai Hub] Fetching: " .. url)
    
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and result and not result:find("404: Not Found") and #result > 0 then
        return result
    end
    return nil
end

local placeId = tostring(game.PlaceId)
local gameId = tostring(game.GameId)

print("[Zurai Hub] Checking Place ID: " .. placeId)
print("[Zurai Hub] Checking Game ID: " .. gameId)

local code = fetchScript(placeId .. ".lua") or fetchScript(gameId .. ".lua")
local loadedType = "Game-Specific"

if not code then
    print("[Zurai Hub] Specific script not found. Attempting universal.lua...")
    code = fetchScript("universal.lua")
    loadedType = "Universal"
end

if not code then
    warn("[Zurai Hub] Error: Could not find " .. placeId .. ".lua, " .. gameId .. ".lua, or universal.lua on GitHub!")
    notify("Zurai Hub", "Script not found on GitHub.")
    return
end

local loadedFunc, syntaxErr = loadstring(code)
if not loadedFunc then
    warn("[Zurai Hub] Syntax Error in target script: " .. tostring(syntaxErr))
    notify("Zurai Hub", "Syntax error in script!")
    return
end

local execSuccess, execErr = pcall(loadedFunc)
if execSuccess then
    notify("Zurai Hub", loadedType .. " Script Loaded!")
else
    warn("[Zurai Hub] Runtime Execution Error: " .. tostring(execErr))
    notify("Zurai Hub", "Execution error! Check F9 Console.")
end
