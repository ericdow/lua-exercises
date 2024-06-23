--[[
    Exercise 24.4: Write a line iterator for the coroutine-based library (Figure 24.5, “Running synchronous
    code on top of the asynchronous library”), so that you can read the file with a for loop.
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

function putline(stream, line)
    local co = coroutine.running() -- calling coroutine
    local callback = (function()
        coroutine.resume(co)
    end)
    lib.writeline(stream, line, callback)
    coroutine.yield()
end

function getline(stream)
    local co = coroutine.running() -- calling coroutine
    local callback = (function(l)
        coroutine.resume(co, l)
    end)
    lib.readline(stream, callback)
    local line = coroutine.yield()
    return line
end

function getlines(stream)
    return function()
        return getline(stream)
    end
end

io.input("async-lib.lua")

run(function()
    local t = {}
    local inp = io.input()
    local out = io.output()

    for line in getlines(inp) do
        t[#t + 1] = line
    end

    for i = #t, 1, -1 do
        putline(out, t[i] .. "\n")
    end
end)
