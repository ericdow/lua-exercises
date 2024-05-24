--[[
    Exercise 18.3: Write an iterator uniquewords that returns all words from a given file without repetitions.
    (Hint: start with the allwords code in Figure 18.1, “Iterator to traverse all words from the standard
    input”; use a table to keep all words already reported.)
]] --
function uniquewords()
    local line = io.read() -- current line
    local pos = 1 -- current position in the line
    local found = {}
    return function() -- iterator function
        while line do -- repeat while there are lines
            local w, e = string.match(line, "(%w+)()", pos)
            if w then -- found a word?
                pos = e -- next position is after this word
                if not found[w] then
                    found[w] = true
                    return w -- return the word
                end
            else
                line = io.read() -- word not found; try next line
                pos = 1 -- restart from first position
            end
        end
        return nil -- no more lines: end of traversal
    end
end

io.input("ex-18.2.lua")
for w in uniquewords() do
    print(w)
end
