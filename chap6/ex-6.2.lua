--[[
    Exercise 6.2: Write a function that takes an arbitrary number of values and returns all of them, except
    the first one.
]] --
function getlast(...)
    return select(2, ...)
end

b, c, x = getlast("a", "b", "c")
print(b, c, x)
