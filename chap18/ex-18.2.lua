--[[
    Exercise 18.2: Add a step parameter to the iterator from the previous exercise. Can you still implement
    it as a stateless iterator?
]] --
function fromto(n, m, s)
    local i = n - s
    return function()
        i = i + s
        if i <= m then
            return i
        end
    end
end

local function iter(ms, i)
    local m = ms[1]
    local s = ms[2]
    i = i + s
    if i <= m then
        return i
    end
end

function fromto2(n, m, s)
    return iter, {m, s}, n - s
end

for i in fromto(3, 11, 3) do
    print(i)
end

for i in fromto2(2, 11, 2) do
    print(i)
end
