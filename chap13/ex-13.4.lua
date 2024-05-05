--[[
    Exercise 13.4: Write a function to compute the Hamming weight of a given integer. (The Hamming weight
    of a number is the number of ones in its binary representation.)
]] -- 
local function hammingweight(n)
    local weight = 0
    for i = 1, 64 do
        n = n >> 1
        if n & 1 == 1 then
            weight = weight + 1
        end
    end
    return weight
end
print(hammingweight(1 << 13))
print(hammingweight((1 << 63) + (1 << 8) + (1 << 1)))
