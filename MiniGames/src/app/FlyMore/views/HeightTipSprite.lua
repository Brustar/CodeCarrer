
local HeightTipSprite = class("HeightTipSprite", function()
    local sprite = cc.Sprite:create()

    return sprite
end)

function HeightTipSprite:ctor(meter_num)
    self.meter_num=meter_num
end

function HeightTipSprite:updateState(height)
--    local num_1 = math.floor(math.mod(height, 10) / 1)
--    local num_2 = math.floor(math.mod(height, 100) / 10)
--    local num_3 = math.floor(math.mod(height, 1000) / 100)
--    local num_4 = math.floor(math.mod(height, 10000) / 1000)
--    self:getChildByName("num_1"):setSpriteFrame(HeightTipSprite.NUMBER_FRAMES[num_1])
--    self:getChildByName("num_2"):setSpriteFrame(HeightTipSprite.NUMBER_FRAMES[num_2])
--    self:getChildByName("num_3"):setSpriteFrame(HeightTipSprite.NUMBER_FRAMES[num_3])
--    self:getChildByName("num_4"):setSpriteFrame(HeightTipSprite.NUMBER_FRAMES[num_4])
    self.meter_num:setString(height)
    return self
end

return HeightTipSprite
