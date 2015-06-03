local BubbleScene = class("BubbleScene",cc.load("mvc").ViewBase)
function BubbleScene:onCreate()
	self:infoCSB()
	self:infoTouch()
end

function BubbleScene:infoCSB()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("Bubble/popo.plist","Bubble/popo.png")
    local simInstance = cc.SimpleAudioEngine:getInstance()
    simInstance:preloadEffect("Bubble/audio/clickdown.mp3")--加载游戏背景音乐和音效
    simInstance:preloadEffect("Bubble/audio/finally.mp3")
    simInstance:preloadEffect("Bubble/audio/four.mp3")
    simInstance:preloadMusic("Bubble/audio/music.mp3")
    simInstance:preloadEffect("Bubble/audio/seven.mp3")
    simInstance:preloadEffect("Bubble/audio/three.mp3")
    simInstance:preloadEffect("Bubble/audio/touchdu.mp3")
    simInstance:preloadEffect("Bubble/audio/boom.mp3")
    self:createResoueceNode("Bubble/index.csb")
    local CSB=self.resourceNode_
    local bg = CSB:getChildByName("root") 
    local btnPanel = bg:getChildByName("pl_btn")
    self.btn_help = btnPanel:getChildByName("pl_btn_help")
    self.btn_top = btnPanel:getChildByName("pl_btn_paihang")
    self.btn_chat = btnPanel:getChildByName("pl_chat")
    self.btn_forum = btnPanel:getChildByName("pl_forum")

    self.btn_home =  bg:getChildByName("pl_btn_home")
    self.btn_begin = bg:getChildByName("btn_playgame")
end
function BubbleScene:infoTouch()
	local function backCallback(sender,eventType)
   
		if eventType == ccui.TouchEventType.ended then	
			self:getApp():enterScene("MainScene")
		end
	end
	self.btn_home:addTouchEventListener(backCallback)
	local function gameStart(sender,eventType)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/clickdown.mp3",false)
		if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("BubbleNoteScene")
		end
	end
	self.btn_begin:addTouchEventListener(gameStart)
	local function gameHelp(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
        -- 游戏帮助
			local helpLayer = require("app.Bubble.BubbleHelpLayer").new()
            self:addChild(helpLayer)
		end
	end
	self.btn_help:addTouchEventListener(gameHelp)
	local function gameRank(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏排行
            local rankLayer = require("app.Bubble.BubbleRankLayer").new()
            self:addChild(rankLayer)
		end
	end
	self.btn_top:addTouchEventListener(gameRank)
	local function gameMessage(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏聊天
			native.showPage("http://act.lexun.com/balloonbang/chatlist.php")
		end
	end
	self.btn_chat:addTouchEventListener(gameMessage)
	local function gameTalk(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showPage("http://act.lexun.com/balloonbang/chatlist.php")
			--游戏论坛
		end
	end
	self.btn_forum:addTouchEventListener(gameTalk)
end
return BubbleScene