--[[
    Exercise 25.5: Improve the previous exercise to handle updates, too.
]] -- 
function getvarvalue(_, name, isenv)
    local value
    local found = false
    local level = 4

    -- try local variables
    for i = 1, math.huge do
        local n, v = debug.getlocal(level, i)
        if not n then
            break
        end
        if n == name then
            value = v
            found = true
        end
    end
    if found then
        return value
    end

    -- try non-local variables
    local func = debug.getinfo(level, "f").func
    for i = 1, math.huge do
        local n, v = debug.getupvalue(func, i)
        if not n then
            break
        end
        if n == name then
            return v
        end
    end

    if isenv then
        return
    end -- avoid loop

    -- not found; get value from the environment
    local _, env = getvarvalue(nil, "_ENV", true)
    if env then
        return rawget(env, name)
    end
end

function setvarvalue(_, name, value, isenv)
    local found = false
    local level = 4

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
    local result = setvarvalue(nil, "_ENV", value, true)
    if result then
        _ENV[name] = value
    end
    return
end

function debug2()
    local env = setmetatable({
        print = print, -- allow printing inside debug
        string = string
    }, {
        __index = getvarvalue,
        __newindex = setvarvalue
    })
    while true do
        io.write("debug> ")
        local line = io.read()
        if line == "cont" then
            break
        end
        assert(load(line, nil, nil, env))()
    end
end

g1 = "g1"
function foo()
    local up1 = "up1"
    local up2 = "up2"
    return function()
        local l1 = "l1"
        local l2 = "l2"
        if up1 == up2 then
            up1 = up1
        end
        debug2()
    end
end

foo()()
