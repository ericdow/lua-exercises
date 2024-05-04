--[[
    Exercise 7.2: Change the previous program so that it asks for confirmation if the user gives the name of
    an existing file for its output.
]] --
local infile = arg[1] or stdin
local outfile = arg[2] or stdout

if arg[2] then
    local f = io.popen("ls", "r")
    for entry in f:lines() do
        if entry == arg[2] then
            print("File exists, overwrite?")
            local r = io.read(1)
            if string.lower(r) ~= 'y' then
                print('Exiting')
                return
            end
        end
    end
end

io.input(infile)

local t = {}
for line in io.lines() do
    t[#t + 1] = line
end
table.sort(t)

io.output(outfile)
for i = 1, #t do
    io.write(t[i] .. "\n")
end
