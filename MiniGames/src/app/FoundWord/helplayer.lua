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
	local CSB = cc.CSLoader:createNode("FoundWord/game_help.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_close = bg:getChildByName("btn_close")
    self.item = bg:getChildByName("ItemPanel")
    self.item:setVisible(false)
    self.listview = bg:getChildByName("ListView")
    self.mjoin = bg:getChildByName("btn_join")
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
    content:setColor(cc.c3b(157,93,32))
    content:setSystemFontSize(26)
    content:setPosition(2,5)
    content:setWidth(self.size.width)
    local text1="1、完全开放给登录用户和游客，每天游戏次数无上限"
    local text2="\n2、本游戏总关卡30关，系统按顺序在每一关设置趣味题，越往后越难。限时2分钟内结束内结束"
    content:setString(text1..text2)
    item:addChild(content)
    --title
    local contentSize = content:getContentSize()
    local title = cc.Label:create()
    title:setString("游戏规则")
    title:setAnchorPoint(0,0)
    title:setColor(cc.c3b(190,142,22))
    title:setSystemFontSize(30)
    title:setPosition(2,5+contentSize.height+10)
    item:addChild(title)
    --line，star
    local line = item:getChildByName("line")
    local star = item:getChildByName("star")
    line:setVisible(false)
    star:setVisible(false)
    item:setContentSize(cc.size(self.size.width,5+contentSize.height+10+35))
    self.listview:pushBackCustomItem(item)
end
function helplayer:getActivityData()
    local activityList = GameActivityPB_pb.PBGameActivty_Params()
    activityList.ishome = 0
    activityList.gameid = 1
    local flag,getReturn = HttpManager.post("http://lxgame.lexun.com/interface/gameactivity.aspx",activityList:SerializeToString())
    if not flag then return end
    local obj=GameActivityPB_pb.PBGameActivity()
    obj:ParseFromString(getReturn)
    dump(obj)
    if not obj.acrid then return end
    local item = self.item:clone()
    item:setVisible(true)
    --button
    local mJoin = self.mjoin:clone()
    mJoin:setAnchorPoint(0.5,0)
    mJoin:setPosition(self.size.width*0.5,5)
    item:addChild(mJoin)
    local function joingame(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:getParent():getApp():enterScene("foundwordgamelayer")
        end
    end
    mJoin:setTouchEnabled(true)
    mJoin:setVisible(true)
    mJoin:addTouchEventListener(joingame)
    local joinSize = mJoin:getContentSize()
    local jointext = cc.Sprite:createWithSpriteFrameName("text_play_now_cz.png")
    mJoin:addChild(jointext)
    jointext:setPosition(joinSize.width*0.5,joinSize.height*0.5)
    --content
    local content = cc.Label:create()
    content:setAnchorPoint(0,0)
    content:setColor(cc.c3b(157,93,32))
    content:setSystemFontSize(26)
    content:setPosition(2,5+joinSize.height+20)
    content:setWidth(self.size.width)
    content:setString("活动："..obj.conditionname.."\n条件："..obj.conditiondesc.."\n奖励："..obj.awarddesc.."\n说明："..obj.remark)
    item:addChild(content)
    --title
    local contentSize = content:getContentSize()
    local title = cc.Label:create()
    title:setString(obj.acname)
    title:setAnchorPoint(0,0)
    title:setColor(cc.c3b(190,142,22))
    title:setSystemFontSize(30)
    title:setPosition(2,5+joinSize.height+20+contentSize.height+10)
    item:addChild(title)
    --line and str
    local titleSize = title:getContentSize()
    local line = item:getChildByName("line")
    local star = item:getChildByName("star")
    local lineX,lineY = line:getPosition()
    local starX,starY = star:getPosition()
    star:setPosition(starX,5+joinSize.height+20+contentSize.height+10+titleSize.height+10)
    line:setPosition(lineX,5+joinSize.height+20+contentSize.height+10+titleSize.height+25)

    item:setContentSize(cc.size(self.size.width,5+joinSize.height+20+contentSize.height+10+titleSize.height+25))
    self.listview:pushBackCustomItem(item)
end
return helplayer