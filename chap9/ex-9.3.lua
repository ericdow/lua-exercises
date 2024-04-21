--[[
    Exercise 9.3: Exercise 5.4 asked you to write a function that receives a polynomial (represented as a table)
    and a value for its variable, and returns the polynomial value. Write the curried version of that function.
    Your function should receive a polynomial and return a function that, when called with a value for x,
    returns the value of the polynomial for that x. See the example:
        f = newpoly({3, 0, 1})
        print(f(0)) --> 3
        print(f(5)) --> 28
        print(f(10)) --> 103
]] -- 
function newpoly(a)
    return function(x)
        result = a[1]
        for i = 2, #a do
            result = result + a[i] * x ^ (i - 1)
        end
        return result
    end
end

f = newpoly({3, 0, 1})
print(f(0))
print(f(5))
print(f(10))
