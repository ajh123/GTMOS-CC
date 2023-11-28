--[[- The sandbox API provides access to create programs in a sandbox and
use the GT MOS APIs. 

Programs can be ran in a custom environment to ensure saftey.

@module[kind=program] sandbox
]]
local sandbox = {}

--- Creates a custom environment.
--
-- The environment can be used to safeley run potentialy unsafe programs,
-- or allow programs to use the custom GT MOS APIs.
--
-- @treturn table The virtual environment created.
-- @since 0.1.0
function sandbox.makeEnvironment()
    -- Create a custom environment
    return {
        myVariable = 42,
        myFunction = function(x)
            return x * 2
        end,
    }
end

--- Creates a coroutine from a function.
--
-- The coroutine will be sandboxed inside a custom environment.
--
-- > [Uses deprecated features][!WARNING]
-- > This makes use of the deprecated `setfenv`! This function *might*
-- > not work in your environment.
--
-- @tparam function func The function to wrap.
-- @treturn table A thread A coroutine from the function.
-- @since 0.1.0
-- @see sandbox.makeEnvironment
function sandbox.makeProgramFunction(func)
    -- Load the program as a function with the custom environment
    setfenv(func, sandbox.makeEnvironment())
    return coroutine.create(func)
end

--- Creates a coroutine from a file.
--
-- The coroutine will be sandboxed inside a custom environment.
--
-- @tparam string path The absolute path read from.
-- @treturn table A coroutine from the file.
-- @throws If the file path could not be found.
-- @since 0.1.0
-- @see sandbox.makeEnvironment
function sandbox.makeProgramFile(path)
    -- Load the program as a function with the custom environment
    local programFunction, errorString = loadfile(path, "bt", sandbox.makeEnvironment())
    if programFunction then
        return coroutine.create(programFunction)
    else
        error("Error loading program file: " .. tostring(errorString))
    end
end

return sandbox