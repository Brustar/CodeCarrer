local Levels = import(".Levels")
local GameView = class("GameView",cc.load("mvc").ViewBase)
local Times = 1
GameView.EVENTS = {
	QUIT = "QUIT",
	REFRESH = "REFRESH",
	FINISH = "FINISH",
	NEXT = "NEXT",
}

GameView.click = "GameViewClick" --控制五子棋音效的开关

function GameView:onCreate()
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

    self:createResoueceNode("ChineseBlock/game.csb")
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
    self.level_num:setProperty("0", "ChineseBlock/level_num.png", 20, 31, ".")
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

    local body = cc.Node:create():setContentSize(614, 615):setAnchorPoint(0, 0):setPosition(10,10):setScale(1)
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

function GameView:reInitialInterFace()
    self.num_star:setString(self.star)
    self.level_num:setString(self.level-1)
    self.num_foot:setString(self.foot)
	self:initBody()
end

function GameView:getLevelNum()
	return table.maxn(Levels)
end

function GameView:getLevelData(level)
	return Levels[level]
end

function GameView:getLevelState(level)
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

function GameView:initHead()
	local levelState = self.data.levelState
	local headSize = self.head:getContentSize()

	self:createLevelStarSprite(levelState.star)
	self:createTimerSprite(self.time)
end

function GameView:createLevelStarSprite(star)
    self.num_star:setString(star)
    self.num_foot:setString(self.foot)
    self.level_num:setString(self.level-1)
end

function GameView:createTimerSprite(time)
    self.num_time:setString(time)
end

function GameView:initFoot()
	local levelState = self.data.levelState
end

function GameView:initBody()
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
                blockSprite:setSpriteFrame("icon_block.png")
			end
		elseif block.cate == 2 then
			if block.len == 2 then
				if block.rotation == 0 then
                    blockSprite:setSpriteFrame("icon_block07.png")
                     blockSprite:setAnchorPoint(0, 0)
				else
					blockSprite:setSpriteFrame("icon_block06.png")
				end
			elseif block.len == 3 then
				if block.rotation == 0 then
                    blockSprite:setSpriteFrame("icon_blocks.png")
				else
                    blockSprite:setSpriteFrame("icon_blocks_v.png") 
				end
			end
		end
        blockSprite:setAnchorPoint(0, 0)
		blockSprite:setPosition((block.x - 1) * (100), (block.y - 1) * (100))
		self.body:addChild(blockSprite)
		self.blocks[i] = blockSprite
		blockSprite.model = block
	end

end

function GameView:addTouchListenerForBody()
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

function GameView:adjustBlockPosition(block)
	local posX = block:getPositionX()
	local posY = block:getPositionY()
	if math.mod(posX, 100) >= 100 / 2 then
		posX = math.ceil(posX / 100) * (100)
	else
		posX = math.floor(posX / 100) * (100)
	end
	if math.mod(posY, 100) >= 100 / 2 then
		posY = math.ceil(posY / 100) * (100)
	else
		posY = math.floor(posY / 100) * (100)
	end
	block:setPosition(posX, posY)
    if self.BegainposX ~=posX or self.BegainposY ~=posY  then
        self.foot = self.foot +1
        if cc.UserDefault:getInstance():getStringForKey(GameView.click) == "0" or 
        cc.UserDefault:getInstance():getStringForKey(GameView.click) == "" then
        audio.playSound("Sound/ChineseBlock/move.mp3", false)
        end
    end	                 
end

function GameView:finishGame()
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

    self.body:removeAllChildren()
    levelState.level=levelState.level+1
  	self.deltaTime = 0
	self.isFinished = false
    self.coststarttime=self.costendtime
    local total = self:getLevelNum()
	if  levelState.level> total then
        local account = self:TransPerformance()
		self.time = 1
		Times = 1
		local finishlayer = require("src.app.ChineseBlock.finishlayer").new(3,self,account)
		self:addChild(finishlayer,10)
        if cc.UserDefault:getInstance():getStringForKey(GameView.click) == "0" or 
        cc.UserDefault:getInstance():getStringForKey(GameView.click) == "" then
        audio.playSound("Sound/ChineseBlock/solved.mp3", false)
        end
    else
        self.level = levelState.level
        self.data.levelData= self:getLevelData(levelState.level)
        self.data.levelState=levelState
        self:reInitialInterFace()
	end
end

function GameView:enableNext()
	print("GameView:enableNext")
	local nextBtn = self.nextBtn
	nextBtn:setOpacity(255)
	nextBtn:setTouchEnabled(true)
	nextBtn:addClickEventListener(function()
	    self:dispatchEvent({name = GameView.EVENTS.NEXT, levelState = self.data.levelState})
	end)
	local rotateBy = cc.RotateBy:create(1, -45)
	local nextBtnSprite = nextBtn:getChildByName("sprite")
	nextBtnSprite:runAction(cc.RepeatForever:create(cc.Sequence:create(rotateBy, rotateBy:reverse())))
end


--开始倒计时
function GameView:countdownBegin()
	self.startTime = os.date("%Y-%m-%d %H:%M:%S")
	self.time = 120
	local delay = cc.DelayTime:create(1)
	local function callback()
		self.time = self.time - 1
        self:createTimerSprite(self.time)
		if self.time == 0 then
			self:stopAction(self.countdownaction)
			local account = self:TransPerformance()
			self.time = 1
			Times = 1
			local finishlayer = require("src.app.ChineseBlock.finishlayer").new(1,self,account)
			self:addChild(finishlayer,10)
            if cc.UserDefault:getInstance():getStringForKey(GameView.click) == "0" or 
            cc.UserDefault:getInstance():getStringForKey(GameView.click) == "" then
            audio.playSound("Sound/ChineseBlock/fail.mp3", false)
            end
		end
	end
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self.countdownaction = cc.RepeatForever:create(sequence)
    self:runAction(self.countdownaction)
end

function GameView:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			--self:removeFromParent()
            local CSB = cc.CSLoader:createNode("ChineseBlock/backhome.csb") 
    		self:addChild(CSB)
    		CSB:setContentSize(display.size)
    		ccui.Helper:doLayout(CSB)
    		local dailog_bg = CSB:getChildByName("bg"):getChildByName("window")
    		self.btn_return = dailog_bg:getChildByName("btn_continue")
		    self.btn_close = dailog_bg:getChildByName("btn_back")   
		    self.content = dailog_bg:getChildByName("text_record")
		    --self.content:setString(string.format("您已通过%d关",self.data.levelState.level-1))
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
            self:playClickSound()
		end
	end
	self.btn_black:addTouchEventListener(backCallback)


        --声音按钮
    local judge = cc.UserDefault:getInstance():getStringForKey(GameView.click)
    if judge == "" or judge == "0" then
       self.btn_open_sound:setVisible(true)
       self.btn_close_sound:setVisible(false)
    else
       self.btn_open_sound:setVisible(false)
       self.btn_close_sound:setVisible(true)
    end
    self.btn_open_sound:addTouchEventListener(handler(self,self.voiceControl))
    self.btn_close_sound:addTouchEventListener(handler(self,self.voiceControl))
end

--华容道音控制
function GameView:voiceControl(sender,eventType)
    if eventType == ccui.TouchEventType.ended then
        --0:开状态 1:关状态
        local judge = cc.UserDefault:getInstance():getStringForKey(GameView.click)
        if judge == ""then
            judge = "0" 
        end
        if judge == "0" then
          --  self.icon_voice:setOpacity(128)
            self.btn_open_sound:setVisible(false)
            self.btn_close_sound:setVisible(true)
            cc.UserDefault:getInstance():setStringForKey(GameView.click,"1")
        elseif judge == "1" then
        --    self.icon_voice:setOpacity(255)
            self.btn_open_sound:setVisible(true)
            self.btn_close_sound:setVisible(false)
            cc.UserDefault:getInstance():setStringForKey(GameView.click,"0")
        end 
    end
end

--发送结算协议
function GameView:TransPerformance()
	self.endTime = os.date("%Y-%m-%d %H:%M:%S")
	local Account = GamePB_pb.PBBlockedGamelog_Update_Params()
	Account.starttime = self.startTime
	Account.endtime = self.endTime
	Account.levels = self.level
	Account.costtime = 120-self.time
    Account.starnum =self.star
    Account.stepnum = self.foot
	print("===",Account.starttime,Account.endtime,Account.levels,Account.costtime)
	local flag,getAccountreturn = HttpManager.post("http://lxgame.lexun.com/interface/blocked/updategamelog.aspx",Account:SerializeToString())
	if not flag then return end
	local obj=ServerBasePB_pb.PBMessage()
    obj:ParseFromString(getAccountreturn)
    print(obj.outmsg)
    return Account
end

function GameView:playClickSound()
    if cc.UserDefault:getInstance():getStringForKey(GameView.click) == "0" or 
    cc.UserDefault:getInstance():getStringForKey(GameView.click) == "" then
    audio.playSound("Sound/ChineseBlock/click.mp3", false)
    end
end


return GameView