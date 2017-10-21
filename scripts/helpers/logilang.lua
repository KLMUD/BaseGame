--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 20-10-17
-- Time: 21:58
-- To change this template use File | Settings | File Templates.
--
local pprint = require 'scripts.helpers.pprint'
local logilang = {}
logilang.If = function(cond, stat1, stat2)
    return { func = "If", cond = cond, Then = stat1, Else = stat2 }
end

logilang.When = function(...)
    return { func = "When", lines = { ... } }
end
logilang.And = function(stat1, stat2)
    return { func = "And", stat1 = stat1, stat2 = stat2 }
end
logilang.Or = function(stat1, stat2)
    return { func = "Or", stat1 = stat1, stat2 = stat2 }
end
logilang.isTrue = function(cond)
    return { func = "isTrue", cond = cond }
end
logilang.isFalse = function(cond)
    return { func = "isFalse", cond = cond }
end
logilang.FiftyFifty = function()
    return { func = "FiftyFifty" }
end
logilang.parsers = {}


function logilang.parsers.If(stat, obj)
    if logilang.parse(stat.cond, obj) then
        return logilang.parse(stat.Then, obj)
    else
        return logilang.parse(stat.Else, obj)
    end
end

function logilang.parsers.When(stat, obj)
    for _, v in ipairs(stat.lines) do
        local res = logilang.parse(v, obj)
        if res then
            return res
        end
    end
end

function logilang.parsers.And(stat, obj)
    return logilang.parse(stat.stat1, obj) and logilang.parse(stat.stat2, obj)
end

function logilang.parsers.FiftyFifty(stat, obj)
    return math.random() > 0.5
end

function logilang.parsers.Or(stat, obj)
    return logilang.parse(stat.stat1, obj) or logilang.parse(stat.stat2, obj)
end

function logilang.parsers.isTrue(stat, obj)
    return not not obj[stat.cond]
end

function logilang.parsers.isFalse(stat, obj)
    return not obj[stat.cond]
end

function logilang.parse(stat, obj)
    if (type(stat) ~= "table" or not stat.func) then
        return stat
    end
    return logilang.parsers[stat.func](stat, obj)
end



local stat = logilang.When
(
    logilang.If(logilang.isTrue("aa"), "test"),
    logilang.If(logilang.isTrue("aa"), "tet2"),
    "haha"
)
print("ANS", logilang.parse(stat, { door = true }))

return logilang