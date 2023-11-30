local sandbox = require "api.sandbox"

local programFilePath = shell.resolve("rom/bios.lua")
local func = sandbox.makeProgramFile(programFilePath)

while coroutine.status(func) ~= "dead" do
    local myEvent = { os.pullEvent() }

    local ok, result = coroutine.resume(func, table.unpack(myEvent))
    if not ok then
        printError(result)
    end
end