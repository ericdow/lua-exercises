--[[
    Exercise 10.2: The patterns '%D' and '[^%d]' are equivalent. What about the patterns '[^%d%u]' and '[%D%U]'?
]] -- 
--[[
They are not equivalent, since the '^' complement is not distributive:
'[^%d%u]' matches anything that is not (a digit followed by an upper case letter)
'[%D%U]' matches anything that is not a digit followed by anything that is not an upper case letter
]] --
local s = "9a"
print(string.match(s, "[^%d%u]"))
print(string.match(s, "[%D%U]"))
