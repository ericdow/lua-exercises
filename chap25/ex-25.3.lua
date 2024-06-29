--[[
    Exercise 25.3: Write a version of getvarvalue (Figure 25.1, “Getting the value of a variable”) that
    returns a table with all variables that are visible at the calling function. (The returned table should not
    include environmental variables; instead, it should inherit them from the original environment.)
]] -- 
function getvars()
    local vars = {}

    -- grab local variables
    for i = 1, math.huge do
        local n, v = debug.getlocal(2, i)
        if n then
            vars[n] = v
        else
            break
        end
    end

    -- grab non-local variables
    local func = debug.getinfo(2, "f").func
    for i = 1, math.huge do
        local n, v = debug.getupvalue(func, i)
        if n and n ~= "_ENV" then
            vars[n] = v
        else
            break
        end
    end

    -- use __index and __pairs to tack on globals
    local mt = {}
    mt.__index = function(_, k)
        return _ENV[k] or rawget(vars, k)
    end
    mt.__pairs = function()
        local localsdone = false
        local startglobals = true
        return function(_, k)
            local nextkey, nextvalue
            if not localsdone then
                nextkey, nextvalue = next(vars, k)
                if not nextkey then
                    localsdone = true
                end
            end
            if localsdone then
                if startglobals then
                    nextkey, nextvalue = next(_ENV, nil)
                    startglobals = false
                else
                    nextkey, nextvalue = next(_ENV, k)
                end
            end
            return nextkey, nextvalue
        end
    end
    setmetatable(vars, mt)

    return vars
end

g1 = "g1"
g2 = "g2"

function tmp()
    local up1 = "up1"
    local up2 = "up2"
    return function()
        local l1 = "l1"
        local l2 = "l2"
        if up1 == up2 then
            up1 = up1
        end
        local t = getvars()
        return t
    end
end

local f = tmp()
local vars = f()

for k, v in pairs(vars) do
    print(k, v)
end
