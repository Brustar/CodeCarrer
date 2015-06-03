----------------------------------------------------------------------------
-- $Id: md5.lua,v 1.4 2006/08/21 19:24:21 carregal Exp $
----------------------------------------------------------------------------

module("md5",package.seeall)

md5.core = require "md5.core"

----------------------------------------------------------------------------
-- @param k String with original message.
-- @return String with the md5 hash value converted to hexadecimal digits

function sumhexa (k)
  k = md5.core.sum(k)
  return (string.gsub(k, ".", function (c)
           return string.format("%02x", string.byte(c))
         end))
end

function filecode(path)
	local bytes = io.readfile(path,"rb")
	return md5.sumhexa(bytes)
end