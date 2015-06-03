local helplayer = class("helplayer",
	function ()
		return cc.Layer:create()
	end)
local winSize = cc.Director:getInstance():getWinSize()
function helplayer:ctor()
	self:infoCSB()
	self:infoTouch()
    self:infoRule()
    performWithDelay(self, function ()
	   self:getActivityData()
    end,0.001)
end
function helplayer:infoCSB()
	local CSB = cc.CSLoader:createNode("FiveChess/guize.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_close = bg:getChildByName("btn_close")

    self.item = bg:getChildByName("item")
    self.item:setVisible(false)
    self.listview = bg:getChildByName("Panel_bg"):getChildByName("ListView")
    self.mjoin = bg:getChildByName("btn_play_now")
    self.size = self.listview:getContentSize()
end
function helplayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
end
function helplayer:infoRule()
    local item = self.item:clone()
    item:setVisible(true)
    --content
    local content = cc.Label:create()
    content:setAnchorPoint(0,0)
    content:setColor(cc.c3b(83,82,81))
    content:setSystemFontSize(20)
    content:setPosition(2,5)
    content:setWidth(self.size.width)
    local text1="1、黑白双方轮流下棋，最先在棋盘横向、竖向、斜向形成连续的相同色五个棋子的一方为胜。"
    local text2="\n2、每日设立排行榜，统计最快获胜的玩家"
    content:setString(text1..text2)
    item:addChild(content)
    --title
    local contentSize = content:getContentSize()
    local title = cc.Label:create()
    title:setString("游戏规则")
    title:setAnchorPoint(0,0)
    title:setColor(cc.c3b(181,0,0))
    title:setSystemFontSize(28)
    title:setPosition(2,5+contentSize.height+10)
    item:addChild(title)

    item:setContentSize(cc.size(self.size.width,5+contentSize.height+10+35))
    self.listview:pushBackCustomItem(item)
end
function helplayer:getActivityData()
    local activityList = GameActivityPB_pb.PBGameActivty_Params()
    activityList.ishome = 0
    activityList.gameid = 10
    local flag,getReturn = HttpManager.post("http://lxgame.lexun.com/interface/gameactivity.aspx",activityList:SerializeToString())
    if not flag then return end
    local obj=GameActivityPB_pb.PBGameActivity()
    obj:ParseFromString(getReturn)
    dump(obj)
    if obj.acname=="" then return end
    local item = self.item:clone()
    item:setVisible(true)
    --button
    local mJoin = self.mjoin:clone()
    mJoin:setAnchorPoint(0.5,0)
    mJoin:setPosition(self.size.width*0.5,5)
    item:addChild(mJoin)
    local function joingame(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:getParent():getApp():enterScene("FiveChessView")
        end
    end
    mJoin:setTouchEnabled(true)
    mJoin:setVisible(true)
    mJoin:addTouchEventListener(joingame)
    local joinSize = mJoin:getContentSize()
    local content = cc.Label:create()
    content:setAnchorPoint(0,0)
    content:setColor(cc.c3b(83,82,81))
    content:setSystemFontSize(20)
    content:setPosition(2,5+joinSize.height+20)
    content:setWidth(self.size.width)
    content:setString("活动："..obj.conditionname.."\n条件："..obj.conditiondesc.."\n奖励："..obj.awarddesc.."\n说明："..obj.remark)
    item:addChild(content)
    --title
    local contentSize = content:getContentSize()
    local title = cc.Label:create()
    title:setString(obj.acname)
    title:setAnchorPoint(0,0)
    title:setColor(cc.c3b(181,0,0))
    title:setSystemFontSize(28)
    title:setPosition(2,5+joinSize.height+20+contentSize.height+10)
    item:addChild(title)
    --line
    local titleSize = title:getContentSize()
    local line = cc.Sprite:create()
    line:setAnchorPoint(0,0)
    line:setTextureRect(cc.rect(0,0,self.size.width,2))
	line:setColor(cc.c3b(255,255,255))
	line:setPosition(0,5+joinSize.height+20+contentSize.height+10+titleSize.height+15)
	item:addChild(line)


    item:setContentSize(cc.size(self.size.width,5+joinSize.height+20+contentSize.height+10+titleSize.height+15))
    self.listview:pushBackCustomItem(item)
end
return helplayer