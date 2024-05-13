--[[
    Exercise 15.5: The approach of avoiding constructors when saving tables with cycles is too radical. It is
    possible to save the table in a more pleasant format using constructors for the simple case, and to use
    assignments later only to fix sharing and loops. Reimplement the function save (Figure 15.3, “Saving
    tables with cycles”) using this approach. Add to it all the goodies that you have implemented in the previous
    exercises (indentation, record syntax, and list syntax).
]] --
function save(name, value, saved, tofix, indent)
    if not saved then
        saved = {}
        io.write(name, " = ")
    end
    indent = indent or '        '
    tofix = tofix or {}
    local t = type(value)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        io.write(string.format("%q", value))
    elseif t == "table" then
        if not saved[value] then
            saved[value] = name
            io.write("{\n")
            -- look for any lists
            local max = 0
            while value[max + 1] do
                max = max + 1
            end

            -- write out any non-list elements
            for k, v in pairs(value) do
                if not saved[v] then
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
                    local fname = string.format("%s[%s]", name, k)
                    save(fname, v, saved, tofix, indent .. '    ')
                    io.write(",\n")
                else
                    tofix[k] = {
                        lhs = name,
                        rhs = saved[v]
                    }
                end
            end
            io.write(string.sub(indent, 1, -5) .. "}")
        end
    else
        error("cannot serialize a " .. type(value))
    end
    if indent == '        ' then
        io.write("\n")
        -- write out the parts of the table that have sharing/loops
        for k, v in pairs(tofix) do
            if type(k) == "number" then
                io.write(v.lhs, '[', k, '] = ', v.rhs, "\n")
            else
                io.write(v.lhs, '["', k, '"] = ', v.rhs, "\n")
            end
        end
    end
end

a = {
    ["$"] = 1,
    y = 2,
    {3, 4, 5}
}
a[2] = a
a["333"] = a[1]

save("a", a)
