--[[-
The shell is the user interface for GT MOS - CC.

@module[kind=program] shell
]]

local cwd = "/"

-- from: https://stackoverflow.com/a/22831842
function string.starts(String, Start)
    return string.sub(String,1,string.len(Start))==Start
end

-- Function to execute a Lua script
local function executeLuaScript(filename)
    local newName = cwd.."/"..filename
    newName = string.gsub(newName, "//", "/")
    local func, err = loadfile(newName)
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
    io.write(cwd.." $ ") -- Display the prompt
    local input = io.read() -- Read user input

    -- Parse command-line arguments
    local args = {}
    for arg in input:gmatch("%S+") do
        table.insert(args, arg)
    end

    if args[1] == "exit" then
        print("Shell exiting...")
        break
    elseif args[1] == "cd" then
        if args[2] ~= nil then
            local nd = cwd.."/"..args[2]

            cwd = string.gsub(nd, "//", "/")
            cwd = string.gsub(cwd, "//", "/") 
        end
    else
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
