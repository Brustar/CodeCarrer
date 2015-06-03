local CrazyCatScene = class("CrazyCatScene", cc.load("mvc").ViewBase)
function CrazyCatScene:onCreate()
	self:infoSCB()
	self:infoTouch()
end
function CrazyCatScene:infoSCB()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("CrazyCat/crazy_cat.plist")
    self:createResoueceNode("CrazyCat/Home.csb")
    local CSB=self.resourceNode_
    local root = CSB:getChildByName("root")
    self.btn_home = root:getChildByName("btn_home")
    self.btn_play = root:getChildByName("btn_play")
    local panel_btn = root:getChildByName("panel_btn")
    self.help_btn = panel_btn:getChildByName("panel_help"):getChildByName("btn_help")
    self.rank_btn = panel_btn:getChildByName("panel_rick"):getChildByName("btn_rick")
    self.message_btn = panel_btn:getChildByName("panel_message"):getChildByName("btn_message")
    self.talk_btn = panel_btn:getChildByName("panel_talk"):getChildByName("btn_talk")
end
function CrazyCatScene:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("MainScene")
		end
	end
	self.btn_home:addTouchEventListener(backCallback)
	local function playCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--开始游戏
			self:getApp():enterScene("CrazyCatLayer")
		end
	end
	self.btn_play:addTouchEventListener(playCallback)
	local function gameHelp(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏帮助
			local gamelayer = require("app.CrazyCat.helplayer").new()
			self:addChild(gamelayer)
		end
	end
	self.help_btn:addTouchEventListener(gameHelp)
	local function gameRank(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏排行
			local gamelayer = require("app.CrazyCat.ranklayer").new()
			self:addChild(gamelayer)
		end
	end
	self.rank_btn:addTouchEventListener(gameRank)
	local function gameMessage(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏聊天
			native.showPage("http://clubc.lexun.com/surroundcat/chatlist.aspx")
		end
	end
	self.message_btn:addTouchEventListener(gameMessage)
	local function gameTalk(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showPage("http://f.lexun.com/list.php?bid=27082")
			--游戏论坛
		end
	end
	self.talk_btn:addTouchEventListener(gameTalk)
end   
return CrazyCatScene