require "api.sandbox"

-- Your Lua program file
local programFilePath = shell.resolve("programs/shell/main.lua")
local func = makeProgram(programFilePath)
runProgram(func)