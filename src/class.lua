---@class Class
local Class = {}

function Class:new(parent, content)
    local obj = {
        parent = parent,
        content = content
    }

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

---@param token string
---@param index integer
---@param area Area
---@return Area
function Class.detect(token, index, area)
    if token ~= 'class' then
        return area
    end

    return area
end

return Class
