--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-17
-- Time: 23:10
-- To change this template use File | Settings | File Templates.
--


local logger = require("logger"):new()
local utils = require("utils")

local _M = {
    _VERSION = "1.0"
}

function _M.create_account(params)
    logger:notice("inside create_account")
    local headers = ngx.req.get_headers()
    logger:notice("message-id : ", headers["message-id"])
    logger:notice("app-id : ", headers["app-id"])
    logger:notice("Content-Type : ", headers["Content-Type"])
    logger:notice("ngx.var.request_method : ", ngx.var.request_method)

    
    
    --logger:notice("params", utils.table_to_json(params))
end

function _M.get_account_details(params)
    -- statements
end

return _M
