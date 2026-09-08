local repoOwner = "zurai02"
local repoName  = "zurai-hub"
local branch    = "main"
local folder    = "Scr"

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
    local url = string.format(
        "https://raw.githubusercontent.com/%s/%s/%s/%s/%s",
        repoOwner, repoName, branch, folder, fileName
    )
    print("[Zurai Hub] Fetching: " .. url)

    local ok, result = pcall(game.HttpGet, game, url)
    if ok and result and #result > 0 and not result:find("404: Not Found") then
        return result
    end
end

local placeId = tostring(game.PlaceId)
local gameId  = tostring(game.GameId)

print("[Zurai Hub] Place ID: " .. placeId)
print("[Zurai Hub] Game ID:  " .. gameId)

local code, loadedType

code = fetchScript(placeId .. ".lua") or fetchScript(gameId .. ".lua")
loadedType = "Game-Specific"

if not code then
    print("[Zurai Hub] No specific script found. Falling back to universal.lua...")
    code = fetchScript("universal.lua")
    loadedType = "Universal"
end

if not code then
    warn("[Zurai Hub] Could not find " .. placeId .. ".lua, " .. gameId .. ".lua, or universal.lua.")
    notify("Zurai Hub", "Script not found on GitHub.")
    return
end

local fn, syntaxErr = loadstring(code)
if not fn then
    warn("[Zurai Hub] Syntax error: " .. tostring(syntaxErr))
    notify("Zurai Hub", "Syntax error in script!")
    return
end

local ok, execErr = pcall(fn)
if ok then
    notify("Zurai Hub", loadedType .. " script loaded!")
else
    warn("[Zurai Hub] Execution error: " .. tostring(execErr))
    notify("Zurai Hub", "Execution error! Check F9 console.")
end
