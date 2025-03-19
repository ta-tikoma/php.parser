local inspect = require("inspect")
local Word = require("src.simple.word")
local Space = require("src.simple.space")
local Other = require("src.simple.other")
local End = require("src.simple.end")

---@class Use
local Use = {}

function Use:new(token)
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

function Use.mask()
    return {
        { Word,  'use' },
        { Space },
        { Word },
        { Other, '\\' },
        { Word },
        { End },
    }
end

return Use
