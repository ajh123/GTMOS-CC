--[[-
The virtual_env module provides the definitions for the GT MOS - CC environment.

@module[module] virtual_env
]]
local virtual_env = {}

--- Prints a message to the console.
--
-- This is the GT MOS - CC speficic version of [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print), it behaves excatly like the Lua bulitin [`print`](https://www.lua.org/manual/5.1/manual.html#pdf-print).
--
-- @tparam any ... The data to print.
-- @since 0.1.0
function virtual_env.print(...)
    print(...)
end

return virtual_env