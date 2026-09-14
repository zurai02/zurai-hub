--!strict

local Services = {} :: { [string]: any }

setmetatable(Services, {
    __index = function(self: { [string]: any }, serviceName: string): any
        local success, service = pcall(game.GetService, game, serviceName)
        
        if success and service then
            rawset(self, serviceName, service)
            return service
        end
        
        error(string.format("[ServiceMapper]: Service '%s' does not exist or cannot be accessed.", tostring(serviceName)), 2)
    end
})

return Services
