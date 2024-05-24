--[[
    Exercise 18.5: Write a true iterator that traverses all subsets of a given set. (Instead of creating a new table
    for each subset, it can use the same table for all its results, only changing its contents between iterations.)
]] --
function subsets(s, f)
    local function backtrack(s, subset, index, f)
        f(subset)
        for i = index, #s do
            table.insert(subset, s[i])
            backtrack(s, subset, i + 1, f)
            subset[#subset] = nil
        end
    end

    local subset = {}
    backtrack(s, subset, 1, f)
end

local function printset(s)
    print(table.concat(s))
end

local s = {"a", "b", "c"}
subsets(s, printset)
