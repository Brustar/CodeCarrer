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
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/blocked/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBBlockedBestscoreList()
        obj:ParseFromString(rankReturn)
        self:infoData(obj)
        self:getDataAgain()
    end,0.001)
end
function ranklayer:infoCSB()
	local CSB = cc.CSLoader:createNode("ChineseBlock/gameranking.csb") 
    self:addChild(CSB)
    local bg = CSB:getChildByName("bg"):getChildByName("window")
    self.btn_close = bg:getChildByName("btn_close")
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg_article = bg:getChildByName("bg_article")
    local list_ranking = bg_article:getChildByName("list_ranking")
    local top_ranking  = bg_article:getChildByName("top_ranking")
    self.top_rankingReturn=top_ranking
    self.self_top_num = top_ranking:getChildByName("num")
    self.self_top_img = top_ranking:getChildByName("img")
    self.self_top_photo = top_ranking:getChildByName("photo")
    self.self_top_name = top_ranking:getChildByName("name")
    self.self_top_record = top_ranking:getChildByName("record")
    self.self_top_avatar = top_ranking:getChildByName("avatar")
    local item_ranking = bg_article:getChildByName("item_ranking")
    self.self_item_num = top_ranking:getChildByName("num")
    self.self_item_img = top_ranking:getChildByName("img")
    self.self_item_photo = top_ranking:getChildByName("photo")
    self.self_item_name = top_ranking:getChildByName("name")
    self.self_item_record = top_ranking:getChildByName("record")
    self.self_item_avatar = top_ranking:getChildByName("avatar")

    self.list = list_ranking
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
    --self.my_rank:setVisible(true)
    if pageindex == 1 then
        --自己的数据
        if data.bestscore.userid ~= 0 then
            --self:controlRankNum(data.bestscore.rank)
            self.self_top_num:setString(data.bestscore.rank)
            self.self_top_name:setString(data.bestscore.nick)
            --self.my_name_shown:setString(data.bestscore.nick)
            self.self_top_record:setString(data.bestscore.levels.."关"..data.bestscore.starnum.."颗星"..data.bestscore.stepnum.."步".." 耗时:"..data.bestscore.costtime.."秒")
            self.self_top_photo:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
        else 
           -- self:controlRankNum("0")
            self.self_top_num:setString("0")
            self.self_top_name:setString(UserData.nick)
           -- self.my_name_shown:setString(UserData.nick)
            self.self_top_photo:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
           -- self.my_info:setString("赶快来试玩一下吧")
           -- self.mark_me_title:setString("暂无成绩")
        end
    local function gotoGame(sender,eventType)
           if eventType == ccui.TouchEventType.ended then
                self:getParent():getApp():enterScene("GameView")
           end
    end
    self.top_rankingReturn:addTouchEventListener(gotoGame)
    end
    if #data.list == 0 then return end
    --其他玩家的排行列表
    for i,v in ipairs(data.list) do
        if v.userid ==0 then return end
        local item = self.item_ranking:clone()
        item:setVisible(true)
 
        item.other_rank_num = item.other_top_none:getChildByName("item_num")
        item.other_img_avatar = item:getChildByName("item_photo")
 
        item.other_name = item:getChildByName("item_name")
 
        item.other_info = item:getChildByName("item_record")

        item.other_rank_num:setVisible(false)
       
        item.other_name:setString(v.nick)

        item.other_info:setString("闯关:"..v.levels.."关"..v.starnum.."颗星"..v.stepnum.."步".." 耗时:"..v.costtime.."秒")
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
                local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/blocked/rank.aspx",PAGE:SerializeToString())
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