local CloudSprite = class("CloudSprite", function()
    local sprite = cc.Sprite:create()
    return sprite
end)

local Cloud   = import("..models.Cloud")

CloudSprite.WIDTH = 100
CloudSprite.HEIGHT = 83

CloudSprite.COLOR_FRAMES = {}

CloudSprite.COLOR_FRAMES[Cloud.COLOR_BLUE] = "game_image_game_b.png"
CloudSprite.COLOR_FRAMES[Cloud.COLOR_GREEN] = "game_image_game_g.png"
CloudSprite.COLOR_FRAMES[Cloud.COLOR_ORANGE] = "game_image_game_co.png"
CloudSprite.COLOR_FRAMES[Cloud.COLOR_PURPLE] = "game_image_game_p.png"

function CloudSprite:ctor(model)
    self.model_ = model
end

function CloudSprite:getModel()
    return self.model_
end

function CloudSprite:updateState()
    local model = self:getModel()
    local color = model:getColor()
    self:setSpriteFrame(CloudSprite.COLOR_FRAMES[color])
    self:setPosition(model:getPosition())
    return self
end

return CloudSprite