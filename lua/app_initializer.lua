--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-10
-- Time: 23:07
-- To change this template use File | Settings | File Templates.
--

local logger = require("logger")
local utils = require("utils")

print ("Entering app_initializer ...")

local _M = {
    _VERSION = "1.0"
}


function _M.init(app_config_file_name)

    ngx.log (logger.DEBUG, "app_initializer:init() with ", app_config_file_name)

    local config_file, err = utils.read_file(app_config_file_name)

    return true, ""

end


return _M