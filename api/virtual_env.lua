--[[-
The virtual_env module provides the definitions for the GT MOS - CC environment.

@module[module] virtual_env
@since 0.1.0
]]
local virtual_env = {}

local virtual_fs = require "api.virtual_fs"

--- Prints a message to the console.
--
-- This is the GT MOS - CC speficic version of [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print), it behaves excatly like the Lua bulitin [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print).
--
-- @tparam any ... ~ The data to print.
-- @since 0.1.0
virtual_env.print = print

--- Prints the specified values to the screen in red, separated by spaces,
-- wrapping when necessary. After printing, the cursor is moved to the next line.
--
-- @tparam any ... ~ The data to print.
-- @since 0.1.0
virtual_env.printError = printError

---
-- Sets the metatable for the given table. If `metatable` is `nil`, removes the metatable of the given table. If the original metatable has a `__metatable` field, raises an error.
-- 
-- @tparam table table ~ The table to set the metatable for.
-- @tparam[opt] metatable|table metatable ~ The metatable or `nil`.
-- @treturn table ~ The new table
-- @since 0.1.0
virtual_env.setmetatable = setmetatable

---
-- Gets an object's metatable.
-- 
-- @tparam any object ~ The object to get the metatable from.
-- @treturn metatable table ~ The object's metatable or `nil` if it does not have one.
-- @nodiscard
-- @since 0.1.0
virtual_env.getmetatable = getmetatable

---
-- Calls the function `f` with the given arguments in *protected mode*. This means that any error inside `f` is not propagated; instead, `pcall` catches the error and returns a status code. Its first result is the status code (a boolean), which is true if the call succeeds without errors. In such case, `pcall` also returns all results from the call, after this first result. In case of any error, `pcall` returns `false` plus the error object.
-- 
-- @tparam function f ~ The function to be called
-- @tparam[opt] any arg1 ~ The first argument for the function.
-- @tparam any ... ~ Any extra arguments for the functions.
-- @treturn boolean ~ The sucsess status of the function.
-- @treturn any ~ The data returned by the function, or a error message if the function errored.
-- @treturn any ~ Any additional data from the function.
-- @since 0.1.0
virtual_env.pcall = pcall

virtual_env.io = io

---
-- The GT MOS - CC [`virtual_fs`] is accessiable via the `fs` global variable inside sandboxed programs.
-- @since 0.1.0
virtual_env.fs = virtual_fs
virtual_env.table = table
virtual_env.string = string

return virtual_env