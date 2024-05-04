--[[
    Exercise 10.4: At the end of the section called “Captures”, we defined a trim function. Because of its
    use of backtracking, this function can take a quadratic time for some strings. (For instance, in my new
    machine, a match for a 100 KB string can take 52 seconds.)
]] -- 
-- • Create a string that triggers this quadratic behavior in function trim.
function trim(s)
    s = string.gsub(s, "^%s*(.-)%s*$", "%1")
    return s
end

function test(f)
    for m = 1, 5 do
        local n = 100000
        local t = {}
        for i = 1, n do
            for j = 1, math.pow(2, m) do
                t[#t + 1] = "a"
            end
            for m = 1, math.pow(2, m) do
                t[#t + 1] = " "
            end
        end
        s = table.concat(t)
        local start = os.clock()
        local result = f(s)
        print(string.format("elapsed time: %e", os.clock() - start))
    end
end
test(trim)

-- • Rewrite that function so that it always works in linear time.
local function trimfast(s)
    local n = string.find(s, "%S")
    if n then
        return string.match(s, ".*%S", n)
    end
    return ""
end
test(trimfast)
