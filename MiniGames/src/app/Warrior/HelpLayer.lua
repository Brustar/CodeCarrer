local HelpLayer = class("HelpLayer",
	function ()
		return cc.Layer:create()
	end)
local winSize = cc.Director:getInstance():getWinSize()
function HelpLayer:ctor()
	self:infoCSB()
	self:infoTouch()
end
function HelpLayer:infoCSB()
	local CSB = cc.CSLoader:createNode("Warrior/help.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
     local window = CSB:getChildByName("bg"):getChildByName("window")
     self.btnClose = window:getChildByName("btn_lose")
   
end
function HelpLayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btnClose:addTouchEventListener(backCallback)
    --[[
	local function joingame(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getParent():getApp():enterScene("StartScene")
		end
	end
	self.btn_join:addTouchEventListener(joingame)
    ]]
end
return HelpLayer