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
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/cat/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBCatBestscoreList()
        obj:ParseFromString(rankReturn)
        dump(obj)
        self:infoData(obj)
     end,0.001)
end
function ranklayer:infoCSB()
	local CSB = cc.CSLoader:createNode("CrazyCat/paihang.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog")
    self.btn_close = bg:getChildByName("btn_close")
    local content = bg:getChildByName("dailog_con")
    local myItem = content:getChildByName("my_rank")
    local my_rank =  myItem:getChildByName("rank_num")
    self.my_rank_image_none = my_rank:getChildByName("num_bg")
    self.my_rank_num = self.my_rank_image_none:getChildByName("num")
    self.my_rank_image_one = my_rank:getChildByName("num_one")
    self.my_rank_image_two = my_rank:getChildByName("num_two")
    self.my_rank_image_three = my_rank:getChildByName("num_three")
    self.my_avatar = myItem:getChildByName("avatar"):getChildByName("avatar_img")
    self.my_name = myItem:getChildByName("info"):getChildByName("name")
    self.my_info = myItem:getChildByName("info"):getChildByName("info_data")
    self.my_datafrom = myItem:getChildByName("info"):getChildByName("via")
    self.myItem = myItem
    myItem:setVisible(false)

    local otherItem = content:getChildByName("other_rank")
    local other_rank = otherItem:getChildByName("orank_num")
    self.other_rank_image_none = other_rank:getChildByName("onum_bg")
    self.other_rank_num = self.other_rank_image_none:getChildByName("onum")
    self.other_rank_image_one = other_rank:getChildByName("onum_one")
    self.other_rank_image_two = other_rank:getChildByName("onum_two")
    self.other_rank_image_three = other_rank:getChildByName("onum_three")
    self.other_avatar = otherItem:getChildByName("oavatar"):getChildByName("oavatar_img")
    self.other_name = otherItem:getChildByName("oinfo"):getChildByName("oname")
    self.other_info = otherItem:getChildByName("oinfo"):getChildByName("info_data_0")
    self.other_datafrom = otherItem:getChildByName("oinfo"):getChildByName("ovia")
    self.otherItem = otherItem
    otherItem:setVisible(false)

    self.listView = content:getChildByName("rank_list")
end
function ranklayer:infoData(data)
	lastdata = data
	self.myItem:setVisible(true)
	if pageindex == 1 then
	     --自己的数据
	    if data.bestscore.userid ~= 0 then
	        self:controlRankNum(data.bestscore.rank)
	        self.my_name:setString(data.bestscore.nick)
	        self.my_info:setString("步数:"..data.bestscore.stepnum.." 耗时:"..data.bestscore.costtime.."秒")
	        self.my_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
	    else 
	        self:controlRankNum("0")
	        self.my_name:setString(UserData.nick)
	        self.my_avatar:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
	        self.my_info:setString("赶快来试玩一下吧")
	    end
	   local function gotoGame(sender,eventType)
	       if eventType == ccui.TouchEventType.ended then
	           self:getParent():getApp():enterScene("CrazyCatLayer")
	       end
	   end
	   self.myItem:addTouchEventListener(gotoGame)
	end

    if #data.list == 0 then return end
    --其他玩家的排行列表
    for i,v in ipairs(data.list) do
        if v.userid ==0 then return end
        local item = self.otherItem:clone()
        item:setVisible(true)
	    local other_rank = item:getChildByName("orank_num")
	    item.other_rank_image_none = other_rank:getChildByName("onum_bg")
	    item.other_rank_num = item.other_rank_image_none:getChildByName("onum")
	    item.other_rank_image_one = other_rank:getChildByName("onum_one")
	    item.other_rank_image_two = other_rank:getChildByName("onum_two")
	    item.other_rank_image_three = other_rank:getChildByName("onum_three")
	    item.other_avatar = item:getChildByName("oavatar"):getChildByName("oavatar_img")
	    item.other_name = item:getChildByName("oinfo"):getChildByName("oname")
	    item.other_info = item:getChildByName("oinfo"):getChildByName("info_data_0")
	    item.other_datafrom = item:getChildByName("oinfo"):getChildByName("ovia")
        item.other_rank_image_none:setVisible(false)
        item.other_rank_num:setVisible(false)
        item.other_rank_image_one:setVisible(false)
        item.other_rank_image_two:setVisible(false)
        item.other_rank_image_three:setVisible(false)

        if v.rank == 1 then
            item.other_rank_image_one:setVisible(true)
        elseif v.rank == 2 then
            item.other_rank_image_two:setVisible(true)
        elseif v.rank == 3 then
            item.other_rank_image_three:setVisible(true)
        else 
            item.other_rank_image_none:setVisible(true)
            item.other_rank_num:setVisible(false)
            local guanNum = ccui.TextAtlas:create()
            local size = item.other_rank_image_none:getContentSize()
            guanNum:setProperty(v.rank, "FoundWord/number_top_cz.png", 22, 29, ".")
            guanNum:setPosition(size.width*0.5,size.height*0.5)  
            item.other_rank_image_none:addChild(guanNum)
        end
        item.other_name:setString(v.nick) 
        item.other_info:setString("步数:"..v.stepnum.." 耗时:"..v.costtime.."秒")
        --下载玩家头像
        HttpManager.downIcon (v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
        print("====v.headimg",v.headimg)
        item.other_avatar:loadTexture(device.writablePath..file)

        self.listView:pushBackCustomItem(item)
    end
end
function ranklayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
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
   self.listView:addScrollViewEventListener(onScroll)
end
--控制排行名次显示
function ranklayer:controlRankNum(num)
    self.my_rank_image_none:setVisible(false)
    self.my_rank_image_one:setVisible(false)
    self.my_rank_image_two:setVisible(false)
    self.my_rank_image_three:setVisible(false)
    if num == 1 then
        self.my_rank_image_one:setVisible(true)
    elseif num == 2 then
        self.my_rank_image_two:setVisible(true)
    elseif num == 3 then
        self.my_rank_image_three:setVisible(true)
    else
        self.my_rank_image_none:setVisible(true)
        local size = self.my_rank_image_none:getContentSize()
        local guanNum = ccui.TextAtlas:create()
        guanNum:setProperty(num, "FoundWord/number_top_cz.png", 22, 29, ".")
        guanNum:setPosition(size.width*0.5,size.height*0.5)  
        self.other_rank_image_none:addChild(guanNum)
    end
end
return ranklayer