--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-17
-- Time: 23:10
-- To change this template use File | Settings | File Templates.
--


local logger = require("logger"):new()
local router = require("router")
local acocunts_processor = require("accounts_processor")
local utils = require("utils")


local _M = {
    _VERSION = "1.0"
}

local r = router.new()

local config = {log_level = logger.ERROR}

function _M.init(account_config)

    if account_config then
      config = account_config
    end

    local routing_table = {
        GET = {
            ["mycompany/accounts/accountId/:accountId"] = acocunts_processor.get_account_details
        },
        POST = {
            ["mycompany/accounts"] = acocunts_processor.create_account
        }
    }
    r:match(routing_table)

    return r
end

function _M.execute()
    logger:notice("Execute inside request_router !!!")
    ngx.var.timestamp = utils.get_timestamp()
    ngx.var.http_version = ngx.req.http_version() or "NA"
    ngx.var.message_id = ngx.req.get_headers()["message-id"] or "NA"
    ngx.var.accept = ngx.req.http_accept or "NA"
    ngx.var.request_url_nqp = string.gsub(ngx.var.request_uri, "?.*", "")

    local post_args = nil --TODO: Undestand more on post_args
    if ngx.var.http_content_type == 'application/x-www-form-urlencoded' then
        post_args = ngx.req.get_post_args()
    end

    
    local ok, _ = r:execute(
    ngx.var.request_method,
    ngx.var.request_url_nqp,
    ngx.req.get_uri_args(),
    post_args,
    {other_arg = 1 })

    if not ok then
        --TODO: add error return for URI not found
    end
end


return _M