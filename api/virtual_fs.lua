--[[-
The virtual_fs module provides a virtual filesystem for the GT MOS - CC environment.

This is designed to be comptabile with the standard ComputerCraft filesystem libaray (`fs`).

@module[module] virtual_fs
@since 0.1.0
]]
local virtual_fs = {}

-- from: https://stackoverflow.com/a/22831842
function string.starts(String, Start)
    return string.sub(String,1,string.len(Start))==Start
end

local customPaths = {
    {
        dest = "/rom/programs/",
        src = "rom/programs/",
        readOnly = true
    },
    {
        dest = "/rom/apis/io.lua",
        src = "/rom/apis/io.lua",
        readOnly = true
    },
    {
        dest = "/rom/apis/fs.lua",
        src = "/rom/apis/fs.lua",
        readOnly = true
    }
}

virtual_fs.list = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.list(newPath)
        end
    end

    return fs.list("/env/"..path)
end

virtual_fs.combine = fs.combine

virtual_fs.getName = fs.getName

virtual_fs.getDir = fs.getDir

virtual_fs.getSize = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.exists(newPath)
        end
    end
    return fs.getSize("/env/"..path)
end

virtual_fs.exists = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[1].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.exists(newPath)
        end
    end
    return fs.exists("/env/"..path)
end

virtual_fs.isDir = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.isDir(newPath)
        end
    end
    return fs.isDir("/env/"..path)
end

virtual_fs.isReadOnly = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            if customPaths[k].readOnly then
                return true
            end
        end
    end
    return fs.isReadOnly("/env/"..path)
end

virtual_fs.makeDir = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            if customPaths[k].readOnly then
                error(path..": Access denined")
            end
        end
    end
    return fs.makeDir("/env/"..path)
end

virtual_fs.move = function (path, dest)
    for k, _ in pairs(customPaths) do
        if string.starts(dest, customPaths[k].dest) then
            if customPaths[k].readOnly then
                error(dest..": Access denined")
            end
        end
        if string.starts(path, customPaths[1].dest) then
            if customPaths[k].readOnly then
                error(path..": Access denined")
            end
        end
    end
    return fs.move("/env/"..path, "/env/"..dest)
end

virtual_fs.copy = function (path, dest)
    for k, _ in pairs(customPaths) do
        if string.starts(dest, customPaths[k].dest) then
            if customPaths[k].readOnly then
                error(dest..": Access denined")
            end
        end
    end
    return fs.copy("/env/"..path, "/env/"..dest)
end

virtual_fs.delete = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            if customPaths[k].readOnly then
                error(path..": Access denined")
            end
        end
    end
    return fs.delete("/env/"..path)
end

virtual_fs.open = function (path, mode)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.open(newPath, mode)
        end
    end
    return fs.open("/env/"..path, mode)
end

virtual_fs.getDrive = function (path)
    if string.starts(path, customPaths[1].src) then
        return "rom"
    end
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.getDrive("/env/"+newPath)
        end
    end
    return fs.getDrive("/env/"..path)
end

virtual_fs.getFreeSpace = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.getFreeSpace("/env/"+newPath)
        end
    end
    return fs.getFreeSpace("/env/"..path)
end

virtual_fs.getCapacity = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            if customPaths[k].readOnly then
                return nil
            end
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.getCapacity(newPath)
        end
    end
    return fs.getCapacity("/env/"..path)
end

virtual_fs.attributes = function (path)
    for k, _ in pairs(customPaths) do
        if string.starts(path, customPaths[k].dest) then
            local newPath = shell.resolve(customPaths[k].src).."/"..string.gsub(path, customPaths[k].dest, "", 1)
            return fs.attributes("/env/"+newPath)
        end
    end
    return fs.attributes("/env/"..path)
end

return virtual_fs