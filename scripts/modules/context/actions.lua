--
-- Defines which actions can be taken within the context of location
--
local scripts = require 'scripts.helpers.scripts'
local CTX = {}
CTX.run = {
    name = "run",
    validator = scripts.onlyHuman,
    call = function(l, update, player, location, world, context)

        if context[tonumber(l[2])] then

            update.message.text =context[tonumber(l[2])]
            local a, b =  bot.cmd(update)

            return a, b
        end
    end
}
return CTX
