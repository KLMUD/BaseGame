--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 17-10-17
-- Time: 21:11
-- To change this template use File | Settings | File Templates.
--
local safe = require 'scripts.objects.closets.safe'
local door = require 'scripts.objects.doors.trivialdoor'
return {
    id = "university.zilverling.iapc",
    name = "IAPC",
    objects = {safe("safe",451,{}), door("door", "university.zilverling.educafe"), door("rolluik", "university.zilverling.educafe"),  }
}