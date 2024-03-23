--[[
    Exercise 1.5: What is the value of the expression type(nil) == nil? (You can use Lua to check
    your answer.) Can you explain this result?
]]

if type(nil) == nil then
    print("equal")
else
    print("not equal")
end

--[[
    The expression is false
    The result of type() always produces a string, which is not equal to nil
]]