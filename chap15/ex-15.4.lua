--[[
    Exercise 15.4: Modify the code of the previous exercise so that it uses the constructor syntax for lists
    whenever possible. For instance, it should serialize the table {14, 15, 19} as {14, 15, 19}, not
    as {[1] = 14, [2] = 15, [3] = 19}. (Hint: start by saving the values of the keys 1, 2, ..., as
    long as they are not nil. Take care not to save them again when traversing the rest of the table.)
]] -- 
function serialize(o, indent)
    if not indent then
        indent = '    '
    end
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        io.write(string.format("%q", o))
    elseif t == "table" then
        io.write("{\n")
        -- look for any lists
        local max = 0
        while o[max + 1] do
            max = max + 1
        end

        -- write out any non-list elements
        for k, v in pairs(o) do
            local s = type(k)
            if s == "string" then
                local match = string.match(k, "[_%a][_%w]*")
                if match and string.len(k) == string.len(match) then
                    io.write(indent, k, " = ")
                else
                    io.write(indent, string.format('["%s"] = ', k))
                end
            elseif k < 1 or k > max then
                io.write(indent, string.format('[%s] = ', k))
            else
                io.write(indent)
            end
            serialize(v, indent .. '    ')
            io.write(",\n")
        end
        io.write(string.sub(indent, 1, -5) .. "}")
    else
        error("cannot serialize a " .. type(o))
    end
    if indent == '    ' then
        io.write("\n")
    end
end

local t = {}
t[1] = 42
t[2] = {"eep", 3.14}
t["foo"] = "bar"
t[4] = {11, 12, 13, 14}
t[4]["_a"] = "b"
t[4]["#"] = true
t[4]["s"] = {}
t[4]["s"][-2] = 0
t[4]["s"]["333"] = "ee"

serialize(t)
