--[[
    Exercise 24.2: Exercise 6.5 asked you to write a function that prints all combinations of the elements in
    a given array. Use coroutines to transform this function into a generator for combinations, to be used like
    here:
        for c in combinations({"a", "b", "c"}, 2) do
            printResult(c)
        end
]] -- 
function printResult(a)
    for i = 1, #a do
        io.write(a[i], " ")
    end
    io.write("\n")
end

function tail(t)
    c = {}
    for i = 2, #t do
        c[i - 1] = t[i]
    end
    return c
end

function combogen(s, x, l, k)
    if l > #s then
        return
    end

    if #x == k then
        coroutine.yield(x)
    else
        local stail = tail(s)
        table.insert(x, s[1])
        combogen(stail, x, l - 1, k)

        table.remove(x, #x)
        combogen(stail, x, l, k)
    end
end

function combinations(a, k)
    return coroutine.wrap(function()
        combogen(a, {}, k, k)
    end)
end

for c in combinations({"a", "b", "c"}, 2) do
    printResult(c)
end
