--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 22-10-17
-- Time: 18:03
-- To change this template use File | Settings | File Templates.
--
local COMMANDS = require 'scripts.helpers.command'

local CLA =require 'scripts.modules.context.actions'
local CTX = {}

CTX[#CTX + 1] = { COMMANDS.numberCommand(), CLA.run }

return CTX
