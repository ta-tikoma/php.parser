local inspect = require("inspect")

---@class Word
local Word = {}

function Word:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. 'word:' .. self.token)
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function Word.detect(token)
    return string.match(token, '^%w[%w%d_]+$')
end

return Word
