--[[
    Exercise 4.4: Redo the previous exercise for UTF-8 strings:
        > insert("ação", 5, "!") --> ação!
    (Note that the position now is counted in codepoints.)
]] --
function insert(s, pos, i)
    local s1 = string.sub(s, 1, utf8.offset(s, pos) - 1)
    local s2 = string.sub(s, utf8.offset(s, pos), utf8.offset(s, #s))
    return s1 .. i .. s2
end
for i = 1, 5 do
    print(insert("ação", i, "!"))
end
