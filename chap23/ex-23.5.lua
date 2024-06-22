--[[
    Exercise 23.5: For this exercise, you need at least one Lua script that uses lots of memory. If you do not
    have one, write it. (It can be as simple as a loop creating tables.)
    • Run your script with different values for pause and stepmul. How they affect the performance and
    memory usage of the script? What happens if you set the pause to zero? What happens if you set the
    pause to 1000? What happens if you set the step multiplier to zero? What happens if you set the step
    multiplier to 1000000?
    • Adapt your script so that it keeps full control over the garbage collector. It should keep the collector
    stopped and call it from time to time to do some work. Can you improve the performance of your script
    with this approach?
]] -- 
-- collectgarbage("setpause", 1000)
-- collectgarbage("setstepmul", 1000000)
local gcstep = 100
local gcamt = 10

local foo = {}
for i = 1, 10000000 do
    foo[i] = {}
end

local tic = os.clock()
local n = #foo
local peakmem = collectgarbage("count")
collectgarbage("stop")
for i = 1, n do
    foo[i] = nil
    foo[n + i] = {}
    if i % gcstep == 0 then
        collectgarbage("step", gcamt)
    end
    peakmem = math.max(peakmem, collectgarbage("count"))
end
local toc = os.clock()

print("Peak memory usage: " .. peakmem / 1024 / 1024)
print("Time taken: " .. toc - tic)

--[[
                    Memory          Time
Default             1.42 GB         3.373s
Pause = 0           1.36 GB         5.735s
Pause = 1000        1.42 GB         2.805s
Step = 0            1.42 GB         3.385s
Step = 1000000      1.41 GB         3.402s
Custom              1.13 GB         5.462s
]] --

