local FoundWordscene = class("FoundWordscene",cc.load("mvc").ViewBase)
function FoundWordscene:onCreate()
	self:infohomeCSB()
	self:infohomeTouch()
end
function FoundWordscene:infohomeCSB()
    self:createResoueceNode("FoundWord/home.csb")
    local CSB=self.resourceNode_
    local btnPanel = CSB:getChildByName("bg"):getChildByName("panel_btn")
    self.btn_start = btnPanel:getChildByName("btn_start")
    self.btn_help = btnPanel:getChildByName("panel_help"):getChildByName("btn_help")
    self.btn_top = btnPanel:getChildByName("panel_top"):getChildByName("btn_top")
    self.btn_message = btnPanel:getChildByName("panel_message"):getChildByName("btn_message")
    self.btn_talk = btnPanel:getChildByName("panel_talk"):getChildByName("btn_talk")
    self.btn_home =  CSB:getChildByName("bg"):getChildByName("btn_home")
end
function FoundWordscene:infohomeTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then	
			self:getApp():enterScene("MainScene")
		end
	end
	self.btn_home:addTouchEventListener(backCallback)
	local function gameStart(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("foundwordgamelayer")
		end
	end
	self.btn_start:addTouchEventListener(gameStart)
	local function gameHelp(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏帮助
			local gamelayer = require("app.FoundWord.helplayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_help:addTouchEventListener(gameHelp)
	local function gameRank(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏排行
			local gamelayer = require("app.FoundWord.ranklayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_top:addTouchEventListener(gameRank)
	local function gameMessage(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏聊天
			native.showPage("http://clubc.lexun.com/crazywords-fee/chatlist.aspx")
		end
	end
	self.btn_message:addTouchEventListener(gameMessage)
	local function gameTalk(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showPage("http://f2.lexun.com/list.php?bid=27082")
			--游戏论坛
		end
	end
	self.btn_talk:addTouchEventListener(gameTalk)
end
return FoundWordscene