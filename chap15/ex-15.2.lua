--[[
    Exercise 15.2: Modify the code of the previous exercise so that it uses the syntax ["key"]=value, as
    suggested in the section called “Saving tables without cycles”.
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
            local s = type(k)
            if s == "number" then
                io.write(indent, string.format('[%s] = ', k))
            else
                io.write(indent, string.format('["%s"] = ', k))
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
t["foo"] = "bar"
t[4] = {}
t[4]["a"] = "b"
t[4][365] = true
t[4]["s"] = {}
t[4]["s"][-2] = 0
t[4]["s"]["oo"] = "ee"

serialize(t)
