--[=[
    Exercise 4.1: How can you embed the following fragment of XML as a string in a Lua program?
        <![CDATA[
          Hello world
        ]]>
    Show at least two different ways.
]=] -- 
local hw1 = [=[
<![CDATA[
  Hello world
]]>]=]
print(hw1)

local hw2 = "<![CDATA[\n  Hello world\n]]>"
print(hw2)
