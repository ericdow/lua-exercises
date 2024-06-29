--[[
    Exercise 4.5: Write a function to remove a slice from a string; the slice should be given by its initial
    position and its length:
        > remove("hello world", 7, 4) --> hello d
]] -- 
function remove(s, pos, l)
    return string.sub(s, 1, pos - 1) .. string.sub(s, pos + l, #s)
end
print(remove("hello world", 7, 4))
