--[[
    Exercise 13.1: Write a function to compute the modulo operation for unsigned integers.
]] --
function umod(a, b)
    if math.ult(a, b) then
        return a
    elseif a == b then
        return 0
    else
        -- compute floor(a/b)
        local q = ((a >> 1) // b) << 1
        local r = a - q * b
        if not math.ult(r, b) then
            q = q + 1
        end

        return a - q * b
    end
end
