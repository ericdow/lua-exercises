--[[
    Exercise 18.4: Write an iterator that returns all non-empty substrings of a given string.
]] --
function allsubstrings(s)
    local found = {} -- unique substrings found
    local l = 1 -- current substring length
    local pos = 1 -- current start position of substring
    return function()
        while l < #s do
            if pos + l - 1 > #s then
                l = l + 1 -- grow the substring size
                pos = 1 -- start search from beginning of string
            end
            if l <= #s then
                local sub = string.sub(s, pos, pos + l - 1)
                pos = pos + 1
                if not found[sub] then
                    found[sub] = true
                    return sub
                end
            end
        end
        return nil
    end
end

for ss in allsubstrings("ababababa") do
    print(ss)
end
