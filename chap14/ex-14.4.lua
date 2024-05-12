--[[
    Exercise 14.4: Assume the graph representation of the previous exercise, where the label of each arc
    represents the distance between its end nodes. Write a function to find the shortest path between two given
    nodes, using Dijkstra's algorithm.
]] -- 
local function name2node(graph, name)
    local node = graph[name]
    if not node then
        -- node does not exist; create a new one
        node = {
            name = name,
            inc = {} -- incident set of arcs that originat from this node
        }
        graph[name] = node
    end
    return node
end

function readgraph()
    local graph = {}
    for line in io.lines() do
        -- split line in two names and a label
        local namefrom, nameto, label = string.match(line, "(%S+)%s+(%S+)%s+(%S+)")
        -- find corresponding nodes
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)
        local arc = {
            to = to,
            label = label
        }
        table.insert(from.inc, arc)
    end
    return graph
end

function dijkstra(graph, sourcename, targetname)
    local source = graph[sourcename]
    assert(source, "source node " .. sourcename .. " not found")
    local target = graph[targetname]
    assert(target, "target node " .. targetname .. " not found")

    local q = {}
    local dist = {}
    local prev = {}
    for _, node in pairs(graph) do
        dist[node] = math.huge
        q[node] = true
    end
    dist[source] = 0

    while next(q) do
        local min = math.huge
        local u = nil
        for node, _ in pairs(q) do
            if dist[node] < min then
                u = node
                min = dist[node]
            end
        end
        q[u] = nil

        for _, arc in pairs(u.inc) do
            local v = arc.to
            if q[v] then
                local alt = dist[u] + tonumber(arc.label)
                if alt < dist[v] then
                    dist[v] = alt
                    prev[v] = u
                end
            end
        end
    end

    local s = {}
    local u = target
    if prev[u] or u == source then
        local i = 0
        local t = {}
        while u do
            t[i] = u
            u = prev[u]
            i = i - 1
        end
        for j, u in pairs(t) do
            s[j - i] = u
        end
    end
    return s
end

io.input("graph.txt")
local graph = readgraph()
local s = dijkstra(graph, "n1", "n5")
for i, n in pairs(s) do
    print(i, n.name)
end
