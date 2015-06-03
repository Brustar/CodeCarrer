import(".pb.FuturesPB_pb")

local HelpScene = class("HelpScene", 
	function()
		return cc.Scene:create()
	end)

function HelpScene:ctor()
	self:initWithCSB()
end

function HelpScene:initWithCSB()
    local node = cc.CSLoader:createNode("youxi_wanfa.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = root:getChildByName("pl_top")
	self.pl_back = pl_top:getChildByName("pl_back")
	self.pl_back:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():popScene() 
	end)
end

return HelpScene