--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 17-10-17
-- Time: 21:11
-- To change this template use File | Settings | File Templates.
--
local door = require 'scripts.objects.doors.trivialdoor'

return {
    id = "university.zilverling.educafe",
    name = "Educafé",
    objects = { door("door", "university.zilverling.iapc"), }
}