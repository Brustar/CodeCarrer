local ranklayer = class("ranklayer",
	function ()
		return cc.Layer:create()
	end)
local pageindex= 1
local lastdata -- 记录上一次拉的数据,如果上次拉的数据少于10条，则滑到底部不再拉取数据
function ranklayer:ctor()
	self:infoCSB()
	self:infoTouch()
    performWithDelay(self, function()
        local PAGE = ServerBasePB_pb.PBPageInfo()
        PAGE.page  = 1
        PAGE.pagesize  = 10
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/warrior/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBWarriorBestscoreList()
        --PBWarriorBestscoreList()
        obj:ParseFromString(rankReturn)
        self:infoData(obj)
        self:getDataAgain()
    end,0.001)
end
function ranklayer:infoCSB()
	local CSB = cc.CSLoader:createNode("warrior/gameranking.csb") 
    self:addChild(CSB)
    local bg = CSB:getChildByName("bg")
    local window = bg:getChildByName("window")
    local bgArticle = window:getChildByName("bg_article")
    local topRanking = bgArticle:getChildByName("top_ranking")
    
    self.btn_close = bg:getChildByName("window"):getChildByName("btn_close")
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    --我的数据
    self.firstRanking = topRanking:getChildByName("img_iranking")--我第一名
    self.myName = topRanking:getChildByName("name")--我的称呢
    self.myNumBg = topRanking:getChildByName("num_bg")--我的排名bg
    self.myNum =  topRanking:getChildByName("num_bg"):getChildByName("num")--我的排名text
    self.myPhoto = topRanking:getChildByName("photo") --我的头像
   -- self.myGrade =  topRanking:getChildByName("grade") --
    --关，星，步
    self.myLevelStar = topRanking:getChildByName("grade")
    self.myLevel = topRanking:getChildByName("grade"):getChildByName("num_guan")--多少关text
    self.myStar = topRanking:getChildByName("grade"):getChildByName("num_xing")--多少个星星text
    self.myStep = topRanking:getChildByName("grade"):getChildByName("num_bu")--多少步text
    self.myTime = topRanking:getChildByName("grade"):getChildByName("num_time")--多少时间text
    self.myInfo = topRanking:getChildByName("no_grade") --成绩--暂无成绩

    self.myFrom = topRanking:getChildByName("from")--我的 来自哪里
    topRanking:setVisible(false)
    self.topRanking = topRanking
    --列表数据
    local itemRanking = bgArticle:getChildByName("item_ranking")
    self.itemFirstRanking = itemRanking:getChildByName("item_img_iranking")--列表第一名
    self.itemName = itemRanking:getChildByName("item_name")--列表称呢
    self.itemNumBg = itemRanking:getChildByName("item_num_bg")--列表排名BG
    self.itemNum = itemRanking:getChildByName("item_num_bg"):getChildByName("num12")--列表排名text
    self.itemPhoto = itemRanking:getChildByName("item_photo") --我的头像
    self.iteminfo = itemRanking:getChildByName("no_grade") --成绩--暂无成绩
    --关，星，步
    self.itemLevelStar = itemRanking:getChildByName("item_grade")
    self.itemLevel = itemRanking:getChildByName("item_grade"):getChildByName("item_num_guan")--列表多少关text
    self.itemStar = itemRanking:getChildByName("item_grade"):getChildByName("item_num_xing")--列表多少个星星text
    self.itemStep = itemRanking:getChildByName("item_grade"):getChildByName("item_num_bu")--列表多少步text
    self.itemTime = itemRanking:getChildByName("item_grade"):getChildByName("item_num_time")--多少时间text
    self.itemInfo = itemRanking:getChildByName("item_o_grade")--列表隐藏，暂无成绩
    self.itemFrom = itemRanking:getChildByName("item_from")--列表 来自哪里
    itemRanking:setVisible(false)
    self.itemRanking = itemRanking
    self.list = bgArticle:getChildByName("list_ranking")
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
    self.topRanking:setVisible(true)
    if pageindex == 1 then
        --自己的数据
        if data.bestscore.userid ~= 0 then
            self.myInfo:setVisible(false)--无成绩,,隐藏
            self.myLevelStar:setVisible(true)--关卡,步数,时间显示
            self:controlRankNum(data.bestscore.rank)
            self.myName:setString(data.bestscore.nick)
            self.myLevel:setString(data.bestscore.levels) --多少关text
            self.myStar:setString(data.bestscore.starnum) --多少个星星text
            self.myStep:setString(data.bestscore.stepnum) --多少步text
            self.myTime:setString(data.bestscore.costtime) --多少时间
           -- self.myInfo:setString(..data.bestscore.levels.."关,"..data.bestscore.allStars.."颗星,".." 耗时:"..data.bestscore.costtime.."秒")
            self.myPhoto:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
        else 
            self.myInfo:setVisible(true)--无成绩,,显示
            self.myLevelStar:setVisible(false)--关卡,步数,时间y隐藏
            self:controlRankNum("0")
            self.myName:setString(UserData.nick)
            self.myNum:setString("0")
            --self.my_name_shown:setString(UserData.nick)
            self.myPhoto:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
          --  self.my_info:setString("赶快来试玩一下吧")
            --self.mark_me_title:setString("暂无成绩")
        end
    end
    if #data.list == 0 then
     return 
 end
    --其他玩家的排行列表
    for i,v in ipairs(data.list) do
        if v.userid ==0 then
         return end
        local item = self.itemRanking:clone()
        item:setVisible(true)
         --列表数据
        --local itemNumBg = item:getChildByName("item_num_bg")----
        item.itemFirstRanking = item:getChildByName("item_img_iranking")--列表第一名
        item.itemName = item:getChildByName("item_name")--列表称呢
        item.itemBg = item:getChildByName("item_num_bg") --列表排名背景
        item.itemNum = item:getChildByName("item_num_bg"):getChildByName("num12")--列表排名text
        item.itemPhoto = item:getChildByName("item_photo") --列表的头像
        item.iteminfo = item:getChildByName("no_grade") --成绩--暂无成绩
        --关，星，步
        item.itemLevelStar = item:getChildByName("item_grade")
        item.itemLevel = item:getChildByName("item_grade"):getChildByName("item_num_guan")--列表多少关text
        item.itemStar = item:getChildByName("item_grade"):getChildByName("item_num_xing")--列表多少个星星text
        item.itemStep = item:getChildByName("item_grade"):getChildByName("item_num_bu")--列表多少步text
        item.itemTime = item:getChildByName("item_grade"):getChildByName("item_num_time")--多少时间text
        item.itemInfo = item:getChildByName("item_o_grade")--列表隐藏，暂无成绩
        item.itemFrom = item:getChildByName("item_from")--列表 来自哪里
       -- item.itemRanking:setVisible(false)
        item.itemFirstRanking:setVisible(false)
        item.itemInfo:setVisible(false)
        item.itemBg:setVisible(false)
    
        if v.rank == 1 then
            item.itemFirstRanking:setVisible(true)
        elseif v.rank == 2 then
            itemFirstRanking:setVisible(true)
            itemFirstRanking:loadTexture("num_2.png")
        elseif v.rank == 3 then
            itemFirstRanking:setVisible(true)
            itemFirstRanking:loadTexture("num_3.png")
        else 
            --item.itemBg:setVisible(true)
            item.itemBg:setVisible(false)
        end

         item.itemName:setString(v.nick)
         item.itemLevel:setString(v.levels)--关数
         item.itemStar:setString(v.starnum)
         item.itemStep:setString(v.stepnum)
         item.itemTime:setString(v.costtime)
      
        --下载玩家头像
        HttpManager.downIcon (v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
       -- print("====v.headimg",v.headimg)
        item.itemPhoto:loadTexture(device.writablePath..file)

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
                local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/warrior/rank.aspx",PAGE:SerializeToString())
                if not flag then return end
                local obj=GamePB_pb.PBWarriorBestscoreList()
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
     self.firstRanking:setVisible(false)
     self.myNumBg:setVisible(false)
    if num == 1 then
        self.firstRanking:setVisible(true)
    elseif num == 2 then
         self.firstRanking:setVisible(true)
         self.firstRanking:loadTexture("num_2")
    elseif num == 3 then
        self.firstRanking:setVisible(true)
        self.firstRanking:loadTexture("num_3")
    else
       self.myNumBg:setVisible(true)
    end
end
return ranklayer