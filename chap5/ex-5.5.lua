--[[
    Exercise 5.5: Can you write the function from the previous item so that it uses at most n additions and n
    multiplications (and no exponentiations)?
]] function polyval(a, x)
    -- Applying Horner's method:
    result = a[#a]
    for i = #a - 1, 1, -1 do
        result = result * x + a[i]
    end
    return result
end

print(polyval({1, 2, 3}, 2.2))
