--[[
    Exercise 4.3: Write a function to insert a string into a given position of another one:
        > insert("hello world", 1, "start: ") --> start: hello world
        > insert("hello world", 7, "small ") --> hello small world
]] --
function insert(s, pos, i)
    local s1 = string.sub(s, 1, pos - 1)
    local s2 = string.sub(s, pos, #s)
    return s1 .. i .. s2
end
print(insert("hello world", 1, "start: "))
print(insert("hello world", 7, "small "))
