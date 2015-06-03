import(".pb.FuturesPB_pb")

local BiddingHelpScene = class("BiddingHelpScene", 
	function()
		return cc.Scene:create()
	end)

function BiddingHelpScene:ctor()
	self:initWithCSB()
end

function BiddingHelpScene:initWithCSB()
    local node = cc.CSLoader:createNode("tuiguanguize.csb")
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

return BiddingHelpScene