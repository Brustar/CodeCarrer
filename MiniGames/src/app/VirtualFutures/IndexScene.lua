cc.FileUtils:getInstance():addSearchPath("res/VirtualFutures")
cc.SpriteFrameCache:getInstance():addSpriteFrames("commen.plist")

import(".pb.FuturesPB_pb")

local TypeScene = import(".TypeScene")
local HelpScene = import(".HelpScene")
local DetailScene = import(".DetailScene")
local BiddingScene = import(".BiddingScene")
local RewardBagScene = import(".RewardBagScene")
local RankScene = import(".RankScene")

local IndexScene = class("IndexScene", 
	function()
		return cc.Scene:create()
	end)

function IndexScene:ctor()
	self:initWithCSB()

    self:switchTypeList(1)

	self:scheduleUpdate(handler(self, self.step))
end

function IndexScene:initWithCSB()
    local node = cc.CSLoader:createNode("index.csb")
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node

	local pl_cutoff_time = root:getChildByName("pl_cutoff_time")
	self.text_time = pl_cutoff_time:getChildByName("text_time")
	self.btn_help = pl_cutoff_time:getChildByName("pl_btn_help"):getChildByName("btn_help")
    self.btn_help:addClickEventListener(function(sender, eventType)
        -- cc.Director:getInstance():pushScene(HelpScene:create())
        require("app.MyApp"):create():run()
    end)

	local pl_tab = root:getChildByName("pl_tab")
	self.pl_qbqh = pl_tab:getChildByName("pl_qbqh")
    self.pl_qbqh:addClickEventListener(function(sender, eventType)
        if self.flag == 1 then
            self:switchTypeList(2)
        else
            self:switchTypeList(1)
        end
    end)
    self.pl_qbqh:getChildByName("text_qbqh"):setName("title")
    self.pl_qbqh:getChildByName("img_san"):setName("icon")

	self.pl_zxj = pl_tab:getChildByName("pl_zxj")
    self.pl_zxj:addClickEventListener(function(sender, eventType)
        if self.sortType == 1 then
            self:sortTypeList(2)
        else
            self:sortTypeList(1)
        end
    end)
    self.pl_zxj:getChildByName("text_zxj"):setName("title")
    self.pl_zxj:getChildByName("img_san1"):setName("icon")

	self.pl_zdf = pl_tab:getChildByName("pl_zdf")
    self.pl_zdf:addClickEventListener(function(sender, eventType)
        if self.sortType == 3 then
            self:sortTypeList(4)
        else
            self:sortTypeList(3)
        end
    end)
    self.pl_zdf:getChildByName("text_zdf"):setName("title")
    self.pl_zdf:getChildByName("img_san2"):setName("icon")

	self.pl_lw_item = root:getChildByName("pl_lw_item")
	self.pl_lw_item:setVisible(false)

	self.ListView_1 = root:getChildByName("ListView_1")
	self.ListView_1:setClippingEnabled(true)
    self.ListView_1:addScrollViewEventListener((function()
        local seconds = 1
        local lasttime = os.clock()
        return function(sender, eventType)
            if eventType == ccui.ScrollviewEventType.scrollToBottom then
                if os.clock() - lasttime > seconds then
                    lasttime = os.clock()
                    self:loadTypeList()
                end
            end
        end
    end)())

	local pl_bottom_tab = root:getChildByName("pl_bottom_tab")
	self.pl_jl = pl_bottom_tab:getChildByName("pl_jl")
    self.pl_jl:getChildByName("pl_jl_con"):addClickEventListener(function(sender, eventType)
        cc.Director:getInstance():pushScene(DetailScene:create())
    end)
	self.pl_jj = pl_bottom_tab:getChildByName("pl_jj")
    self.pl_jj:getChildByName("pl_jj_con"):addClickEventListener(function(sender, eventType)
        cc.Director:getInstance():pushScene(BiddingScene:create())
    end)
	self.pl_lb = pl_bottom_tab:getChildByName("pl_lb")
    self.pl_lb:getChildByName("pl_lb_con"):addClickEventListener(function(sender, eventType)
        cc.Director:getInstance():pushScene(RewardBagScene:create())
    end)
	self.pl_pm = pl_bottom_tab:getChildByName("pl_pm")
    self.pl_pm:getChildByName("pl_pm_con"):addClickEventListener(function(sender, eventType)
        cc.Director:getInstance():pushScene(RankScene:create())
    end)
end

function IndexScene:switchTypeList(flag)
    self:removeTypeList()
    if flag == 1 then
        self.pl_qbqh:getChildByName("title"):setString("全部期货")
    elseif flag == 2 then
        self.pl_qbqh:getChildByName("title"):setString("我的期货")
    end
    self.flag = flag
    self:loadTypeList()
end

function IndexScene:removeTypeList()
    self.page = 0
    self.pagesize = 20
    self.total = 0
    self.types = {}
    self.ListView_1:removeAllChildren()
end

function IndexScene:loadTypeList()
    if self.total > 0 and self.total <= self.page * self.pagesize then
        return
    end
    local pbRequest = FuturesPB_pb.PBTypeListRequest()
    pbRequest.page = self.page + 1
    pbRequest.pagesize = self.pagesize
    pbRequest.flag = self.flag
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/typelist.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBTypeList()
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
    if not self.types then
    	self.types = {}
	end
    for i, type in ipairs(pbResponse.list) do 
    	table.insert(self.types, type)
    end
    self:sortTypeList(self.sortType)
    self.ajusttime = os.clock() + pbResponse.seconds
end

function IndexScene:appendTypeListItem(types)
    for i, type in ipairs(types) do 
        local item = self.pl_lw_item:clone()
        item:setTag(type.typeid)
        item:getChildByName("text_name"):setString(type.typename)
        item:getChildByName("text_num"):setString(type.price)
        if type.extent >= 0 then
            item:getChildByName("pl_zhang"):setVisible(true):getChildByName("text_zhang"):setString(string.format("%.2f%%", type.extent))
            item:getChildByName("pl_die"):setVisible(false)
        else
            item:getChildByName("pl_die"):setVisible(true):getChildByName("text_die"):setString(string.format("%.2f%%", type.extent))
            item:getChildByName("pl_zhang"):setVisible(false)
        end
        item:setVisible(true)
        item:addClickEventListener(function(sender, eventType) 
            local typeid = sender:getTag()
            cc.Director:getInstance():pushScene(TypeScene:create(typeid))
        end)
        self.ListView_1:addChild(item)
    end
end

function IndexScene:removeTypeListItem(types)
    for i, type in ipairs(types) do
        local item = self.ListView_1:getChildByTag(type.typeid)
        if item then
            item:removeFromParent()
        end
    end
end

function IndexScene:sortTypeList(sortType)
    local fn = function(a, b)
        if sortType == 1 then
            return a.price > b.price
        elseif sortType == 2 then
            return a.price < b.price
        elseif sortType == 3 then
            return a.extent > b.extent
        elseif sortType == 4 then
            return a.extent < b.extent
        end
    end
    table.sort(self.types, fn)
    self:removeTypeListItem(self.types)
    self:appendTypeListItem(self.types)
    self.sortType = sortType
end

function IndexScene:step(dt)
	self:countDown(dt)
end

function IndexScene:countDown(dt)
    if self.ajusttime - os.clock() <= 0  then
        self.text_time:setString("正在调价中...")
        self:switchTypeList(self.flag)
    end
    local seconds = self.ajusttime - os.clock()
	local hours = math.floor(seconds / 3600)
	seconds = math.floor(seconds % 3600)
	local minutes = math.floor(seconds / 60)
	seconds = math.floor(seconds % 60)
	self.text_time:setString(string.format("%d%d:%d%d:%d%d"
        , math.floor(hours / 10), math.floor(hours % 10)
        , math.floor(minutes / 10), math.floor(minutes % 10)
        , math.floor(seconds / 10), math.floor(seconds % 10)
    ))
end

return IndexScene