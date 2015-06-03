local finishlayer = class("finishlayer",
	function ()
		return cc.Layer:create()
	end)
local winSize = cc.Director:getInstance():getWinSize()
function finishlayer:ctor(which,parent,account,msg)
	self:createLayer()
	self:gameEnd(which,parent,account,msg)
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
function finishlayer:infoNoTime(parent,which,account,msg)
	local CSB = cc.CSLoader:createNode("FoundWord/erro_anw.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local dailog_bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.congratulate = dailog_bg:getChildByName("congratulate_bg"):getChildByName("congratulate")
    if which == 2 then
        self.congratulate:loadTexture("text_error_cz.png",1)
    elseif which ==1 then
        self.congratulate:loadTexture("text_notime_cz.png",1)
    end
    self.btn_return = dailog_bg:getChildByName("btn_return")
    self.btn_close = dailog_bg:getChildByName("btn_close")  

    self.num_game =  dailog_bg:getChildByName("num_game")
    self.num_time = dailog_bg:getChildByName("num_time")
    self.num_top = dailog_bg:getChildByName("num_game_0")
    self.tips = dailog_bg:getChildByName("text_tips")
    if msg ~= "" then
        self.tips:setString(msg)
    else
        self.tips:setVisible(false)
    end
    self.num_game:setString(account.levels)
    self.num_time:setString(account.costtime.." 秒")
    self.num_top:setString(account.rank)
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            parent:getApp():enterScene("FoundWordscene")
    	end
    end
    self.btn_close:addTouchEventListener(onclose)
    local function onreturn(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    		self:removeFromParent()

            parent.background:removeAllChildren()
            local allLattice=parent:createAllLattice(2)
            parent:createEachFonts(allLattice)
            parent.number_guan:setString(1)
            parent.countTime:setString("02:00")
            parent:countdownBegin()
    	end
    end
    self.btn_return:addTouchEventListener(onreturn)
end
--初始化通关csb
function finishlayer:infoDoWell(parent,account,msg)
	local CSB = cc.CSLoader:createNode("FoundWord/tongguan.csb") 
    self:addChild(CSB)
    local dailog_bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_return = dailog_bg:getChildByName("btn_return")
    self.btn_close = dailog_bg:getChildByName("btn_close")   
    
    self.time = dailog_bg:getChildByName("text_time")
    self.top = dailog_bg:getChildByName("text_top")
    self.getThing = dailog_bg:getChildByName("Text_2")

    self.time:setString(account.costtime)
    self.top:setString(account.rank)
    if msg ~= "" then
        self.top:setString(msg)
    else 
        self.top:setVisible(false)
    end
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            parent:getApp():enterScene("FoundWordscene")
    	end
    end
    self.btn_close:addTouchEventListener(onclose)
    local function onreturn(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    		self:removeFromParent()

            parent.background:removeAllChildren()
            local allLattice=parent:createAllLattice(2)
            parent:createEachFonts(allLattice)
            parent.number_guan:setString(1)
            parent.countTime:setString("02:00")
            parent:countdownBegin()
    	end
    end
    self.btn_return:addTouchEventListener(onreturn)
end
--游戏提示ui
function finishlayer:gameEnd(which,parent,account,msg)
	if which == 1 or which ==2 then
		self:infoNoTime(parent,which,account,msg)
	elseif which == 3 then
		self:infoDoWell(parent,account,msg)
	end
end
return finishlayer