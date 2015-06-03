local helplayer = class("helplayer",
	function ()
		return cc.Layer:create()
	end)
local winSize = cc.Director:getInstance():getWinSize()
function helplayer:ctor()
	self:infoCSB()
	self:infoTouch()
end
function helplayer:infoCSB()
	local CSB = cc.CSLoader:createNode("FlyMore/game_help.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    local content_scoll =  bg
    self.btn_join = content_scoll:getChildByName("btn_join")
    self.btn_close = bg:getChildByName("btn_close")

    self.line = content_scoll:getChildByName("line")
    self.star = content_scoll:getChildByName("star")
    self.game_title = content_scoll:getChildByName("game_title")
    self.game_content = content_scoll:getChildByName("game_content")


--    self.star:setVisible(false)
--    self.game_title:setVisible(false)
--    self.game_content:setVisible(false)
--    self.btn_join:setVisible(false)
end
function helplayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
	local function joingame(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getParent():getApp():enterScene("GameViewFly")
		end
	end
	self.btn_join:addTouchEventListener(joingame)
end
return helplayer