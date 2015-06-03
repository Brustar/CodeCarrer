require("app.Warrior.PngJson")
PngHelper = class("PngHelper")

function PngHelper:init(index)
	local fileName = string.format("images_%d",index)
    self.image = cc.Director:getInstance():getTextureCache():addImage(string.format("Warrior/%s.png",fileName))
    self.jsonConfig = JsonManager.decode(_G[fileName])
    return self
end

function PngHelper.shared()
  if nil == _G["PngHelper.object"] then
    _G["PngHelper.object"] = PngHelper.new()
  end

  return _G["PngHelper.object"]
end

function PngHelper:spriteFromJson(pngName)
    local png = cc.Sprite:createWithTexture(self.image)
    local frame=self.jsonConfig.frames[pngName].frame
    png:setTextureRect(cc.rect(frame.x,frame.y,frame.w,frame.h))
    return png
end

function PngHelper:framecacheFromJson(pngName,total)
  local sprite = self:spriteFromJson(string.format("%s1",pngName))
  local cache = cc.SpriteFrameCache:getInstance()
  local animFrames = {}
  for k = 1, total do
      local frame=self.jsonConfig.frames[string.format("%s%d",pngName,k)].frame
      local sframe = cc.SpriteFrame:createWithTexture(self.image,cc.rect(frame.x,frame.y,frame.w,frame.h))
      animFrames[k] = sframe
  end

  local animation = cc.Animation:createWithSpriteFrames(animFrames, 0.1)
  sprite:runAction(cc.RepeatForever:create(cc.Animate:create(animation)))
  return sprite
end

function PngHelper.clearTexture()
  for i=1,4 do
    cc.Director:getInstance():getTextureCache():removeTextureForKey(string.format("Warrior/images_%d.png",i))
  end
end