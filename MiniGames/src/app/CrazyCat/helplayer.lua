local helplayer = class("helplayer",
	function ()
		return cc.Layer:create()
	end)
function helplayer:ctor()
	self:infoCSB()
	self:infoTouch()
	self:infoRule()
	performWithDelay(self, function ()
	   self:getActivityData()
    end,0.001)
end
function helplayer:infoCSB()
	local CSB = cc.CSLoader:createNode("CrazyCat/gamehelp.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("alert_bg"):getChildByName("dailog")
    self.btn_close = bg:getChildByName("btn_close")
    local dialog = bg:getChildByName("dailog_con")
    self.item = dialog:getChildByName("item")
    self.item:setVisible(false)
    self.listview = dialog:getChildByName("ListView")
    self.mjoin = dialog:getChildByName("btn_join")
    self.iconTitle = dialog:getChildByName("con_title")
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
    content:setColor(cc.c3b(0,0,0))
    content:setSystemFontSize(26)
    content:setPosition(2,5)
    content:setWidth(self.size.width)
    local text1 = "1、游戏开始后想办法将图中的那只猫围住，不让它从旁边跑掉；"
	local text2 = "\n2、在游戏开始会有几个随机分布的点亮了的格子；"
	local text3 = "\n3、你需要点一个圈将猫围起来，这时候你会发现猫的姿势会改变；"
    content:setString(text1..text2..text3)
    item:addChild(content)
    --title
    local contentSize = content:getContentSize()
    local titleIcon = self.iconTitle:clone()
    titleIcon:setVisible(true)
    titleIcon:setPosition(2,5+contentSize.height+10)
    item:addChild(titleIcon)
    local iconSize = titleIcon:getContentSize()
    local title = cc.Label:create()
    title:setString("游戏规则")
    title:setAnchorPoint(0.5,0.5)
    title:setColor(cc.c3b(255,255,255))
    title:setSystemFontSize(28)
    title:setPosition(iconSize.width*0.5,iconSize.height*0.5)
    titleIcon:addChild(title)
    --line
    local line = item:getChildByName("line")
    line:setVisible(false)
    item:setContentSize(cc.size(self.size.width,5+contentSize.height+10+iconSize.height))
    self.listview:pushBackCustomItem(item)
end
function helplayer:getActivityData()
    local activityList = GameActivityPB_pb.PBGameActivty_Params()
    activityList.ishome = 0
    activityList.gameid = 3
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
            self:getParent():getApp():enterScene("CrazyCatLayer")
        end
    end
    mJoin:setTouchEnabled(true)
    mJoin:setVisible(true)
    mJoin:addTouchEventListener(joingame)
    local joinSize = mJoin:getContentSize()
    local content = cc.Label:create()
    content:setAnchorPoint(0,0)
    content:setColor(cc.c3b(0,0,0))
    content:setSystemFontSize(26)
    content:setPosition(2,5+joinSize.height+20)
    content:setWidth(self.size.width)
    content:setString("活动："..obj.conditionname.."\n条件："..obj.conditiondesc.."\n奖励："..obj.awarddesc.."\n说明："..obj.remark)
    item:addChild(content)
    --title
    local contentSize = content:getContentSize()
    local titleIcon = self.iconTitle:clone()
    titleIcon:setVisible(true)
    titleIcon:setPosition(2,5+joinSize.height+20+contentSize.height+10)
    item:addChild(titleIcon)
    local iconSize = titleIcon:getContentSize()
    local title = cc.Label:create()
    title:setString(obj.acname)
    title:setAnchorPoint(0.5,0.5)
    title:setColor(cc.c3b(255,255,255))
    title:setSystemFontSize(28)
    title:setPosition(iconSize.width*0.5,iconSize.height*0.5)
    titleIcon:addChild(title)
    --line
    local titleSize = titleIcon:getContentSize()
    local line = item:getChildByName("line")
	line:setPosition(0,5+joinSize.height+20+contentSize.height+10+titleSize.height+15)

    item:setContentSize(cc.size(self.size.width,5+joinSize.height+20+contentSize.height+10+titleSize.height+15))
    self.listview:pushBackCustomItem(item)
end
return helplayer