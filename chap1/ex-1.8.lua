--[[
    Exercise 1.8: Write a simple script that prints its own name without knowing it in advance.
]]

--[[
    All arguments to a lua script are stored in the global variable 'arg'
    The script name is stored at index 0
]]

print(arg[0])