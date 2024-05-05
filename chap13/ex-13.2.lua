--[[
    Exercise 13.2: Implement different ways to compute the number of bits in the representation of a Lua
    integer.
]] -- 
local function numbits()
    return 4 * string.len(string.format("%x", ~0))
end
print(numbits())

local function numbits2()
    -- shift bits until you get zero
    local n = 0
    local i = ~0
    while i ~= 0 do
        i = i << 1
        n = n + 1
    end
    return n
end
print(numbits2())
