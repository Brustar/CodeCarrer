local AlertLayer = class("AlertLayer", 
	function()
		return cc.Layer:create()
	end)

function AlertLayer:ctor(title, content)
	self.title = title
	self.content = content

	self:initWithCSB()
end

function AlertLayer:initWithCSB()
    local node = cc.CSLoader:createNode("alert_weituo.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_laert = root:getChildByName("pl_laert")

	self.text_cg = pl_laert:getChildByName("pl_weituo_cg"):getChildByName("text_cg")
	self.text_cg:setString(self.title)
	self.text_cg_con = pl_laert:getChildByName("text_cg_con")
	self.text_cg_con:setString(self.content)
	self.Button_1 = pl_laert:getChildByName("Button_1")
	self.Button_1:addClickEventListener(function(sender, eventType)
		self:removeFromParent()
	end)
end

return AlertLayer