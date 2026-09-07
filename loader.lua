local StarterGui = game:GetService("StarterGui") 
local HttpService = game:GetService("HttpService")

local PlaceId = tostring(game.PlaceId)
local GameId = tostring(game.GameId) 

local Username = "zurai02" 
local Repo = "zurai-hub" 
local Branch = "main" 
local Folder = "Scr" 

local function notify(title, text)
    pcall(function() 
        StarterGui:SetCore("SendNotification", { 
            Title = title, 
            Text = text, 
            Duration = 5 
        }) 
    end)
end

local function fetchScript(id)
    local url = string.format("https://raw.githubusercontent.com/%s/%s/%s/%s/%s.lua", Username, Repo, Branch, Folder, id) 
    local success, content = pcall(game.HttpGet, game, url, true)
    if success and content and content ~= "404: Not Found" and not content:find("404: Not Found") then
        return content
    end
    return nil
end

local scriptContent = fetchScript(PlaceId) or fetchScript(GameId)

if scriptContent then 
    local loadedFunc, err = loadstring(scriptContent) 
    
    if loadedFunc then 
        notify("Zurai Hub", "Script loaded successfully!")
        
        local execSuccess, execErr = pcall(loadedFunc) 
        if not execSuccess then 
            warn("[Zurai Hub] Execution Error: " .. tostring(execErr)) 
        end 
    else 
        warn("[Zurai Hub] Syntax Error: " .. tostring(err)) 
    end 
else 
    notify("Zurai Hub", "Place/Game ID not supported.")
    warn("[Zurai Hub] Game/Place ID is not supported or script not found.") 
end
