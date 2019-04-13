--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-10
-- Time: 23:07
-- To change this template use File | Settings | File Templates.
--

local logger = require("logger"):new()
local utils = require("utils")
local account_info_cache = require("accounts_cache")

print ("Entering app_initializer ...")

local _M = {
    _VERSION = "1.0"
}

function _M.init(app_config_file_name)

    ngx.log (logger.DEBUG, "app_initializer:init() with ", app_config_file_name)

    local config_file, err = utils.read_file(app_config_file_name)
    local config = utils.json_to_table(config_file)
    ngx.log (logger.DEBUG, config.app_level.log_level)

    -- Initializing logger
    logger:set_log_level(config.app_level.log_level)
    logger:notice("Logger initialized successfully")

    -- Initializing account_info_cache
    account_info_cache.init(config.cache)

    return true, ""

end

return _M