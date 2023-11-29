--[[-
The sandbox module provides a safe environment for creating and running programs,
allowing controlled access to the GT MOS - CC APIs.

Programs executed in this sandbox are contained within a custom environment to enhance safety.

@module[module] sandbox
@since 0.1.0
]]
local sandbox = {}
local virtual_env = require "api.virtual_env"
local expect = require "cc.expect"

-- from: https://stackoverflow.com/a/53992026
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


--- Creates a custom environment.
--
-- This environment can safely run potentially unsafe programs or allow programs to utilise
-- custom GT MOS - CC APIs.
--
-- @treturn table ~ The virtual environment created.
-- @since 0.1.0
function sandbox.makeEnvironment()
    -- Create a custom environment
    env = deepcopy(virtual_env)
    env._G = env
    env.load = function (chnk, chunkname, mode, _env)
        return load(chnk, chunkname, mode, _env)
    end

    env.loadfile = function(filename, mode, _env)
        -- Support the previous `loadfile(filename, env)` form instead.
        if type(mode) == "table" and _env == nil then
            mode, _env = nil, mode
        end

        expect.expect(1, filename, "string")
        expect.expect(2, mode, "string", "nil")
        expect.expect(3, _env, "table", "nil")

        local file = fs.open(filename, "r")
        if not file then return nil, "File not found" end

        local func, err = env.load(file.readAll(), "@/" .. fs.combine(filename), mode, _env)
        file.close()
        return func, err
    end

    env.dofile = function(_sFile)
        expect.expect(1, _sFile, "string")

        local fnFile, e = env.loadfile(_sFile, nil, env._G)
        if fnFile then
            return fnFile()
        else
            error(e, 2)
        end
    end
    return env
end

--- Creates a coroutine from a function.
--
-- The coroutine will be sandboxed inside a custom environment.
--
-- > [Uses deprecated features][!WARNING]
-- > This makes use of the deprecated `setfenv`! This function *might*
-- > not work in your environment.
--
-- @tparam function func ~ The function to wrap.
-- @treturn table ~ A thread A coroutine from the function.
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
-- @tparam string path ~ The absolute path read from.
-- @treturn table ~ A coroutine from the file.
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
