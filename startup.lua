local sandbox = require "api.sandbox"

-- Your Lua program file
local programFilePath = shell.resolve("programs/shell/main.lua")
local func = sandbox.makeProgramFile(programFilePath)
local success, result = coroutine.resume(func)
if not success then
    print("Error running program: " .. tostring(result))
end