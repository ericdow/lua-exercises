--[[
    Exercise 20.3: An alternative way to implement read-only tables might use a function as the __index
    metamethod. This alternative makes accesses more expensive, but the creation of read-only tables is 
    cheaper, as all read-only tables can share a single metatable. Rewrite the function readOnly using 
    this approach.
]] --
local hidden = {} -- use a table as the key for storing the table in the proxy to "hide" the table
local mt = {
    __index = function(proxy, k)
        return proxy[hidden][k]
    end,
    __newindex = function(t, k, v)
        error("attempt to update a read-only table", 2)
    end
}

function readOnly(t)
    local proxy = {
        [hidden] = t
    }
    setmetatable(proxy, mt)
    return proxy
end

days = readOnly {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
months = readOnly {"Jan", "Feb", "Mar"}

print(days[1])
days[2] = "Noday"
