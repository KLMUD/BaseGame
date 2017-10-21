--
-- Defines which actions can be taken within the context of location
--
local LOCATION = {}
local LLE = require 'scripts.modules.location.entities'
local scripts = require 'scripts.helpers.scripts'

LOCATION.teleport = {
    name = "teleport",
    validator = scripts.onlyHuman,
    call = function(l, update, player, _, _)
        player.location = l[2]
        DATA.setDataFromChat("Player", update, player)
        TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "Set Location to " .. l[2])
    end
}
LOCATION.where = {
    name = "where",
    validator = scripts.onlyHuman,
    call = function(_, update, player, location, _)
        local str = ""
        for _, v in pairs(location.objects) do
            if v.go then
                str = str .. "\n" .. v.go .. ": /_" .. v.name
            end
        end
        TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "You are at " .. player.location .. str)
    end
}
LOCATION.go = {
    name = "go",
    validator = scripts.onlyHuman,
    call = function(l, update, player, location, _)
        local to
        for k, v in pairs(location.objects) do
            if v.name == l[2] then
                to = v
            end
        end
        if to then
            player.location = to.go
            DATA.setDataFromChat("Player", update, player)
            TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "Set Location to " .. to.go)
            location = LLE.getLocation(player, update)
            LOCATION.where.call(l, update, player, location, _)
        else
            TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "Can't go there,  " .. l[2] .. " isn't a possible route here. You may want to check /where.")
        end
    end
}
return LOCATION