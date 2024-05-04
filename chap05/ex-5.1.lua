--[[
    Exercise 5.1: What will the following script print? Explain.
        sunday = "monday"; monday = "sunday"
        t = {sunday = "monday", [sunday] = monday}
        print(t.sunday, t[sunday], t[t.sunday])
]] --
sunday = "monday";
monday = "sunday"
t = {
    sunday = "monday",
    [sunday] = monday
}
print(t.sunday, t[sunday], t[t.sunday])
--[[
    The table t stores 
    t["sunday"] = "monday"
    t["monday"] = "sunday"
    t.sunday = t["sunday"] = "monday"
    t[sunday] = t["monday"] = "sunday"
    t[t.sunday] = t["monday"] = "sunday"
]]
