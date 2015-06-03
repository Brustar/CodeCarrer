import(".pb.FuturesPB_pb")

local DetailScene = class("DetailScene", 
	function()
		return cc.Scene:create()
	end)

function DetailScene:ctor()
    self.page = 0
    self.pagesize = 24
    self.total = 0
    self.flag = 1
	
	self:initWithCSB()

	self:switchDetailList(1)
end

function DetailScene:initWithCSB()
    local node = cc.CSLoader:createNode("chengjiao_jilu.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = root:getChildByName("pl_top")
	self.pl_back = pl_top:getChildByName("pl_back")
	self.pl_back:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():popScene() 
	end)

	local pl_day_tab = root:getChildByName("pl_day_tab")
	self.pl_today = pl_day_tab:getChildByName("pl_today")
	self.pl_today:addClickEventListener(function(sender, eventType) 
		self:switchDetailList(1)
	end)
	self.pl_today:getChildByName("text_today"):setTag(1)

	self.pl_7day = pl_day_tab:getChildByName("pl_7day")
	self.pl_7day:addClickEventListener(function(sender, eventType) 
		self:switchDetailList(2)
	end)
	self.pl_7day:getChildByName("text_7day"):setTag(1)

	self.pl_10day = pl_day_tab:getChildByName("pl_10day")
	self.pl_10day:addClickEventListener(function(sender, eventType) 
		self:switchDetailList(3)
	end)
	self.pl_10day:getChildByName("text_10day"):setTag(1)

	self.pl_zdy = pl_day_tab:getChildByName("pl_zdy")
	self.pl_zdy:addClickEventListener(function(sender, eventType) 
		self:switchDetailList(4)
	end)
	self.pl_zdy:getChildByName("text_zdy"):setTag(1):setString("全部")

	self.pl_lv_cjl_item = root:getChildByName("pl_lv_cjl_item")
	self.pl_lv_cjl_item:setVisible(false)

	self.lv_cjjl = root:getChildByName("lv_cjjl")
	self.lv_cjjl:setClippingEnabled(true)
	self.lv_cjjl:addScrollViewEventListener((function()
		local seconds = 1
		local lasttime = os.clock()
		return function(sender, eventType)
	        if eventType == ccui.ScrollviewEventType.scrollToBottom then
				if os.clock() - lasttime > seconds then
					lasttime = os.clock()
					self:loadDetailList()
		    	end
	        end
        end
	end)())
end

function DetailScene:switchDetailList(flag)
	self:removeDetailist()
	if flag == 1 then
		self.pl_today:getChildByTag(1):setColor(cc.c3b(15, 141, 184))
	elseif flag == 2 then
		self.pl_7day:getChildByTag(1):setColor(cc.c3b(15, 141, 184))
	elseif flag == 3 then
		self.pl_10day:getChildByTag(1):setColor(cc.c3b(15, 141, 184))
	elseif flag == 4 then
		self.pl_zdy:getChildByTag(1):setColor(cc.c3b(15, 141, 184))	
	end
	self.flag = flag
	self:loadDetailList()
end

function DetailScene:removeDetailist()
	self.pl_today:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
	self.pl_7day:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
	self.pl_10day:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
	self.pl_zdy:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
	self.page = 0
	self.pagesize = 20
    self.flag = 0
	self.ranks = {}
	self.lv_cjjl:removeAllChildren()
end

function DetailScene:loadDetailList()
    if self.total > 0 and self.total <= self.page * self.pagesize then
        return
    end
    local pbRequest = FuturesPB_pb.PBDetailListRequest()
    pbRequest.page = self.page + 1
    pbRequest.pagesize = self.pagesize
    pbRequest.flag = self.flag
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/detaillist.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBDetailList()
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
    if not self.details then
    	self.details = {}
	end
    for i, detail in ipairs(pbResponse.list) do 
    	table.insert(self.details, detail)
        local item = self.pl_lv_cjl_item:clone()
        item:getChildByName("text_time_num"):setString(detail.typename)
        if detail.flag == 0 then
    		item:getChildByName("text_mmlx_num"):setVisible(true)
    		item:getChildByName("text_mmlx_num1"):setVisible(false)
    		item:getChildByName("text_cjl_zhang_num"):setVisible(true):setString(detail.tradenum)
    		item:getChildByName("text_cjsl_die_num"):setVisible(false):setString(detail.tradenum)
    	else
    		item:getChildByName("text_mmlx_num"):setVisible(false)
    		item:getChildByName("text_mmlx_num1"):setVisible(true)
    		item:getChildByName("text_cjl_zhang_num"):setVisible(false):setString(detail.tradenum)
    		item:getChildByName("text_cjsl_die_num"):setVisible(true):setString(detail.tradenum)
		end
    	item:setVisible(true)
    	self.lv_cjjl:pushBackCustomItem(item)
    end
end

return DetailScene