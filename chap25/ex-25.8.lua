--[[
    Exercise 25.8: One problem with the sandbox in Figure 25.6, “Using hooks to bar calls to unauthorized
    functions” is that sandboxed code cannot call its own functions. How can you correct this problem?
]] -- 
local debug = require "debug"

-- maximum "steps" that can be performed
local steplimit = 1000

local count = 0 -- counter for steps

-- set of authorized functions
local validfunc = {
    [string.upper] = true,
    [string.lower] = true
}

local src = "sandboxed.lua"
local function hook(event)
    if event == "call" then
        local info = debug.getinfo(2, "Sfn")
        if not validfunc[info.func] and info.source ~= "@" .. src then
            error("calling bad function: " .. (info.name or "?"))
        end
    end
    count = count + 1
    if count > steplimit then
        error("script uses too much CPU")
    end
end

-- load chunk
local f = assert(loadfile(src, "t"))

debug.sethook(hook, "c", 1) -- set hook

f() -- run chunk
