--[[
    Exercise 21.1: Implement a class Stack, with methods push, pop, top, and isempty.
]] --
local Stack = require "Stack"

local s = Stack:new()
print(s:isempty())
s:push("a")
s:push("b")
s:push("c")
print(s:top())
print(s:isempty())
s:pop()
s:pop()
s:pop()
print(s:isempty())
