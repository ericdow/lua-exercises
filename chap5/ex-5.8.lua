--[[
    Exercise 5.8: The table library offers a function table.concat, which receives a list of strings and
    returns their concatenation:
        print(table.concat({"hello", " ", "world"})) --> hello world
    Write your own version for this function.
    Compare the performance of your implementation against the built-in version for large lists, with hundreds
    of thousands of entries. (You can use a for loop to create those large lists.)
]] --
function concat(t)
    out = t[1]
    for s = 2, #t do
        out = out .. t[s]
    end
    return out
end

n = 100000
t = {}
for i = 1, n do
    t[#t + 1] = "foo"
end
start = os.clock()
concat(t)
print(string.format("elapsed time: %e", os.clock() - start))
start = os.clock()
table.concat(t)
print(string.format("elapsed time: %e", os.clock() - start))
