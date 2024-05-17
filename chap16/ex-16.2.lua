--[[
    Exercise 16.2: Write a function multiload that generalizes loadwithprefix by receiving a list of
    readers, as in the following example:
        f = multiload("local x = 10;",
                      io.lines("temp", "*L"),
                      " print(x)")
    In the above example, multiload should load a chunk equivalent to the concatenation of the string
    "local...", the contents of the temp file, and the string "print(x)". Like loadwithprefix,
    from the previous exercise, multiload should not actually concatenate anything.
]] --
function multiload(...)
    local numcalls = 1
    local chunks = table.pack(...)
    local function loader()
        if numcalls > #chunks then
            return nil
        else
            local chunk = chunks[numcalls]
            local t = type(chunks[numcalls])
            numcalls = numcalls + 1
            if t == "string" then
                return chunk
            elseif t == "function" then
                return chunk()
            else
                error("chunks must be string or function")
            end
        end
    end
    return load(loader)
end

local f = multiload("local x = 10;", io.lines("chunk.txt", "*L"), " print(x)")
print(f())
