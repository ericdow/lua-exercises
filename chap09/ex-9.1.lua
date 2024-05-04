--[[
    Exercise 9.1: Write a function integral that takes a function f and returns an approximation of its
    integral. 
]] --
function integral(f, a, b, n)
    -- Use the midpoint rule to approximate the integral of f on the interval [a,b]
    local a = a or 0
    local b = b or 1
    local n = n or 100

    local dx = (b - a) / n
    local x = a + 0.5 * dx

    local int = 0.0
    for i = 1, 100 do
        int = int + f(x) * dx
        x = x + dx
    end

    return int
end

print(integral(math.sin))
