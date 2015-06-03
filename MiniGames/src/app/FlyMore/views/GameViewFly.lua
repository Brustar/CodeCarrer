local GameViewFly = class("GameViewFly", cc.load("mvc").ViewBase)

local FlyMoreDefine=import(".FlymoreDefine")
local Timer   = import("..models.Timer")
local Player   = import("..models.Player")
local Cloud   = import("..models.Cloud")
local ComboTrigger   = import("..models.ComboTrigger")

local TimerSprite = import(".TimerSprite")
local PlayerSprite = import(".PlayerSprite")
local CloudSprite = import(".CloudSprite")
local ComboTriggerSprite   = import(".ComboTriggerSprite")
local HeightTipSprite = import(".HeightTipSprite")

GameViewFly.events = {
    GAME_OVER_EVENT = "GAME_OVER_EVENT",
    TIME_OVER_EVENT="TIME_OVER_EVENT",
}
function GameViewFly:onCreate()
    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    self.gameHeight_ = 0
    self.cloudsHeight_ = 0
    self.treesHeight_ = 0
    self.lastTouchPoint = cc.p(0, 0)
    cc.SpriteFrameCache:getInstance():addSpriteFrames("FlyMore/Plist.plist")
    self:createResoueceNode("FlyMore/game.csb")
    local CSB=self.resourceNode_

    self.bg = CSB:getChildByName("bg")
    local info_top = CSB:getChildByName("info_top")
    self.btn_zd = info_top:getChildByName("btn_zd")
    self.btn_back = info_top:getChildByName("btn_back")
    self.btn_chat = info_top:getChildByName("pl_chat")

    local hight_score = info_top:getChildByName("hight_score")
    local my_meter = info_top:getChildByName("my_meter")
    local top_info = info_top:getChildByName("top_info")

    hight_score:setVisible(false)

    self.topslider=top_info:getChildByName("slider")
    self.topIcon_ball=self.topslider:getChildByName("icon_ball")
    self.topslider_cut=self.topslider:getChildByName("slider_cut")
    self.topChildSlider=self.topslider_cut:getChildByName("slider")
    self.topChildSlider:setVisible(false)
    self.img_crazy_one=top_info:getChildByName("img_crazy_one")
    self.img_crazy_two=top_info:getChildByName("img_crazy_two")

    self.crazy_num1 = top_info:getChildByName("crazy_num")
    self.crazy_num = ccui.TextAtlas:create()
    self.crazy_num:setProperty("1", "FlyMore/nums.png", 19, 25, ".")
    self.crazy_num:setPosition(self.crazy_num1:getPosition()) 
    top_info:addChild(self.crazy_num)
    self.crazy_num1:setVisible(false)

    self.game_image_game_cloud = CSB:getChildByName("game_image_game_cloud")
    self.game_image_game_co = CSB:getChildByName("game_image_game_co")
    self.game_image_game_g = CSB:getChildByName("game_image_game_g")
    self.game_image_game_p = CSB:getChildByName("game_image_game_p")
    self.game_image_game_b = CSB:getChildByName("game_image_game_b")
    self.game_image_game_bird = CSB:getChildByName("game_image_game_bird")
    self.game_fnt_cjt = CSB:getChildByName("game_fnt_cjt")
    self.game_image_person_dh = CSB:getChildByName("game_image_person_dh")

    local bottom = CSB:getChildByName("bottom")
    local large_slider = bottom:getChildByName("large_slider")

    self.fnt_aq=bottom:getChildByName("fnt_aq")
    self.slider= large_slider:getChildByName("slider_cut"):getChildByName("slider")
    self.second= large_slider:getChildByName("slider_head"):getChildByName("second")
    self.meter_num1=my_meter:getChildByName("meter_num")

    self.meter_num = ccui.TextAtlas:create()
    self.meter_num:setProperty("1", "FlyMore/shuzi.png", 30, 42, ".")
    local metersize = self.meter_num1:getContentSize()
    self.meter_num:setPosition(metersize.width*1.5+5,metersize.height+5)  
    my_meter:addChild(self.meter_num)
    self.meter_num1:setVisible(false)

    self.leftTree= CSB:getChildByName("tree_left")
    self.rightTree = CSB:getChildByName("tree_right")

    self.game_image_game_co:setVisible(false)
    self.game_image_game_g:setVisible(false)
    self.game_image_game_p:setVisible(false)
    self.game_image_game_b:setVisible(false)
    self.game_image_person_dh:setVisible(false)
    self.game_fnt_cjt:setVisible(false)
    self.game_image_game_bird:setVisible(false)
    self.img_crazy_one:setVisible(false)
    self.img_crazy_two:setVisible(false)

    self:setContentSize(FlyMoreDefine.WIDTH, FlyMoreDefine.HEIGHT)
        :setAnchorPoint(cc.p(0.5, 0.5))
        :setPosition(display.cx, display.cy)

    local heightTip = HeightTipSprite:create(self.meter_num)
        :addTo(self, FlyMoreDefine.ZORDER_HEIGHT_TIP)
        :updateState(self.gameHeight_)
    self.heightTip_ = heightTip

    local comboTrigger = ComboTriggerSprite:create(ComboTrigger:create(),self.crazy_num,self.img_crazy_one,self.img_crazy_two,self.topslider)      
        :addTo(self, FlyMoreDefine.ZORDER_COMBO_TRIGGER)
        :updateState()
    self.comboTrigger_ = comboTrigger

    local timer = TimerSprite:create(Timer:create(),self.second,self.slider)
        :addTo(self, FlyMoreDefine.ZORDER_TIMER)
        :updateState()
    self.timer_ = timer
    self.slider:setVisible(false)

    local clipping = ccui.Layout:create()
        :setClippingEnabled(true)
        :ignoreContentAdaptWithSize(false)
        :setContentSize(FlyMoreDefine.CLIPPING_WIDTH, FlyMoreDefine.CLIPPING_HEIGHT)
        :setAnchorPoint(0, 0)
        :setPosition((FlyMoreDefine.WIDTH - FlyMoreDefine.CLIPPING_WIDTH) / 2, 100)
        :addTo(self.bg)
    self.clipping_ = clipping

    local sky = cc.Sprite:create()
        :setAnchorPoint(cc.p(0.5, 0))
        :setPosition(FlyMoreDefine.CLIPPING_WIDTH / 2, 0)
        :addTo(clipping, FlyMoreDefine.ZORDER_SKY)
    self.sky_ = sky

    self.bg:loadTexture("FlyMore/game_bg.png")

    local zone = cc.Node:create()
        :addTo(clipping, GameViewFly.ZORDER_ZONE)
    self.zone_ = zone

    local playerModel = Player:create()
        :setPosition(cc.p(CloudSprite.WIDTH * FlyMoreDefine.CLOUD_HORIZONTAL_NUM / 2, 0))
        :setMinX(FlyMoreDefine.ADD_WIDTH)
        :setMaxX(CloudSprite.WIDTH * FlyMoreDefine.CLOUD_HORIZONTAL_NUM)
        :setSpeed(Player.SPEED_NORMAL)
    local player = PlayerSprite:create(playerModel)
        :setAnchorPoint(cc.p(0.5, 0))
        :addTo(zone, FlyMoreDefine.ZORDER_PLAYER)
        :updateState()
    self.player_ = player
    --self.player_=self.game_image_person_dh

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

    self:addEventListener(GameViewFly.events.GAME_OVER_EVENT, handler(self, self.onGameOver))
    self:addEventListener(GameViewFly.events.TIME_OVER_EVENT, handler(self, self.onTimeOver))
    self.hisGameHeight_ = 0
    self.newHeight=0
    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    self:start()
    self:InitTouch()
    self.myLayer=cc.Layer:create()
    self.bg:addChild(self.myLayer)
end

--重置数据
function GameViewFly:reSetData()
    self.meter_num:setString(0)
    self.crazy_num:setString(0)
    self:removeClouds()
end

--按钮状态交替
function GameViewFly:InitTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then		
			self:getApp():enterScene("FlyMoreScene")
		end
	end
	self.btn_back:addTouchEventListener(backCallback)

   local function zdCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
        if self.btn_zd:isBright() ==true then
             self.btn_zd:setBright(false)
            self:onExit(self.btn_zd:isBright())
        else
            self.btn_zd:setBright(true)
            self:onEnter(self.btn_zd:isBright())          
		end
        end
	end
	self.btn_zd:addTouchEventListener(zdCallback)
    self.btn_zd:setBright(false)
    self.btn_zd:setEnabled (true); 
end

--重力感应开
function GameViewFly:onEnter(bEnable)
     self.myLayer:setAccelerometerEnabled(bEnable)
     local function accelerometerListener(event,x,y,z,timestamp)
            print("*********",x,y)
            local target  = event:getCurrentTarget()
            local ballSize = target:getContentSize()
            local ptNowX    = 0
            ptNowX =  x * 10
            self.player_:getModel():moveX(ptNowX)
    end

    local listerner  = cc.EventListenerAcceleration:create(accelerometerListener)
    self.myLayer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listerner,self.player_)
end

--重力感应关
function GameViewFly:onExit()
    self.myLayer:setAccelerometerEnabled(false)
end

function GameViewFly:onCleanup()
    self:removeAllEventListeners()
end

function GameViewFly:start()
    self:scheduleUpdate(handler(self, self.step))
    return self
end

function GameViewFly:stop()
    self:unscheduleUpdate()
    return self
end

--游戏开始，时间倒计时
function GameViewFly:step(dt)
    self.timer_:step(dt)
    if self.timer_:getModel():getLeftSeconds() <= 0 then
        self:dispatchEvent({name = GameViewFly.events.TIME_OVER_EVENT})
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
                    self.game_fnt_cjt :setVisible(true)
                else
                    self.game_fnt_cjt :setVisible(false)
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
    local offsetY = position.y + self.player_:getContentSize().height  + self.zone_:getPositionY()
    local offsetYEx = position.y + self.zone_:getPositionY() - self.player_:getContentSize().height+20
    if offsetYEx < 0 then
        if self:getGameHeight() <= 200 then
            self.player_:getModel():setSpeed(Player.SPEED_NORMAL)
        end
    end

    if offsetY < 0 then
        if self:getGameHeight() > 200 then
            self:dispatchEvent({name = GameViewFly.events.GAME_OVER_EVENT})
            return self
        end
    end

    local deltaUp = math.floor(offsetY - FlyMoreDefine.CLIPPING_HEIGHT / 4 * 3)
    if deltaUp > 0 then
        self:goUp(math.floor(deltaUp))
    end
    if self:getGameHeight() > 200 then
        self.game_image_game_cloud:setVisible(false)
        self.fnt_aq:setVisible(false)
    else 
        self.game_image_game_cloud:setVisible(true)
        self.fnt_aq:setVisible(true)
    end
    return self
end

--切换模式
function GameViewFly:changeMode(mode, color)
    for cloud in pairs(self.clouds) do
        if mode == ComboTrigger.MODE_CRAZY then
            cloud:getModel():changeColor(color)
        else
            cloud:getModel():restoreColor()
        end
        cloud:updateState()
    end 
end

--得到当前高度
function GameViewFly:getGameHeight()
    return self.gameHeight_
end

function GameViewFly:shuffle(array)
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

--动态生成云
function GameViewFly:addClouds()
    if self.clouds_ == nil then
        self.clouds_ = {}
    end
    local clouds = self.clouds_
    local zone = self.zone_
    while FlyMoreDefine.CLIPPING_HEIGHT + (-zone:getPositionY()) - self.cloudsHeight_ >= 0 do
        local colorNum = 0
        if self.cloudsHeight_ <= FlyMoreDefine.CLOUD_COLOR_HEIGHT_1 then
            colorNum = 1
        elseif self.cloudsHeight_ <= FlyMoreDefine.CLOUD_COLOR_HEIGHT_2 then
            colorNum = 2
        elseif self.cloudsHeight_ <= FlyMoreDefine.CLOUD_COLOR_HEIGHT_3 then
            colorNum = 3
        else
            colorNum = 4
        end
        local array = {}
        for i = 1, FlyMoreDefine.CLOUD_HORIZONTAL_NUM do
            array[i] = i
        end
        self:shuffle(array)
        local cloudNum = 0
        local rnd = math.random(1, 100)
        if rnd < FlyMoreDefine.CLOUD_NUM_RATE_1 then
            cloudNum = 1
        elseif rnd < FlyMoreDefine.CLOUD_NUM_RATE_2 then
            cloudNum = 2
        else
            cloudNum = 3
        end
        local mode = self.comboTrigger_:getModel():getMode()
        local comboColor = self.comboTrigger_:getModel():getComboColor()
        for i = 1, cloudNum do
            local cloudModel = Cloud:create()
            cloudModel:setPosition(cc.p((array[i] - 1) * CloudSprite.WIDTH+25, self.cloudsHeight_)):setColor(Cloud.COLORS[math.floor(math.random(1, colorNum))])
            if mode == ComboTrigger.MODE_CRAZY then
                cloudModel:changeColor(comboColor)
            end
            local cloud = CloudSprite:create(cloudModel)
                :setAnchorPoint(cc.p(0, 0))
                :addTo(zone, FlyMoreDefine.ZORDER_CLOUD)
                :updateState()
            clouds[cloud] = cloud
        end
        self.cloudsHeight_ = self.cloudsHeight_ + CloudSprite.WIDTH + 5
    end
    return self
end

--移除动态生成云
function GameViewFly:removeClouds()
    local clouds = self.clouds_
    local zone = self.zone_
    for cloud in pairs(clouds) do
        if (-zone:getPositionY()) >= cloud:getPositionY() + 40 then
            cloud:removeFromParent()
            clouds[cloud] = nil
        end
    end
end

--动态生成树
function GameViewFly:addTrees()
    if self.trees_ == nil then
        self.trees_ = {}
    end
    local trees = self.trees_
    local zone = self.zone_
    while FlyMoreDefine.CLIPPING_HEIGHT + (-zone:getPositionY()) - self.treesHeight_ >= 0 do
        local leftTree = cc.Sprite:create():setSpriteFrame("game_image_tree.png")
            :setAnchorPoint(cc.p(0, 0))
            :setPosition(-20, self.treesHeight_)
            :addTo(zone, FlyMoreDefine.ZORDER_TREE)
        local rightTree = cc.Sprite:create():setSpriteFrame("game_image_tree.png")
            :setAnchorPoint(cc.p(0, 0))
            :setPosition(278, self.treesHeight_)
            :addTo(zone, FlyMoreDefine.ZORDER_TREE)
        trees[leftTree] = leftTree
        trees[rightTree] = rightTree
        self.treesHeight_ = self.treesHeight_ + 520
        leftTree:setVisible(false)
        rightTree:setVisible(false)
    end
    return self
end

function GameViewFly:removeTrees()
    local trees = self.trees_
    local zone = self.zone_
    for tree in pairs(trees) do
        if (-zone:getPositionY()) >= tree:getPositionY() + 520 then
            tree:removeFromParent()
            trees[tree] = nil
        end
    end
end

--背景切换
function GameViewFly:goUp(delta)
    delta = delta  
    self.gameHeight_ = self.gameHeight_ + delta / 5
    self:addClouds()
    self:removeClouds()  
    self:addTrees()
    self:removeTrees()
    
    local sky = self.sky_
    if sky:getPositionY() - delta / 10 >= -(sky:getContentSize().height - FlyMoreDefine.CLIPPING_HEIGHT) then
        sky:setPositionY(sky:getPositionY() - delta / 10)
    else
        sky:setPositionY(-(sky:getContentSize().height - FlyMoreDefine.CLIPPING_HEIGHT))
    end
    
    local zone = self.zone_
    zone:setPositionY(zone:getPositionY() - delta)
    
    local heightTip = self.heightTip_
    heightTip:updateState(self.gameHeight_)
end

--游戏结束
function GameViewFly:onGameOver(event)
    self:stop()
    FlyMoreDefine:showResultMenu(self)
    performWithDelay(self, function () FlyMoreDefine:submitResult(self) end,0.001)
    local finishlayer = require("src.app.FlyMore.views.finishlayer").new(1,self,account)
    self:addChild(finishlayer,10)
end

--时间到结束
function GameViewFly:onTimeOver(event)
    self:stop()
    FlyMoreDefine:showResultMenu(self)
    performWithDelay(self, function () FlyMoreDefine:submitResult(self) end,0.001)
    local finishlayer = require("src.app.FlyMore.views.finishlayer").new(3,self,account)
    self:addChild(finishlayer,10)
end

return GameViewFly

