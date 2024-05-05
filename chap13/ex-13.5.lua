--[[
    Exercise 13.5: Write a function to test whether the binary representation of a given integer is a palindrome.
]] -- 
local function ispalindrome(n)
    local maskl = 1
    local maskr = 1 << 63
    for i = 1, 32 do
        local lb = n & maskl
        local rb = n & maskr
        if (lb == 0 and rb ~= 0) or (rb == 0 and lb ~= 0) then
            return false
        end
        maskl = maskl << 1
        maskr = maskr >> 1
    end
    return true
end
print(ispalindrome((1 << 63) + (1 << 0)))
print(ispalindrome((1 << 63) + (1 << 38) + (1 << 0) + (1 << 25)))
print(ispalindrome((1 << 63) + (1 << 3)))
print(ispalindrome((1 << 63) + (1 << 39) + (1 << 0) + (1 << 25)))
