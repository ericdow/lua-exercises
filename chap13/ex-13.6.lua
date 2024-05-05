--[[
   Exercise 13.6: Implement a bit array in Lua. It should support the following operations:
    • newBitArray(n) (creates an array with n bits),
    • setBit(a, n, v) (assigns the Boolean value v to bit n of array a),
    • testBit(a, n) (returns a Boolean with the value of bit n).
]] -- 
local function newBitArray(n)
    assert(n > 0, "n bits must be > 0")
    local bitarray = {}
    bitarray.nbits = n
    for i = 1, math.ceil(n / 64) do
        table.insert(bitarray, 0)
    end
    return bitarray
end

local function setBit(a, n, v)
    assert(n > 0 and n <= a.nbits, "n must be 0 < n <= a.nbits")
    local i = math.ceil(n / 64)
    local b = n % 64
    b = (b == 0) and 64 or b
    if v then
        a[i] = a[i] | (1 << (b - 1))
    else
        a[i] = a[i] & ~(1 << (b - 1))
    end
end

local function testBit(a, n)
    assert(n > 0 and n <= a.nbits, "n must be 0 < n <= a.nbits")
    local i = math.ceil(n / 64)
    local b = n % 64
    b = (b == 0) and 64 or b
    return a[i] & (1 << (b - 1)) ~= 0
end

local nbits = 420
local a = newBitArray(nbits)
for i = 1, nbits do
    setBit(a, i, true)
end
setBit(a, 13, false)
setBit(a, 65, false)
setBit(a, 1, false)
setBit(a, 420, false)
for i = 1, nbits do
    if not testBit(a, i) then
        print("bit " .. i .. " not set")
    end
end

