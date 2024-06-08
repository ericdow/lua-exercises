--[[
    Exercise 22.2: Explain in detail what happens in the following program and what it will print.
]] -- 
local foo
do
    local _ENV = _ENV -- local _ENV is upvalue in foo() closure
    function foo()
        print(X) -- evaluated as local _ENV.X
    end
end
X = 13
_ENV = nil
foo() -- prints 13
X = 0 -- global environment is nil so this fails
