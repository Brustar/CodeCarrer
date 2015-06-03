local brushThroughView = class("brushThroughView",cc.load("mvc").ViewBase)

local winSize = cc.Director:getInstance():getWinSize()

function brushThroughView:ctor(which,parent)
	self:gameEnd(which,parent,account)
end



--游戏提示ui
function brushThroughView:gameEnd(which,parent,account)	
	
	if which == 1 then 
		self:timeOut(parent,which,account)
	elseif which == 2 then
		self:wrongWay(parent,which,account)
	elseif which == 3 then
		self:passSuccess(parent,which,account)
	end

	parent.draw:removeAllChildren()
	parent.draw:clear()
	parent.draw1:clear()
	parent.draw2:clear()
	

end

--画结算界面,路径错误
function brushThroughView:wrongWay(parent,which,account)
	local waywrong = cc.CSLoader:createNode("BrushThrough/waywrong.csb")
	self:addChild(waywrong)
	waywrong:setContentSize(display.size)
    ccui.Helper:doLayout(waywrong)
    local window = waywrong:getChildByName("bg"):getChildByName("window")
    self.backHome = window:getChildByName("btn_backhome")
    self.goGame = window:getChildByName("btn_gogame")
    self.text = window:getChildByName("text")

    self.text:setString(string.format("您只过了%s关哦,快再来试一次吧!",parent.gamelevel))
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    	  self:getParent():removeFromParent()
    	end
    end
    self.backHome:addTouchEventListener(onclose)

    local function onreturn(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                   -- self:getParent():removeFromParent()     
                    self:removeFromParent()
    				parent.init()
    				parent.level_num:setString(1)
    				parent.num_time:setString(120)
    				parent:countdownBegin()
    				parent:drawGraph() 

                end
    end
    self.goGame:addTouchEventListener(onreturn)
end

--时间用完
function brushThroughView:timeOut(parent,which,account)
	local timeout = cc.CSLoader:createNode("BrushThrough/timeout.csb")
	self:addChild(timeout)
	timeout:setContentSize(display.size)
    ccui.Helper:doLayout(timeout)
    local window = timeout:getChildByName("bg"):getChildByName("window")
    self.backPage = window:getChildByName("btn_backhome")
    self.rePlayGame = window:getChildByName("btn_gogame")
    self.text = window:getChildByName("text")
    self.text:setString(string.format("您一共通过了%s关哦,快再来试一次吧!",parent.gamelevel))
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    	  self:getParent():removeFromParent()
    	end
    end
    self.backPage:addTouchEventListener(onclose)

    local function onreturn(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                   -- self:getParent():removeFromParent()     
                    self:removeFromParent()
				parent.init()
				parent.level_num:setString(1)
				parent.num_time:setString(120)
				parent:countdownBegin()
				parent:drawGraph() 

                end
    end
    self.rePlayGame:addTouchEventListener(onreturn)

end

function brushThroughView:passSuccess(parent,which,account)
	local pass = cc.CSLoader:createNode("BrushThrough/pass.csb")
	self:addChild(pass)
	pass:setContentSize(display.size)
    ccui.Helper:doLayout(pass)
    local window = pass:getChildByName("bg"):getChildByName("window")
    self.backPass = window:getChildByName("btn_backhome")
    self.rePlayPass = window:getChildByName("btn_gogame")
    local function onclose(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    	  self:getParent():removeFromParent()
    	end
    end
    self.backPass:addTouchEventListener(onclose)

    local function onreturn(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                   -- self:getParent():removeFromParent()     
                    self:removeFromParent()
    				parent.init()
    				parent.level_num:setString(1)
    				parent.num_time:setString(120)
    				parent:countdownBegin()
    				parent:drawGraph() 

                end
    end
    self.rePlayPass:addTouchEventListener(onreturn)

end

return brushThroughView