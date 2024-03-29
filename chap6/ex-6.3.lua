--[[
    Exercise 6.3: Write a function that takes an arbitrary number of values and returns all of them, except
    the last one.
]] --
function getfirst(...)
    local t = table.pack(...)
    table.remove(t, #t)
    return table.unpack(t)
end

a, b, x = getfirst("a", "b", "c")
print(a, b, x)
