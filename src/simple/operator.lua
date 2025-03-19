local inspect = require("inspect")
local M = require("moses")

---@class Operator
local Operator = {}

local operators = {
    'clone',
    'new',
    '**',
    '+',
    '-',
    '++',
    '--',
    '~',
    '(int)',
    '(float)',
    '(string)',
    '(array)',
    '(object)',
    '(bool)',
    '@',
    'instanceof',
    '!',
    '*',
    '/',
    '%',
    '.',
    '>>',
    '<<',
    '<',
    '<=',
    '>',
    '>=',
    '==',
    '!=',
    '===',
    '!==',
    '<>',
    '<=>',
    '&',
    '^',
    '|',
    '&&',
    '||',
    '??',
    '?:',
    '=',
    '+=',
    '-=',
    '*=',
    '**=',
    '/=',
    '.=',
    '%=',
    '&=',
    '|=',
    '^=',
    '<<=',
    '>>=',
    '??=',
    'yield from',
    'yield',
    'print',
    'and',
    'xor',
    'or'
}

function Operator:new(token)
    local obj = {
        token = token,
    }

    function obj:print(tab)
        print(tab .. 'operator:' .. token)
    end

    setmetatable(obj, self)
    self.__index = self;
    return obj
end

function Operator.detect(token)
    return M.contains(operators, token)
end

return Operator
