import(".pb.FuturesPB_pb")

local BiddingNewScene = import(".BiddingNewScene")

local BiddingScene = class("BiddingScene", 
	function()
		return cc.Scene:create()
	end)

function BiddingScene:ctor()
	self:initWithCSB()

	self:removeBiddingList()
	self:loadBiddingList()
end

function BiddingScene:initWithCSB()
    local node = cc.CSLoader:createNode("jinjiatuiguan.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = root:getChildByName("pl_top")
	self.pl_back = pl_top:getChildByName("pl_back")
	self.pl_back:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():popScene() 
	end)
	self.pl_btn_tg = pl_top:getChildByName("pl_btn_tg")
	self.pl_btn_tg:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():pushScene(BiddingNewScene:create()) 
	end)

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
					self:loadBiddingList()
		    	end
	        end
        end
	end)())
end

function BiddingScene:removeBiddingList()
    self.page = 0
    self.pagesize = 20
    self.total = 0
	self.biddings = {}
	self.lv_cjjl:removeAllChildren()
end

function BiddingScene:loadBiddingList()
    if self.total > 0 and self.total <= self.page * self.pagesize then
        return
    end
    local pbRequest = FuturesPB_pb.PBUserBiddingListRequest()
    pbRequest.page = self.page + 1
    pbRequest.pagesize = self.pagesize
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/biddinglist.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBUserBiddingList()
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
    if not self.biddings then
    	self.biddings = {}
	end
    for i, bidding in ipairs(pbResponse.list) do 
    	table.insert(self.biddings, bidding)
        local item = self.pl_lv_cjl_item:clone()
        item:getChildByName("text_yxq_num"):setString(bidding.rid)
        item:getChildByName("text_qhmc_name"):setString(bidding.bidname)
        item:getChildByName("text_cjl_num"):setString("保密")
    	item:setVisible(true)
    	self.lv_cjjl:pushBackCustomItem(item)
    end
end

return BiddingScene