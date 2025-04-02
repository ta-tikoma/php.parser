require('src.maybe')
require('src.bind').init()

local P = {}

---@param s string symbol
---@param i string input
function P.parseChar(s, i)
    if i == s then
        return Just(i)
    end

    return Nothing()
end

---@param str string
---@return table
function P.unpack(str)
    local t = {}
    str:gsub(".", function(c) table.insert(t, c) end)
    return t
end

P.parseString = SequenceA:bind(P.parseChar)

return P
