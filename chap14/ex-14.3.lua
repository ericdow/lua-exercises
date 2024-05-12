--[[
    Exercise 14.3: Modify the graph structure so that it can keep a label for each arc. The structure should
    represent each arc by an object, too, with two fields: its label and the node it points to. Instead of an adjacent
    set, each node keeps an incident set that contains the arcs that originate at that node.
    
    Adapt the function readgraph to read two node names plus a label from each line in the input file.
    (Assume that the label is a number.)
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

io.input("graph.txt")
local graph = readgraph()

for name, node in pairs(graph) do
    print("Node: " .. node.name)
    for i, arc in pairs(node.inc) do
        print("Arc " .. arc.label .. " -> " .. arc.to.name)
    end
end
