--[[
    Exercise 2.2: An alternative implementation for the eight-queen problem would be to generate all possible
    permutations of 1 to 8 and, for each permutation, to check whether it is valid. Change the program to use
    this approach. How does the performance of the new program compare with the old one? (Hint: compare
    the total number of permutations with the number of times that the original program calls the function
    isplaceok.)
]] --
N = 8 -- board size

-- check whether position (n,c) is free from attacks
function isplaceok(a, n, c)
    for i = 1, n - 1 do -- for each queen already placed
        if (a[i] == c) or -- same column?
        (a[i] - i == c - n) or -- same diagonal?
        (a[i] + i == c + n) then -- same diagonal?
            return false -- place can be attacked
        end
    end
    return true -- no attacks; place is OK
end

-- print a board
function printsolution(a)
    for i = 1, N do -- for each row
        for j = 1, N do -- and for each column
            -- write "X" or "-" plus a space
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
end

function permute(k, a)
    if k == 1 then
        -- check for attacks
        valid = true
        for n = 2, N do
            valid = valid and isplaceok(a, n, a[n])
        end
        if valid then
            printsolution(a)
        end
    else
        for i = 1, k do
            permute(k - 1, a)
            if k % 2 == 0 then
                a[i], a[k] = a[k], a[i]
            else
                a[1], a[k] = a[k], a[1]
            end
        end
    end
end

a = {}
for i = 1, N do
    table.insert(a, i)
end

-- run the program
permute(N, a)
