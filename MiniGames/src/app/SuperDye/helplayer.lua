local helplayer = class("helplayer",
	function ()
		return cc.Layer:create()
	end)
function helplayer:ctor()
	self:infoCSB()
	self:infoTouch()
end
function helplayer:infoCSB()
	local CSB = cc.CSLoader:createNode("SuperDye/game_help1.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
   	local bg = CSB:getChildByName("root"):getChildByName("pl_alert")
   	self.btn_close = bg:getChildByName("btn_close")
end
function helplayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
end
return helplayer