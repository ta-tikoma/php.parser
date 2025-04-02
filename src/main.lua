local inspect = require("inspect")
local M = require("moses")
local PhpTag = require("src.phptag")

local file = io.open('test.php', 'r')
if file ~= nil then
    local p = nil
    local word = nil
    local r = {}
    repeat
        local c = file:read(1)
        p = c
    until c == nil

    local function readSymbolFromFile(_file)
        local c = _file:read(1)
        if c ~= nil then return c, _file end
    end

    local area = M.chain(M.unfold(readSymbolFromFile, file))
        :foldl(function(current, next)
            return PhpTag.parse(s)
        end, {})
        :value()

    file:close()

    print(inspect(area))
end
