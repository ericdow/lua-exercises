--[[
    Exercise 17.3: What happens in the search for a library if the path has some fixed component (that is, a
    component without a question mark)? Can this behavior be useful?
]] --
--[[
    From https://www.lua.org/pil/8.1.html:
    A component does not need to have interrogation marks; it can be a fixed file name, such as the last 
    component in the following path:

    ?;?.lua;/usr/local/default.lua

    In this case, whenever require cannot find another option, it will run this fixed file. (Of course, it only
    makes sense to have a fixed component as the last component in a path.) This can be used to load some 
    default file whenever require is called on a file that can't be found.
]] --
package.path = package.path .. ";ex-17.1.lua"
require "nonexistent"
