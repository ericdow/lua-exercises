--[[
    Exercise 16.3: The function stringrep, in Figure 16.2, “String repetition”, uses a binary multiplication
    algorithm to concatenate n copies of a given string s.

    Figure 16.2. String repetition

        function stringrep(s, n)
            local r = ""
            if n > 0 then
                while n > 1 do
                    if n % 2 ~= 0 then
                        r = r .. s
                    end
                    s = s .. s
                    n = math.floor(n / 2)
                end
                r = r .. s
            end
            return r
        end

    For any fixed n, we can create a specialized version of stringrep by unrolling the loop into a sequence
    of instructions r = r .. s and s = s .. s. As an example, for n = 5 the unrolling gives us
    the following function:

        function stringrep_5(s)
            local r = ""
            r = r .. s
            s = s .. s
            s = s .. s
            r = r .. s
            return r
        end

    Write a function that, given n, returns a specialized function stringrep_n. Instead of using a closure,
    your function should build the text of a Lua function with the proper sequence of instructions (a mix of r
    = r .. s and s = s .. s) and then use load to produce the final function. Compare the performance
    of the generic function stringrep (or of a closure using it) with your tailor-made functions.
]] --
function unrollstringrep(n)
    lines = {}
    table.insert(lines, 'local s = ...')
    table.insert(lines, 'local r = ""')
    if n > 0 then
        while n > 1 do
            if n % 2 ~= 0 then
                table.insert(lines, "r = r .. s")
            end
            table.insert(lines, "s = s .. s")
            n = math.floor(n / 2)
        end
        table.insert(lines, "r = r .. s")
    end
    table.insert(lines, "return r")
    return load(table.concat(lines, "\n"))
end

function stringrep(s, n)
    local r = ""
    if n > 0 then
        while n > 1 do
            if n % 2 ~= 0 then
                r = r .. s
            end
            s = s .. s
            n = math.floor(n / 2)
        end
        r = r .. s
    end
    return r
end

local n = 10000000
local s = "foo"
local f = unrollstringrep(n)

local tic = os.clock()
f(s)
print("unrollstringrep:", os.clock() - tic)

tic = os.clock()
stringrep(s, n)
print("stringrep:", os.clock() - tic)
