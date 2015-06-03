
local PlayerSprite = class("PlayerSprite", function()
    local sprite = cc.Sprite:create()
    return sprite
end)

local Player   = import("..models.Player")

PlayerSprite.WIDTH = 76
PlayerSprite.HEIGHT = 112

PlayerSprite.UP_FRAMES = {}
--PlayerSprite.UP_FRAMES[Player.ORIENTATION_LEFT] = cc.SpriteFrame:create("cs_jmp.png", cc.rect(0, 0, 32, 40)):retain()
--PlayerSprite.UP_FRAMES[Player.ORIENTATION_RIGHT] = cc.SpriteFrame:create("cs_jmp.png", cc.rect(32, 0, 32, 40)):retain()
PlayerSprite.UP_FRAMES[Player.ORIENTATION_LEFT] ="game_l.png"
PlayerSprite.UP_FRAMES[Player.ORIENTATION_RIGHT] ="image_person.png"


PlayerSprite.DOWN_FRAMES = {}
--PlayerSprite.DOWN_FRAMES[Player.ORIENTATION_LEFT] = cc.SpriteFrame:create("cs_jmp.png", cc.rect(64, 0, 32, 36)):retain()
--PlayerSprite.DOWN_FRAMES[Player.ORIENTATION_RIGHT] = cc.SpriteFrame:create("cs_jmp.png", cc.rect(96, 0, 32, 36)):retain()

PlayerSprite.DOWN_FRAMES[Player.ORIENTATION_LEFT] = "game_r.png"
PlayerSprite.DOWN_FRAMES[Player.ORIENTATION_RIGHT] ="game_image_person_dh.png"



function PlayerSprite:ctor(model)
    self.model_ = model
end

function PlayerSprite:getModel()
    return self.model_
end

function PlayerSprite:step(dt)
    self:getModel():step(dt)
    self:updateState()
    return self
end

function PlayerSprite:updateState()
    local model = self:getModel()
    local orientation = model:getOrientation()
    local frame = nil
    if model:getSpeed() > 0 then
        frame = PlayerSprite.UP_FRAMES[orientation]
    else
        frame = PlayerSprite.DOWN_FRAMES[orientation]
    end
    --if self:getSpriteFrame() ~= frame then
        self:setSpriteFrame(frame)
   -- end
    self:setPosition(model:getPosition())
    return self
end

return PlayerSprite