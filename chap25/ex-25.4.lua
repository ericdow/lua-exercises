--[[
    Exercise 25.4: Write an improved version of debug.debug that runs the given commands as if they
    were in the lexical scope of the calling function. (Hint: run the commands in an empty environment and
    use the __index metamethod attached to the function getvarvalue to do all accesses to variables.)
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

function debug2()
    local env = setmetatable({
        print = print, -- allow printing inside debug
        string = string
    }, {
        __index = getvarvalue
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
