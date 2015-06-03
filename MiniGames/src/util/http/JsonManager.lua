-- json
require "cocos.cocos2d.json"
module("JsonManager",package.seeall)

local jsonLua = require("json")

-- return table 把json字符串转化为表
function decode(str)
	return jsonLua.decode(str)
end

-- return jsonStr 把表转化为json字符串
function encode(table)
	return jsonLua.encode(table)
end

function isJSON(s)
    local startPos = 1
    startPos = scanWhitespace(s,startPos)
    if(startPos>string.len(s)) then
        return false
    end
    local curChar = string.sub(s,startPos,startPos)
    -- Object
    if not (curChar=='{' or curChar=='[') then
        return false
    end

    return true
end