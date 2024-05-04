--[[
    Exercise 10.3: Write a function transliterate. This function receives a string and replaces each character
    in that string with another character, according to a table given as a second argument. If the table maps
    a to b, the function should replace any occurrence of a with b. If the table maps a to false, the function
    should remove occurrences of a from the resulting string.
]] -- 
function transliterate(s, map)
    local map2 = map
    for a, b in pairs(map2) do
        if b == false then
            map2[a] = ''
        end
    end
    return (string.gsub(s, "(.)", map2))
end
s = "abcdefghabcdefgh"
map = {
    a = 'b',
    c = 'd',
    e = 'f',
    g = 'h',
    h = false
}
print(transliterate(s, map))
