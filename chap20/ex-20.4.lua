--[[
    Exercise 20.4: Proxy tables can represent other kinds of objects besides tables. Write a function
    fileAsArray that takes the name of a file and returns a proxy to that file, so that after a call t =
    fileAsArray("myFile"), an access to t[i] returns the i-th byte of that file, and an assignment
    to t[i] updates its i-th byte.
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
        end
    }
    setmetatable(proxy, mt)
    return proxy
end
