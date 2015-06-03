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
function finishlayer:infoFailed(parent,which,account)
	local CSB = cc.CSLoader:createNode("FlyMore/end.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local dailog_bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
--    self.congratulate = dailog_bg:getChildByName("congratulate_bg"):getChildByName("congratulate")
--    if which == 2 then
--        self.congratulate:loadTexture("text_error_cz.png",1)
--    elseif which ==1 then
--        self.congratulate:loadTexture("text_notime_cz.png",1)
--    end
    self.btn_replay = dailog_bg:getChildByName("btn_replay")
    self.btn_close = dailog_bg:getChildByName("btn_close")
    self.btn_back = dailog_bg:getChildByName("btn_back")    

    self.num_game =  dailog_bg:getChildByName("num_game")
    self.num_time = dailog_bg:getChildByName("num_time")
    self.num_top = dailog_bg:getChildByName("num_game_0")
    self.tips = dailog_bg:getChildByName("text_tips")

    local game_huodong=dailog_bg:getChildByName("game_huodong")

    self.inner_txt=game_huodong:getChildByName("inner_bg_po"):getChildByName("inner_txt")
    self.record=game_huodong:getChildByName("inner_linebg"):getChildByName("record")
  
    self.inner_txt:setString(string.format("时间到！您只飞了%s米，\n未能打破记录，快重新挑战吧！",parent.newHeight))
    self.record:setString(string.format("最高纪录：%s米",parent.hisGameHeight_))

    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            parent:getApp():enterScene("FlyMoreScene")
    	end
    end
    self.btn_close:addTouchEventListener(onclose)
    self.btn_back:addTouchEventListener(onclose)
    local function onreturn(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    		self:removeFromParent()
 
--            parent.gameHeight_ = 0
--            parent.cloudsHeight_ = 0
--            parent.treesHeight_ = 0
--            parent:reSetData()
--            parent:start()
        parent:getApp():enterScene("GameViewFly")
    	end
    end
    self.btn_replay:addTouchEventListener(onreturn)
end
--初始化通关csb
function finishlayer:infoDoWell(parent,account)
	local CSB = cc.CSLoader:createNode("FlyMore/time_out.csb") 
    self:addChild(CSB)
    local dailog_bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_replay = dailog_bg:getChildByName("btn_replay")
    self.btn_close = dailog_bg:getChildByName("btn_close")
    self.btn_back = dailog_bg:getChildByName("btn_back")    

    self.num_game =  dailog_bg:getChildByName("num_game")
    self.num_time = dailog_bg:getChildByName("num_time")
    self.num_top = dailog_bg:getChildByName("num_game_0")
    self.tips = dailog_bg:getChildByName("text_tips")

    local game_huodong=dailog_bg:getChildByName("game_huodong")

    self.inner_txt=game_huodong:getChildByName("inner_bg_po"):getChildByName("inner_txt")
    self.record=game_huodong:getChildByName("inner_linebg"):getChildByName("record")
    self.no_potxt=game_huodong:getChildByName("inner_bg_po"):getChildByName("bg_record")
  
    self.inner_txt:setString(string.format("恭喜您，您只飞了%s米",parent.newHeight))
    self.record:setString(string.format("最高纪录：%s米",parent.hisGameHeight_))

    if parent.newHeight > parent.hisGameHeight_ then
        self.no_potxt:setVisible(false)
    else
        self.no_potxt:setVisible(true)
    end
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            parent:getApp():enterScene("FlyMoreScene")
    	end
    end
    self.btn_close:addTouchEventListener(onclose)
    local function onreturn(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    		self:removeFromParent()

--            parent.gameHeight_ = 0
--            parent.cloudsHeight_ = 0
--            parent.treesHeight_ = 0
--            parent:reSetData()
--            parent:start()
            parent:getApp():enterScene("GameViewFly")
    	end
    end
    self.btn_replay:addTouchEventListener(onreturn)
end
--游戏提示ui
function finishlayer:gameEnd(which,parent,account)
	if which == 1 or which ==2 then
		self:infoFailed(parent,which,account)
	elseif which == 3 then
		self:infoDoWell(parent,account)
	end
end
return finishlayer