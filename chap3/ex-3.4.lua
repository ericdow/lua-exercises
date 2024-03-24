--[[
    Exercise 3.4: What is the result of the expression 2^3^4? What about 2^-3^4?
]] -- 
-- exponentiation is right associative
print(2 ^ 3 ^ 4) -- = 2^(3^4) = 2^81 = 2.4178516392293e+24
print(2 ^ -3 ^ 4) --  = 2^(-3^4) = 2^-81 = 4.1359030627651e-25
