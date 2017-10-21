--
-- Defines helper-function-generators for type-check functions
--

local COMMANDTYPES = {}

--
-- A command checker for commands without arguments. Example: /help
--
COMMANDTYPES.zeroArg = function(arg)
    return function(var)
        return #var == 1 and var[1] == arg, var
    end
end

--
-- A command checker for commands with one arguments. Example: /teleport
--
COMMANDTYPES.oneArg = function(arg, typ)
    return function(var)
        return #var == 2 and var[1] == arg and type(var[1]) == typ, var
    end
end

--
-- A command checker for lines that aren't commands. Curently only used for /say
--
COMMANDTYPES.noCommand = function()
    return function(_, str)
        return string.sub(str, 1, 1) ~= "/", { "/say", str }
    end
end

--
-- A command checker for lines that aren't commands. Curently only used for /say
--
COMMANDTYPES.goCommand = function()
    return function(_, str)
        return string.sub(str, 1, 2) == "/_", { "/go", string.sub(str, 3) }
    end
end
--
-- A command checker for commands with a string-that-can-contain-spaces as command.
--
COMMANDTYPES.arbyArg = function(arg)
    return function(var)
        if #var <= 1 or var[1] ~= arg then
            return false
        end
        local s = var[2]
        for i = 3, #var do
            s = s .. " " .. var[i]
        end
        return true, { var[1], s }
    end
end

return COMMANDTYPES