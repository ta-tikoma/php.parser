local unpack = table.unpack or unpack

local M = {}
local Maybe = {}

function Maybe.new()
    local self = setmetatable({}, Maybe)
    self.value = nil
    self.is_nothing = true

    return self
end

function Maybe.__tostring(maybe)
    if maybe.is_nothing then
        return "Nothing"
    end

    return "Just " .. tostring(maybe.value)
end

function Just(v)
    local j = Maybe.new()
    j.value = v
    j.is_nothing = false

    return j
end

function Nothing()
    return Maybe.new()
end

---@param a table string
---@param b table input
function SequenceA(f, a, b)
    if #a ~= #b then
        return Nothing()
    end

    local values = {}
    for k, v in ipairs(a) do
        local m = f(a[k], v)
        if m.is_nothing then
            return m
        end

        table.insert(values, m.value)
    end

    return Just(values)
end

function Map(f, ...)
    local maybes = { ... }
    local unmaybes = {}
    for i, m in ipairs(maybes) do
        if m.is_nothing then
            return m
        end

        table.insert(unmaybes, m.value)
    end

    return Just(f(unpack(unmaybes)))
end

-- like <|>
function Alternative(...)
    local maybes = { ... }
    for i, m in ipairs(maybes) do
        if not m.is_nothing then
            return m
        end
    end

    return Nothing()
end

return M
