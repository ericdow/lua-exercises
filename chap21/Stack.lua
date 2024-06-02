Stack = {
    data = {}
}

function Stack:new(s)
    s = s or {}
    self.__index = self
    setmetatable(s, self)
    return s
end

function Stack:push(v)
    self.data[#self.data + 1] = v
end

function Stack:pop()
    if (self:isempty()) then
        error("Can't pop from empty stack!", 2)
    end
    local v = self.data[#self.data]
    self.data[#self.data] = nil
    return v
end

function Stack:top()
    return self.data[#self.data]
end

function Stack:isempty()
    return #self.data == 0
end

return Stack
