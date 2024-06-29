--[[
    Exercise 4.8: Redo the previous exercise so that it ignores differences in spaces and punctuation
]] --
function ispali(s)
    for i = 1, #s / 2 do
        local j = #s - i + 1
        local si = string.sub(s, i, i)
        local sj = string.sub(s, j, j)
        if string.match(si, "%w") and string.match(sj, "%w") and string.sub(s, i, i) ~= string.sub(s, j, j) then
            return false
        end
    end
    return true
end
print(ispali("?step.on no!pets "))
print(ispali("banana"))
