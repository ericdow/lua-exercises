--[[
    Exercise 6.4: Write a function to shuffle a given list. Make sure that all permutations are equally probable.
]] --
function shuffle(t)
    -- Using Fisher-Yates
    for i = #t, 1, -1 do
        local j = math.random(i)
        if (i ~= j) then
            t[i], t[j] = t[j], t[i]
        end
    end
    return t
end

local num3first = 0
for i = 1, 10000 do
    r = shuffle({1, 2, 3, 4, 5})
    if r[1] == 3 then
        num3first = num3first + 1
    end
end
print(num3first / 10000)
