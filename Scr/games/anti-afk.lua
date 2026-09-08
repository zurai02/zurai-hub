local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local localPlayer = Players.LocalPlayer

if getgenv().AntiAfkLoaded then return end
getgenv().AntiAfkLoaded = true

localPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
