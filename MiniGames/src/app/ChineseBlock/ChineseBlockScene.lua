local SelectLevelView = import(".SelectLevelView")
local GameView = import(".GameView")
local Levels = import(".Levels")

cc.FileUtils:getInstance():addSearchPath("res/ChineseBlock")

local ChineseBlockScene = class("ChineseBlockScene", 
	function()
		return cc.Scene:create()
	end)

ChineseBlockScene.EVENTS = {
	QUIT = "QUIT"
}

function ChineseBlockScene:ctor()
	cc.bind(self, "event")

	self:enterLevelSelectView(1)
end

function ChineseBlockScene:getLevelNum()
	return table.maxn(Levels)
end

function ChineseBlockScene:getLevelData(level)
	return Levels[level]
end

function ChineseBlockScene:getLevelState(level)
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

function ChineseBlockScene:saveLevelState(levelState)
	if not self.levelStates then
		self.levelStates = {}
	end
	self.levelStates[levelState.level] = levelState
end

function ChineseBlockScene:unLockLevel(level)
	local levelState = self:getLevelState(level)
	if levelState then
		levelState.isLocked = false
		self:saveLevelState(levelState)
	end
end

function ChineseBlockScene:enterLevelSelectView(page)
	if self.view then
		self:removeChild(self.view)
	end
	local total = self:getLevelNum()
	local pageSize = SelectLevelView.PAGE_SIZE
	if not page or (page - 1) * pageSize + 1 > total then
		page = 1
	end
	local startIdx, endIdx = (page - 1) * pageSize + 1, page * pageSize
	local levelStates = {}
	for i = startIdx, endIdx do
		table.insert(levelStates, self:getLevelState(i))
	end
	self.view = SelectLevelView:create({levelStates = levelStates, page = page, total = total})
	self.view:addEventListener(SelectLevelView.EVENTS.SELECTED, function(event) 
			self:enterGameView(event.levelState.level)
		end)
	self.view:addEventListener(SelectLevelView.EVENTS.PAGE, function(event) 
			self:enterLevelSelectView(event.page)
		end)
	self.view:addEventListener(SelectLevelView.EVENTS.QUIT, function(event) 
			self:dispatchEvent({name = ChineseBlockScene.EVENTS.QUIT})
		end)
	self:addChild(self.view)
end

function ChineseBlockScene:enterGameView(level)
	if self.view then
		self:removeChild(self.view)
	end
	local levelState = self:getLevelState(level)
	local levelData = self:getLevelData(level)
	self.view = GameView:create({levelState = levelState, levelData = levelData})
	self.view:addEventListener(GameView.EVENTS.QUIT, function(event) 
			self:enterLevelSelectView() 
		end)
	self.view:addEventListener(GameView.EVENTS.REFRESH, function(event) 
			self:enterGameView(event.levelState.level)
		end)
	self.view:addEventListener(GameView.EVENTS.FINISH, function(event)
			self:saveLevelState(event.levelState)
			self:unLockLevel(event.levelState.level + 1)
			self.view:enableNext()
		end)
	self.view:addEventListener(GameView.EVENTS.NEXT, function(event)
			local nextLevelState = self:getLevelState(event.levelState.level + 1)
			if nextLevelState then
				self:enterGameView(nextLevelState.level)
			else
				self:enterLevelSelectView() 
			end
		end)
	self:addChild(self.view)
end

return ChineseBlockScene