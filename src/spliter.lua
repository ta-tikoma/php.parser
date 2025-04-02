local inspect = require("inspect")
local M = require("moses")

---@class Spliter
local Spliter = {}

---@return Spliter
function Spliter:new()
    local obj = {
        prev = nil,
        content = {}
    }

    ---@param c string
    function obj:push(c)
        local last = self.content[#self.content]
        if last == nil then
            table.insert(self.content, c)
        else
            last
        end
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

return Spliter
