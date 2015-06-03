local GameView = import(".GameView")
local Levels = import(".Levels")

local CrazyBlockScene = class("CrazyBlockScene",cc.load("mvc").ViewBase)

local winSize = cc.Director:getInstance():getWinSize()
function CrazyBlockScene:onCreate()
	self:infohomeCSB()
	self:infohomeTouch()
end
function CrazyBlockScene:infohomeCSB()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("ChineseBlock/fangkuai.plist")
    self:createResoueceNode("ChineseBlock/home.csb") 
    local CSB =self.resourceNode_
    local btnPanel = CSB:getChildByName("bg")
    self.btn_start = btnPanel:getChildByName("btn_start")
    self.btn_home = btnPanel:getChildByName("btn_home")
    self.btn_teach = btnPanel:getChildByName("btn_teach")
    self.btn_help =  btnPanel:getChildByName("bottom_list_btn"):getChildByName("help")
    self.ranking = btnPanel:getChildByName("bottom_list_btn"):getChildByName("ranking")
    self.chat = btnPanel:getChildByName("bottom_list_btn"):getChildByName("chat")
    self.forum = btnPanel:getChildByName("bottom_list_btn"):getChildByName("forum")
end

function CrazyBlockScene:getLevelNum()
	return table.maxn(Levels)
end

function CrazyBlockScene:getLevelData(level)
	return Levels[level]
end

function CrazyBlockScene:getLevelState(level)
	if not self.levelStates then
		self.levelStates = {}
	end
	local levelState = self.levelStates[level]
	if not levelState and Levels[level] then
		levelState = {level = level, star = 0, isLocked = true}
		if level == 1 then
			levelState.isLocked = false
		end
		self.levelStates[level] = levelState
	end
	return levelState
end

function CrazyBlockScene:enterGameMainView()
      local CrazyBlockScene = require("src.app.ChineseBlock.CrazyBlockScene").new()
      cc.Director:getInstance():replaceScene(CrazyBlockScene)
end

function CrazyBlockScene:infohomeTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then		
			require("app.MyApp"):create():run()
		end
	end
	self.btn_home:addTouchEventListener(backCallback)
	local function gameStart(sender,eventType)
		if eventType == ccui.TouchEventType.ended then

--		local levelReturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/levellist.aspx")
--	    local level=GamePB_pb.PBCrazywordsLevelsList()
--	    level:ParseFromString(levelReturn)
--	    local wordReturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/textlist.aspx")
--	    local word=GamePB_pb.PBCrazywordsWordsList()
--	    word:ParseFromString(wordReturn)
			--游戏开始

        self:getApp():enterScene("GameView")
        end
	end
	self.btn_start:addTouchEventListener(gameStart)
    local function gameTeachStart(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
        self:getApp():enterScene("TeachView")
        end
	end
	self.btn_teach:addTouchEventListener(gameTeachStart)
	local function gameHelp(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏帮助
			local gamelayer = require("app.ChineseBlock.helplayer").new()
			self:addChild(gamelayer)
		end
	end
	self.btn_help:addTouchEventListener(gameHelp)
	local function gameRank(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏排行
			local gamelayer = require("app.ChineseBlock.ranklayer").new()
			self:addChild(gamelayer)
		end
	end
	self.ranking:addTouchEventListener(gameRank)
	local function gameMessage(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--游戏聊天
			native.showPage("http://clubc.lexun.com/crazywords-fee/chatlist.aspx")
		end
	end
	self.chat:addTouchEventListener(gameMessage)
	local function gameTalk(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showPage("http://f3.lexun.com/touch/list.php?bid=27082&vs=2")
			--游戏论坛
		end
	end
	self.forum:addTouchEventListener(gameTalk)
end
return CrazyBlockScene