--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 20-10-17
-- Time: 22:41
-- To change this template use File | Settings | File Templates.
--
local logilang = require 'scripts.helpers.logilang'

return function(name, to)
    return {
        name = name,
        go =  to
    }
end