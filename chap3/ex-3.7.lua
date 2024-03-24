--[[
    Exercise 3.7: Using math.random, write a function to produce a pseudo-random number with a standard
    normal (Gaussian) distribution.
]] --
function gaussian()
    -- Box-Muller transform
    return math.sqrt(-2 * math.log(math.random())) * math.cos(2 * math.pi * math.random())
end
