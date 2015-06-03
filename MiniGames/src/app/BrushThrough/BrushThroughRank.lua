local BrushThroughRank = class("BrushThroughRank",
	function ()
		return cc.Layer:create()
	end)

local pageindex= 1
local lastdata -- 记录上一次拉的数据,如果上次拉的数据少于10条，则滑到底部不再拉取数据
function BrushThroughRank:ctor()
    self:infoCSB()
    self:infoTouch()
    performWithDelay(self, function ()
        local PAGE = ServerBasePB_pb.PBPageInfo()
        PAGE.page  = 1
        PAGE.pagesize  = 10
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/onepath/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBCrazywordsBestscoreList()
        obj:ParseFromString(rankReturn)
        self:infoData(obj)
        self:getDataAgain()
    end,0.001)
end
function BrushThroughRank:infoCSB()

local CSB = cc.CSLoader:createNode("BrushThrough/ranking.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
 
    
    local window = CSB:getChildByName("bg"):getChildByName("window")
    self.btn_lose = window:getChildByName("btn_lose")

    local my_rank = window:getChildByName("list_rankimg")
    local my_rankTest = my_rank:getChildByName("num")
    
    self.img_first = my_rankTest:getChildByName("img_first")--
    self.text_num = my_rankTest:getChildByName("text_num")
    self.self_img_avatar = my_rank:getChildByName("photo"):getChildByName("img")
    self.my_name = my_rank:getChildByName("name")
    self.pass_dian = my_rank:getChildByName("dian") --点
    self.text_pass = my_rank:getChildByName("text_pass") --关数
    self.pass_num = my_rank:getChildByName("pass_num") --第几关test
    self.tame_num = my_rank:getChildByName("time")
    self.my_time = my_rank:getChildByName("time_num") --用时
    my_rank:setVisible(false)
    self.my_rank = my_rank
    local other_list_item = window:getChildByName("list_item")--下拉重复的自己的排名other_rank
    local other_num_item = other_list_item:getChildByName("num_item")
  
    self.other_rank_num = other_num_item:getChildByName("text_num_item")
    self.other_first_item = other_num_item:getChildByName("img_first_item")
    self.self_other_avatar = other_list_item:getChildByName("photo_item"):getChildByName("img_item")
    self.other_name_item = other_list_item:getChildByName("name_item")
    self.other_pass_num = other_list_item:getChildByName("pass_num_item")
    self.other_time = other_list_item:getChildByName("time_num_item")
    other_list_item:setVisible(false)
    self.other_list_item = other_list_item
    self.list = window:getChildByName("list")
end

function BrushThroughRank:infoTouch()
    local function backCallback(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:removeFromParent()
        end
    end
    self.btn_lose:addTouchEventListener(backCallback)
end

function BrushThroughRank:infoData(data)
    lastdata = data
    self.my_rank:setVisible(true)
    if pageindex == 1 then
        --自己的数据
        if data.bestscore.userid ~= 0 then
            self:controlRankNum(data.bestscore.rank)
            self.my_name:setString(data.bestscore.nick)
            self.pass_num:setString(data.bestscore.levels)  --关数
            self.my_time:setString(data.bestscore.costtime) --用时
            self.self_img_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
        else 
            
           -- self.text_pass:setVisible(false)--关数
            self.tame_num:setVisible(false)--时间
            self.pass_dian:setVisible(false)--点
            self.pass_num:setVisible(false)--第几关test
            self.my_time:setVisible(false)--时间
            self:controlRankNum("0")
            self.my_name:setString(UserData.nick)
            self.self_img_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
            self.text_pass:setString("赶快来试玩一下吧")
           -- self.mark_me_title:setString("暂无成绩")
        end
       local function gotoGame(sender,eventType)
           if eventType == ccui.TouchEventType.ended then
                self:getParent():getApp():enterScene("brushThroughScene")
           end
       end
       self.my_rank:addTouchEventListener(gotoGame)
    end
    if #data.list == 0 then return end
    --其他玩家的排行列表
    for i,v in ipairs(data.list) do
        if v.userid ==0 then return end
        local item = self.other_list_item:clone()
        item:setVisible(true)

        local other_num_item = item:getChildByName("num_item")
        item.other_rank_num = other_num_item:getChildByName("text_num_item")
        item.other_first_item = other_num_item:getChildByName("img_first_item")
        item.self_other_avatar = item:getChildByName("photo_item"):getChildByName("img_item")
        local other_list_item = item:getChildByName("list_item")
        item.other_name_item = item:getChildByName("name_item")
        item.other_pass_num = item:getChildByName("pass_num_item")
        item.other_time = item:getChildByName("time_num_item")

        item.other_rank_num:setVisible(false)
        item.other_first_item:setVisible(false)
      
        local size =item.other_first_item:getContentSize()
        local guanNum = ccui.TextAtlas:create()
        guanNum:setProperty(v.rank, "BrushThrough/num.png", 21, 29, ".")
        guanNum:setPosition(size.width-95,size.height)  
        item.self_other_avatar:addChild(guanNum)
   
        if v.rank == 1 then
           item.other_first_item:setVisible(true)
          -- item.other_rank_num:setVisible(true)
        elseif v.rank == 2 then
            item.other_first_item:setVisible(true)
            item.other_first_item:loadTexture("icon_second.png",1)--加入缓存 
        elseif v.rank == 3 then
             item.other_first_item:setVisible(true)
             item.other_first_item:loadTexture("icon_third.png",1)--加入缓存

        end

        --我的排名(下拉排名)
       item.other_rank_num:setVisible(true)
       item.self_other_avatar:setVisible(true)--头像
       item.other_name_item:setString(v.nick)
       item.other_pass_num:setString(v.levels)  --关数
       item.other_time:setString(v.costtime) --用时

        --下载玩家头像

        HttpManager.downIcon (v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
        print("====v.headimg",v.headimg)
        item.self_other_avatar:loadTexture(device.writablePath..file)
        self.list:pushBackCustomItem(item)
    end
end
--滑到底部再拉数据

function BrushThroughRank:getDataAgain()
    self.TIME_T = os.clock()
    local function onScroll(_,eventType)
        if eventType == ccui.ScrollviewEventType.scrollToBottom then--滑到底部
            if os.clock()-self.TIME_T>1 and #lastdata.list>=10 then --防止拉取数据太快
                pageindex = pageindex + 1 
                self.TIME_T = os.clock()
                local PAGE = ServerBasePB_pb.PBPageInfo()
                PAGE.page  = pageindex
                PAGE.pagesize  = 10
                local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/onepath/rank.aspx",PAGE:SerializeToString())
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
function BrushThroughRank:controlRankNum(num)
     self.img_first:setVisible(false)
     self.text_num:setVisible(false)
   
    local size = self.img_first:getContentSize()
    local guanNum = ccui.TextAtlas:create()
    guanNum:setProperty(num, "BrushThrough/num.png", 21, 29, ".")
    guanNum:setPosition(size.width-95,size.height)  
    self.self_img_avatar:addChild(guanNum)

    if num == 1 then
        self.img_first:setVisible(true)     
    elseif num ==2 then
        self.img_first:setVisible(true)
        self.img_first:loadTexture("icon_second.png",1)--加入缓存
     elseif num ==3 then
        self.img_first:setVisible(true)
        self.img_first:loadTexture("icon_third.png",1)--加入缓存
    --else
    end

end
return BrushThroughRank
