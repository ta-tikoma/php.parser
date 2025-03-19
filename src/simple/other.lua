local inspect = require("inspect")

---@class Other
local Other = {}

function Other:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. 'other:' .. self.token)
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function Other.detect(token)
    return true
end

return Other
