--[[
    Exercise 25.1: Adapt getvarvalue (Figure 25.1, “Getting the value of a variable”) to work with 
    different coroutines (like the functions from the debug library).
]] --
function getvarvalue(co, name, level, isenv)
    local isco = (type(co) == "thread")
    if not isco then
        isenv = level
        level = name
        name = co
        assert(type(name) == "string")
        assert(level == nil or type(level) == "number")
        assert(isenv == nil or type(isenv) == "boolean")
    end

    local value
    local found = false

    level = (level or 1)
    if not isco then
        level = level + 1
    end

    -- try local variables
    for i = 1, math.huge do
        local n, v
        if isco then
            n, v = debug.getlocal(co, level, i)
        else
            n, v = debug.getlocal(level, i)
        end
        if not n then
            break
        end
        if n == name then
            value = v
            found = true
        end
    end
    if found then
        return "local", value
    end

    -- try non-local variables
    local func
    if isco then
        func = debug.getinfo(co, level, "f").func
    else
        func = debug.getinfo(level, "f").func
    end
    for i = 1, math.huge do
        local n, v = debug.getupvalue(func, i)
        if not n then
            break
        end
        if n == name then
            return "upvalue", v
        end
    end

    if isenv then
        return "noenv"
    end -- avoid loop

    -- not found; get value from the environment
    local _, env = getvarvalue("_ENV", level, true)
    if env then
        return "global", env[name]
    else -- no _ENV available
        return "noenv"
    end
end

local a = 0
b = 1
print(getvarvalue("a"))
print(getvarvalue("b"))

local co = coroutine.create(function()
    local x = 3
    y = 42
    coroutine.yield()
end)

coroutine.resume(co)
print(getvarvalue(co, "x"))
print(getvarvalue(co, "y"))
