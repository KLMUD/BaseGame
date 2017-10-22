--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 22-10-17
-- Time: 18:03
-- To change this template use File | Settings | File Templates.
--
local CTX = {}
function CTX.getContext(update)
    local d = DATA.getDataFromChat("Context", update)
    if not d then
        return {}
    end
    return d
end

function CTX.setContext(update, context)
    DATA.setDataFromChat("Context", update, context)

end
return CTX