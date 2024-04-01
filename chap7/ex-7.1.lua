--[[
    Exercise 7.1: Write a program that reads a text file and rewrites it with its lines sorted in alphabetical order.
    When called with no arguments, it should read from standard input and write to standard output. When
    called with one file-name argument, it should read from that file and write to standard output. When called
    with two file-name arguments, it should read from the first file and write to the second.
]] --
local infile = arg[1] or stdin
local outfile = arg[2] or stdout

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
