--[[
    Exercise 25.6: Implement some of the suggested improvements for the basic profiler that we developed
    in the section called “Profiles”.
]] --
local Counters = {}
local Names = {}

local function hook()
    local f = debug.getinfo(2, "f").func
    local count = Counters[f]
    if count == nil then -- first time 'f' is called?
        Counters[f] = 1
        Names[f] = debug.getinfo(2, "Sn")
    else -- only increment the counter
        Counters[f] = count + 1
    end
end

local function getname(func)
    local n = Names[func]
    if n.what == "C" then
        return n.name
    end
    local lc = string.format("[%s]:%d", n.short_src, n.linedefined)
    if n.what ~= "main" and n.namewhat ~= "" then
        return string.format("%s (%s)", lc, n.name)
    else
        return lc
    end
end

-- suppress printing
local printorig = print
print = function()
end

local f = assert(loadfile("ex-25.1.lua"))
debug.sethook(hook, "c")
f()
debug.sethook()

print = printorig

-- sort the functions by call count
sorted = {}
for func in pairs(Counters) do
    table.insert(sorted, func)
end
table.sort(sorted, function(a, b)
    return Counters[a] > Counters[b]
end)

for i, func in ipairs(sorted) do
    print(getname(func), Counters[func])
end
