--
-- Defines which actions can be taken within the context of location
--
local LOCATION = {}
local LLE = require 'scripts.modules.location.entities'
local scripts = require 'scripts.helpers.scripts'
local logilang = require 'scripts.helpers.logilang'
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
    call = function(_, update, player, location, _, C)
        local str = "\n"
        local ctx = {}

        for k, v in pairs(location.objects) do
            if v.go then
                local l = logilang.parse(v.go, v)
                ctx[#ctx+1] = "/go ".. v.name
                str = str .. "/"..#ctx .. " : ("..v.name..") " .. l .."\n"
            else
                local l = logilang.parse(v.examine, v)
                ctx[#ctx+1] = "/examine ".. k
                str = str .. "/"..#ctx .. " : examine " .. v.name .."\n"
            end
        end
        TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "You are at " .. player.location .. str.."")
        return false, ctx
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
            player.location = logilang.parse(to.go)
            DATA.setDataFromChat("Player", update, player)
            TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "Set Location to " .. player.location)
            location = LLE.getLocation(player, update)
            local _, c =   LOCATION.where.call(l, update, player, location, _)

            return false, c
        else
            TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "Can't go there,  " .. l[2] .. " isn't a possible route here. You may want to check /where.")

        end
    end
}
return LOCATION