--[[
    Exercise 6.5: Write a function that takes an array and prints all combinations of the elements in the array.
]] --
function printallcombos(t)
    local C = {}
    for n = 1, #t do
        C[n] = {}
        for m = 1, n do
            C[n][m] = {}

            if C[n - 1] and C[n - 1][m] then
                for l = 1, #C[n - 1][m] do
                    table.insert(C[n][m], C[n - 1][m][l])
                end
            end

            if m == 1 then
                table.insert(C[n][m], {t[#t - n + 1]})
            else
                for l = 1, #C[n - 1][m - 1] do
                    tmp = {}
                    tmp[1] = t[#t - n + 1]
                    for k = 1, #C[n - 1][m - 1][l] do
                        tmp[k + 1] = C[n - 1][m - 1][l][k]
                    end
                    table.insert(C[n][m], tmp)
                end
            end
        end
    end
    for m = 1, #t do
        for l = 1, #C[#t][m] do
            print(table.unpack(C[#t][m][l]))
        end
    end
end

printallcombos({'a', 'b', 'c', 'd'})
