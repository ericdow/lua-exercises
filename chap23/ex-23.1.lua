--[[
    Exercise 23.1: Write an experiment to determine whether Lua actually implements ephemeron tables.
    (Remember to call collectgarbage to force a garbage collection cycle.) If possible, try your code
    both in Lua 5.1 and in Lua 5.2/5.3 to see the difference.
]] --
do
    local mem = {} -- memorization table
    setmetatable(mem, {
        __mode = "k"
    })
    function memsize()
        local count = 0
        for k in pairs(mem) do
            count = count + 1
        end
        return count
    end
    function factory(o)
        local res = mem[o]
        if not res then
            res = (function()
                return o
            end)
            mem[o] = res
        end
        return res
    end
end

local o = {}
factory(o)
o = nil
print(memsize())
collectgarbage()
print(memsize())
