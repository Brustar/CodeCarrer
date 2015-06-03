import(".pb.FuturesPB_pb")

local RewardBagScene = class("RewardBagScene", 
	function()
		return cc.Scene:create()
	end)

function RewardBagScene:ctor()
	self:initWithCSB()
end

function RewardBagScene:initWithCSB()
    local node = cc.CSLoader:createNode("my_libao.csb")
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

return RewardBagScene