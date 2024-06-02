--[[
    Exercise 21.2: Implement a class StackQueue as a subclass of Stack. Besides the inherited methods,
    add to this class a method insertbottom, which inserts an element at the bottom of the stack. (This
    method allows us to use objects of this class as queues.)
]] --
local Stack = require "Stack"

local StackQueue = Stack:new()

function StackQueue:insertbottom(v)
    table.insert(self.data, 1, v) -- inefficient, but doesn't require overloading other member functions
end

local s = StackQueue:new()
print(s:isempty())
s:push("a")
s:push("b")
s:insertbottom("x")
s:insertbottom("y")
print(s:top())
print(s:isempty())
s:pop()
s:pop()
s:pop()
s:pop()
print(s:isempty())
