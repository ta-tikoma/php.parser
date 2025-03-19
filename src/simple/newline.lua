local inspect = require("inspect")

---@class NewLine
local NewLine = {}

function NewLine:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. 'new-line.')
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function NewLine.detect(token)
    return token == '\n'
end

return NewLine
