local inspect = require("inspect")

---@class End
local End = {}

function End:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. ';')
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function End.detect(token)
    return token == ';'
end

return End
