--[[
    Exercise 9.4: Using our system for geometric regions, draw a waxing crescent moon as seen from the
    Northern Hemisphere.
]] -- 
function disk(cx, cy, r)
    return function(x, y)
        return (x - cx) ^ 2 + (y - cy) ^ 2 <= r ^ 2
    end
end

function rect(left, right, bottom, up)
    return function(x, y)
        return left <= x and x <= right and bottom <= y and y <= up
    end
end

function complement(r)
    return function(x, y)
        return not r(x, y)
    end
end

function union(r1, r2)
    return function(x, y)
        return r1(x, y) or r2(x, y)
    end
end

function intersection(r1, r2)
    return function(x, y)
        return r1(x, y) and r2(x, y)
    end
end

function difference(r1, r2)
    return function(x, y)
        return r1(x, y) and not r2(x, y)
    end
end

function translate(r, dx, dy)
    return function(x, y)
        return r(x - dx, y - dy)
    end
end

function plot(r, M, N)
    for i = 1, N do -- for each line
        local line = ""
        local y = (N - i * 2) / N
        for j = 1, M do -- for each column
            local x = (j * 2 - M) / M
            line = line .. (r(x, y) and "xx" or "  ")
        end
        print(line)
    end
end

c1 = disk(0, 0, 0.5)
plot(difference(c1, translate(c1, -0.3, 0)), 20, 20)
