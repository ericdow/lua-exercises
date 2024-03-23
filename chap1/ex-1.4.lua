--[[
    Exercise 1.4: Which of the following strings are valid identifiers?
    ___ _end End end until? nil NULL one-step
]]

___ = 42 -- valid, we can have '_' in an identifier
_end = 42 -- valid, same as above
End = 42 -- valid, lua is case sensitive
-- end = 42 -- invalid, 'end' is a reserved keyword
-- until? = 42 -- invalid, 'until is a reserved keyword
-- nil = 42 -- invalid, 'nil' is a reserved keyword
NULL = 42 -- valid, this ain't C
-- one-step = 42 -- invalid, the '-' is interpreted as an operator
