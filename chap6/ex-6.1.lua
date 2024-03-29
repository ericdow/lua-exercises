--[[
    Exercise 6.1: Write a function that takes an array and prints all its elements.
]] --
function printarray(a)
    for i = 1, #a do
        print(a[i])
    end
end
printarray({"a", "b", "c"})
