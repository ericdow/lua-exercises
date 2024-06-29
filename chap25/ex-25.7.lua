--[[
    Exercise 25.7: Write a library for breakpoints. It should offer at least two functions:
        setbreakpoint(function, line) --> returns handle
        removebreakpoint(handle)
    We specify a breakpoint by a function and a line inside that function. When the program hits a breakpoint,
    the library should call debug.debug. (Hint: for a basic implementation, use a line hook that checks
    whether it is in a breakpoint; to improve performance, use a call hook to trace program execution and only
    turn on the line hook when the program is running the target function.)
]] -- 
function foo()
    local a = 1
    local b = 2
    bar()
    local c = 20
    local d = a + b - c
end

function bar()
    print("bar")
    return
end

function readonly(t)
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function(t, k, v)
            error("attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, mt)
    return proxy
end

local breakpoints = {}

function hook(event, line)
    if event == "line" then
        local f = debug.getinfo(2, "f").func
        local lines = breakpoints[f]
        if lines[line] then
            debug.debug()
        end
    elseif event == "call" then
        local f = debug.getinfo(2, "f").func
        local lines = breakpoints[f]
        if lines then
            debug.sethook(hook, "lcr")
        else
            debug.sethook(hook, "cr")
        end
    else -- return event
        local f = debug.getinfo(3, "f")
        if f then
            f = f.func
            local lines = breakpoints[f]
            if lines then
                debug.sethook(hook, "lcr")
            else
                debug.sethook(hook, "cr")
            end
        end
    end
end

function setbreakpoint(func, line)
    assert(type(func) == "function")
    assert(type(line) == "number")

    if not debug.getinfo(func, "L").activelines[line] then
        error("breakpoint set on inactive line", 2)
    end

    local lines = breakpoints[func]
    if lines then
        local handle = lines[line]
        if handle then
            return handle
        else
            handle = readonly {
                func = func,
                line = line
            }
            lines[line] = handle
            return handle
        end
    else
        lines = {}
        breakpoints[func] = lines
        local handle = readonly {
            func = func,
            line = line
        }
        lines[line] = handle
        return handle
    end
end

-- initially set the hook to trigger on call events
debug.sethook(hook, "c")

function removebreakpoint(handle)
    local lines = breakpoints[handle.func]
    lines[handle.line] = nil
    if next(lines) == nil then
        breakpoints[handle.func] = nil
    end
end

local h1 = setbreakpoint(foo, 12)
local h2 = setbreakpoint(foo, 15)
foo()
removebreakpoint(h1)
foo()
