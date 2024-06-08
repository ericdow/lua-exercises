--[[
    Exercise 22.1: The function getfield that we defined in the beginning of this chapter is too forgiving,
    as it accepts “fields” like math?sin or string!!!gsub. Rewrite it so that it accepts only single dots
    as name separators.
]] --
function getfield(f)
    local v = _G -- start with the table of globals
    local i, j, s = 1, 1, 1
    while j ~= #f do
        i, j = string.find(f, "[%a_][%w_]*", s)
        assert(i == s, "Invalid field")
        assert(j == #f or string.sub(f, j + 1, j + 1) == ".", "Invalid separator")
        s = j + 2
        local w = string.sub(f, i, j)
        v = v[w]
    end
    return v
end
a = {}
a.b = {}
a.b.c = {}
a.b.c.d = 42
print(getfield("a.b.c.d"))
getfield("a?b.c!!d")
