--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-13
-- Time: 16:46
-- To change this template use File | Settings | File Templates.
--
local _M = {
    _VERSION = "1.0"
}

local log = require("logger"):new()
local utils = require("utils")

local account_shared_cache = ngx.shared.account_info_cache
local config = {log_level = log.DEBUG}

function _M.init(account_cache_config)

    if account_cache_config then config = account_cache_config end
    log:notice("Initializing account cache")

    log:debug("flush_cache_on_init: ", config.shared_cache.flush_cache_on_init)

    if config.shared_cache.flush_cache_on_init then
        account_shared_cache:flush_all()
        account_shared_cache:flush_expired()
    end
end


-- Set the key/value in accounts shared cache
function _M.put(key, value)
    log:debug("Putting values to account_info_cache : ", key, "-", value)
    local ok, err, forcible = account_shared_cache:set(key,value)

    if ok then
        log:notice(key, " : ", value," - Successfully added to account_info_cache")
        if forcible then
            log:notice("Some eviction has happened to put this value")
        end
        return true
    else
        log:notice(key, " : ", value," - Failed to add to account_info_cache", err)
        return false
    end
end

function _M.get(key)
    log:debug("Getting values from account_info_cache", key)
    local start_time = ngx.now()
    local value = account_shared_cache:get(key)
    local time_to_fetch_ms = (ngx.now() - start_time) * 1000

    if not utils.is_null_empty(value) then
        log:notice("Found value for ", key)
        log:notice("Record fetch time from account_info_cache :", time_to_fetch_ms)
        return value
    end

end


return _M