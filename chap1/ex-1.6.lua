--[[
    Exercise 1.6: How can you check whether a value is a Boolean without using the function type?
]] --
--[[
    We can negate the value twice and check if it equals itself
    Since 'not' always returns a boolean, we will be checking if the value is 'true' or 'false'
]] --
function isbool(a)
    return a == not not a
end

print("isbool(3):", isbool(3))
print("isbool('hi'):", isbool('hi'))
print("isbool(nil):", isbool(nil))
print("isbool(true):", isbool(true))
print("isbool(false):", isbool(false))
