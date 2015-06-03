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
	local CSB = cc.CSLoader:createNode("FlyMore/rank.csb") 
    self:addChild(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_close = bg:getChildByName("btn_close")
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)

    local inner_bg=bg:getChildByName("inner_bg")
    local my_rank = inner_bg:getChildByName("my_rank")
    local my_level = my_rank:getChildByName("my_ranknum")
    self.my_ranknum = my_level
    self.self_rank_num = my_level:getChildByName("num")
    self.self_img_avatar = my_rank:getChildByName("avatar"):getChildByName("img")
 
    self.my_name = my_rank:getChildByName("nick_name")
    self.my_info = my_rank:getChildByName("scroe")
    self.myvia = my_rank:getChildByName("via")
    my_rank:setVisible(false)
    self.my_rank = my_rank

    local other_rank = inner_bg:getChildByName("other_rank")
 
    self.other_top1_img = other_rank:getChildByName("rank_one")
    self.other_top2_img = other_rank:getChildByName("rank_two")
    self.other_top3_img = other_rank:getChildByName("rank_three")
 
    self.other_rank_num = other_rank:getChildByName("my_ranknum"):getChildByName("num")
    self.other_img_avatar = other_rank:getChildByName("avatar"):getChildByName("img_2") 
    self.other_name = other_rank:getChildByName("nick_name")
    self.other_info = other_rank:getChildByName("core")
    self.other_via = other_rank:getChildByName("via")
    other_rank:setVisible(false)
    self.other_rank = other_rank

    self.list = inner_bg:getChildByName("rank_list")
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
            self.my_info:setString("闯关:"..data.bestscore.levels.."关".." 耗时:"..data.bestscore.costtime.."秒")
            self.self_img_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
            self.myvia:setString(data.bestscore.via)
        else 
            self:controlRankNum("0")
            self.my_name:setString(UserData.nick)
             
            self.self_img_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
            self.my_info:setString("赶快来试玩一下吧")
            self.other_via:setString(UserData.via)
        end
       local function gotoGame(sender,eventType)
           if eventType == ccui.TouchEventType.ended then
                self:getParent():getApp():enterScene("GameViewFly")
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
        local other_level = item
        item.other_top1_img = other_level:getChildByName("rank_one")
        item.other_top2_img = other_level:getChildByName("rank_two")
        item.other_top3_img = other_level:getChildByName("rank_three")
        item.other_img_avatar = item:getChildByName("avatar"):getChildByName("img_2")
        item.other_rank_num=other_level:getChildByName("my_ranknum"):getChildByName("num")
        
        item.other_name = other_level:getChildByName("nick_name")
        item.other_info = other_level:getChildByName("core")
        item.other_via = other_level:getChildByName("via")

        item.other_top1_img:setVisible(false)
        item.other_top2_img:setVisible(false)
        item.other_top3_img:setVisible(false)
 
        item.other_rank_num:setVisible(false)
        if v.rank == 1 then
            item.other_top1_img:setVisible(true)
        elseif v.rank == 2 then
            item.other_top2_img:setVisible(true)
        elseif v.rank == 3 then
            item.other_top3_img:setVisible(true)
        else 
--            item.other_top_none:setVisible(true)
--            local size = item.other_top_none:getContentSize()
--            local guanNum = ccui.TextAtlas:create()
--            guanNum:setProperty(v.rank, "FlyMore/number_top_cz.png", 22, 29, ".")
--            guanNum:setPosition(size.width*0.5,size.height*0.5)  
--            item.other_top_none:addChild(guanNum)
        end
        item.other_name:setString(v.nick)
        item.other_via:setString(v.via)
 
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
    self.self_rank_num:setVisible(false)
    local size = self.my_ranknum:getContentSize()
    local guanNum = ccui.TextAtlas:create()
    guanNum:setProperty(num, "FlyMore/nums.png", 19, 25, ".")
    guanNum:setPosition(size.width*0.5,size.height*0.5)  
    self.my_ranknum:addChild(guanNum)

end
return ranklayer