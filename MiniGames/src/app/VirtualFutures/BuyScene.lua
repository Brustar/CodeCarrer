import(".pb.FuturesPB_pb")

local Util = import(".Util")
local AlertLayer = import(".AlertLayer")

local BuyScene = class("BuyScene", 
	function()
		return cc.Scene:create()
	end)

function BuyScene:ctor(typeid)
	self.typeid = typeid

	self:initWithCSB()

	self:loadTypeDetail()

	self:loadMyqhDetail()
end

function BuyScene:initWithCSB()
    local node = cc.CSLoader:createNode("buy_weituo.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = root:getChildByName("pl_top")
	self.pl_back = pl_top:getChildByName("pl_back")
	self.pl_back:addClickEventListener(function(sender, eventType)
		cc.Director:getInstance():popScene() 
	end)

	local pl_weituo = root:getChildByName("pl_weituo")

	local pl_weituo_con = pl_weituo:getChildByName("pl_weituo_con")
	self.text_qh_name = pl_weituo_con:getChildByName("pl_qihuo_name"):getChildByName("text_qh_name")
	self.text_price_num = pl_weituo_con:getChildByName("pl_price"):getChildByName("text_price_num")
	self.btn_refresh = pl_weituo_con:getChildByName("pl_price"):getChildByName("btn_refresh")
	self.TextField_3 = pl_weituo_con:getChildByName("pl_buy"):getChildByName("pl_input"):getChildByName("TextField_3")
	self.TextField_3:setPlaceHolder("")
	Util.wrapTextField(self.TextField_3)
	self.btn_add = pl_weituo_con:getChildByName("pl_buy"):getChildByName("btn_add")
	self.btn_add:addClickEventListener(function(sender, eventType)
		self:setTradeNum(self:getTradeNum() + 1)
	end)

	local pl_all = pl_weituo_con:getChildByName("pl_all")
	self.pl_all_five = pl_all:getChildByName("pl_all_five")
	self.pl_all_five:addClickEventListener(function(sender, eventType)
		self:setTradeNumPercent(20)
	end)
	self.pl_all_four = pl_all:getChildByName("pl_all_four")
	self.pl_all_four:addClickEventListener(function(sender, eventType)
		self:setTradeNumPercent(25)
	end)
	self.pl_all_three = pl_all:getChildByName("pl_all_three")
	self.pl_all_three:addClickEventListener(function(sender, eventType)
		self:setTradeNumPercent(33)
	end)
	self.pl_all_three_0 = pl_all:getChildByName("pl_all_three_0")
	self.pl_all_three_0:addClickEventListener(function(sender, eventType)
		self:setTradeNumPercent(50)
	end)
	self.pl_all_all = pl_all:getChildByName("pl_all_all")
	self.pl_all_all:addClickEventListener(function(sender, eventType)
		self:setTradeNumPercent(100)
	end)

	self.text_ = pl_weituo_con:getChildByName("text_")
	self.text_:setString("")

	self.btn_buy = pl_weituo:getChildByName("btn_buy")
	self.btn_buy:addClickEventListener(function(sender, eventType)
		self:Commit()
	end)
end

function BuyScene:getMaxTradeNum()
	return math.floor(UserData.stone / self.type.price)
end

function BuyScene:getTradeNum()
	return tonumber(self.TextField_3:getString())
end

function BuyScene:setTradeNum(num)
	self.TextField_3:setString(num)
end

function BuyScene:setTradeNumPercent(percent)
	self:setTradeNum(math.floor(self:getMaxTradeNum() * percent / 100))
end

function BuyScene:loadTypeDetail()
    local pbRequest = FuturesPB_pb.PBTypeDetailRequest()
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/typedetail.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBType()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
    self.type = pbResponse
    self.text_qh_name:setString(self.type.typename)
    self.text_price_num:setString(self.type.price)

    self.text_:setString("最大买入数量" .. self:getMaxTradeNum() .."股")
end

function BuyScene:loadMyqhDetail()
    local pbRequest = FuturesPB_pb.PBMyqhDetailRequest()
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/myqhdetail.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBMyqh()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
    self.myqh = pbResponse
end

function BuyScene:Commit()
	local op = 1
	local typeid = self.type.typeid
	local num = self:getTradeNum()

    local pbRequest = FuturesPB_pb.PBTradeRequest()
    pbRequest.op = op
    pbRequest.typeid = typeid
    pbRequest.num = num
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/trade.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBCommonResponse()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	self:addChild(AlertLayer:create("委托已提交", pbResponse.msg))
end

return BuyScene