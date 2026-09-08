local repoOwner, repoName, branch, folder = "zurai02", "zurai-hub", "main", "Scr/games"

local function fetchScript(fileName)
    local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s/%s", repoOwner, repoName, branch, folder, fileName)
    local ok, res = pcall(game.HttpGet, game, url)
    if ok and res ~= "" and not res:find("404: Not Found") then return res end
end

local placeId, gameId = tostring(game.PlaceId), tostring(game.GameId)
local code = fetchScript(placeId .. ".lua") or fetchScript(gameId .. ".lua") or fetchScript("universal.lua")

if code then
    local fn = loadstring(code)
    if fn then 
        task.spawn(pcall, fn)
    end
end

local antiAfkCode = fetchScript("anti-afk.lua")
if antiAfkCode then
    local antiAfkFn = loadstring(antiAfkCode)
    if antiAfkFn then
        task.spawn(pcall, antiAfkFn)
    end
end
