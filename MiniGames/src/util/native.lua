module("native",package.seeall)

if device.platform == "android" then
  native.luaj=require "cocos.cocos2d.luaj"
end

if device.platform=="ios" then
  native.luaoc=require "cocos.cocos2d.luaoc"
end

native.className="com/lexun/game/Device"
native.objcet="Device"
native.networkNames={"cellular","WIFI"}


function imei()
	  if device.platform == "android" then
      local args = {}
      local sigs = "()Ljava/lang/String;"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"imei",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return ret
    end

    if device.platform=="ios" then
      local ok,ret  = native.luaoc.callStaticMethod(native.objcet,"imei")
      if not ok then
          print("luaoc error:", ok)
      end

      return ret
    end

    return "864771020022100" --"unknown"
end


function networkReachable()
  if device.platform == "android" then
      local args = {}
      local sigs = "()Z"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"networkReachable",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return ret
  end

  if device.platform == "ios" then
      return native.luaoc.callStaticMethod(native.objcet,"networkReachable")
  end

  return true
end


function brand()
  if device.platform == "android" then
      local args = {}
      local sigs = "()Ljava/lang/String;"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"brand",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return ret
  end

  if device.platform == "ios" then
      return string.split(device.model," ")[1]
  end

  return "unknown"
end


function model()
  if device.platform == "android" then
      local args = {}
      local sigs = "()Ljava/lang/String;"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"model",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return ret
  else
      return device.model
  end

end


function OSVersion()
  if device.platform == "android" then
      local args = {}
      local sigs = "()Ljava/lang/String;"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"OSVersion",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return device.platform .. ret
  end

  if device.platform == "ios" then
      local ok,ret  = native.luaoc.callStaticMethod(native.objcet,"OSVersion")
      if not ok then
          print("luaoc error:", ok)
      end

      return device.platform .. ret
  end

  return "unknown"
end


function kindofNetwork()
  if device.platform == "android" then
      local args = {}
      local sigs = "()I"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"kindofNetwork",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return native.networkNames[ret+1]
  end

  if device.platform == "ios" then
      local ok,ret  = native.luaoc.callStaticMethod(native.objcet,"kindofNetwork")
      if not ok then
          print("luaoc error:", ok)
      end

      return native.networkNames[ret]
  end

  return "unknown"
end


function ip()
  if device.platform == "android" then
      local args = {}
      local sigs = "()Ljava/lang/String;"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"ip",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return ret
  end

  if device.platform == "ios" then
      local ok,ret  = native.luaoc.callStaticMethod(native.objcet,"ip")
      if not ok then
          print("luaoc error:", ok)
      end

      return ret
  end

  return "unknown"
end


function isIndex(index)
  if device.platform == "android" then
      local args = {index}
      local sigs = "(Z)V"
      local ok  = native.luaj.callStaticMethod(native.className,"isIndex",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end
  end
end

function macAddress()
  if device.platform == "android" then
      local args = {}
      local sigs = "()Ljava/lang/String;"
      local ok,ret  = native.luaj.callStaticMethod(native.className,"macAddress",args,sigs)
      if not ok then
        print("luaj error:",ret)
      end

      return ret
  end

  if device.platform == "ios" then
      local ok,ret  = native.luaoc.callStaticMethod(native.objcet,"macAddress")
      if not ok then
          print("luaoc error:", ok)
      end

      return ret
  end

  return "unknown"
end


function pb()
  local obj=ServerBasePB_pb.PBBaseInfo()

  obj.softid=SOFT_ID
  obj.softvs=APP_VERSION[100].version
  obj.imei=native.imei()
 
  local lxt=cc.UserDefault:getInstance():getStringForKey('lxt')
  if #lxt>0 then
    obj.lxt=lxt
  end
  obj.phonebrand=native.brand()
  obj.phonemode=native.model()
  obj.phoneversion=native.OSVersion()
  --obj.ip=native.ip()
  obj.network=native.kindofNetwork()
  obj.mac=native.macAddress()
  return util.des(obj:SerializeToString())
end


function showPage(url)
    local title = "乐讯"
    if device.platform == "android" then
       local args = {url,title}
       local sigs = "(Ljava/lang/String;Ljava/lang/String;)V"
       native.luaj.callStaticMethod(native.className,"showPage",args,sigs)
    end

    if device.platform == "ios" then
        local args = {url = url , title = title}
        local ok,ret  = native.luaoc.callStaticMethod(native.objcet,"showPage",args)
        if not ok then
            cc.Director:getInstance():resume()
        else
            print("The ret is:", ret)
        end

     end
end


function showDate(callBack)
    if device.platform == "android" then
       local args = {callBack}
       local sigs = "(I)V"
       native.luaj.callStaticMethod(native.className,"showDate",args,sigs)
    end

    if device.platform == "ios" then
        local args = {callBack = callBack}
        native.luaoc.callStaticMethod(native.objcet,"showDate",args)
     end
end