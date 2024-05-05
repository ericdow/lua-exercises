--[[
    Exercise 13.3: How can you test whether a given integer is a power of two?
]] -- 
local function ispow2(n)
    -- assuming 64-bit integers
    if n < 0 then
        n = -n
    end
    if n & 1 == 1 then
        return false
    end
    local numones = 0
    for i = 1, 63 do
        n = n >> 1
        if n & 1 == 1 then
            numones = numones + 1
            if numones > 1 then
                return false
            end

        end
    end
    return numones == 1
end
print(ispow2(1 << 23))
print(ispow2(-1 << 18))
print(ispow2(37))
print(ispow2(0))
print(ispow2(-1))
