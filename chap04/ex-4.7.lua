--[[
    Exercise 4.7: Write a function to check whether a given string is a palindrome:
        > ispali("step on no pets") --> true
        > ispali("banana") --> false
]] --
function ispali(s)
    for i = 1, #s / 2 do
        local j = #s - i + 1
        if string.sub(s, i, i) ~= string.sub(s, j, j) then
            return false
        end
    end
    return true
end
print(ispali("step on no pets"))
print(ispali("banana"))
