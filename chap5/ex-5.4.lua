--[[
    Exercise 5.4: We can represent a polynomial a_n*x^n +
    a_{n-1}*x^{n-1} + ... + a_1*x^1 + a_0 in Lua as a list of its
    coefficients, such as {a_0 , a_1 , ..., a_n}.  Write a function
    that takes a polynomial (represented as a table) and a value for x
    and returns the polynomial value.
]] -- 
function polyval(a, x)
    result = a[1]
    for i = 2, #a do
        result = result + a[i] * x ^ (i - 1)
    end
    return result
end

print(polyval({1, 2, 3}, 2.2))
