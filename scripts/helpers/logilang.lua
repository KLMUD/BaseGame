--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 20-10-17
-- Time: 21:58
-- To change this template use File | Settings | File Templates.
--

local logilang = {}
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
logilang.parsers = {}



function logilang.parsers.And(stat, obj)
    return logilang.parse(stat.stat1, obj) and logilang.parse(stat.stat2, obj)
end

function logilang.parsers.Or(stat, obj)
    return logilang.parse(stat.stat1, obj) or logilang.parse(stat.stat2, obj)
end

function logilang.parsers.isTrue(stat, obj)
    return not not  obj[stat.cond]
end

function logilang.parsers.isFalse(stat, obj)
    return not obj[stat.cond]
end

function logilang.parse(stat, obj)
    return logilang.parsers[stat.func](stat, obj)
end
print(logilang.parse(logilang.Or(logilang.isTrue("open"), logilang.isTrue("aa")), {open=true}))

return logilang