--[[
    Exercise 3.6: Write a function to compute the volume of a right circular cone, given its height and the
    angle between a generatrix and the axis.
]] --
function conevol(h, a)
    local r = h * math.tan(a)
    return math.pi * r * r * h / 3
end

print(conevol(1, math.pi / 4))
