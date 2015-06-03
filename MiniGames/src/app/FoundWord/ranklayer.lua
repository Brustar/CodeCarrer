local ranklayer = class("ranklayer",
	function ()
		return cc.Layer:create()
	end)
local pageindex= 1
local lastdata -- 记录上一次拉的数据,如果上次拉的数据少于10条，则滑到底部不再拉取数据
function ranklayer:ctor()
	self:infoCSB()
	self:infoTouch()
    performWithDelay(self, function ()
        local PAGE = ServerBasePB_pb.PBPageInfo()
        PAGE.page  = 1
        PAGE.pagesize  = 10
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBCrazywordsBestscoreList()
        obj:ParseFromString(rankReturn)
        self:infoData(obj)
        self:getDataAgain()
    end,0.001)
end
function ranklayer:infoCSB()
	local CSB = cc.CSLoader:createNode("FoundWord/paihang.csb") 
    self:addChild(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_close = bg:getChildByName("btn_close")
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local my_rank = bg:getChildByName("my_rank")
    local my_level = my_rank:getChildByName("my_level")
    self.self_top1_img = my_level:getChildByName("top1_img")
    self.self_top2_img = my_level:getChildByName("top2_img")
    self.self_top3_img = my_level:getChildByName("top3_img")
    self.self_top_none = my_level:getChildByName("top_none")
    self.self_rank_num = self.self_top_none:getChildByName("rank_num")
    self.self_img_avatar = my_rank:getChildByName("my_avatar"):getChildByName("img_avatar")
    local my_data = my_rank:getChildByName("my_data")
    self.my_name = my_data:getChildByName("name")
    self.my_name_shown = my_data:getChildByName("name_shown")
    self.my_info = my_data:getChildByName("info")
    self.mark_me_title = my_rank:getChildByName("mark_me"):getChildByName("title")
    my_rank:setVisible(false)
    self.my_rank = my_rank
    local other_rank = bg:getChildByName("other_rank")
    local other_level = other_rank:getChildByName("rank_level")
    self.other_top1_img = other_level:getChildByName("top1_img")
    self.other_top2_img = other_level:getChildByName("top2_img")
    self.other_top3_img = other_level:getChildByName("top3_img")
    self.other_top_none = other_level:getChildByName("top_none")
    self.other_rank_num = self.other_top_none:getChildByName("rank_num")
    self.other_img_avatar = other_rank:getChildByName("rank_avatar"):getChildByName("img_avatar")
    local other_data = other_rank:getChildByName("rank_data")
    self.other_name = other_data:getChildByName("name")
    self.other_name_shown = other_data:getChildByName("name_msk")
    self.other_info = other_data:getChildByName("info")
    other_rank:setVisible(false)
    self.other_rank = other_rank

    self.list = bg:getChildByName("rank_list")
end
function ranklayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
end
function ranklayer:infoData(data)
    lastdata = data
    self.my_rank:setVisible(true)
    if pageindex == 1 then
        --自己的数据
        if data.bestscore.userid ~= 0 then
            self:controlRankNum(data.bestscore.rank)
            self.my_name:setString(data.bestscore.nick)
            self.my_name_shown:setString(data.bestscore.nick)
            self.my_info:setString("闯关:"..data.bestscore.levels.."关".." 耗时:"..data.bestscore.costtime.."秒")
            self.self_img_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
        else 
            self:controlRankNum("0")
            self.my_name:setString(UserData.nick)
            self.my_name_shown:setString(UserData.nick)
            self.self_img_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
            self.my_info:setString("赶快来试玩一下吧")
            self.mark_me_title:setString("暂无成绩")
        end
       local function gotoGame(sender,eventType)
           if eventType == ccui.TouchEventType.ended then
                self:getParent():getApp():enterScene("foundwordgamelayer")
           end
       end
       self.my_rank:addTouchEventListener(gotoGame)
    end
    if #data.list == 0 then return end
    --其他玩家的排行列表
    for i,v in ipairs(data.list) do
        if v.userid ==0 then return end
        local item = self.other_rank:clone()
        item:setVisible(true)
        local other_level = item:getChildByName("rank_level")
        item.other_top1_img = other_level:getChildByName("top1_img")
        item.other_top2_img = other_level:getChildByName("top2_img")
        item.other_top3_img = other_level:getChildByName("top3_img")
        item.other_top_none = other_level:getChildByName("top_none")
        item.other_rank_num = item.other_top_none:getChildByName("rank_num")
        item.other_img_avatar = item:getChildByName("rank_avatar"):getChildByName("img_avatar")
        local other_data = item:getChildByName("rank_data")
        item.other_name = other_data:getChildByName("name")
        item.other_name_shown = other_data:getChildByName("name_msk")
        item.other_info = other_data:getChildByName("info")

        item.other_top1_img:setVisible(false)
        item.other_top2_img:setVisible(false)
        item.other_top3_img:setVisible(false)
        item.other_top_none:setVisible(false)
        item.other_rank_num:setVisible(false)
        if v.rank == 1 then
            item.other_top1_img:setVisible(true)
        elseif v.rank == 2 then
            item.other_top2_img:setVisible(true)
        elseif v.rank == 3 then
            item.other_top3_img:setVisible(true)
        else 
            item.other_top_none:setVisible(true)
            local size = item.other_top_none:getContentSize()
            local guanNum = ccui.TextAtlas:create()
            guanNum:setProperty(v.rank, "FoundWord/number_top_cz.png", 22, 29, ".")
            guanNum:setPosition(size.width*0.5,size.height*0.5)  
            item.other_top_none:addChild(guanNum)
        end
        item.other_name:setString(v.nick)
        item.other_name_shown:setString(v.nick)
        item.other_info:setString("闯关:"..v.levels.."关".." 耗时:"..v.costtime.."秒")
        --下载玩家头像
        HttpManager.downIcon (v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
        print("====v.headimg",v.headimg)
        item.other_img_avatar:loadTexture(device.writablePath..file)

        self.list:pushBackCustomItem(item)
    end
end
--滑到底部再拉数据
function ranklayer:getDataAgain()
    self.TIME_T = os.clock()
    local function onScroll(_,eventType)
        if eventType == ccui.ScrollviewEventType.scrollToBottom then--滑到底部
            if os.clock()-self.TIME_T>1 and #lastdata.list>=10 then --防止拉取数据太快
                pageindex = pageindex + 1 
                self.TIME_T = os.clock()
                local PAGE = ServerBasePB_pb.PBPageInfo()
                PAGE.page  = pageindex
                PAGE.pagesize  = 10
                local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/rank.aspx",PAGE:SerializeToString())
                if not flag then return end
                local obj=GamePB_pb.PBCrazywordsBestscoreList()
                obj:ParseFromString(rankReturn)
                self:infoData(obj)
                lastdata = obj
            end
        end
    end
   self.list:addScrollViewEventListener(onScroll)
end
--控制排行名次显示
function ranklayer:controlRankNum(num)
    self.self_top1_img:setVisible(false)
    self.self_top2_img:setVisible(false)
    self.self_top3_img:setVisible(false)
    self.self_top_none:setVisible(false)
    if num == 1 then
        self.self_top1_img:setVisible(true)
    elseif num == 2 then
        self.self_top2_img:setVisible(true)
    elseif num == 3 then
        self.self_top3_img:setVisible(true)
    else
        self.self_top_none:setVisible(true)
        self.self_rank_num:setVisible(false)
        local size = self.self_top_none:getContentSize()
        local guanNum = ccui.TextAtlas:create()
        guanNum:setProperty(num, "FoundWord/number_top_cz.png", 22, 29, ".")
        guanNum:setPosition(size.width*0.5,size.height*0.5)  
        self.self_top_none:addChild(guanNum)
    end
end
return ranklayer