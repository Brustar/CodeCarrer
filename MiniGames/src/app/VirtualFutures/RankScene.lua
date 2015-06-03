import(".pb.FuturesPB_pb")

local RankScene = class("RankScene", 
	function()
		return cc.Scene:create()
	end)

function RankScene:ctor()
	self:initWithCSB()

	self:switchRankList(1)
end

function RankScene:initWithCSB()
    local node = cc.CSLoader:createNode("gaoshou_paihang.csb")
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
		self:switchRankList(1)
	end)
	self.pl_today:getChildByName("text_today"):setTag(1)

	self.pl_zuotian = pl_day_tab:getChildByName("pl_zuotian")
	self.pl_zuotian:addClickEventListener(function(sender, eventType) 
		self:switchRankList(2)
	end)
	self.pl_zuotian:getChildByName("text_zuotian"):setTag(1)

	self.pl_zdy = pl_day_tab:getChildByName("pl_zdy")
	self.pl_zdy:addClickEventListener(function(sender, eventType) 
		self:switchRankList(3)
	end)
	self.pl_zdy:getChildByName("text_zb"):setTag(1)

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
					self:loadRankList()
		    	end
	        end
        end
	end)())
end

function RankScene:switchRankList(flag)
	self:removeRankList()
	if flag == 1 then
		self.pl_today:getChildByTag(1):setColor(cc.c3b(15, 141, 184))
	elseif flag == 2 then
		self.pl_zuotian:getChildByTag(1):setColor(cc.c3b(15, 141, 184))
	elseif flag == 3 then
		self.pl_zdy:getChildByTag(1):setColor(cc.c3b(15, 141, 184))
	end
	self.flag = flag
	self:loadRankList()
end

function RankScene:removeRankList()
    self.page = 0
    self.pagesize = 20
    self.total = 0
	self.ranks = {}
	self.lv_cjjl:removeAllChildren()
	self.pl_today:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
	self.pl_zuotian:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
	self.pl_zdy:getChildByTag(1):setColor(cc.c3b(255, 255, 255))
end

function RankScene:loadRankList()
    if self.total > 0 and self.total <= self.page * self.pagesize then
        return
    end
    local pbRequest = FuturesPB_pb.PBRankListRequest()
    pbRequest.page = self.page + 1
    pbRequest.pagesize = self.pagesize
    pbRequest.flag = self.flag
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/ranklist.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBRankList()
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
    if not self.ranks then
    	self.ranks = {}
	end
    for i, rank in ipairs(pbResponse.list) do 
    	table.insert(self.ranks, rank)
        local item = self.pl_lv_cjl_item:clone()
        item:getChildByName("text_mingci_num"):setString(rank.rid)
        item:getChildByName("text_user_name"):setString(rank.nick)
        item:getChildByName("text_yl_num"):setString(math.floor(rank.winstone / 100000000))
    	item:setVisible(true)
    	self.lv_cjjl:pushBackCustomItem(item)
    end
end

return RankScene