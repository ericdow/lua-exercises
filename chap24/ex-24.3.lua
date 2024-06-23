--[[
    Exercise 24.3: In Figure 24.5, “Running synchronous code on top of the asynchronous library”, both the
    functions getline and putline create a new closure each time they are called. Use memorization to
    avoid this waste.
]] --
local lib = require "async-lib"

function run(code)
    local co = coroutine.wrap(function()
        code()
        lib.stop() -- finish event loop when done
    end)
    co() -- start coroutine
    lib.runloop() -- start event loop
end

local memoput = {}
function putline(stream, line)
    local co = coroutine.running() -- calling coroutine
    local callback = memoput[co]
    if not callback then
        callback = function()
            coroutine.resume(co)
        end
        memoput[co] = callback
    end
    lib.writeline(stream, line, callback)
    coroutine.yield()
end

local memoget = {}
function getline(stream)
    local co = coroutine.running() -- calling coroutine
    local callback = memoget[co]
    if not callback then
        callback = function(l)
            coroutine.resume(co, l)
        end
        memoget[co] = callback
    end
    lib.readline(stream, callback)
    local line = coroutine.yield()
    return line
end

io.input("async-lib.lua")

run(function()
    local t = {}
    local inp = io.input()
    local out = io.output()

    while true do
        local line = getline(inp)
        if not line then
            break
        end
        t[#t + 1] = line
    end

    for i = #t, 1, -1 do
        putline(out, t[i] .. "\n")
    end
end)
