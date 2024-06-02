--[[
    Exercise 20.5: Extend the previous example to allow us to traverse the bytes in the file with pairs(t)
    and get the file length with #t.
]] --
function fileAsArray(f)
    local proxy = {}
    local fh = assert(io.open(f, "r+b"))
    local mt = {
        __index = function(proxy, i)
            assert(type(i) == "number")
            fh:seek("cur", i - 1)
            local v = fh:read(1)
            fh:seek("set", 0)
            return string.byte(v)
        end,
        __newindex = function(proxy, i, v)
            assert(type(i) == "number")
            assert(type(v) == "string")
            assert(#v == 1)
            fh:seek("cur", i - 1)
            fh:write(v)
            fh:seek("set", 0)
        end,
        __len = function(proxy)
            local size = fh:seek("end")
            fh:seek("set", 0)
            return size
        end,
        __pairs = function()
            local fhp = io.open(f, "rb")
            return function(_, k)
                local k = fhp:seek()
                local v = fhp:read(1)
                if v then
                    return k + 1, v
                end
            end
        end
    }
    setmetatable(proxy, mt)
    return proxy
end
