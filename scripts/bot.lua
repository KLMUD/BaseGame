--
-- Main entry point for bot
--
DATA = require('scripts.DATASTORE')
TELEGRAM = require('net.nander.botproject.integrations.Telegram')
json = require 'scripts/DATASTORE'

local bot = {}

local TICKRATE = 100
local helper = require 'scripts.helpers.scripts'

local PLE = require 'scripts.modules.player.entities'
local LLE = require 'scripts.modules.location.entities'
local WLE = require 'scripts.modules.world.entities'
local logilang = require 'scripts.helpers.logilang'
-- Load commands
COMMANDS = {}
local modules = DATA.parse(require 'net.nander.botproject.integrations.GetDirectories'.GET("scripts/modules"))
local private_modules = DATA.parse(require 'net.nander.botproject.integrations.GetDirectories'.GET("scripts/modules_private"))

for _, v in ipairs(modules) do
    helper.addCommands(COMMANDS, require('scripts.modules.' .. v .. '.commands'))
    print("Loaded module : " .. v)
end
for _, v in ipairs(private_modules) do
    helper.addCommands(COMMANDS, require('scripts.modules_private.' .. v .. '.commands'))
    print("Loaded private module : " .. v)
end

local function execute(func, _, var, update, P, L, W)
    if (func.validator(var, update, P, L, W)) then
        print("Calling", func.name, P.name, update.message.from.userName)
        for _, v in ipairs(var) do
            print(">", v)
        end
        return func.call(var, update, P, L, W)
    end
end


-- Main entry point
bot.start = function()
    while (true) do
        local msg = json.parse(TELEGRAM.getNextMessage(TICKRATE))
        if (msg ~= nil) then
            if bot.cmd(msg) then
                return
            end
        else
            bot.tick()
        end
    end
end

-- Tick
bot.tick = function()
end

-- Execute command
bot.cmd = function(update)
    if not update or not update.message or not update.message.text then
        print("Thanks for trying")
        return
    end
    update.message.text = update.message.text:gsub("u0027", "'")

    local P = PLE.getPlayer(update)
    local L = LLE.getLocation(P, update)
    local W = WLE.getWorld(P)
    local test = false
    local split = helper.split(update.message.text)
    local oneActive = false
    for _, v in ipairs(COMMANDS) do
        local b, newSplit = v[1](split, update.message.text)
        oneActive = b or oneActive
        if b then
            local r = execute(v[2], update.message.text, newSplit, update, P, L, W)
            test = test or r
        end
    end
    if not oneActive then
        TELEGRAM.sendReplyMessage(update.message.chat.id, update.message.messageId, "I don't understand that")
    end
    return test
end
return bot