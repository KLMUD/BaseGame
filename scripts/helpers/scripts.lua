--
-- Defines a few helper functions
--
local scripts = {}

-- Splits a string into words.
function scripts.split(str)
    local arr = {}
    for i in string.gmatch(str, "%S+") do
        arr[#arr + 1] = i
    end
    return arr
end

-- Returns true if the sender of the update is a human.
function scripts.onlyHuman(_, update)
    return update.message.chat.id > 0
end

-- Adds all commands in the second list to the first list.
function scripts.addCommands(cmd, newc)
    for _, v in ipairs(newc) do
        cmd[#cmd + 1] = v
    end
end

return scripts