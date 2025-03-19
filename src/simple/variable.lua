local inspect = require("inspect")

---@class Variable
local Variable = {}

function Variable:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. 'variable:' .. self.token)
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function Variable.detect(token)
    return token:sub(1, 1) == '$'
end

return Variable
