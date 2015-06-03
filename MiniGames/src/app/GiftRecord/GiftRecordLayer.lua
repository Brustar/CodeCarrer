local GiftRecordLayer = class("gamelayer",cc.load("mvc").ViewBase)
local OpenEdPage,UnOpenPage = 1,1
local currentType = 0 --当前礼包列表的类型，0未领取 1领取
local OpenEdDataList,UnOpenDataList = {},{} -- 已经领取的礼包数据，未领取的礼包数据
local clickOpenEd,clickUnOpen = false,false --是否切换过礼包列表
local OpenEdLastData,UnOpenLastData = {},{}-- 记录上一次拉的数据,如果上次拉的数据少于10条，则滑到底部不再拉取数据
local GameNameByID = 
{
    [1]="疯狂找字礼包",
    [2]="疯狂迷宫礼包",
    [3]="围住神经猫礼包",
    [4]="一笔画礼包",
    [6]="我要飞得更高礼包",
    [5]="气球砰砰砰礼包",
    [8]="勇士与公主礼包",
    [7]="超级魔法墙礼包",
    [9]="方块华容道礼包",
    [10]="五子棋礼包",
    [11]="虚拟期货礼包",
    [12]="疯狂大话礼包",
}
function GiftRecordLayer:onCreate()
	self:infoCSB()
	self:infoTouch()
end
function GiftRecordLayer:infoCSB()
 	self:createResoueceNode("Gift/gift_page.csb")
    local CSB=self.resourceNode_
    local root = CSB:getChildByName("root")
    self.mBack = root:getChildByName("Pl_head"):getChildByName("btn_back")
    self.mRefresh = root:getChildByName("Pl_head"):getChildByName("btn_refresh")
    local buttenTab = root:getChildByName("Pl_tab")
    self.UnGetBtn = buttenTab:getChildByName("Pl_tab_left")
    self.UnGetBtnS = self.UnGetBtn:getChildByName("Pl_tab_left_foc")
    self.UnGetBtnU = self.UnGetBtn:getChildByName("Pl_tab_left_noc")
    self.AlreadyGetBtn = buttenTab:getChildByName("Pl_tab_right")
    self.AlreadyGetBtnS = self.AlreadyGetBtn:getChildByName("Pl_tab_right_foc")
    self.AlreadyGetBtnU = self.AlreadyGetBtn:getChildByName("Pl_tab_right_noc")

    self.ListView = root:getChildByName("list_gift")
    self.itemOpenEd = root:getChildByName("item_coin")
    self.itemUnOpen = root:getChildByName("item_gift")
    self.itemOpenEd:setVisible(false)
    self.itemUnOpen:setVisible(false)
end
function GiftRecordLayer:infoTouch()
	local function onBack(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
            UnOpenPage,OpenEdPage,currentType = 1,1,0
            OpenEdDataList,UnOpenDataList = {},{} 
            clickOpenEd,clickUnOpen = false,false
            OpenEdLastData,UnOpenLastData = {},{}
            self:getApp():enterScene("MainScene")
    	end
    end
    self.mBack:addTouchEventListener(onBack)
    local function onRefresh(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if  currentType == 0 then
                UnOpenPage,UnOpenDataList,UnOpenLastData,clickUnOpen = 1,{},{},false
            elseif currentType == 1 then
                OpenEdPage,OpenEdDataList,OpenEdLastData,clickOpenEd = 1,{},{},false
            end
            self.ListView:removeAllItems()
            performWithDelay(self, function ()
                self:getData(currentType)
            end,0.02)
        end
    end
    self.mRefresh:addTouchEventListener(onRefresh)
    local function PanelControl(index)
    	if index == 0 then
		    self.UnGetBtnS:setVisible(true)
			self.UnGetBtnU:setVisible(false)
			self.AlreadyGetBtnS:setVisible(false)
			self.AlreadyGetBtnU:setVisible(true)
    	elseif index == 1 then
		    self.UnGetBtnS:setVisible(false)
			self.UnGetBtnU:setVisible(true)
			self.AlreadyGetBtnS:setVisible(true)
			self.AlreadyGetBtnU:setVisible(false)
    	end
    end
    local function isOpenCall(sender,eventType)
    	if eventType == ccui.TouchEventType.ended then
    		if self.UnGetBtn == sender then
                if currentType == 0 then 
                    return 
                else
                    self.ListView:removeAllItems()
                    currentType = 0
                    PanelControl(0)
                    performWithDelay(self, function ()
                        self:getData(0)
                    end,0.02)
                end
    		else
                if currentType == 1 then
                    return
                else
                    self.ListView:removeAllItems()
                    currentType = 1
    			    PanelControl(1)
                    performWithDelay(self, function ()
                        self:getData(1)
                    end,0.02)
                end
    		end
    	end
    end
    self.UnGetBtn:addTouchEventListener(isOpenCall)
	self.AlreadyGetBtn:addTouchEventListener(isOpenCall)
	PanelControl(0)
    performWithDelay(self, function ()
        self:getData(0)
        self:getDataAgain()
    end,0.02)
end
function GiftRecordLayer:getData(gettype)
    if gettype == 0 and clickUnOpen then
        self:infoData(UnOpenDataList,gettype)      
        return 
    elseif gettype == 1 and clickOpenEd then
        self:infoData(OpenEdDataList,gettype)
        return
    end
	local gift = GamePB_pb.PBUserGiftbag_Params()
	gift.isget  = gettype --0:未领取 1:已领取
	gift.pageinfo.page  = 1
    gift.pageinfo.pagesize = 10
    local flag,giftReturn = HttpManager.post("http://lxgame.lexun.com/interface/giftbaglist.aspx",gift:SerializeToString())
    if not flag then return end
    local obj=GamePB_pb.PBUserGiftbagList()
    obj:ParseFromString(giftReturn)
    if gettype == 0 then  --把礼包列表保存起来，避免在没有礼包改变的情况在每次切换都拉取数据
        clickUnOpen = true
        for _,v in ipairs(obj.list) do
            table.insert(UnOpenDataList,v)
        end
    elseif gettype == 1 then
        clickOpenEd = true
        for _,v in ipairs(obj.list) do
            table.insert(OpenEdDataList,v)
        end
    end
    self:infoData(obj.list,gettype)
    print("======obj.list",#obj.list,gettype,obj.pageinfo.total)
end
function GiftRecordLayer:infoData(Data,gettype)
    if #Data == 0 then return end
    for i,v in ipairs(Data) do
        if gettype == 0 then
            UnOpenLastData = Data
            local item = self.itemUnOpen:clone()
            item:setVisible(true)
            item.img = item:getChildByName("img_libao")
            item.name = item:getChildByName("text_libao_num")
            item.reward = item:getChildByName("text_reward")
            item.mOpen = item:getChildByName("btn_open")
            local function openCall(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                    --开启礼包
                    local getGift = GamePB_pb.PBGetUserGiftBag_Params()
                    getGift.ubid = v.ubid
                    local flag,getReturn = HttpManager.post("http://lxgame.lexun.com/interface/giftbaglist.aspx",getGift:SerializeToString())
                    if not flag then return end
                    local obj=ServerBasePB_pb.PBMessage()
                    if obj.noerror then --领取成功后再次切换需拉取礼包列表
                        --需要刷新礼包列表
                        self.ListView:removeAllItems()
                        table.remove(UnOpenDataList,i)
                        self:infoData(UnOpenDataList,0)

                        UnOpenPage,OpenEdPage,currentType = 1,1,0
                        OpenEdDataList,UnOpenDataList = {},{} 
                        clickOpenEd,clickUnOpen = false,false
                        OpenEdLastData,UnOpenLastData = {},{}
                    end
                    DialogBox.run(self,obj.outmsg) 
                end
            end
            item.mOpen:addTouchEventListener(openCall)
            item.reward:setString(v.remark)
            item.name:setString(GameNameByID[v.gameid])
            item.img:loadTexture("Gift/gift_icon"..v.awardtype..".png")
            self.ListView:pushBackCustomItem(item)
        elseif gettype == 1 then
            OpenEdLastData = Data
            local item = self.itemOpenEd:clone()
        end
    end
end
--滑到底部再拉数据
function GiftRecordLayer:getDataAgain()
    self.TIME_T = os.clock()
    local function onScroll(_,eventType)
        if eventType == ccui.ScrollviewEventType.scrollToBottom then--滑到底部
            local lastdata
            if currentType == 0 then lastdata = UnOpenLastData end
            if currentType == 1 then lastdata = OpenEdLastData end
            if os.clock()-self.TIME_T>1 and #lastdata>=10 then --防止拉取数据太快
                local page
                if currentType == 0 then
                    UnOpenPage = UnOpenPage+1
                    page = UnOpenPage
                elseif currentType == 1 then
                    OpenEdPage = OpenEdPage+1
                    page = OpenEdPage
                end
                self.TIME_T = os.clock()

                local gift = GamePB_pb.PBUserGiftbag_Params()
                gift.isget  = currentType --0:未领取 1:已领取
                gift.pageinfo.page  = page
                gift.pageinfo.pagesize = 10
                print("=================currentType==",currentType,page)
                local flag,giftReturn = HttpManager.post("http://lxgame.lexun.com/interface/giftbaglist.aspx",gift:SerializeToString())
                if not flag then return end
                local obj=GamePB_pb.PBUserGiftbagList()
                obj:ParseFromString(giftReturn)
                if currentType == 0 then
                    UnOpenLastData = obj
                    for _,v in ipairs(obj.list) do
                        table.insert(UnOpenDataList,v)
                    end
                elseif currentType == 1 then
                    OpenEdLastData = obj
                    for _,v in ipairs(obj.list) do
                        table.insert(OpenEdDataList,v)
                    end
                end
                self:infoData(obj.list,currentType)
            end
        end
    end
   self.ListView:addScrollViewEventListener(onScroll)
end
return GiftRecordLayer