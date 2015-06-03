local finishlayer = class("finishlayer",
	function ()
		return cc.Layer:create()
	end)
local winSize = cc.Director:getInstance():getWinSize()
function finishlayer:ctor(which,parent,account)
	self:createLayer()
	self:gameEnd(which,parent,account)
end
--创建底
function finishlayer:createLayer()
	self.layer = cc.LayerColor:create(cc.c4b(0, 255, 127,0))
   	self:addChild(self.layer)
    local touchListener = cc.EventListenerTouchOneByOne:create()
	local function onTouchBegan()
		return true
	end
	touchListener:setSwallowTouches(true)
	touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener, self.layer)
end
--初始化时间到了和答错题csb
function finishlayer:infoNoTime(parent,which,account)
	local CSB = cc.CSLoader:createNode("ChineseBlock/time.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local window = CSB:getChildByName("bg"):getChildByName("window")
--    self.img_title = window:getChildByName("congratulate_bg"):getChildByName("img_title")
--    if which == 2 then
--        self.congratulate:loadTexture("text_error_cz.png",1)
--    elseif which ==1 then
--        self.congratulate:loadTexture("text_notime_cz.png",1)
--    end
    self.btn_reset = window:getChildByName("btn_reset")
    self.btn_back = window:getChildByName("btn_back")
    self.btn_close = window:getChildByName("btn_close")    

    self.guanka_num =  window:getChildByName("list_guanka"):getChildByName("guanka_num")
    self.xingxing_num = window:getChildByName("list_xingxing"):getChildByName("xingxing_num")
    self.bushu_num = window:getChildByName("list_bushu"):getChildByName("bushu_num")

    self.xingxing_num:setString(parent.star)
    self.guanka_num:setString(account.levels)
    self.bushu_num:setString(parent.foot)
--    self.num_top:setString(account.rank)
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
        self:getParent():getApp():enterScene("CrazyBlockScene")
    	end
    end
    self.btn_back:addTouchEventListener(onclose)
    self.btn_close:addTouchEventListener(onclose)
    local function onreturn(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            parent.body:removeAllChildren()
            parent.time = 0
            parent.deltaTime = 0

            local levelState = parent.data.levelState
            levelState.level=1
            parent.data.levelData= parent:getLevelData(1)
            parent.data.levelState=levelState
            parent.star =0
            parent.foot =0
            parent:reInitialInterFace()
            parent:countdownBegin()
            self:removeFromParent()
    	end
    end
    self.btn_reset:addTouchEventListener(onreturn)
end
--初始化通关csb
function finishlayer:infoDoWell(parent,account)
	local CSB = cc.CSLoader:createNode("ChineseBlock/tongguan.csb") 
    self:addChild(CSB)
    local window = CSB:getChildByName("bg"):getChildByName("window")
    self.btn_reset = window:getChildByName("btn_reset")
    self.btn_back = window:getChildByName("btn_back")   
    
    self.guanka_num =  window:getChildByName("list_guanka"):getChildByName("guanka_num")
    self.bushu_num = window:getChildByName("list_bushu"):getChildByName("bushu_num")
    self.xingxing_num = window:getChildByName("list_xingxing"):getChildByName("xingxing_num")

    self.xingxing_num:setString(parent.star)
    self.guanka_num:setString(account.levels)
    self.bushu_num:setString(parent.foot)

    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            self:getParent():getApp():enterScene("CrazyBlockScene")
    	end
    end
    self.btn_back:addTouchEventListener(onclose)
    local function onreturn(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            parent.body:removeAllChildren()
            parent.time = 0
            parent.deltaTime = 0
            parent.isFinished = false
            print("**********"..parent.data.levelState.level)
            local levelState = parent.data.levelState
            levelState.level=1
            parent.data.levelData= parent:getLevelData(1)
            parent.data.levelState=levelState
            parent.star=0
            parent.level=1
            parent.foot =0    
            parent:reInitialInterFace()
            parent:countdownBegin()
            self:removeFromParent()
    	end
    end
    self.btn_reset:addTouchEventListener(onreturn)
end
--游戏提示ui
function finishlayer:gameEnd(which,parent,account)
	if which == 1 or which ==2 then
		self:infoNoTime(parent,which,account)
	elseif which == 3 then
		self:infoDoWell(parent,account)
	end
end
return finishlayer