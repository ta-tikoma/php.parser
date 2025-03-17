local inspect = require("inspect")
local M = require("moses")
local Area = require("src.area")
local O = M.operator
local unpack = table.unpack or unpack

function last(r)
    return r[#r]
end

local function unpacked(f)
    return function(t)
        f(unpack(t))
    end
end

local function appendToLastElement(r, c)
    r[#r] = r[#r] .. c
    return r
end

-- -- для группировки по словам
local groupByWords = M.cond(M.map({
    { M.isNil,                      M.constant(true),               M.push },
    { M.bind(O.eq, ' '),            M.bind(O.eq, ' '),              appendToLastElement },
    { M.bind(O.eq, '_'),            M.bind(O.eq, '_'),              appendToLastElement },
    { M.bind(O.eq, '<'),            M.bind(O.eq, '?'),              appendToLastElement },
    { M.bind(O.eq, '<?'),           M.bind(O.eq, 'p'),              appendToLastElement },
    { M.bind(O.eq, '$'),            M.bind2(string.match, '^%w+$'), appendToLastElement },
    { M.bind(O.eq, '__'),           M.bind2(string.match, '^%w+$'), appendToLastElement },
    { M.bind2(string.match, '%w$'), M.bind2(string.match, '^%w+$'), appendToLastElement },
    { M.constant(true),             M.constant(true),               M.push },
}, (function(t)
    return { M.overArgs(O.land, M.compose(t[1], last), t[2]), t[3] }
end)))

local file = io.open('test.php', 'r')
if file ~= nil then
    local function readSymbolFromFile(_file)
        local c = _file:read(1)
        if c ~= nil then return c, _file end
    end

    local result = M.chain(M.unfold(readSymbolFromFile, file))
        :reduce(groupByWords, {})
        :reduce(function(a, c)
            a:push(c)
            return a
        end, Area:new(nil, nil))
        :value()

    file:close()

    print(inspect(result))
end
