--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/11
--此文件由[BabeLua]插件自动生成
local Levels = import(".Levels")
local TeachView = class("TeachView",cc.load("mvc").ViewBase)
local Times = 1
TeachView.EVENTS = {
	QUIT = "QUIT",
	REFRESH = "REFRESH",
	FINISH = "FINISH",
	NEXT = "NEXT",
}

TeachView.click = "TeachViewClick" --控制五子棋音效的开关

function TeachView:onCreate()
    cc.bind(self, "event")	
    self.data ={}
    local levelState = self:getLevelState(1)
	local levelData = self:getLevelData(1)
	self.data.levelState=levelState
    self.data.levelData=levelData
	self.time = 0
	self.deltaTime = 0
	self.isFinished = false
    self.foot = 0
    self.level=1
    self.star =0

    self:createResoueceNode("ChineseBlock/teach.csb")

    local CSB =self.resourceNode_
    local btnPanel = CSB:getChildByName("bg")
    local game = btnPanel:getChildByName("game")
    local title=btnPanel:getChildByName("title")
    self.head= title

    local level_bg=title:getChildByName("level_bg")
    self.text_level=level_bg:getChildByName("text_level")
    self.level_num1=level_bg:getChildByName("level_num")
    self.level_num1:setVisible(false)

    self.level_num = ccui.TextAtlas:create()
    self.level_num:setProperty("1", "ChineseBlock/level_num.png", 20, 31, ".")
    self.level_num:setPosition(self.level_num1:getPosition()) 
    self.level_num:setColor(cc.c3b(185,122,87)); 
    level_bg:addChild(self.level_num)

    local title_btn=title:getChildByName("title_btn")
    self.btn_black=title_btn:getChildByName("btn_black")
    self.btn_open_sound=title_btn:getChildByName("btn_open_sound")
    self.btn_close_sound=title_btn:getChildByName("btn_close_sound")

    local title_record = title:getChildByName("title_record")
    self.img_time=title_record:getChildByName("img_time")
    self.img_star=title_record:getChildByName("img_star")
    self.img_foot=title_record:getChildByName("img_foot")

    self.num_time1=title_record:getChildByName("num_time")
    self.num_star1=title_record:getChildByName("num_star")
    self.num_foot1=title_record:getChildByName("num_foot")

    self.num_time1:setVisible(false)
    self.num_star1:setVisible(false)
    self.num_foot1:setVisible(false)

    local size = title_record:getContentSize()

    self.num_time = ccui.TextAtlas:create()
    self.num_time:setProperty("1", "ChineseBlock/level_num.png", 20, 31, ".")
    self.num_time:setPosition(self.num_time1:getPosition())
    self.num_time:setColor(cc.c3b(0,162,232)); 

    self.num_star = ccui.TextAtlas:create()
    self.num_star:setProperty("1", "ChineseBlock/level_num.png", 20, 31, ".")
    self.num_star:setPosition(self.num_star1:getPosition())
    self.num_star:setColor(cc.c3b(255,128,64));   

    self.num_foot = ccui.TextAtlas:create()
    self.num_foot:setProperty("1", "ChineseBlock/level_num.png", 20, 31, ".")
    self.num_foot:setPosition(self.num_foot1:getPosition())
    self.num_foot:setColor(cc.c3b(0,255,0));     

    title_record:addChild(self.num_time)
    title_record:addChild(self.num_star)
    title_record:addChild(self.num_foot)

    local game_bg = game:getChildByName("game_bg")

    local body = cc.Node:create():setContentSize(600, 600):setAnchorPoint(0, 0):setPosition(4, 5):setScale(1)
    game_bg:addChild(body)
    self.body = body
    self.row_bg = title_record:getChildByName("row_bg")
    self.row_bg_0 = title_record:getChildByName("row_bg_0")
    self.row_bg_1 = title_record:getChildByName("row_bg_1")
    self.row_bg_2 = title_record:getChildByName("row_bg_2")
    self.row_bg_0 = title_record:getChildByName("row_bg_0")
    self.row_bg_0 = title_record:getChildByName("row_bg_0")

    local game_block = game:getChildByName("game_block")
    self.img_block_dark = game_block:getChildByName("img_block_dark")
    self.img_blocks_tinge = game_block:getChildByName("img_blocks_tinge")
    self.img_block_dark_v =  game_block:getChildByName("img_block_dark_v")
    self.img_blocks_tinge_v = game_block:getChildByName("img_blocks_tinge_v")
    self.img_blocks_mid = game_block:getChildByName("img_blocks_mid")

    self.img_block_dark:setVisible(false)
    self.img_blocks_tinge:setVisible(false)
    self.img_block_dark_v:setVisible(false)
    self.img_blocks_tinge_v:setVisible(false)
    self.img_blocks_mid:setVisible(false)

    self:infoTouch()  
	self:initHead()
	self:initFoot()
	self:initBody()
    self:countdownBegin()

    self.num_star:setString(0)
    self.num_foot:setString(0)
    self:addTouchListenerForBody()
    self.coststarttime=120
end

function TeachView:reInitialInterFace()
    self.num_star:setString(self.star)
    self.level_num:setString(self.level)
	self:initBody()
end

function TeachView:getLevelNum()
	return table.maxn(Levels)
end

function TeachView:getLevelData(level)
	return Levels[level]
end

function TeachView:getLevelState(level)
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

function TeachView:initHead()
	local levelState = self.data.levelState
	local headSize = self.head:getContentSize()

	self:createLevelStarSprite(levelState.star)
	self:createTimerSprite(self.time)
end

function TeachView:createLevelStarSprite(star)
    self.num_star:setString(star)
    self.num_foot:setString(self.foot)
    self.level_num:setString(self.level)
end

function TeachView:createTimerSprite(time)
    self.num_time:setString(time)
end

function TeachView:initFoot()
	local levelState = self.data.levelState
end

function TeachView:initBody()
	local levelData = self.data.levelData

	local exitSprite = cc.Sprite:create():setTextureRect(cc.rect(0, 0,  100, 100))
	exitSprite:setAnchorPoint(0, 0)
	exitSprite:setPosition((levelData.exit.x - 1) * 100, (levelData.exit.y - 1) * 100)
    exitSprite:setVisible(false)
	self.body:addChild(exitSprite)
	self.exit = exitSprite

	self.blocks = {}
	for i, block in ipairs(levelData.blocks) do
		local blockSprite = cc.Sprite:create()
		if block.cate == 1 then
			if block.len == 2 then
                blockSprite:setSpriteFrame("icon_block03.png")
                --blockSprite:setColor(cc.c3b(0,128,0));
			end
		elseif block.cate == 2 then
			if block.len == 2 then
				if block.rotation == 0 then
                    blockSprite:setSpriteFrame("icon_block04.png")
                     blockSprite:setAnchorPoint(0, 0)
				else
					blockSprite:setSpriteFrame("icon_block05.png")
				end
			elseif block.len == 3 then
				if block.rotation == 0 then
                    blockSprite:setSpriteFrame("icon_blocks01.png")
				else
                    blockSprite:setSpriteFrame("icon_blocks_vs.png") 
				end
			end
		end
        blockSprite:setAnchorPoint(0, 0)
		blockSprite:setPosition((block.x - 1) * (96 + 2), (block.y - 1) * (96 + 4))
		self.body:addChild(blockSprite)
		self.blocks[i] = blockSprite
		blockSprite.model = block
	end

end

function TeachView:addTouchListenerForBody()
    -- 触摸开始
    local function onTouchBegan(touch, event)
    	local result = false
		if not self.isFinished then
			self.targetBlock = nil
	        local touchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
	        for _, block in ipairs(self.blocks) do
	    		if cc.rectContainsPoint(block:getBoundingBox(), touchPoint) then
					self.targetBlock = block
                    self.BegainposX = self.targetBlock:getPositionX()
	                self.BegainposY = self.targetBlock:getPositionY()
					result = true
					break
				end
	    	end
	    	self.lastTouchPoint = touchPoint
		end
        return result                     -- 必须返回true 后边move end才会被处理
    end
    -- 触摸移动
    local function onTouchMoved(touch, event)
		local touchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
		local offsetX = 0
		local offsetY = 0
    	if self.targetBlock.model.rotation == 0 then
    		offsetX = touchPoint.x - self.lastTouchPoint.x
		else
			offsetY = touchPoint.y - self.lastTouchPoint.y
		end
		local targetRect = self.targetBlock:getBoundingBox()
		targetRect.x = targetRect.x + offsetX
		targetRect.y = targetRect.y + offsetY
		if cc.rectGetMinX(targetRect) < 0 or cc.rectGetMaxX(targetRect) > 6 * 100 then
			targetRect.x = targetRect.x - offsetX
		end
		if cc.rectGetMinY(targetRect) < 0 or cc.rectGetMaxY(targetRect) > 6 * 100 then
			targetRect.y = targetRect.y - offsetY
		end
        for _, block in ipairs(self.blocks) do
        	if block ~= self.targetBlock then
	        	local intersection = cc.rectIntersection(targetRect, block:getBoundingBox())
	    		if intersection.width > 0 and intersection.height > 0 then
	    			if offsetX > 0 then
						targetRect.x = targetRect.x - intersection.width
					elseif offsetX < 0 then
						targetRect.x = targetRect.x + intersection.width
    				end
	    			if offsetY > 0 then
						targetRect.y = targetRect.y - intersection.height
					elseif offsetY < 0 then
						targetRect.y = targetRect.y + intersection.height
    				end
				end
    		end
    	end
		self.targetBlock:setPosition(targetRect.x, targetRect.y)
		self.lastTouchPoint = touchPoint
    end
    -- 触摸结束
    local function onTouchEnded(touch, event)
        self:adjustBlockPosition(self.targetBlock)
        if self.targetBlock.model.cate == 1 then
        	local intersection = cc.rectIntersection(self.targetBlock:getBoundingBox(), self.exit:getBoundingBox())
        	if intersection.width > 0 and intersection.height > 0 then
                self:stopAction(self.countdownaction)
    			self:finishGame()
    		end
    	end
        self.lastTouchPoint = touchPoint
        self.num_foot:setString(self.foot)
    end 
    -- 注册单点触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(listener, self.body)
end

function TeachView:adjustBlockPosition(block)
	local posX = block:getPositionX()
	local posY = block:getPositionY()
	if math.mod(posX, 100) >= 100 / 2 then
		posX = math.ceil(posX / 100) * (96 + 2)
	else
		posX = math.floor(posX / 100) * (96 + 2)
	end
	if math.mod(posY, 100) >= 100 / 2 then
		posY = math.ceil(posY / 100) * (96 + 4)
	else
		posY = math.floor(posY / 100) * (96 + 4)
	end
	block:setPosition(posX, posY)
    if self.BegainposX ~=posX or self.BegainposY ~=posY  then
        self.foot = self.foot +1
    end	                 
end

function TeachView:finishGame()
	self.isFinished = true
    self.costendtime =self.time
    self.getstartime=self.coststarttime-self.costendtime 
	local star = 0
    if self.getstartime <= 30 then
		star = 3
	elseif self.getstartime <= 60 then
		star = 2
	elseif self.getstartime <= 90 then
		star = 1
	end
    self.star = self.star + star
	local levelState = self.data.levelState
	if star > levelState.star then
		levelState.star = star
		self:createLevelStarSprite(levelState.star)
	end

    levelState.level=levelState.level+1
  	self.deltaTime = 0
	self.isFinished = false
    self.coststarttime=self.costendtime
    local total = self:getLevelNum()
    local account ={}
    self.time = 1
    Times = 1
	local finishlayer = require("src.app.ChineseBlock.finishlayer").new(3,self,account)
	self:addChild(finishlayer,10)
end

function TeachView:enableNext()
	print("TeachView:enableNext")
	local nextBtn = self.nextBtn
	nextBtn:setOpacity(255)
	nextBtn:setTouchEnabled(true)
	nextBtn:addClickEventListener(function()
	    self:dispatchEvent({name = TeachView.EVENTS.NEXT, levelState = self.data.levelState})
	end)
	local rotateBy = cc.RotateBy:create(1, -45)
	local nextBtnSprite = nextBtn:getChildByName("sprite")
	nextBtnSprite:runAction(cc.RepeatForever:create(cc.Sequence:create(rotateBy, rotateBy:reverse())))
end

--开始倒计时
function TeachView:countdownBegin()
	self.startTime = os.date("%Y-%m-%d %H:%M:%S")
	self.time = 120
	local delay = cc.DelayTime:create(1)
	local function callback()
		self.time = self.time - 1
        self:createTimerSprite(self.time)
		if self.time == 0 then
			self:stopAction(self.countdownaction)
			local account ={}
			self.time = 1
			Times = 1
			local finishlayer = require("src.app.ChineseBlock.finishlayer").new(1,self,account)
			self:addChild(finishlayer,10)
		end
	end
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self.countdownaction = cc.RepeatForever:create(sequence)
    self:runAction(self.countdownaction)
end

function TeachView:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
            self:createResoueceNode("ChineseBlock/backhome.csb")
            local CSB =self.resourceNode_
    		local dailog_bg = CSB:getChildByName("bg"):getChildByName("window")
    		self.btn_return = dailog_bg:getChildByName("btn_continue")
		    self.btn_close = dailog_bg:getChildByName("btn_back")   
		    self.content = dailog_bg:getChildByName("text_record")
		    self.content:setString(string.format("您已通过%d关",self.data.levelState.level-1))
		    local function onclose(sender,eventType)
		    	if eventType == ccui.TouchEventType.ended then
		    		self:getApp():enterScene("CrazyBlockScene")
		    	end
		    end
		    self.btn_close:addTouchEventListener(onclose)
		    local function onreturn(sender,eventType)
		    	if eventType == ccui.TouchEventType.ended then
		    		CSB:removeFromParent()	    		
		    	end
		    end
		    self.btn_return:addTouchEventListener(onreturn)
		end
	end
	self.btn_black:addTouchEventListener(backCallback)


        --声音按钮
    local judge = cc.UserDefault:getInstance():getStringForKey(TeachView.click)
    if judge == "" or judge == "0" then
       self.btn_open_sound:setVisible(false)
       self.btn_close_sound:setVisible(true)
    else
       self.btn_open_sound:setVisible(true)
       self.btn_close_sound:setVisible(false)
    end
    self.btn_open_sound:addTouchEventListener(handler(self,self.voiceControl))
    self.btn_close_sound:addTouchEventListener(handler(self,self.voiceControl))
end

--五子棋声音控制
function TeachView:voiceControl(sender,eventType)
    if eventType == ccui.TouchEventType.ended then
        --0:开状态 1:关状态
        local judge = cc.UserDefault:getInstance():getStringForKey(TeachView.click)
        if judge == ""then
            judge = "0" 
        end
        if judge == "0" then
          --  self.icon_voice:setOpacity(128)
            self.btn_open_sound:setVisible(false)
            self.btn_close_sound:setVisible(true)
            cc.UserDefault:getInstance():setStringForKey(TeachView.click,"1")
        elseif judge == "1" then
        --    self.icon_voice:setOpacity(255)
            self.btn_open_sound:setVisible(true)
            self.btn_close_sound:setVisible(false)
            cc.UserDefault:getInstance():setStringForKey(TeachView.click,"0")
        end 
    end
end

return TeachView



--endregion
