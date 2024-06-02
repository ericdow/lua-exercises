--[[
    Exercise 21.3: Reimplement your Stack class using a dual representation.
]] -- 
local data = {} -- data for all Stack instances

Stack = {}

function Stack:new(s)
    s = s or {}
    self.__index = self
    setmetatable(s, self)
    data[s] = {} -- data for this instance (initially empty)
    return s
end

function Stack:push(v)
    data[self][#data[self] + 1] = v
end

function Stack:pop()
    if (self:isempty()) then
        error("Can't pop from empty stack!", 2)
    end
    local v = data[self][#data[self]]
    data[self][#data[self]] = nil
    return v
end

function Stack:top()
    return data[self][#data[self]]
end

function Stack:isempty()
    return #data[self] == 0
end

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
