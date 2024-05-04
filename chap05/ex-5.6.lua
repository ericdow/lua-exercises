--[[
    Exercise 5.6: Write a function to test whether a given table is a valid sequence.
]] -- 
function issequence(t)
    -- A sequence is a table where the positive numeric keys comprise a set {1,...,n} for some n
    max = 0
    numpairs = 0
    for k, _ in pairs(t) do
        if type(k) == "number" and k > 0 then
            max = math.max(k, max)
        end
        numpairs = numpairs + 1
    end

    if max > numpairs then
        return false
    end

    for i = 1, max do
        if t[i] == nil then
            return false
        end
    end
    return true
end

t = {
    foo = 1,
    [1] = 3,
    bar = 2,
    [2] = 4,
    [3] = 4,
    [4] = 2,
    [5] = 5
}
print(issequence(t))

t = {
    [1] = 3,
    [2] = 4,
    [3] = nil,
    [4] = 2,
    [5] = 5
}
print(issequence(t))
