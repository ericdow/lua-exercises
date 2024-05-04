--[[
    Exercise 5.7: Write a function that inserts all elements of a given list into a given position of another given
    list.
]] --
function insertat(l1, l2, p)
    for k, v in ipairs(l1) do
        table.insert(l2, p + k - 1, v)
    end
end
t2 = {1, 2, 6, 7, 8}
t1 = {3, 4, 5}
insertat(t1, t2, 3)
for _, v in ipairs(t2) do
    print(v)
end
