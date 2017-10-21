--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 20-10-17
-- Time: 21:06
-- To change this template use File | Settings | File Templates.
--
local logilang = require 'scripts.helpers.logilang'
return function(name, code, contents)
    return {
        name = name,
        unlocksBy = "code",
        unlocked = false,
        open = false,
        code = code,
        contents = contents,
        examine =
        {
            type = "takeFirstTruth",
            {
                logilang.isTrue("open"),
                { text = "This safe is open", contents = true }
            },
            {
                logilang.isFalse("open"),
                { text = "This safe is closed", contents = false }
            }
        }
    }
end