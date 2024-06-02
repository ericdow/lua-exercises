--[[
    Exercise 21.4: A variation of the dual representation is to implement objects using proxies (the section
    called “Tracking table accesses”). Each object is represented by an empty proxy table. An internal table
    maps proxies to tables that carry the object state. This internal table is not accessible from the outside,
    but methods use it to translate their self parameters to the real tables where they operate. Implement the
    Account example using this approach and discuss its pros and cons.
]] -- 
proxies = {}

Account = {}

function Account:new(o)
    proxy = {}
    proxies[proxy] = o or {}
    if proxies[proxy].balance == nil then
        proxies[proxy].balance = 0
    end
    self.__index = self
    setmetatable(proxy, self)
    return proxy
end

function Account:deposit(v)
    proxies[self].balance = proxies[self].balance + v
end

function Account:withdraw(v)
    if v > proxies[self].balance then
        error "insufficient funds"
    end
    proxies[self].balance = proxies[self].balance - v
end

function Account:balance()
    return proxies[self].balance
end

local a = Account:new{
    balance = 100
}
a:deposit(20)
a:withdraw(50)
print(a:balance())
--[[
    Pros:
        - Data for each instance is stored together
        - Garbage collection is a bit easier than dual representation

    Cons:
        - Creates more tables than the dual representation approach
        - Default values require a bit more boilerplate
        - No guarantee that every instance contains the same member data
]]
