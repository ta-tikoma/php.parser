---@class Namespace
local Namespace = {}

function Namespace:new(parent, namespace, content)
    local obj = {
        parent = parent,
        namespace = namespace,
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
function Namespace.detect(token, index, area)
    if token ~= 'namespace' then
        return area
    end

    return area
end

return Namespace
