local inspect = require("inspect")
local M = require("moses")

---@class Area
local Area = {}

local brackets = {
    { '{',     '}' },
    { '(',     ')' },
    { '[',     ']' },
    { "'",     "'" },
    { '"',     '"' },
    { '<?php', '?>' },
}


---@param open string|nil
---@param close string|nil
---@return Area
function Area:new(open, close)
    local obj = {
        open = open,
        close = close,
        is_open = true,
        content = {}
    }

    ---@return boolean
    function obj:isOpen()
        return self.is_open
    end

    ---@param c string
    function obj:push(c)
        -- if last element is area then delegate work
        local last = self.content[#self.content]
        if type(last) == 'table' and getmetatable(last) == Area then
            if last:isOpen() then
                return last:push(c)
            end
        end

        local index = M.detect(brackets, function(b)
            return b[1] == c or b[2] == c
        end)

        if M.isNil(index) then -- if not brackets
            self.content[#self.content + 1] = c
        else
            if brackets[index][2] == c and self.close == c then -- if close brackets close area
                self.is_open = false
            else                                                -- else open brackets create area
                self.content[#self.content + 1] = Area:new(brackets[index][1], brackets[index][2])
            end
        end
    end

    ---@param some Class
    ---@param from integer
    ---@param to integer
    function obj:replace(some, from, to)
        self.content = M.append(M.push(M.slice(self.content, 0, from), some), M.slice(self.content, to))
    end

    function obj:recursive(call)
        self.content = M.map(self.content, function(token)
            if type(token) == 'table' and getmetatable(token) == Area then
                return token:recursive(call)
            end

            return call(token)
        end)

        return self
    end

    function obj:print(tab)
        print(tab .. 'area: ' .. self.open)

        self.content = M.map(self.content, function(token)
            if type(token) == 'table' then
                token:print(tab .. '    ')
            else
                print(token)
            end
        end)

        print(tab .. self.close)
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

return Area
