--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/12
--此文件由[BabeLua]插件自动生成
local FlyMoreScene = class("FlyMoreScene",cc.load("mvc").ViewBase)
function FlyMoreScene:onCreate()
	self:infohomeCSB()
	self:infohomeTouch()
end
function FlyMoreScene:infohomeCSB()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("FlyMore/Plist.plist")
    self:createResoueceNode("FlyMore/index.csb")
    local CSB=self.resourceNode_
    local blue_bg = CSB:getChildByName("blue_bg")
    self.btn_play = blue_bg:getChildByName("start_center"):getChildByName("btn_play")
    self.btn_help = blue_bg:getChildByName("btn_panel"):getChildByName("btn_help")
    self.btn_rank = blue_bg:getChildByName("btn_panel"):getChildByName("btn_rank")
    self.btn_chat = blue_bg:getChildByName("btn_panel"):getChildByName("btn_chat")
    self.btn_group = blue_bg:getChildByName("btn_panel"):getChildByName("btn_group")
    self.btn_home = blue_bg:getChildByName("btn_home")
end
function FlyMoreScene:infohomeTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then	
			self:getApp():enterScene("MainScene")
		end
	end
	self.btn_home:addTouchEventListener(backCallback)
	local function gameStart(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("GameViewFly")
		end
	end
	self.btn_play:addTouchEventListener(gameStart)
	local function gameHelp(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏帮助
			local gamelayer = require("app.FlyMore.views.helplayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_help:addTouchEventListener(gameHelp)
	local function gameRank(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏排行
			local gamelayer = require("app.FlyMore.views.ranklayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_rank:addTouchEventListener(gameRank)
	local function gameMessage(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏聊天
			native.showPage("http://clubc.lexun.com/crazywords-fee/chatlist.aspx")
		end
	end
	self.btn_chat:addTouchEventListener(gameMessage)
	local function gameTalk(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showPage("http://f2.lexun.com/list.php?bid=27082")
			--游戏论坛
		end
	end
	self.btn_group:addTouchEventListener(gameTalk)
end
return FlyMoreScene


--endregion
