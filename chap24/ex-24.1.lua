--[[
    Exercise 24.1: Rewrite the producer–consumer example in the section called “Who Is the Boss?” using a
    producer-driven design, where the consumer is the coroutine and the producer is the main thread.
]] --
function producer(cons)
    while true do
        local x = io.read()
        coroutine.resume(cons, x)
    end
end

-- The first time coroutine.resume() is called, x is passed into the body of the coroutine
-- On subsequent calls, x is passed as the results from coroutine.yield()
function consumer()
    return coroutine.create(function(x)
        io.write(x, "\n")
        while true do
            local x = coroutine.yield()
            io.write(x, "\n")
        end
    end)
end

producer(consumer())
