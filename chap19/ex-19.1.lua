--[[
    Exercise 19.1: Generalize the Markov-chain algorithm so that it can use any size for the sequence of
    previous words used in the choice of the next word.
]] --
function allwords()
    local line = io.read() -- current line
    local pos = 1 -- current position in the line
    return function() -- iterator function
        while line do -- repeat while there are lines
            local w, e = string.match(line, "(%w+[,;.:]?)()", pos)
            if w then -- found a word?
                pos = e -- update next position
                return w -- return the word
            else
                line = io.read() -- word not found; try next line
                pos = 1 -- restart from first position
            end
        end
        return nil -- no more lines: end of traversal
    end
end

local statetab = {}

function insert(prefix, value)
    local list = statetab[prefix]
    if list == nil then
        statetab[prefix] = {value}
    else
        list[#list + 1] = value
    end
end

function generate(maxgen, prefixsize)
    local NOWORD = "\n"
    local prefixsize = 4

    -- build table
    local words = {}
    for i = 1, prefixsize do
        table.insert(words, NOWORD)
    end
    for nextword in allwords() do
        insert(table.concat(words, " "), nextword)
        for i = 1, prefixsize - 1 do
            words[i] = words[i + 1]
        end
        words[prefixsize] = nextword;
    end
    insert(table.concat(words, " "), NOWORD)

    -- generate text
    for i = 1, prefixsize do
        words[i] = NOWORD
    end
    for i = 1, maxgen do
        local list = statetab[table.concat(words, " ")]
        -- choose a random item from list
        local r = math.random(#list)
        local nextword = list[r]
        if nextword == NOWORD then
            return
        end
        io.write(nextword, " ")
        for i = 1, prefixsize - 1 do
            words[i] = words[i + 1]
        end
        words[prefixsize] = nextword;
    end
end

io.input("genesis.txt")
generate(200, 3)
