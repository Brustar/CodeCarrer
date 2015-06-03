local ranklayer = class("ranklayer",
	function ()
		return cc.Layer:create()
	end)
local pageindex= 1
local lastdata -- 记录上一次拉的数据,如果上次拉的数据少于10条，则滑到底部不再拉取数据
function ranklayer:ctor(parent)
	self:infoCSB()
	self:infoTouch()
    performWithDelay(self, function ()
        local PAGE = ServerBasePB_pb.PBPageInfo()
        PAGE.page  = 1
        PAGE.pagesize  = 10
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/gobang/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBGobangBestscoreList()
        obj:ParseFromString(rankReturn)
        print("list",#obj.list)
        self:infoData(obj,parent)
        self:getDataAgain()
    end,0.001)
end
function ranklayer:infoCSB()
	local CSB = cc.CSLoader:createNode("FiveChess/Top.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local content = CSB:getChildByName("dialog"):getChildByName("content")
    self.btn_close = content:getChildByName("btn_closed")
    local top = content:getChildByName("top")
    local my_top = top:getChildByName("my_top")
    self.my_img_top = my_top:getChildByName("img_top")
    self.my_num_top = my_top:getChildByName("num_top")
    self.my_avater = my_top:getChildByName("avater"):getChildByName("img_avater")
    self.my_name = my_top:getChildByName("nickname")
    self.my_id = my_top:getChildByName("ID")
    self.my_mask = my_top:getChildByName("mark"):getChildByName("Text_3")
    self.my_winnum = my_top:getChildByName("win")
    self.my_top = my_top
    self.my_top:setVisible(false)

    local item = top:getChildByName("item_top")
    self.item_img_top = item:getChildByName("img_top")
    self.item_num_top = item:getChildByName("num_top")
    self.item_avater = item:getChildByName("avater"):getChildByName("img_avater")
    self.item_name = item:getChildByName("nickname")
    self.item_id = item:getChildByName("ID")
    self.item_winnum = item:getChildByName("win")
    self.item = item
    item:setVisible(false)

    self.list = top:getChildByName("list_top")
    self:getDataAgain()
end
function ranklayer:infoData(data,parent)
    self.my_top:setVisible(true)
    lastdata = data
    if parent then
        if data.bestscore.userid  ~=0 then
            print("data.bestscore.rank",data.bestscore.rank)
            if data.bestscore.rank < 4 then
                self.my_num_top:setVisible(false)
                self.my_img_top:loadTexture("icon_top"..data.bestscore.rank.."_wzq.png",1)
            else 
                self.my_num_top:setVisible(false)
                self.my_img_top:setVisible(false)
                local x,y = self.my_num_top:getPosition()
                local Num = ccui.TextAtlas:create()
                Num:setProperty(data.bestscore.rank, "FiveChess/number_top_wzq.png", 24, 40, ".")
                Num:setPosition(x,y)  
                self.my_top:addChild(Num)
            end
            self.my_name:setString(data.bestscore.nick)
            self.my_id:setString(data.bestscore.userid)
            self.my_winnum:setString(data.bestscore.costtime.."秒"..data.bestscore.stepnum.."步")
            --下载玩家头像
            HttpManager.download(data.bestscore.headimg)
            local _,_,_,file=parseUrl(data.bestscore.headimg)
            self.my_avater:loadTexture(device.writablePath..file)
        else
            self.my_num_top:setVisible(false)
            self.my_img_top:setVisible(false)
            local x,y = self.my_num_top:getPosition()
            local Num = ccui.TextAtlas:create()
            Num:setProperty(data.bestscore.rank, "FiveChess/number_top_wzq.png", 24, 40, ".")
            Num:setPosition(x,y)  
            self.my_top:addChild(Num) 
            self.my_name:setString(UserData.nick)
            self.my_id:setString(UserData.userid)
            self.my_winnum:setString("赶快来试玩一下吧")
            self.my_mask:setString("暂无成绩")
        end
        local function gotoGame(sender,eventType)
           if eventType == ccui.TouchEventType.ended then
                self:getParent():getApp():enterScene("FiveChessView")
           end
       end
       self.my_top:addTouchEventListener(gotoGame)
    end
    --列表
    if #data.list == 0 then return end
    print("======data.list=",#data.list)
    for i,v in ipairs(data.list) do
        if v.userid == 0 then return end
        local item = self.item:clone()
        item:setVisible(true)
        local item_img_top = item:getChildByName("img_top")
        local item_num_top = item:getChildByName("num_top")
        local item_avater = item:getChildByName("avater"):getChildByName("img_avater")
        local item_name = item:getChildByName("nickname")
        local item_id = item:getChildByName("ID")
        local item_winnum = item:getChildByName("win")
        if v.rank < 4 then
            item_num_top:setVisible(false)
            print("==v.rank=",v.rank)
            if v.rank ~= 0 then
                item_img_top:loadTexture("icon_top"..v.rank.."_wzq.png",1)
            end
        else 
            item_num_top:setVisible(false)
            item_img_top:setVisible(false)
            local x,y = item_num_top:getPosition()
            local Num = ccui.TextAtlas:create()
            Num:setProperty(v.rank, "FiveChess/number_top_wzq.png", 24, 40, ".")
            Num:setPosition(x,y)  
            item:addChild(Num)
        end
        item_name:setString(v.nick)
        item_id:setString(v.userid)
        item_winnum:setString(v.costtime.."秒"..v.stepnum.."步")
        --下载玩家头像
        HttpManager.download(v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
        item_avater:loadTexture(device.writablePath..file)
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
                local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/gobang/rank.aspx",PAGE:SerializeToString())
                if not flag then return end
                local obj=GamePB_pb.PBGobangBestscoreList()
                obj:ParseFromString(rankReturn)
                self:infoData(obj)
                lastdata = obj
            end
        end
    end
   self.list:addScrollViewEventListener(onScroll)
end
function ranklayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
end
return ranklayer