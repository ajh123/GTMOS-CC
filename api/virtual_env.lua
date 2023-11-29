--[[-
The virtual_env module provides the definitions for the GT MOS - CC environment.

@module[module] virtual_env
@since 0.1.0
]]
local virtual_env = {}

--- Prints a message to the console.
--
-- This is the GT MOS - CC speficic version of [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print), it behaves excatly like the Lua bulitin [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print).
--
-- @tparam any ... The data to print.
-- @since 0.1.0
virtual_env.print = print

--- Prints the specified values to the screen in red, separated by spaces,
-- wrapping when necessary. After printing, the cursor is moved to the next line.
--
-- @tparam any ... The data to print.
-- @since 0.1.0
virtual_env.printError = printError

---
-- Sets the metatable for the given table. If `metatable` is `nil`, removes the metatable of the given table. If the original metatable has a `__metatable` field, raises an error.
-- 
-- This function returns `table`.
-- 
-- To change the metatable of other types from Lua code, you must use the debug library ([§6.10](command:extension.lua.doc?["en-us/53/manual.html/6.10"])).
-- 
-- @tparam table table
-- @tparam metatable|table metatable?
-- @treturn table
-- @since 0.1.0
virtual_env.setmetatable = setmetatable

---
-- If object does not have a metatable, returns nil. Otherwise, if the object's metatable has a __metatable field, returns the associated value. Otherwise, returns the metatable of the given object.
-- 
-- @tparam any object
-- @treturn metatable table
-- @nodiscard
-- @since 0.1.0
virtual_env.getmetatable = getmetatable

---
-- Calls the function `f` with the given arguments in *protected mode*. This means that any error inside `f` is not propagated; instead, `pcall` catches the error and returns a status code. Its first result is the status code (a boolean), which is true if the call succeeds without errors. In such case, `pcall` also returns all results from the call, after this first result. In case of any error, `pcall` returns `false` plus the error object.
-- 
-- @tparam function f
-- @tparam any arg1?
-- @tparam any ...
-- @treturn success boolean
-- @treturn result any
-- @treturn ... any
-- @since 0.1.0
virtual_env.pcall = pcall

virtual_env.io = io
virtual_env.table = table

return virtual_env