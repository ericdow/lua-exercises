--[[
    Exercise 17.4: Write a searcher that searches for Lua files and C libraries at the same time. For instance,
    the path used for this searcher could be something like this:

        ./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua

    (Hint: use package.searchpath to find a proper file and then try to load it, first with loadfile
    and next with package.loadlib.)
]] -- 
function searcher(name, path)
    local fname, err = package.searchpath(name, path)
    if fname then
        local f, errlua = loadfile(fname)
        if f then
            return loadfile, fname
        else
            local loader, errc = package.loadlib(name, luaopen_ .. name)
            if loader then
                return loader, fname
            else
                return nil, errlua .. errc
            end
        end
    else
        return nil, err
    end
end
