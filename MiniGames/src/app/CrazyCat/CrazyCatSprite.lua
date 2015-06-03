
local CrazyCatSprite = class("CrazyCatSprite")

function CrazyCatSprite:ctor()
end

function CrazyCatSprite:getCatSprite(scale, x, y)
    local sprite = cc.Sprite:create("CrazyCat/1.png")
        :setScale(scale)
        :setAnchorPoint(0.5, 0)
        :setPosition(x, y)

    local animation = cc.Animation:create()
    animation:addSpriteFrameWithFile("CrazyCat/1.png")
    animation:addSpriteFrameWithFile("CrazyCat/2.png")
    -- animation:addSpriteFrame(sprite:getSpriteFrame())
    -- animation:addSpriteFrame(sprite2:getSpriteFrame())
    animation:setDelayPerUnit(0.4)
   -- animation:setLoops(-1)
    
    local action = cc.Animate:create(animation)
    sprite:runAction(cc.RepeatForever:create(action))
    return sprite
end

return CrazyCatSprite