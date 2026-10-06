local utility = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage")
}

function utility:GetRemote(n)
    local s, r = pcall(function()
        return self.ReplicatedStorage:FindFirstChild(n, true)
    end)

    if s and r then
        return r
    end

    return nil
end

function utility:init()
    self["ref_KickEvent"] = self:GetRemote("ref_KickEvent")
    if not self["ref_KickEvent"] then
        return warn("failed to get ref_KickEvent")
    end

    self.LocalPlayer = self.Players.LocalPlayer
    if not self.LocalPlayer then
        return warn("failed to get localplayer")
    end

    if not hookmetamethod then
        return warn("Unsupported executor: missing hookmetamethod")
    end

    local kickEvent = self["ref_KickEvent"]
    local originalHook

    self.s, self.hook = pcall(function()
        originalHook = hookmetamethod(game, "__namecall", function(selfInstance, ...)
            local method = getnamecallmethod()
            local args = {...}

            if method == "InvokeServer" and selfInstance == kickEvent then
                if args[1] and typeof(args[1]) == "number" and args[2] and typeof(args[2]) == "number" then
                    args[1] = args[2]
                end
            end

            return originalHook(selfInstance, table.unpack(args))
        end)
        return originalHook
    end)

    if not self.s then
        return warn("failed to hook err: " .. tostring(self.hook))
    end

    return warn("success init")
end

utility:init()
