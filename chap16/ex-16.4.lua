--[[
    Exercise 16.4: Can you find any value for f such that the call pcall(pcall, f) returns false as its
    first result? Why is this relevant?
]] --
print(pcall(pcall, (function()
end)()))
