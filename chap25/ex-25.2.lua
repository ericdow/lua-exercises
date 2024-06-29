--[[
    Exercise 25.2: Write a function setvarvalue similar to getvarvalue (Figure 25.1, “Getting the
    value of a variable”).
]] --
function setvarvalue(name, value, level, isenv)
    local found = false

    level = (level or 1) + 1

    -- try local variables
    local n, v, idx
    for i = 1, math.huge do
        n, v = debug.getlocal(level, i)
        if not n then
            break
        end
        if n == name then
            found = true
            idx = i
        end
    end
    if found then
        debug.setlocal(level, idx, value)
        return
    end

    -- try non-local variables
    local func = debug.getinfo(level, "f").func
    for i = 1, math.huge do
        n, v = debug.getupvalue(func, i)
        if not n then
            break
        end
        if n == name then
            debug.setupvalue(func, i, value)
            return
        end
    end

    if isenv then
        return
    end -- avoid loop

    -- not found; set value in the environment
    local result = setvarvalue("_ENV", value, level, true)
    if result then
        _ENV[name] = value
    end
    return
end

local a = 0
b = 1
setvarvalue("a", 42)
setvarvalue("b", 99)
print(a)
print(b)
