--[[-
The rom is the main entry point for GT MOS - CC

@module[kind=program] shell
]]

local func, err = loadfile(filename)
if not err then
    local status, err2 = pcall(func)
    if not status then
        return err2
    end
else
    return err
end
