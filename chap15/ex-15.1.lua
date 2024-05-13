--[[
    Exercise 15.1: Modify the code in Figure 15.2, “Serializing tables without cycles” so that it indents nested
    tables. (Hint: add an extra parameter to serialize with the indentation string.)
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
        for k, v in pairs(o) do
            io.write(indent, k, " = ")
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
t["foo"] = "bar"
t[4] = {}
t[4]["a"] = "b"
t[4][365] = true
t[4]["s"] = {}
t[4]["s"][-2] = 0
t[4]["s"]["oo"] = "ee"

serialize(t)
