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
local request_router = require("request_router")

local _M = {
    _VERSION = "1.0"
}

function _M.init(app_config_file_name)

    ngx.log (logger.DEBUG, "app_initializer:init() with ", app_config_file_name)

    local config_file, err = utils.read_file(app_config_file_name)

    if not config_file then
        ngx.log (logger.ERROR, "Unable to read the config file"..err)
        return false, err
    end

    local config = utils.json_to_table(config_file)
    if not config then
        ngx.log (logger.ERROR, "Unable to load the config file to table"..err)
        return false, err
    end

    -- Initializing logger
    logger:set_log_level(config.accounts_api.log_level)
    logger:notice("Logger initialized successfully")

    -- Initializing account_info_cache
    account_info_cache.init(config.cache)

    --account_info_cache.put("name", "shahzheeb")
    --local value = account_info_cache.get("name")
    --logger:debug("Value from cache : ",value)

    -- Initializing router
    request_router.init(config.accounts_api)
    return true
end

function _M.process_account_requests()
    logger:debug("processing account request")
    request_router.execute()

end

return _M