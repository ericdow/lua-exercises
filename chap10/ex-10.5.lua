--[[
    Exercise 10.5: Write a function to format a binary string as a literal in Lua, using the escape sequence
    \x for all bytes:
        print(escape("\0\1hello\200"))
        --> \x00\x01\x68\x65\x6C\x6C\x6F\xC8
]] -- 
function escape(s)
    return (string.gsub(s, '.', function(c)
        return string.format("\\x%02x", string.byte(c))
    end))
end
print(escape("\0\1hello\200"))
