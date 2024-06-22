--[[
    Exercise 23.2: Consider the first example of the section called “Finalizers”, which creates a table with a
    finalizer that only prints a message when activated. What happens if the program ends without a collection
    cycle? What happens if the program calls os.exit? What happens if the program ends with an error?
]] --
o = {
    x = "hi"
}
setmetatable(o, {
    __gc = function(o)
        print(o.x)
    end
})
o = nil
-- Without collection cycle: finalizer is still called because table o is still cleaned up on exit
-- os.exit(): finalizer is not called, since it terminates the script immediately
-- error: finalizer is called
