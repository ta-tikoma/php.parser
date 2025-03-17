local M = require("moses")

local Area = {}

local brackets = {
    { '{', '}' },
    { '(', ')' },
    { '[', ']' },
    { "'", "'" },
    { '"', '"' },
}


---@param open string|nil
---@param close string|nil
function Area:new(open, close)
    local obj = {
        open = open,
        close = close,
        is_open = true,
        content = {}
    }

    if not M.isNil(open) then
        obj.content[#obj.content + 1] = open
    end

    ---@return boolean
    function obj:isOpen()
        return self.is_open
    end

    ---@param c string
    function obj:push(c)
        local last = self.content[#self.content]
        if type(last) == 'table' then
            if last:isOpen() then
                return last:push(c)
            end
        end

        local bracket = M.findWhere(brackets, { c })
        if M.isNil(bracket) then
            self.content[#self.content + 1] = c
            bracket = M.findWhere(brackets, { nil, c })
            if not M.isNil(bracket) then
                if bracket[2] == self.close then
                    self.is_open = false
                else
                    ---@todo something wrong
                end
            end
        else
            local b = Area:new(bracket[1], bracket[2])
            self.content[#self.content + 1] = b
        end
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

return Area
