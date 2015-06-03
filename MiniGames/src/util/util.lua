local public = {}
local private = {}

util = public


--
-- put number into int at position index
--
function public.putByte(number, index)
    if (index == 0) then
        return bit.band(number,0xff)
    else
        return bit.lshift(bit.band(number,0xff),index*8)
    end
end

--
-- convert byte array to int array
--
function public.bytesToInts(bytes, start, n)
    local ints = {}
    for i = 0, n - 1 do
        ints[i] = public.putByte(bytes[start + (i*4)    ], 3)
                + public.putByte(bytes[start + (i*4) + 1], 2) 
                + public.putByte(bytes[start + (i*4) + 2], 1)    
                + public.putByte(bytes[start + (i*4) + 3], 0)
    end
    return ints
end

--
-- convert int array to byte array
--
function public.intsToBytes(ints, output, outputOffset, n)
    n = n or #ints
    for i = 0, n do
        for j = 0,3 do
            output[outputOffset + i*4 + (3 - j)] = public.getByte(ints[i], j)
        end
    end
    return output
end

--
-- convert bytes to hexString
--
function private.bytesToHex(bytes)
    local hexBytes = ""
    
    for i,byte in ipairs(bytes) do 
        hexBytes = hexBytes .. string.format("%02x", byte)
    end

    return hexBytes
end

--
-- convert data to hex string
--
function public.toHexString(data)
    local type = type(data)
    if (type == "number") then
        return string.format("%08x",data)
    elseif (type == "table") then
        --return private.bytesToHex(data)
        return public.toHexString(serialize(data))
    elseif (type == "string") then
        local bytes = {string.byte(data, 1, #data)}

        return private.bytesToHex(bytes)
    else
        return data
    end
end

function public.hextoString(hex)
    local str, n = hex:gsub("(%x%x)[ ]?", function (word)
            return string.char(tonumber(word, 16))
    end)
    return str
end

function public.des(data)
    return public.toHexString(des.encrypt(DES_KEY,data,#data))
end

function public.padByteString(data)
    local dataLength = #data
    
    local random1 = math.random(0,255)
    local random2 = math.random(0,255)

    local prefix = string.char(random1,
                               random2,
                               random1,
                               random2,
                               public.getByte(dataLength, 3),
                               public.getByte(dataLength, 2),
                               public.getByte(dataLength, 1),
                               public.getByte(dataLength, 0))

    data = prefix .. data

    local paddingLength = math.ceil(#data/16)*16 - #data
    local padding = ""
    for i=1,paddingLength do
        padding = padding .. string.char(math.random(0,255))
    end 

    return data .. padding
end

function private.properlyDecrypted(data)
    local random = {string.byte(data,1,4)}

    if (random[1] == random[3] and random[2] == random[4]) then
        return true
    end
    
    return false
end

function public.unpadByteString(data)
    if (not private.properlyDecrypted(data)) then
        return nil
    end

    local dataLength = public.putByte(string.byte(data,5), 3)
                     + public.putByte(string.byte(data,6), 2) 
                     + public.putByte(string.byte(data,7), 1)    
                     + public.putByte(string.byte(data,8), 0)
    
    return string.sub(data,9,8+dataLength)
end

function serialize(obj)
    local lua = ""
    local t = type(obj)
    if t == "number" then
        lua = lua .. obj
    elseif t == "boolean" then
        lua = lua .. tostring(obj)
    elseif t == "string" then
        lua = lua .. string.format("%q", obj)
    elseif t == "table" then
        lua = lua .. "{\n"
    for k, v in pairs(obj) do
        lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
    end
    local metatable = getmetatable(obj)
    if metatable ~= nil and type(metatable.__index) == "table" then
        for k, v in pairs(metatable.__index) do
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
        end
    end
    lua = lua .. "}"
    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end
    return lua
end

function public.unserialize(lua)
    local t = type(lua)
    if t == "nil" or lua == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        lua = tostring(lua)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    lua = "return " .. lua
    local func = loadstring(lua)
    if func == nil then
        return nil
    end
    return func()
end

return public