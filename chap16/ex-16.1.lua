--[[
    Exercise 16.1: Frequently, it is useful to add some prefix to a chunk of code when loading it. (We saw an
    example previously in this chapter, where we prefixed a return to an expression being loaded.) Write a
    function loadwithprefix that works like load, except that it adds its extra first argument (a string)
    as a prefix to the chunk being loaded.

    Like the original load, loadwithprefix should accept chunks represented both as strings and as
    reader functions. Even in the case that the original chunk is a string, loadwithprefix should not
    actually concatenate the prefix with the chunk. Instead, it should call load with a proper reader function
    that first returns the prefix and then returns the original chunk.
]] --
function loadwithprefix(p, c)
    local prefixloaded = false
    local numcalls = 0
    local t = type(c)
    local function loader()
        if prefixloaded then
            if t == "string" then
                numcalls = numcalls + 1
                if numcalls == 1 then
                    return c
                else
                    return nil
                end
            elseif t == "function" then
                return c()
            else
                error("chunk must be string or function")
            end
        else
            prefixloaded = true
            return p
        end
    end
    return load(loader)
end

local f = loadwithprefix("print('foo')", "print('bar')")
print(f())
