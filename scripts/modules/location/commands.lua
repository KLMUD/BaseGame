--
-- Defines which commands can be typed in the context of location
--
local LOCATION = {}
local COMMANDS = require 'scripts.helpers.command'
local LLA = require 'scripts.modules.location.actions'

-- LOCATION[#LOCATION + 1] = { COMMANDS.oneArg("/teleport", type("ASDF")), LLA.teleport }
LOCATION[#LOCATION + 1] = { COMMANDS.zeroArg("/where"), LLA.where }
LOCATION[#LOCATION + 1] = { COMMANDS.goCommand(), LLA.go }
LOCATION[#LOCATION + 1] = { COMMANDS.oneArg("/go","string"), LLA.go }

return LOCATION