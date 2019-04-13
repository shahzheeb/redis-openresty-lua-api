--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-11
-- Time: 00:40
-- To change this template use File | Settings | File Templates.
--
local log = require("logger"):new()
local cjson = require("cjson.safe")

local _M = {
    _VERSION = "1.0"
}


function _M.read_file(file_name)
    local file, err = io.open(file_name)
    if not file then
        log:error("Failed to open", file_name, ": with error: ", err)
        return nil, err
    end

    log:info("File opened successfully")
    local data, err = file:read("*a")
    file:close()
    return data, err
end

function _M.json_to_table(json_file)
    return cjson.decode(json_file)

end

function _M.is_null_empty(val)
    if val and val ~= ngx.null then
        if(type(val) == "string" and #val == 0) then
            return true
        elseif(type(val) == "table" and next(val) == nil) then
            return true
        end

    else
        return true
    end
end

return _M