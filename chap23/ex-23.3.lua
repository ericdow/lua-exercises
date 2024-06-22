--[[
    Exercise 23.3: Imagine you have to implement a memorizing table for a function from strings to strings.
    Making the table weak will not do the removal of entries, because weak tables do not consider strings as
    collectable objects. How can you implement memorization in that case?
]] --
local trie = {}
setmetatable(trie, {
    __mode = "k"
})
function mapstring(s)
    trie = trie or {}
    local mi = trie
    for i = 1, #s do
        local bi = string.byte(s, i) -- get numeric code for s[i]
        local v = mi[bi]
        if v then
            if type(v) == "string" then
                print("Oh, I know this!")
                return v
            else
                assert(type(v) == "table")
                mi = v
            end
        else
            -- compute result and insert into trie
            local result = "foo" .. s
            mi[bi] = {}
            setmetatable(mi[bi], {
                __mode = "k"
            })
            local mj = mi[bi]
            for j = i + 1, #s - 1 do
                local bj = string.byte(s, j) -- get numeric code for s[j]
                mj[bj] = {}
                setmetatable(mj[bj], {
                    __mode = "k"
                })
                mj = mj[bj]
            end
            local b = string.byte(s, #s) -- get numeric code for s[#s]
            mj[b] = result
            return result
        end
    end
end

mapstring("bar")
mapstring("bar")
trie = nil
collectgarbage()
mapstring("bar")
