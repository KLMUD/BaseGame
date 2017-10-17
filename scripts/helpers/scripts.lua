--
-- Defines a few helper functions
--
local scripts = {}

function scripts.split(str)
    local arr = {}
    for i in string.gmatch(str, "%S+") do
        arr[#arr + 1] = i
    end
    return arr
end


function scripts.onlyHuman(_, update)
    return update.message.chat.id > 0
end

function scripts.addCommands(cmd, newc)
    for _, v in ipairs(newc) do
        cmd[#cmd + 1] = v
    end
end

return scripts