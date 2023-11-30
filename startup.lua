local sandbox = require "api.sandbox"

-- Your Lua program file
local programFilePath = shell.resolve("rom/programs/shell.lua")
local func = sandbox.makeProgramFile(programFilePath)

while coroutine.status(func) ~= "dead" do
    local myEvent = { os.pullEvent() }

    local ok, result = coroutine.resume(func, table.unpack(myEvent))
    if not ok then
        printError(result)
    end
end