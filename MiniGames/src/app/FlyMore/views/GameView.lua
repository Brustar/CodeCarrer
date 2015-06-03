
-- GameView is a combination of view and controller
local GameView = class("GameView", cc.load("mvc").ViewBase)

local Timer   = import("..models.Timer")
local Player   = import("..models.Player")
local Cloud   = import("..models.Cloud")
local ComboTrigger   = import("..models.ComboTrigger")

local TimerSprite = import(".TimerSprite")
local PlayerSprite = import(".PlayerSprite")
local CloudSprite = import(".CloudSprite")
local ComboTriggerSprite   = import(".ComboTriggerSprite")
local HeightTipSprite = import(".HeightTipSprite")

GameView.events = {
    GAME_OVER_EVENT = "GAME_OVER_EVENT",
}

GameView.ZORDER_COMBO_TRIGGER = 100
GameView.ZORDER_HEIGHT_TIP = 50
GameView.ZORDER_TIMER = 100
GameView.ZORDER_CLIPPING = 0
GameView.ZORDER_ZONE = 50
GameView.ZORDER_SKY = 0
GameView.ZORDER_PLAYER = 100
GameView.ZORDER_CLOUD = 50
GameView.ZORDER_TREE = 0

GameView.WIDTH = 320
GameView.HEIGHT = 416

GameView.CLIPPING_WIDTH = 320
GameView.CLIPPING_HEIGHT = 400

GameView.CLOUD_HORIZONTAL_NUM = 7

GameView.CLOUD_COLOR_HEIGHT_1 = 1200
GameView.CLOUD_COLOR_HEIGHT_2 = 2400
GameView.CLOUD_COLOR_HEIGHT_3 = 3600

GameView.CLOUD_NUM_RATE_1 = 70
GameView.CLOUD_NUM_RATE_2 = 95
GameView.CLOUD_NUM_RATE_3 = 100

function GameView:onCreate()
    self.gameHeight_ = 0
    self.cloudsHeight_ = 0
    self.treesHeight_ = 0
    self.lastTouchPoint = cc.p(0, 0)

    self:setContentSize(GameView.WIDTH, GameView.HEIGHT)
        :setAnchorPoint(cc.p(0.5, 0.5))
        :setPosition(display.cx, display.cy)
        
    local heightTip = HeightTipSprite:create()
        :setAnchorPoint(cc.p(0, 0))
        :setPosition(0, GameView.HEIGHT - HeightTipSprite.HEIGHT)
        :addTo(self, GameView.ZORDER_HEIGHT_TIP)
        :updateState(self.gameHeight_)
    self.heightTip_ = heightTip

    local comboTrigger = ComboTriggerSprite:create(ComboTrigger:create())
        :setAnchorPoint(cc.p(0, 0))
        :setPosition(0, GameView.HEIGHT - ComboTriggerSprite.HEIGHT)
        :addTo(self, GameView.ZORDER_COMBO_TRIGGER)
        :updateState()
    self.comboTrigger_ = comboTrigger

    local timer = TimerSprite:create(Timer:create())
        :setAnchorPoint(cc.p(0, 0))
        :setPosition(0, 0)
        :addTo(self, GameView.ZORDER_TIMER)
        :updateState()
    self.timer_ = timer
    

    local clipping = ccui.Layout:create()
        :setClippingEnabled(true)
        :ignoreContentAdaptWithSize(false)
        :setContentSize(GameView.CLIPPING_WIDTH, GameView.CLIPPING_HEIGHT)
        :setAnchorPoint(0, 0)
        :setPosition((GameView.WIDTH - GameView.CLIPPING_WIDTH) / 2, TimerSprite.HEIGHT)
        :addTo(self)
    self.clipping_ = clipping
    
    local sky = cc.Sprite:create("cs_jmp_bg.jpg")
        :setAnchorPoint(cc.p(0.5, 0))
        :setPosition(GameView.CLIPPING_WIDTH / 2, 0)
        :addTo(clipping, GameView.ZORDER_SKY)
    self.sky_ = sky
    
    local zone = cc.Node:create()
        :setAnchorPoint(cc.p(0, 0))
        :setPosition((GameView.CLIPPING_WIDTH - CloudSprite.WIDTH * GameView.CLOUD_HORIZONTAL_NUM) / 2, 0)
        :addTo(clipping, GameView.ZORDER_ZONE)
    self.zone_ = zone
    
    local playerModel = Player:create()
        :setPosition(cc.p(CloudSprite.WIDTH * GameView.CLOUD_HORIZONTAL_NUM / 2, 0))
        :setMinX(0)
        :setMaxX(CloudSprite.WIDTH * GameView.CLOUD_HORIZONTAL_NUM)
        :setSpeed(Player.SPEED_NORMAL)
    local player = PlayerSprite:create(playerModel)
        :setAnchorPoint(cc.p(0.5, 0))
        :addTo(zone, GameView.ZORDER_PLAYER)
        :updateState()
    self.player_ = player
    
--    local safeCloud = cc.Sprite:create("cs_jmp.png"):setTextureRect(cc.rect(0, 320, 320, 36))
--        :setAnchorPoint(cc.p(0.5, 0.5))
--        :addTo(zone, GameView.ZORDER_PLAYER)
    
    self:addClouds()
    
    self:addTrees()
    
    -- bind the "event" component
    cc.bind(self, "event")

        -- add touch layer
    local touchLayer = cc.Layer:create()
        :addTo(self)
    -- 触摸开始
    local function onTouchBegan(touch, event)
        print("Touch Began")
        local touchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
        self.lastTouchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
        return true                     -- 必须返回true 后边move end才会被处理
    end
    -- 触摸移动
    local function onTouchMoved(touch, event)
        --print("Touch Moved")
        local touchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
        self.player_:getModel():moveX(touchPoint.x - self.lastTouchPoint.x)
        self.lastTouchPoint = touchPoint
    end
    -- 触摸结束
    local function onTouchEnded(touch, event)
        print("Touch Ended")
    end 
    -- 注册单点触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(listener, touchLayer)
end

-- function GameView:setScale(scale)
--     print("GameView:setScale")
--     getmetatable(self).setScale(self, scale)
--     local clipping = self.clipping_
--     clipping:setScale(1 / scale)
--     for _, child in ipairs(clipping:getChildren()) do
--         child:setScale(scale)
--     end
--     local clippingRegion = clipping:getClippingRegion()
--     clippingRegion.width = clippingRegion.width * scale
--     clippingRegion.height = clippingRegion.height * scale
--     clipping:setClippingRegion(clippingRegion)
--     return self
-- end

function GameView:onCleanup()
    self:removeAllEventListeners()
end

function GameView:start()
    self:scheduleUpdate(handler(self, self.step))
    return self
end

function GameView:stop()
    self:unscheduleUpdate()
    return self
end

function GameView:step(dt)
    self.timer_:step(dt)
    if self.timer_:getModel():getLeftSeconds() <= 0 then
        self:dispatchEvent({name = GameView.events.GAME_OVER_EVENT})
        return self
    end
    self.player_:step(dt)
    local playerModel = self.player_:getModel()
    local position = playerModel:getPosition()
    local lastPosition = playerModel:getLastPosition()
    if playerModel:getSpeed() <= 0 then
        local clouds = self.clouds_
        for cloud in pairs(clouds) do
            local rect = cloud:getBoundingBox()
            if cc.rectContainsPoint(rect, position) and not cc.rectContainsPoint(rect, lastPosition) then
                clouds[cloud] = nil
                cloud:fadeOut({time = 0.5, delay = 0, removeSelf = true})
                position.y = rect.y + rect.height
                playerModel:setSpeed(Player.SPEED_NORMAL)
                local color = cloud:getModel():getColor()
                local comboTriggerModel = self.comboTrigger_:getModel()
                if comboTriggerModel:trigger(color) then
                    playerModel:setSpeed(Player.SPEED_CRAZY)
                end
                if comboTriggerModel:changeMode() then
                    local mode = comboTriggerModel:getMode()
                    self:changeMode(mode, color)
                end
                self.comboTrigger_:updateState()
                break
            end
        end 
    end
    playerModel:setPosition(position)
    self.player_:updateState()
    local offsetY = position.y + self.zone_:getPositionY()
    if offsetY < 0 then
        self:dispatchEvent({name = GameView.events.GAME_OVER_EVENT})
        return self
    end
    local deltaUp = math.floor(offsetY - GameView.CLIPPING_HEIGHT / 4 * 3)
    if deltaUp > 0 then
        self:goUp(math.floor(deltaUp))
    end
    return self
end

function GameView:changeMode(mode, color)
    for cloud in pairs(self.clouds) do
        if mode == ComboTrigger.MODE_CRAZY then
            cloud:getModel():changeColor(color)
        else
            cloud:getModel():restoreColor()
        end
        cloud:updateState()
    end 
end

function GameView:getGameHeight()
    return self.gameHeight_
end

function GameView:shuffle(array)
    for i = 1, table.maxn(array) do
        local lastKey = nil
        for key in pairs(array) do
            if lastKey and math.random(1, 100) > 50 then
                array[lastKey], array[key] = array[key], array[lastKey]
            end
            lastKey = key
        end
    end
end

function GameView:addClouds()
    if self.clouds_ == nil then
        self.clouds_ = {}
    end
    local clouds = self.clouds_
    local zone = self.zone_
    while GameView.CLIPPING_HEIGHT + (-zone:getPositionY()) - self.cloudsHeight_ >= 0 do
        local colorNum = 0
        if self.cloudsHeight_ <= GameView.CLOUD_COLOR_HEIGHT_1 then
            colorNum = 1
        elseif self.cloudsHeight_ <= GameView.CLOUD_COLOR_HEIGHT_2 then
            colorNum = 2
        elseif self.cloudsHeight_ <= GameView.CLOUD_COLOR_HEIGHT_3 then
            colorNum = 3
        else
            colorNum = 4
        end
        local array = {}
        for i = 1, GameView.CLOUD_HORIZONTAL_NUM do
            array[i] = i
        end
        self:shuffle(array)
        local cloudNum = 0
        local rnd = math.random(1, 100)
        if rnd < GameView.CLOUD_NUM_RATE_1 then
            cloudNum = 1
        elseif rnd < GameView.CLOUD_NUM_RATE_2 then
            cloudNum = 2
        else
            cloudNum = 3
        end
        local mode = self.comboTrigger_:getModel():getMode()
        local comboColor = self.comboTrigger_:getModel():getComboColor()
        for i = 1, cloudNum do
            local cloudModel = Cloud:create()
            cloudModel:setPosition(cc.p((array[i] - 1) * CloudSprite.WIDTH, self.cloudsHeight_)):setColor(Cloud.COLORS[math.floor(math.random(1, colorNum))])
            if mode == ComboTrigger.MODE_CRAZY then
                cloudModel:changeColor(comboColor)
            end
            local cloud = CloudSprite:create(cloudModel)
                :setAnchorPoint(cc.p(0, 0))
                :addTo(zone, GameView.ZORDER_CLOUD)
                :updateState()
            clouds[cloud] = cloud
        end
        self.cloudsHeight_ = self.cloudsHeight_ + CloudSprite.WIDTH + 5
    end
    return self
end

function GameView:removeClouds()
    local clouds = self.clouds_
    local zone = self.zone_
    for cloud in pairs(clouds) do
        if (-zone:getPositionY()) >= cloud:getPositionY() + 40 then
            cloud:removeFromParent()
            clouds[cloud] = nil
        end
    end
end

function GameView:addTrees()
    if self.trees_ == nil then
        self.trees_ = {}
    end
    local trees = self.trees_
    local zone = self.zone_
    while GameView.CLIPPING_HEIGHT + (-zone:getPositionY()) - self.treesHeight_ >= 0 do
        local leftTree = cc.Sprite:create("cs_jmp.png"):setTextureRect(cc.rect(626, 0, 22, 520))
            :setAnchorPoint(cc.p(0, 0))
            :setPosition(-20, self.treesHeight_)
            :addTo(zone, GameView.ZORDER_TREE)
        local rightTree = cc.Sprite:create("cs_jmp.png"):setTextureRect(cc.rect(648, 0, 22, 520))
            :setAnchorPoint(cc.p(0, 0))
            :setPosition(278, self.treesHeight_)
            :addTo(zone, GameView.ZORDER_TREE)
        trees[leftTree] = leftTree
        trees[rightTree] = rightTree
        self.treesHeight_ = self.treesHeight_ + 520
    end
    return self
end

function GameView:removeTrees()
    local trees = self.trees_
    local zone = self.zone_
    for tree in pairs(trees) do
        if (-zone:getPositionY()) >= tree:getPositionY() + 520 then
            tree:removeFromParent()
            trees[tree] = nil
        end
    end
end

function GameView:goUp(delta)
    delta = delta
    
    self.gameHeight_ = self.gameHeight_ + delta / 5
    
    self:addClouds()
    self:removeClouds()
    
    self:addTrees()
    self:removeTrees()
    
    local sky = self.sky_
    if sky:getPositionY() - delta / 10 >= -(sky:getContentSize().height - GameView.CLIPPING_HEIGHT) then
        sky:setPositionY(sky:getPositionY() - delta / 10)
    else
        sky:setPositionY(-(sky:getContentSize().height - GameView.CLIPPING_HEIGHT))
    end
    
    local zone = self.zone_
    zone:setPositionY(zone:getPositionY() - delta)
    
    local heightTip = self.heightTip_
    heightTip:updateState(self.gameHeight_)
    
--    dump(self.trees_, "trees")
--    dump(self.clouds_, "clouds")
end

return GameView
