local M = {}

function M.init()
    local function_binder = function(self, v)
        return function(...)
            return self(v, ...)
        end
    end

    debug.setmetatable(function() end, {
        __index = {
            bind = function_binder,
        },
    })
end

return M
