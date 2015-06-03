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
        local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/magicwall/rank.aspx",PAGE:SerializeToString())
        if not flag then return end
        local obj=GamePB_pb.PBMagicwallBestscoreList()
        obj:ParseFromString(rankReturn)
        dump(obj)
        self:infoData(obj)
        self:getDataAgain()
    end,0.001)
end
function ranklayer:infoCSB()
	local CSB = cc.CSLoader:createNode("SuperDye/game_paihang.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
   	local bg = CSB:getChildByName("root"):getChildByName("pl_alert")
   	self.btn_close = bg:getChildByName("btn_close")
   	local myitem = bg:getChildByName("pl_myranking")
   	self.my_topnum = myitem:getChildByName("al_num")
   	self.my_topimage = myitem:getChildByName("img_one_0")
   	self.my_icon = myitem:getChildByName("img_tx")
   	self.my_nick = myitem:getChildByName("text_user")
   	self.my_describe = myitem:getChildByName("text_result")
   	self.my_from = myitem:getChildByName("text_comeform"):setVisible(false)
   	self.myitem = myitem
   	self.myitem:setVisible(false)
   	self.otheritem = bg:getChildByName("pl_paihang_item")
   	self.otheritem:setVisible(false)
   	self.list = bg:getChildByName("ListView_1")
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
	self.myitem:setVisible(true)
    if pageindex == 1 then
        --自己的数据
        if data.bestscore.userid ~= 0 then
            --self:controlRankNum(data.bestscore.rank)
            if data.bestscore.rank == 1 then
            	self.my_topnum:setVisible(false)
            	self.my_topimage:loadTexture("icon_num_one.png",1)
            elseif data.bestscore.rank == 2 then
            	self.my_topnum:setVisible(false)
            	self.my_topimage:loadTexture("icon_num_two.png",1)
            elseif data.bestscore.rank == 3 then
            	self.my_topnum:setVisible(false)
            	self.my_topimage:loadTexture("icon_num_three.png",1)
            else
            	self.my_topimage:setVisible(false)
            	self.my_topnum:setVisible(false)
            	local ps_x,ps_y = self.my_topimage:getPosition()
		        local guanNum = ccui.TextAtlas:create()
		        guanNum:setProperty(data.bestscore.rank, "SuperDye/img_num.png", 18, 32, ".")
		        guanNum:setPosition(ps_x,ps_y)  
		        self.myitem:addChild(guanNum)
            end
            self.my_nick:setString(data.bestscore.nick)
            self.my_describe:setString(data.bestscore.stepnum.."把  耗时："..data.bestscore.costtime.."秒")
            self.my_icon:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
        else 
            self.my_topimage:setVisible(false)
        	self.my_topnum:setVisible(false)
        	local ps_x,ps_y = self.my_topnum:getPosition()
	        local guanNum = ccui.TextAtlas:create()
	        guanNum:setProperty(0, "SuperDye/img_num.png", 18, 32, ".")
	        guanNum:setPosition(ps_x,ps_y)  
	        self.myitem:addChild(guanNum)
            self.my_nick:setString(UserData.nick)
            self.my_icon:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
            self.my_describe:setString("赶快来试玩一下吧")
            self.my_from:setString("暂无成绩")
        end
       local function gotoGame(sender,eventType)
           if eventType == ccui.TouchEventType.ended then
                self:getParent():getApp():enterScene("dyegamelayer")
           end
       end
       self.myitem:addTouchEventListener(gotoGame)
    end
    if #data.list == 0 then return end
    --其他玩家的排行列表
    for i,v in ipairs(data.list) do
        if v.userid ==0 then return end
        local item = self.otheritem:clone()
        item:setVisible(true)
        item.other_topimage=item:getChildByName("img_one")
        item.other_topnum=item:getChildByName("al_num_0")
        item.other_icon=item:getChildByName("img_tx_3")
        item.other_nick=item:getChildByName("text_user_5")
        item.other_describe=item:getChildByName("text_result_7")
        item.other_from=item:getChildByName("text_comeform_9"):setVisible(false)
        if v.nick == 1 then
        	item.other_topnum:setVisible(false)
        	item.other_topimage:loadTexture("icon_num_one.png",1)
        elseif v.nick == 2 then
        	item.other_topnum:setVisible(false)
        	item.other_topimage:loadTexture("icon_num_two.png",1)
        elseif v.nick == 3 then
        	item.other_topnum:setVisible(false)
        	item.other_topimage:loadTexture("icon_num_three.png",1)
        else
        	item.other_topimage:setVisible(false)
        	item.other_topnum:setVisible(false)
        	local ps_x,ps_y = item.other_topimage:getPosition()
	        local guanNum = ccui.TextAtlas:create()
	        guanNum:setProperty(v.rank, "SuperDye/img_num.png", 18, 32, ".")
	        guanNum:setPosition(ps_x,ps_y)  
	        item:addChild(guanNum)
        end


        item.other_nick:setString(v.nick)
        item.other_describe:setString(v.stepnum.."把  耗时："..v.costtime.."秒")
        --下载玩家头像
        HttpManager.downIcon (v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
        print("====v.headimg",v.headimg)
        item.other_icon:loadTexture(device.writablePath..file)

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
                local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/magicwall/rank.aspx",PAGE:SerializeToString())
        		if not flag then return end
                local obj=GamePB_pb.PBMagicwallBestscoreList()
        		obj:ParseFromString(rankReturn)
        		dump(obj)
                self:infoData(obj)
            end
        end
    end
   self.list:addScrollViewEventListener(onScroll)
end
return ranklayer