local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

localPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
local newCharacter = localPlayer.CharacterAdded:Wait()

local spoofFolder = Instance.new("Folder")
spoofFolder.Name = "FULLY_LOADED_CHAR"
spoofFolder.Parent = newCharacter

newCharacter:WaitForChild("RagdollConstraints"):Destroy()
local spoofValue = Instance.new("BoolValue")
spoofValue.Name = "RagdollConstraints"
spoofValue.Parent = newCharacter

local playerModel = game.Workspace:WaitForChild(localPlayer.Name)
playerModel.Parent = game.Workspace.Players

local bodyEffects = newCharacter:WaitForChild("BodyEffects")
bodyEffects.BreakingParts:Destroy()
