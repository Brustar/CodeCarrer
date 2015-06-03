
local WIDTH = display.width
local HEIGHT = 32

local ComboTriggerSprite = class("ComboTriggerSprite", function()
    local sprite = cc.Sprite:create()
    
    local progress = cc.Sprite:create()  --ͷ
        :setName("progress")
        :addTo(sprite)
    
    cc.ProgressTimer:create(cc.Sprite:create():setSpriteFrame("game_slider_orange.png"))
        :setName("inner")
        :setType(cc.PROGRESS_TIMER_TYPE_BAR)
        :setMidpoint(cc.p(0, 0))
        :setBarChangeRate(cc.p(1, 0))
        :setAnchorPoint(cc.p(0, 0))
       -- :setPosition(display.width-210,  display.height-70)
        :addTo(progress)
        
    cc.Sprite:create()
        :setName("mode")
        :setAnchorPoint(cc.p(0, 0))
        :setPosition(WIDTH - 58, 0)
        :addTo(sprite, 10)
        

    cc.Sprite:create()
        :setName("combo")
        :setAnchorPoint(cc.p(0.5, 1))
        :setPosition(WIDTH / 2, display.height)
        :addTo(sprite) 
    return sprite
end)

local ComboTrigger   = import("..models.ComboTrigger")

ComboTriggerSprite.WIDTH = WIDTH
ComboTriggerSprite.HEIGHT = HEIGHT

ComboTriggerSprite.NONE_FRAME = cc.SpriteFrame:create("cs_jmp_ext.png", cc.rect(0, 0, 0, 0)):retain()

ComboTriggerSprite.COMBO_FRAMES = {}
ComboTriggerSprite.COMBO_FRAMES[1] = ComboTriggerSprite.NONE_FRAME
ComboTriggerSprite.COMBO_FRAMES[2] = "game_image_ljtwo.png"
ComboTriggerSprite.COMBO_FRAMES[3] = "game_image_ljthr.png"
ComboTriggerSprite.COMBO_FRAMES[4] = "game_image_ljfour.png"
ComboTriggerSprite.COMBO_FRAMES[5] = ComboTriggerSprite.NONE_FRAME

ComboTriggerSprite.MODE_FRAMES = {}
ComboTriggerSprite.MODE_FRAMES[ComboTrigger.MODE_NORMAL] = ComboTriggerSprite.NONE_FRAME
ComboTriggerSprite.MODE_FRAMES[ComboTrigger.MODE_CRAZY] = "game_image_crazy.png"

function ComboTriggerSprite:ctor(model,crazy_num,img_crazy_one,img_crazy_two,topslider)
    self.model_ = model
    self.crazy_num=crazy_num
    self.img_crazy_one = img_crazy_one
    self.img_crazy_two = img_crazy_two
    self.topslider=topslider

    local size = self.topslider:getContentSize() 
    self:getChildByName("progress"):getChildByName("inner"):setPosition(size.width+200,display.height-70)
end

function ComboTriggerSprite:getModel()
    return self.model_
end

function ComboTriggerSprite:updateState()
    local model = self.model_
    local mode = model:getMode()
    local comboNum = model:getComboNum()
    local powerPoint = model:getPowerPoint()
    local totalPowerPoint = model:getTotalPowerPoint()
    --self:getChildByName("combo"):setSpriteFrame(ComboTriggerSprite.COMBO_FRAMES[comboNum])
    self.crazy_num:setString(comboNum)
    self:getChildByName("combo"):setSpriteFrame(ComboTriggerSprite.COMBO_FRAMES[comboNum])
    self:getChildByName("progress"):getChildByName("inner"):setPercentage(math.floor(powerPoint / ComboTrigger.MAX_POWER_POINTS[mode] * 100))
    --self:getChildByName("mode"):setSpriteFrame(ComboTriggerSprite.MODE_FRAMES[mode])
    if mode ==2 then
    self:scheduleUpdate(handler(self, self.step))
    self:getChildByName("progress"):getChildByName("inner"):setVisible(false)
    else
    self:unscheduleUpdate()
    self.img_crazy_one:setVisible(false)
    self.img_crazy_two:setVisible(false)
    self:getChildByName("progress"):getChildByName("inner"):setVisible(true)
    end
    return self
end


function ComboTriggerSprite:step(dt)
    local rand=math.random(0,9)
    if rand-dt<=0 then
    if self.img_crazy_one:isVisible() then
        self.img_crazy_one:setVisible(false)
        self.img_crazy_two:setVisible(true)
     else
         self.img_crazy_one:setVisible(true)
         self.img_crazy_two:setVisible(false)
    end
    end
end
 

return ComboTriggerSprite
