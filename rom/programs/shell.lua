--[[-
The shell is the user interface for GT MOS - CC.

@module[kind=program] shell
]]

-- Function to execute a Lua script
local function executeLuaScript(filename)
    local func, err = loadfile(filename)
    if not err then
        local status, err2 = pcall(func)
        if not status then
            return err2
        end
    else
        return err
    end
end

-- Main shell loop
while true do
    io.write(">> ") -- Display the prompt
    local input = io.read() -- Read user input

    if input == "exit" then
        print("Shell exiting...")
        break
    else
        -- Parse command-line arguments
        local args = {}
        for arg in input:gmatch("%S+") do
            table.insert(args, arg)
        end

        -- Porgrams are allways Lua
        local scriptFilename = args[1]
        if scriptFilename ~= nil then
            local err = executeLuaScript(scriptFilename)
            if err then
                printError(err)
            end
        end
    end
end
