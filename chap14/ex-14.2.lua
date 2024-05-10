--[[
    Exercise 14.2: Modify the queue implementation in Figure 14.2, “A double-ended queue” so that both
    indices return to zero when the queue is empty.
    *** From lua.org/pil/errata.html: When the queue is empty, last should return to -1, not to zero.
]] --
function listNew()
    return {
        first = 0,
        last = -1,
        start = 0
    }
end

function pushFirst(list, value)
    local n = list.last - list.first
    if n % 2 == 0 then
        list.first = list.first - 1
    else
        list.last = list.last + 1
    end
    list.start = list.start - 1
    list[list.start] = value
end

function pushLast(list, value)
    local n = list.last - list.first
    if n % 2 == 0 then
        list.first = list.first - 1
    else
        list.last = list.last + 1
    end
    list[list.start + n + 1] = value
end

function popFirst(list)
    local first = list.first
    if first > list.last then
        error("list is empty")
    end
    local n = list.last - list.first
    if n % 2 == 0 then
        list.first = list.first + 1
    else
        list.last = list.last - 1
    end
    local value = list[list.start]
    list[list.start] = nil -- to allow garbage collection
    list.start = list.start + 1
    return value
end

function popLast(list)
    local last = list.last
    if list.first > last then
        error("list is empty")
    end
    local n = list.last - list.first
    if n % 2 == 0 then
        list.first = list.first + 1
    else
        list.last = list.last - 1
    end
    local value = list[list.start + n + 1]
    list[list.start + n + 1] = nil -- to allow garbage collection
    return value
end
