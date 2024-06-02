--[[
    Exercise 20.2: Define a metamethod __len for sets so that #s returns the number of elements in the set s.
]] --
local Set = require "set"

local s = Set.new {1, 2, 3, 4}

local mt = getmetatable(s)
mt.__len = function(s)
    local count = 0
    for _ in pairs(s) do
        count = count + 1
    end
    return count
end

print(#s)
