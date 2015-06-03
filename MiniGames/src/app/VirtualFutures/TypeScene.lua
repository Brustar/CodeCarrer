import(".pb.FuturesPB_pb")

local Util = import(".Util")
local BuyScene = import(".BuyScene")
local SellScene = import(".SellScene")
local CommentScene = import(".CommentScene")

local TypeScene = class("TypeScene", 
	function()
		return cc.Scene:create()
	end)

function TypeScene:ctor(typeid)
	self.typeid = typeid

	self:initWithCSB()

	self:loadTypeDetail()

	self:loadExpectDetail()

	self:reloadTypeList()

	self:createChart()
end

function TypeScene:initWithCSB()
    local node = cc.CSLoader:createNode("my_xiangqin.csb"):setTag(1)
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = root:getChildByName("pl_top")
	self.pl_back = pl_top:getChildByName("pl_back")
	self.pl_back:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():popScene() 
	end)
	self.text_title = pl_top:getChildByName("text_title")

	local pl_qh_con = root:getChildByName("pl_qh_con")

	local pl_qh_num = pl_qh_con:getChildByName("pl_qh_num")
	self.text_qh_num = pl_qh_num:getChildByName("text_qh_num")
	self.text_qh_numadd = pl_qh_num:getChildByName("text_qh_numadd")
	self.text_qh_num_bf = pl_qh_num:getChildByName("text_qh_num_bf")

	local pl_qh_cjl = pl_qh_con:getChildByName("pl_qh_cjl")
	self.text_cjl_num = pl_qh_cjl:getChildByName("text_cjl_num")
	self.Text_34 = pl_qh_cjl:getChildByName("Text_34")

	local pl_qh_zg = pl_qh_con:getChildByName("pl_qh_zg")
	self.text_zg_num = pl_qh_zg:getChildByName("text_zg_num")
	pl_qh_zg:getChildByName("text_zd"):setString("最低")
	self.Text_zd_num = pl_qh_zg:getChildByName("Text_zd_num")

	local pl_maimai = pl_qh_con:getChildByName("pl_maimai")
	self.text_mrl_num = pl_maimai:getChildByName("text_mrl_num")
	self.text_mcl_mum = pl_maimai:getChildByName("text_mcl_mum")
	self.text_cjr_0 = pl_maimai:getChildByName("text_cjr_0")

	root:getChildByName("pl_title_cjl"):getChildByName("text_cjl_zcb"):setString("涨跌幅")

	self.pl_lv_cjl_item = root:getChildByName("pl_lv_cjl_item")
	self.pl_lv_cjl_item:setVisible(false)

	self.lv_cjj = root:getChildByName("lv_cjj")
	self.lv_cjj:setClippingEnabled(true)
	self.lv_cjj:addScrollViewEventListener((function()
		local seconds = 1
		local lasttime = os.clock()
		return function(sender, eventType)
	        if eventType == ccui.ScrollviewEventType.scrollToBottom then
				if os.clock() - lasttime > seconds then
					lasttime = os.clock()
					self:loadTrendList()
		    	end
	        end
        end
	end)())

	local pl_bottom_mm = root:getChildByName("pl_bottom_mm")
	self.pl_btn_buy = pl_bottom_mm:getChildByName("pl_btn_buy")
	self.pl_btn_buy:addClickEventListener(function() 
	    cc.Director:getInstance():pushScene(BuyScene:create(self.typeid))
	end)
	self.pl_btn_sell = pl_bottom_mm:getChildByName("pl_btn_sell")
	self.pl_btn_sell:addClickEventListener(function() 
	    cc.Director:getInstance():pushScene(SellScene:create(self.typeid))
	end)
	self.pl_comment = pl_bottom_mm:getChildByName("pl_comment")
	self.pl_comment:addClickEventListener(function() 
	    cc.Director:getInstance():pushScene(CommentScene:create(self.typeid))
	end)
end

function TypeScene:loadTypeDetail()
    local pbRequest = FuturesPB_pb.PBTypeDetailRequest()
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/typedetail.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBType()
    pbResponse:ParseFromString(data)
    self.type = pbResponse
	self.text_title:setString(self.type.typename)
	self.text_qh_num:setString(self.type.price)
	self.text_qh_numadd:setString(self.type.price - self.type.lastprice)
	self.text_qh_num_bf:setString(string.format("%.2f%%", self.type.extent))
	if self.type.extent > 0 then
		self.text_qh_num:setColor(cc.c3b(255, 24, 0))
		self.text_qh_numadd:setColor(cc.c3b(255, 24, 0))
		self.text_qh_num_bf:setColor(cc.c3b(255, 24, 0))
	else
		self.text_qh_num:setColor(cc.c3b(28, 199, 109))
		self.text_qh_numadd:setColor(cc.c3b(28, 199, 109))
		self.text_qh_num_bf:setColor(cc.c3b(28, 199, 109))
	end
	self.text_cjl_num:setString(self.type.buynum + self.type.sellnum)
	self.Text_34:setString(string.format("%.2f%%", (self.type.buynum + self.type.sellnum) / self.type.totalnum * 100))
	self.text_zg_num:setString(self.type.maxprice)
	self.Text_zd_num:setString(self.type.minprice)
	self.text_mrl_num:setString(self.type.buynum)
	self.text_mcl_mum:setString(self.type.sellnum)
	self.text_cjr_0:setString(self.type.buyprice + self.type.sellprice)
end

function TypeScene:loadExpectDetail()
    local pbRequest = FuturesPB_pb.PBExpectDetailRequest()
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/expectdetail.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBExpect()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	self.expect = pbResponse
	self.pl_comment:getChildByName("pl_"):getChildByName("text_"):setString(self.expect.comments .. "条评论")
end

function TypeScene:reloadTypeList()
    self:removeTrendList()
    self:loadTrendList()
end

function TypeScene:removeTrendList()
    self.page = 0
    self.pagesize = 24
    self.total = 0
	self.trends = {}
	self.lv_cjj:removeAllChildren()
end

function TypeScene:loadTrendList()
    if self.total > 0 and self.total <= self.page * self.pagesize then
        return
    end
    local pbRequest = FuturesPB_pb.PBTrendListRequest()
    pbRequest.page = self.page + 1
    pbRequest.pagesize = self.pagesize
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/trendlist.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBTrendList()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	if not pbResponse.list or #pbResponse.list <= 0 then
		return
	end
    self.page = pbResponse.pageinfo.page
    self.pagesize = pbResponse.pageinfo.pagesize
    self.total = pbResponse.pageinfo.total
    if not self.trends then
    	self.trends = {}
	end
    for i, trend in ipairs(pbResponse.list) do 
    	table.insert(self.trends, trend)
    	table.sort(self.trends, function(a, b) return Util.parseTime(a.addtime) < Util.parseTime(b.addtime) end)
        local item = self.pl_lv_cjl_item:clone()
        item:getChildByName("text_time"):setString(trend.addtime)
        item:getChildByName("text_cjj_num"):setString(trend.price)
        if trend.extent > 0 then
        	item:getChildByName("text_cjl_zhang_num"):setVisible(true):setString(trend.buynum + trend.sellnum)
        	item:getChildByName("text_cjl_die_num"):setVisible(false)
    	else
        	item:getChildByName("text_cjl_die_num"):setVisible(true):setString(trend.buynum + trend.sellnum)
        	item:getChildByName("text_cjl_zhang_num"):setVisible(false)
		end
        if trend.extent > 0 then
        	item:getChildByName("text_zcb_zhang"):setVisible(true):setString(string.format("%.2f%%", trend.extent))
        	item:getChildByName("text_zcb_die"):setVisible(false)
    	else
        	item:getChildByName("text_zcb_die"):setVisible(true):setString(string.format("%.2f%%", trend.extent))
        	item:getChildByName("text_zcb_zhang"):setVisible(false)
		end
    	item:setVisible(true)
    	self.lv_cjj:pushBackCustomItem(item)
    end
end

function TypeScene:createChart()
	local minPrice, maxPrice = 0, 0
	local minTime, maxTime = 0, 0
	for _, trend in ipairs(self.trends) do
		if minPrice == 0 or minPrice >= trend.price then
			minPrice = trend.price
		end
		if maxPrice == 0 or maxPrice <= trend.price then
			maxPrice = trend.price
		end

		local time = Util.parseTime(trend.addtime)
		if minTime == 0 or minTime >= time then
			minTime = time
		end
		if maxTime == 0 or maxTime <= time then
			maxTime = time
		end
	end
	if minPrice == maxPrice then
		minPrice = minPrice - 1
		maxPrice = maxPrice + 1
	end
	print(minPrice, maxPrice, minTime, maxTime)

	local chart = cc.Node:create()
	chart:setName("chart")
	chart:setPosition(0, 380)
	self:getChildByTag(1):addChild(chart)

	local canvasWidth, canvasHeight = 500, 200
	local canvas = cc.DrawNode:create():setPosition(100, 0)
	chart:addChild(canvas)

	local points = {}
	for i, trend in ipairs(self.trends) do
		table.insert(points, cc.p(canvasWidth / (#self.trends - 1) * (i - 1), canvasHeight * ((trend.price - minPrice) / (maxPrice - minPrice))))
	end
	-- table.insert(points, 1, cc.p(0, 0))
	-- table.insert(points, #self.trends + 1, cc.p(canvasWidth / 24 * (canvasWidth / 24 * (#self.trends - 1) - 1), 0))

	canvas:drawRect(cc.p(0, 0), cc.p(canvasWidth, canvasHeight), cc.c4f(20 / 255, 23 / 255, 26 / 255, 1))
	for i = 1, 5 do
		local y = (canvasHeight / (5 - 1)) * (i - 1)
		for j = 1, canvasWidth / 10 do
			local x = 10 * (j - 1)
			canvas:drawLine(cc.p(x, y), cc.p(x + 5, y), cc.c4f(20 / 255, 23 / 255, 26 / 255, 1))
		end
	end
	canvas:drawPoly(points, #points, false, cc.c4f(5 / 255, 71 / 255, 101 / 255, 1))
	-- canvas:drawPolygon(points, #points, cc.c4f(1, 0, 0, 1), 1, cc.c4f(0, 1, 0, 1))

	for i = 1, 5 do
		local price = minPrice + (maxPrice - minPrice) / (5 - 1) * (i - 1)
		local label = ccui.Text:create()
		label:setString(string.format("%.2f", price))
		label:setAnchorPoint(1, 0.5)
		label:setPosition(-5, canvasHeight / (5 - 1) * (i - 1))
		canvas:addChild(label)
	end

	for i = 1, 6 do
		local time = minTime + (maxTime - minTime) / (6 - 1) * (i - 1)
		local label = ccui.Text:create()
		label:setString(os.date("%H:%M", time))
		label:setAnchorPoint(0.5, 1)
		label:setPosition(canvasWidth / (6 - 1) * (i - 1), -5)
		canvas:addChild(label)
	end
end

return TypeScene