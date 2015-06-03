local SuperDyeScene = class("SuperDyeScene",cc.load("mvc").ViewBase)
function SuperDyeScene:onCreate()
	self:infoCSB()
	self:infoTouch()
end
function SuperDyeScene:infoCSB()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("SuperDye/super_magic.plist")
    self:createResoueceNode("SuperDye/index.csb")
    local CSB=self.resourceNode_
    local btnPanel = CSB:getChildByName("pl_btn")
    self.btn_help = btnPanel:getChildByName("pl_help")
    self.btn_top = btnPanel:getChildByName("pl_paihang")
    self.btn_chat = btnPanel:getChildByName("pl_chat")
    self.btn_forum = btnPanel:getChildByName("pl_forum")

    self.btn_home =  CSB:getChildByName("btn_home")
    self.btn_begin = CSB:getChildByName("btn_playgame")
end
function SuperDyeScene:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then	
			self:getApp():enterScene("MainScene")
		end
	end
	self.btn_home:addTouchEventListener(backCallback)
	local function gameStart(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("dyegamelayer")
		end
	end
	self.btn_begin:addTouchEventListener(gameStart)
	local function gameHelp(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏帮助
			local gamelayer = require("app.SuperDye.helplayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_help:addTouchEventListener(gameHelp)
	local function gameRank(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏排行
			local gamelayer = require("app.SuperDye.ranklayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_top:addTouchEventListener(gameRank)
	local function gameMessage(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏聊天
			--native.showPage("http://clubc.lexun.com/crazywords-fee/chatlist.aspx")
		end
	end
	self.btn_chat:addTouchEventListener(gameMessage)
	local function gameTalk(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showPage("http://f.lexun.com/list.php?bid=27082")
			--游戏论坛
		end
	end
	self.btn_forum:addTouchEventListener(gameTalk)
end
return SuperDyeScene