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
	local CSB = cc.CSLoader:createNode("BrushThrough/help.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)  
    local window = CSB:getChildByName("bg"):getChildByName("window")
    self.btn_lose = window:getChildByName("btn_lose")

end

function HelpLayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_lose:addTouchEventListener(backCallback)
end

return HelpLayer