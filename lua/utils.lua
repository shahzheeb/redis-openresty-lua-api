--
-- Created by IntelliJ IDEA.
-- User: shahzheeb
-- Date: 2019-04-11
-- Time: 00:40
-- To change this template use File | Settings | File Templates.
--
local log = require("logger"):new()

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


return _M