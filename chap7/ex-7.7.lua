--[[
    Exercise 7.7: Can you use os.execute to change the current directory of your Lua script? Why?
]] --
os.execute("cd ..")
local f = io.popen("ls", "r")
for entry in f:lines() do
    print(entry)
end
--[[
    The reason this doesn't work is because os.execute() spawns a new process, and changing the 
    directory in that process doesn't affect the lua script process
]]
