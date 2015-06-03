import(".pb.FuturesPB_pb")

local Util = import(".Util")
local AlertLayer = import(".AlertLayer")
local BiddingHelpScene = import(".BiddingHelpScene")

local BiddingNewScene = class("BiddingNewScene", 
	function()
		return cc.Scene:create()
	end)

function BiddingNewScene:ctor()
	self:initWithCSB()
end

function BiddingNewScene:initWithCSB()
    local node = cc.CSLoader:createNode("tianxiexinxi.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = root:getChildByName("pl_top")
	self.pl_back = pl_top:getChildByName("pl_back")
	self.pl_back:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():popScene() 
	end)
	self.pl_btn_gz = pl_top:getChildByName("pl_btn_gz")
	self.pl_btn_gz:addClickEventListener(function(sender, eventType)
		cc.Director:getInstance():pushScene(BiddingHelpScene:create()) 
	end)

	local pl_weituo = node:getChildByName("pl_weituo")

	local pl_weituo_con = pl_weituo:getChildByName("pl_weituo_con")

	self.tf_qh_name = pl_weituo_con:getChildByName("pl_qihuo_name"):getChildByName("pl_input_qhname"):getChildByName("tf_qh_name")
	self.tf_qh_name:setPlaceHolder("")
	Util.wrapTextField(self.tf_qh_name)

	self.tf_qh_name_11 = pl_weituo_con:getChildByName("pl_price"):getChildByName("pl_input_jjjg"):getChildByName("tf_qh_name_11")
	self.tf_qh_name_11:setPlaceHolder("")
	Util.wrapTextField(self.tf_qh_name_11)

	self.tf_qh_name_11_13 = pl_weituo_con:getChildByName("pl_qhjs"):getChildByName("pl_input_qhjs"):getChildByName("tf_qh_name_11_13")
	self.tf_qh_name_11_13:setPlaceHolder("")
	Util.wrapTextField(self.tf_qh_name_11_13)

	self.btn_submit = pl_weituo:getChildByName("btn_submit")
	self.btn_submit:addClickEventListener(function(sender, eventType)
		self:Commit()
	end)
end

function BiddingNewScene:getBidName()
	return self.tf_qh_name:getString()
end

function BiddingNewScene:getPrice()
	return tonumber(self.tf_qh_name_11:getString())
end

function BiddingNewScene:getRemark()
	return self.tf_qh_name_11_13:getString()
end

function BiddingNewScene:Commit()
	local op = 1
	local bidname = self:getBidName()
	local price = self:getPrice()
	local remark = self:getRemark()

    local pbRequest = FuturesPB_pb.PBUserBiddingRequest()
    pbRequest.op = op
    pbRequest.bidname = bidname
    pbRequest.price = price
    pbRequest.remark = remark
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/bidding.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBCommonResponse()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	self:addChild(AlertLayer:create("委托已提交", pbResponse.msg))
end

return BiddingNewScene