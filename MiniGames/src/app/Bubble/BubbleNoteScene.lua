--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/11
--此文件由[BabeLua]插件自动生成
local BubbleNoteScene = class("BubbleNoteScene",cc.load("mvc").ViewBase)

BubbleNoteScene.STEP_HEIGHT = 20
BubbleNoteScene.SHIGHT = 960
BubbleNoteScene.SWIDTH = 640
local isSound = true

function BubbleNoteScene:onCreate()
    
    self:infoCSB()
    self:infoTouch()
   self:scheduleUpdate(handler(self,self.updateBg))
end

function BubbleNoteScene:updateBg(dt)
  local ischangex = true
  if self.bg_imagone:getPositionX() >= 0 and self.bg_imagtwo:getPositionX() >= 0 then
    ischange = true
  end
  if self.bg_imagone:getPositionX() <= -200 and self.bg_imagtwo:getPositionX() <= -200 then
   ischange = false
   end 

   if ischange then
  self.bg_imagone:setPosition(cc.p(self.bg_imagone:getPositionX() - 10*dt,self.bg_imagone:getPositionY() - 80*dt))
  self.bg_imagtwo:setPosition(cc.p(self.bg_imagtwo:getPositionX() - 10*dt,self.bg_imagtwo:getPositionY() - 80*dt))
  else
  self.bg_imagone:setPosition(cc.p(self.bg_imagone:getPositionX() + 20*dt,self.bg_imagone:getPositionY() - 80*dt))
  self.bg_imagtwo:setPosition(cc.p(self.bg_imagtwo:getPositionX() + 20*dt,self.bg_imagtwo:getPositionY() - 80*dt))
  end

  if self.bg_imagone:getPositionY() <= -2198 then 
    self.bg_imagone:setPosition(cc.p(self.bg_imagone:getPositionX(),2198))
    end
  if self.bg_imagtwo:getPositionY() <= -2198 then 
    self.bg_imagtwo:setPosition(cc.p(self.bg_imagtwo:getPositionX(),2198))
    end
end


function BubbleNoteScene:infoCSB()

    cc.SimpleAudioEngine:getInstance():playMusic("Bubble/audio/music.mp3", true)
    local csbtype = math.random(1,6)
    local CSB
    self.ly = BubbleNoteScene.SHIGHT - display.cy - 10
    self.bg_imagone = display.newSprite("Bubble/background.jpg"):setAnchorPoint(cc.p(0,0)):setPosition(cc.p(0,2198)):setScale(2):addTo(self)
    self.bg_imagtwo = display.newSprite("Bubble/background.jpg"):setAnchorPoint(cc.p(0,0)):setPosition(cc.p(0,0)):setScale(2):addTo(self)
    if csbtype == 1 then
    CSB = cc.CSLoader:createNode("Bubble/hint.csb")
    elseif csbtype == 2 then
    CSB = cc.CSLoader:createNode("Bubble/hint02.csb")
    elseif csbtype == 3 then
    CSB = cc.CSLoader:createNode("Bubble/hint03.csb")
    elseif csbtype == 4 then
    CSB = cc.CSLoader:createNode("Bubble/hint04.csb")
    elseif csbtype == 5 then
    CSB = cc.CSLoader:createNode("Bubble/hint05.csb")
    elseif csbtype == 6 then
    CSB = cc.CSLoader:createNode("Bubble/hint06.csb")
    end
    
   
     CSB:addTo(self):setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local root = CSB:getChildByName("root")
    self.pl_btn_play = root:getChildByName("pl_box"):getChildByName("pl_btn_play")
    self.pl_btn_play:setPosition(cc.p(self.pl_btn_play:getPositionX(),self.pl_btn_play:getPositionY()-40))
    local seque = cc.Sequence:create(cc.MoveBy:create(0.6,cc.p(0,15)),cc.MoveBy:create(0.6,cc.p(0,-15)))
    self.pl_btn_play:runAction(cc.RepeatForever:create(seque))
    
    self.pl_sound = root:getChildByName("pl_box"):getChildByName("pl_sound")
    self.sound_begin = self.pl_sound:getChildByName("sound_begin"):setVisible(true)
    self.sound_closed = self.pl_sound:getChildByName("sound_closed"):setVisible(false)

    self.pl_bg = CSB:getChildByName("root"):getChildByName("pl_bg"):setVisible(false)
    
   

    
end

function BubbleNoteScene:infoTouch()

    local function gameStart(sender,eventType)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/clickdown.mp3",false)
        if eventType == ccui.TouchEventType.ended then
            self:getApp():enterScene("BubbleGameLayer")
        end    
    end
    self.pl_btn_play:addTouchEventListener(gameStart)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/touchdu.mp3",false)
    local function soundChose(sender,eventType)

      if eventType == ccui.TouchEventType.ended then
          if isSound then
            self.sound_begin:setVisible(false)
            self.sound_closed:setVisible(true)
            cc.SimpleAudioEngine:getInstance():pauseMusic()
            isSound = false
         else
            self.sound_begin:setVisible(true)
            self.sound_closed:setVisible(false)
            cc.SimpleAudioEngine:getInstance():resumeMusic()
            isSound = true
         end           
      end 
    end

    self.pl_sound:addTouchEventListener(soundChose)
end

return BubbleNoteScene

--endregion
