--[[
    Exercise 3.3: What will the following program print?
    for i = -10, 10 do
        print(i, i % 3)
    end
]] -- 
for i = -10, 10 do
    print(i, i % 3)
end
--[[
    The '%' operator is valid for negative input, so the loop cycles from 0 to 2, 
    starting on 2 and ending on 1
]]
