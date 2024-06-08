--[[
    Exercise 22.3: Explain in detail what happens in the following program and what it will print.
]] -- 
local print = print
function foo(_ENV, a)
    -- b is evaluated as _ENV.b since it's not a local
    print(a + b) -- print is upvalue in foo() closure
end

foo({
    b = 14
}, 12) -- prints 26
foo({
    b = 10
}, 1) -- prints 11
