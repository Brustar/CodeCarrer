
local WIDTH = 210
local HEIGHT = 20

local TimerSprite = class("TimerSprite", function()
    local sprite = cc.Sprite:create()

    local progress = cc.Sprite:create()
        :setName("progress")
        :addTo(sprite)

        
    cc.ProgressTimer:create(cc.Sprite:create():setSpriteFrame("game_slider_green.png"))
        :setName("inner")
        :setMidpoint(cc.p(0, 0))
        :setType(cc.PROGRESS_TIMER_TYPE_BAR)
        :setBarChangeRate(cc.p(1, 0))
        :addTo(progress)
    return sprite
end)

TimerSprite.WIDTH = WIDTH
TimerSprite.HEIGHT = HEIGHT

TimerSprite.NUMBER_FRAMES = {}
for i = 0, 9 do
    TimerSprite.NUMBER_FRAMES[i] = cc.SpriteFrame:create("shuzi.png", cc.rect(i * 12, 153, 36, 42)):retain()
end 

function TimerSprite:ctor(model,timeSecond,timeInner)
    self.model_ = model
    self.timeSecond = timeSecond
    self.timeInner= timeInner

    local size = self.timeInner:getContentSize() 
    self:getChildByName("progress"):getChildByName("inner"):setPosition(size.width-100,size.height+15)
end

function TimerSprite:getModel()
    return self.model_
end

function TimerSprite:step(dt)
    self:getModel():step(dt)
    self:updateState()
    return self
end

function TimerSprite:updateState()
    local initSeconds = math.floor(self:getModel().INIT_SECONDS)
    local leftSeconds = math.floor(self:getModel():getLeftSeconds())

    self.timeSecond:setString(leftSeconds)
    self:getChildByName("progress"):getChildByName("inner"):setPercentage(math.floor(leftSeconds / initSeconds * 100))
    return self
end

return TimerSprite
