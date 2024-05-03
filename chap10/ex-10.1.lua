--[[
    Exercise 10.1: Write a function split that receives a string and a delimiter pattern and returns a sequence
    with the chunks in the original string separated by the delimiter:
        t = split("a whole new world", " ")
        -- t = {"a", "whole", "new", "world"}
    How does your function handle empty strings? (In particular, is an empty string an empty sequence or a
    sequence with one empty string?)
]] -- 
function split(s, d)
    local chunks = {}
    local start = 1
    local i = 1
    local j = 1
    while i do
        i, j = string.find(s, d, start, true)
        if i then
            if start ~= i then
                chunks[#chunks + 1] = string.sub(s, start, i - 1)
            end
            start = j + 1
        end
    end
    if start <= #s then
        chunks[#chunks + 1] = string.sub(s, start, #s)
    end
    return chunks
end

s = "ababbaaaabbbabbbbaaa"
d = "a"
for _, chunk in pairs(split(s, d)) do
    print(chunk)
end
