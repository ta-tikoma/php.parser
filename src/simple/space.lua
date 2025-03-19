local inspect = require("inspect")

---@class Space
local Space = {}

function Space:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. 'space.')
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function Space.detect(token)
    return string.match(token, '^[ ]+$')
end

return Space
