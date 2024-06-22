--[[
    Exercise 23.4: Explain the output of the program in Figure 23.3, “Finalizers and memory”.
]] -- 
local count = 0

local mt = {
    __gc = function()
        count = count - 1
    end
}
local a = {}

for i = 1, 10000 do
    count = count + 1
    a[i] = setmetatable({}, mt)
end

collectgarbage()
-- The table "a" is still referenced, so it is not collected
print(collectgarbage("count") * 1024, count) -- > 844790.0        10000
a = nil
collectgarbage()
-- Cleaning phase: collects objects that have finalizers into a separate list, calls finalizers
print(collectgarbage("count") * 1024, count) -- > 582654.0        0
-- Sweep phase: cleans up list of finalized objects
collectgarbage()
print(collectgarbage("count") * 1024, count) -- > 22664.0 0

