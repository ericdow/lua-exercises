--[[
    Exercise 24.6: Implement a transfer function in Lua. If you think about resume–yield as similar to call–
    return, a transfer would be like a goto: it suspends the running coroutine and resumes any other coroutine,
    given as an argument. (Hint: use a kind of dispatch to control your coroutines. Then, a transfer would yield
    to the dispatch signaling the next coroutine to run, and the dispatch would resume that next coroutine.)
]] -- 
function transfer(coname)
    coroutine.yield(coname)
end

local coroutines = {}
function register(c)
    coroutines[c.name] = coroutine.create(c.f)
end

function run(c)
    local coname = c
    local status
    while coname do
        local co = coroutines[coname]
        status, coname = coroutine.resume(co)
    end
end

register({
    name = "co1",
    f = function()
        for i = 1, 5 do
            print("I'm coroutine 1")
            transfer("co2")
        end
    end
})

register({
    name = "co2",
    f = function()
        for i = 1, 5 do
            print("I'm coroutine 2")
            transfer("co1")
        end
    end
})

run("co1")
