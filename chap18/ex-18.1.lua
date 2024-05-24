--[[
    Exercise 18.1: Write an iterator fromto such that the next loop becomes equivalent to a numeric for:

        for i in fromto(n, m) do
            body
        end

    Can you implement it as a stateless iterator?
]] --
function fromto(n, m)
    local i = n - 1
    return function()
        i = i + 1
        if i <= m then
            return i
        end
    end
end

local function iter(m, i)
    i = i + 1
    if i <= m then
        return i
    end
end

function fromto2(n, m)
    return iter, m, n - 1
end

for i in fromto(3, 7) do
    print(i)
end

for i in fromto2(2, 6) do
    print(i)
end
