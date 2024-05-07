--[[
    Exercise 14.1: Write a function to add two sparse matrices.
]] --
function spadd(a, b)
    local c = {}
    for i, _ in pairs(a) do
        local rowb = b[i]
        c[i] = {}
        for j, va in pairs(a[i]) do -- 'va' is a[i][j]
            local res = va
            if rowb and rowb[j] then
                res = res + rowb[j]
            end
            c[i][j] = (res ~= 0) and res or nil
        end
    end
    for i, _ in pairs(b) do
        local rowa = a[i]
        c[i] = c[i] and c[i] or {}
        for j, vb in pairs(b[i]) do -- 'vb' is b[i][j]
            if rowa and not rowa[j] then
                c[i][j] = (vb ~= 0) and vb or nil
            end
        end
    end
    return c
end

local a = {}
a[1] = {}
a[1][1] = 1
a[2] = {}
a[2][2] = 2
a[2][4] = 3
a[4] = {}
a[4][3] = 4
a[4][4] = 5

local b = {}
b[1] = {}
b[1][1] = 3
b[1][4] = 3
b[2] = {}
b[2][2] = -a[2][2]
b[2][4] = -a[2][4]
b[4] = {}
b[4][3] = 2
b[4][4] = 7

local c = spadd(a, b)
for i, _ in pairs(c) do
    for j, vc in pairs(c[i]) do
        print("c[" .. i .. "][" .. j .. "]=" .. vc)
    end
end
