--
-- Defines location entity definition. Currently is only a getter
--

local LOCATION = {}

LOCATION.getLocation = function(player, update)
    local l = player.location or "NULL"
    local d = DATA.getData("Location", l)
    if not d then
        local err
        pcall(function() d = require('scripts.locations.' .. l) end)
        if not d then
            player.location = "university.zilverling.iapc"
            DATA.setDataFromChat("Player", update, player)
            TELEGRAM.sendMessage(update.message.chat.id,  "Unknown Location, teleported to default location: " .. player.location)

            return LOCATION.getLocation(player, update)
        end
    end
    return d
end


return LOCATION