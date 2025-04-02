require('src.maybe')

local P = require('src.parser')
local mask = P.unpack('<?php')

local PhpTag = {}

function PhpTag.new(maybe)
    local self = setmetatable({}, PhpTag)
    self.value = maybe.value;
    return self
end

---@param symbols table
function PhpTag.parse(symbols)
    return Map(PhpTag.new, P.parseString(mask, symbols))
end

return PhpTag
