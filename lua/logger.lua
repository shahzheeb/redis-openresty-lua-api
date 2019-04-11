--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-10
-- Time: 23:36
-- To change this template use File | Settings | File Templates.
--

local _M = {
    _VERSION = 1.0
}


_M.ERROR = ngx.ERR
_M.WARN = ngx.WARN
_M.NOTICE = ngx.NOTICE
_M.INFO = ngx.INFO
_M.DEBUG = ngx.DEBUG

ngx_log = ngx.log

--default log level
_M.log_level = _M.DEBUG

_M.is_debug = function(level) return _M.DEBUG <= level end
_M.is_info = function(level) return _M.INFO <= level end
_M.is_notice = function(level) return _M.NOTICE <= level end
_M.is_warn = function(level) return _M.WARN <= level end
_M.is_error = function(level) return _M.ERROR <= level end

local log_level_mapping = {}
log_level_mapping["debug"] = _M.DEBUG
log_level_mapping["info"] = _M.INFO
log_level_mapping["notice"] = _M.NOTICE
log_level_mapping["warn"] = _M.WARN
log_level_mapping["error"] = _M.ERROR

-- Creating an object of logger
function _M:new(o)
    local obj = o or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function _M:set_log_level(app_log_level)
    self.log_level = log_level_mapping[app_log_level]
end

function _M:log_message(log_level, ...)
    --If the log level of the requested log message is greater than the log level of the overall app then skip
    -- log level of debug=1, info=2, error=3 for ngnix
    if(log_level > self.log_level) then
        return
    else
        ngx_log(log_level, ...)
    end
end


function _M:info (...)
    return self.log_message(self, _M.INFO, ...)
end

function _M:notice (...)
    return self.log_message(self, _M.NOTICE, ...)
end

function _M:warn (...)
    return self.log_message(self, _M.WARN, ...)
end

function _M:debug (...)
    return self.log_message(self, _M.DEBUG, ...)
end

function _M:error (...)
    return self.log_message(self, _M.ERROR, ...)
end


return _M

