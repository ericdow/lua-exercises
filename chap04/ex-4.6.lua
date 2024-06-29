--[[
    Exercise 4.6: Redo the previous exercise for UTF-8 strings:
        > remove("ação", 2, 2) --> ao
    (Here, both the initial position and the length should be counted in codepoints.)
]] -- 
function remove(s, pos, l)
    return string.sub(s, 1, utf8.offset(s, pos) - 1) .. string.sub(s, utf8.offset(s, pos + l), #s)
end
print(remove("ação", 2, 2))
