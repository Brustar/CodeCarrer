local BubbleGameLayer = class("BubbleGameLayer",cc.load("mvc").ViewBase)
local numX,numY = 6,7 --横向6个气球，竖向7个气球
local currentlong,doubblenum,selectNum,haveBomb = 0,0,0,false --当前一次的长度，双倍的个数,选中的长度，选中的求中是否有炸弹
BubbleGameLayer.BGSCALE = 2
 BubbleData = {}--
 BubbleData.LBcoin = nil -- 乐币数量
 BubbleData.maxLong = nil --最长的长度
 BubbleData.gameScore = nil --游戏得分
 BubbleData.burstNum = nil --爆炸气球数量
 BubbleData.haveLB = nil -- 是否拥有乐币
local BubbleSprite = require("app.Bubble.BubbleSprite").new()
local BubbleScene = require("app.Bubble.BubbleScene").new()
local bubbleType = BubbleSprite.bubbleType
local specialBubble = BubbleSprite.specialBubble
local bubbleArr = {} --所有的气球
local  touchbubbletabel = {} --找到的气球
local  bpausegame,isTouchEend,isSound,isHaveBomb,touchNum = false,false,true,false,0 --暂停，是否允许玩家触摸,是否暂停背景音乐和音效,在播放音效的时候是否有炸弹,触摸球数量

function BubbleGameLayer:onCreate()
	self:infoCSB()
	self:infoTouch()
	self:createbubble(self:getAllPosition())
	self:onTouchEvent()
	self:showtime()
    self:scheduleUpdate(handler(self, self.step))
end
function BubbleGameLayer:step(dt)
    if self.bg_imgf:getPositionY() <= -2200 then 
        self.bg_imgf:setPosition(cc.p(0,self.bg_img:getPositionY()+2200))
    end
    if self.bg_img:getPositionY() <= -2200 then 
        self.bg_img:setPosition(cc.p(0,self.bg_imgf:getPositionY()+2200))
    end

end
function BubbleGameLayer:infoCSB()
    self.bg_imgf = display.newSprite("Bubble/background.jpg"):setAnchorPoint(cc.p(0,0)):setPosition(cc.p(0,2200)):setScale(2):addTo(self)
    self.bg_img = display.newSprite("Bubble/background.jpg"):setAnchorPoint(cc.p(0,0)):setPosition(cc.p(0,0)):setScale(2):addTo(self)
    
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("Bubble/bubbleAnimation.plist","Bubble/bubbleAnimation.png")--加载plist文件到缓存
	self:createResoueceNode("Bubble/playgaming.csb")
    local CSB=self.resourceNode_
    local bg = CSB:getChildByName("root")
    self.bgPanle = bg:getChildByName("pl_bg"):setVisible(false)
    local topPanel = bg:getChildByName("pl_top")
    self.mBack = topPanel:getChildByName("pl_btn_home")
    local coinPanel = topPanel:getChildByName("pl_lebi"):getChildByName("pl_lebi_num")
    local coinLab = coinPanel:getChildByName("al_lebi"):setVisible(false)--获取乐币数
    local pointPanel = topPanel:getChildByName("pl_fs"):getChildByName("pl_fs_num")
    local pointLab = pointPanel:getChildByName("al_fs"):setVisible(false)--获取得分数
    self.mStop = topPanel:getChildByName("pl_btn_stop")--获取暂停按钮
    self.mSound = topPanel:getChildByName("pl_btn_sound")--获取音量按钮
    self.soundBegin = self.mSound:getChildByName("img_btn_sound"):setVisible(true)
    self.soundClose = self.mSound:getChildByName("img_btn_sound_close"):setVisible(false)

    local timePanel = topPanel:getChildByName("pl_time")
    local TimeLab = timePanel:getChildByName("al_time"):setVisible(false)--获取时间标签
    self.coinLab = ccui.TextAtlas:create():setProperty(0,"Bubble/img_small_num1.png", 24, 36, "."):setPosition(coinLab:getPosition()):addTo(coinPanel)  
    self.pointLab = ccui.TextAtlas:create():setProperty(0,"Bubble/img_small_num1.png", 24, 36, "."):setPosition(pointLab:getPosition()):addTo(pointPanel)
    self.TimeLab = ccui.TextAtlas:create():setProperty(60,"Bubble/img_time_num.png", 46, 65, "."):setPosition(TimeLab:getPosition()):setAnchorPoint(0.5,0.8):addTo(timePanel)
end
function BubbleGameLayer:infoTouch()
	local function touchCall(sender,touchType)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/touchdu.mp3",false)
		if touchType == ccui.TouchEventType.ended then
			if sender == self.mBack then
				self:infoBackCSB()
			elseif sender == self.mStop then
				self:infoStopCSB()    
			end 
		end
	end
	self.mBack:addTouchEventListener(touchCall)
	self.mStop:addTouchEventListener(touchCall)
    local function soundCallBack(sender,touchType)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/touchdu.mp3",false)
       if touchType == ccui.TouchEventType.ended then
           if isSound then
                self.soundBegin:setVisible(false)
                self.soundClose:setVisible(true)
                cc.SimpleAudioEngine:getInstance():pauseMusic()
                cc.SimpleAudioEngine:getInstance():stopAllEffects()
                isSound = false
            else
                 self.soundBegin:setVisible(true)
                self.soundClose:setVisible(false)
                cc.SimpleAudioEngine:getInstance():resumeMusic()
                cc.SimpleAudioEngine:getInstance():resumeAllEffects()
                isSound = true
            end
       end 
    end
	self.mSound:addTouchEventListener(soundCallBack)
end
--初始化暂停按钮
function BubbleGameLayer:infoStopCSB()
	bpausegame = true
	local CSB = cc.CSLoader:createNode("Bubble/alert_stop.csb"):setContentSize(display.size):addTo(self) 
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("root"):getChildByName("pl_box")
    local mBack = bg:getChildByName("pl_btn_back")
    local mAgain = bg:getChildByName("pl_btn_begin")
    local function touchCall(sender,touchType)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/clickdown.mp3",false)
    	if touchType == ccui.TouchEventType.ended then
    		bpausegame = false
    		if sender == mBack then
    			self:getApp():enterScene("BubbleNoteScene")
    		elseif sender == mAgain then
    			CSB:removeFromParent()
    		end
     	end
    end
    mBack:addTouchEventListener(touchCall)
    mAgain:addTouchEventListener(touchCall)
end
--初始化返回CSB
function BubbleGameLayer:infoBackCSB()
	local CSB = cc.CSLoader:createNode("Bubble/alert_comeback.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    local bg= CSB:getChildByName("root"):getChildByName("pl_box")
    local mBack = bg:getChildByName("pl_btn_back")
    local mAgain = bg:getChildByName("pl_btn_begin")
    local function touchCall(sender,touchType)
    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/clickdown.mp3",false)
		if touchType == ccui.TouchEventType.ended then
			if sender == mBack then
				self:getApp():enterScene("BubbleScene")
                 cc.SimpleAudioEngine:getInstance():stopMusic()
			elseif sender == mAgain then
				CSB:removeFromParent()
			end
		end
	end
    mBack:addTouchEventListener(touchCall)
    mAgain:addTouchEventListener(touchCall)
end
--倒计时
function BubbleGameLayer:showtime( )
	self.time = 60
    BubbleData.gameScore = 0
    BubbleData.maxLong = 0
     BubbleData.burstNum = 0
    BubbleData.LBcoin = 0
     BubbleData.haveLB = false
     isTouchEend = true
	local function callback( )
		if bpausegame == false then
			self.time = self.time - 1
			self.TimeLab:setString(self.time)
		end
		if self.time == 0 then
			bubbleArr = {} --所有的气球
            if BubbleData.LBcoin > 0 then
                 BubbleData.haveLB = true
            else
                 BubbleData.haveLB = false
            end
            cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/finally.mp3",false)
			self:stopAction(self.countdownaction)
			self:addChild(require("app.Bubble.finishlayer").new())
		end
	end
	self.countdownaction = cc.RepeatForever:create( cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(callback)))
	self:runAction(self.countdownaction)
end
--返回生成的是正常气球还是特殊气球
function BubbleGameLayer:bubblekind()
	local rand = math.random(1,8) --随机到1-7,正常气球,8表示特殊气球
	if rand >=1 and rand <=7 then
		local Fontsindex = math.random(1,6)
		return bubbleType[Fontsindex]
	elseif rand == 8 then
		local Fontsindex = math.random(1,9)
		return specialBubble[Fontsindex]
	end 
end
--创建气球元素
function BubbleGameLayer:createbubble(positionArr)
	math.randomseed(os.clock())
	self.bubblelay = cc.Layer:create():addTo(self)	
	for i=1,numX do
		bubbleArr[i]={}
	end
	local betweenX = 20
	local shouldX = (display.width-7*20)/6
	for i=1,numX*numY do 
		local bubbleType =self:bubblekind()
        local animation = self:backAnimations(bubbleType,0)--创建动画
        local bubblesp = display.newSprite():setScale(shouldX/64):setPosition(positionArr[i].x,positionArr[i].y):addTo(self.bubblelay,1)
		bubblesp:playAnimationForever(animation)
		local arrOne,arrTwo
		if i%numX > 0 then
			arrOne = i%numX
		elseif i%numX == 0 then
			arrOne = numX
		end
		arrTwo = math.ceil(i/numX)
		bubbleArr[arrOne][arrTwo] = {}
		bubbleArr[arrOne][arrTwo].SPRITE = bubblesp
		bubbleArr[arrOne][arrTwo].INDEX = bubbleType.INDEX
		bubbleArr[arrOne][arrTwo].NORMAL = bubbleType.NORMAL
		bubbleArr[arrOne][arrTwo].indexX = arrOne
		bubbleArr[arrOne][arrTwo].indexY = arrTwo
		bubbleArr[arrOne][arrTwo].posX = positionArr[i].x
		bubbleArr[arrOne][arrTwo].posY = positionArr[i].y
	end
end
--得到气球坐标
function BubbleGameLayer:getAllPosition()
	local betweenX,betweenY = 20,(display.height-960)/8 --气球之间的间隔大小，x方向
	local shouldX = (display.width-7*20)/6 --一个气球应该的大小，x方向
	local shouldY = 80*(shouldX/64)--一个气球应该的大小，y方向
	local positionArr={}
	for i=1,numX*numY do
		positionArr[i]={}
		if i%numX>0 then positionArr[i].x = betweenX*(i%numX)+(i%numX-0.5)*shouldX
		elseif i%numX==0 then positionArr[i].x = betweenX*6+(6-0.5)*shouldX end
		positionArr[i].y = display.height-(135+(display.height-135-7*shouldY-8*betweenY)*0.5+(math.ceil(i/numX)-0.5)*shouldY+(math.ceil(i/numX)-1)*betweenY)
	end
	return positionArr
end
--触摸事件
function BubbleGameLayer:onTouchEvent()
	self.lay = cc.Layer:create():addTo(self.bgPanle)
	local touchBeginpoint = nil
	touchbubbletabel= {}  
    isHaveBomb = false 
	local function onTouchBegan( touch, event )
		touchBeginpoint = touch:getLocation()
        if not isTouchEend then return false end
	    for i,v in ipairs(bubbleArr) do
		    for k,w in ipairs(v) do
			    local bubble_rect = w.SPRITE:getBoundingBox()
			    if cc.rectContainsPoint(bubble_rect,touchBeginpoint) and w.NORMAL then
                    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/touchdu.mp3", loopValue)
                    local animation = self:backAnimations(w,6)
                    w.SPRITE:stopAllActions()   
                    w.SPRITE:playAnimationForever(animation)
				    table.insert(touchbubbletabel,w)
				    return true
			    end
		    end
	    end
		return false
    end
	local function onTouchMoved( touch, event )
		local touchPoint = nil
		touchPoint = touch:getLocation()
		for i,v in ipairs(bubbleArr) do
			for k,w in ipairs(v) do
				local bubble_rect = w.SPRITE:getBoundingBox()
				if cc.rectContainsPoint(bubble_rect,touchPoint) then
                    cc.SimpleAudioEngine:getInstance():playEffect("Bubble/audio/touchdu.mp3",false)
					self:MeetConditions(w) 
					break
				end
			end
		end
	end
	local function onTouchEnded( touch, event )	
        self.checkSound()
		touchBeginpoint = touch:getLocation()
		self:checkbubble()
	end
	local touchListener = cc.EventListenerTouchOneByOne:create()
	touchListener:setSwallowTouches(true)
	touchListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	touchListener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	touchListener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = self:getEventDispatcher():addEventListenerWithSceneGraphPriority(touchListener,self.lay)
end
--选择移动中符合条件的气球
function BubbleGameLayer:checkSound()--检测播放哪种音乐
   touchNum = #touchbubbletabel
   for k,v in ipairs(touchbubbletabel) do
       if not v.NORMAL and (v.INDEX >= 2 and v.INDEX <= 4) then
            isHaveBomb = true
            break
       end
    end
end
function BubbleGameLayer:playSound()--播放音乐
    local sInstance = cc.SimpleAudioEngine:getInstance()
    local loopValue = false
    if isHaveBomb then
        sInstance:playEffect("Bubble/audio/boom.mp3", loopValue)
    elseif touchNum == 3 then
        sInstance:playEffect("Bubble/audio/three.mp3", loopValue)
    elseif touchNum >= 4 and touchNum <= 6 then
        sInstance:playEffect("Bubble/audio/four.mp3", loopValue)
    else 
        sInstance:playEffect("Bubble/audio/seven.mp3", loopValue)
    end
    isHaveBomb = false
end
function BubbleGameLayer:MeetConditions(w)
	--移动中的气球是否符合要求,是否和最后一个元素相邻
	if #touchbubbletabel > 0 and self:withColorBubble(w) and self:isAdjacent(touchbubbletabel[#touchbubbletabel],w) then
		self:PutInTouchBub(w)
	end
end
function BubbleGameLayer:PutInTouchBub(w)
	if self:findtableVal(touchbubbletabel,w) then --是否已经在已选择的气球lab中
		if #touchbubbletabel > 1 then --至少已经选择了两个气球
			local endBubble = touchbubbletabel[#touchbubbletabel]--最后一个
			local endSecondBubble = touchbubbletabel[#touchbubbletabel-1]--倒数第二个
			if endSecondBubble.indexX==w.indexX and endSecondBubble.indexY==w.indexY then
                endBubble.SPRITE:stopAllActions()
                local animation = self:backAnimations(endBubble,0)
                endBubble.SPRITE:playAnimationForever(animation)
				table.remove(touchbubbletabel,#touchbubbletabel)
			end
		end
	else
       w.SPRITE:stopAllActions()
        local animation = self:backAnimations(w,6)
        w.SPRITE:playAnimationForever(animation)
		table.insert(touchbubbletabel,w)
	end
end
--查找table值 
function BubbleGameLayer:findtableVal(sometable,value)
	for i,v in ipairs(sometable) do
		if v.indexX==value.indexX and v.indexY==value.indexY then
			return true
		end
	end
	return false
end
function BubbleGameLayer:backAnimations(bubble,addindex)--创建动画效果
    local addnum = 3
    local frames,animation,num ,atime
    math.randomseed(os.clock())
    local runtime = math.random(1.6,2.1)
   
    if bubble.NORMAL then --创建气泡动画 ，包括选中和非选中状态的动画
        local totalIndex = bubble.INDEX + addindex
        if totalIndex >= 1 and totalIndex  <= 6 then 
             num = 20 
             atime = runtime
        else  
            num = 4
            atime = 0.5
        end
        frames = display.newFrames(bubbleType[totalIndex].ATYPE,1,num)
        animation = display.newAnimation(frames,atime/num) 
    else            -- 创建道具动画
        if addindex > 0 then addindex = addindex + addnum end 
        local totalIndex = bubble.INDEX + addindex
        if totalIndex >= 1 and totalIndex <= 9 then num = 1 else num = 4 end
        frames = display.newFrames(specialBubble[totalIndex].ATYPE,1,num)
         animation = display.newAnimation(frames,0.5/num)
    end
    return animation
end

--检测两个气球是否相邻
function BubbleGameLayer:isAdjacent(v,w)
	local X,Y
	if v.indexX>w.indexX then X=v.indexX-w.indexX else X=w.indexX-v.indexX end
	if v.indexY>w.indexY then Y=v.indexY-w.indexY else Y=w.indexY-v.indexY end
	if X<=1 and Y<=1 then
		return true
	else
		return false
	end
end
--检测移动中的气球是否符合要求
function BubbleGameLayer:withColorBubble(w)
	local WHERE = 0 --记录最后一个彩色球在touchbubbletabel中的位置
	if not w.NORMAL then --是特殊球
		return true
	end
	for i,v in ipairs(touchbubbletabel) do
		if not v.NORMAL and v.INDEX==1 then
			if i == #touchbubbletabel then --touchbubbletabel中的最后一个是彩色球
				return true
			end
			WHERE=i
		end
	end
	if WHERE==0 then --没有彩色球时和touchbubbletabel中第一个比较
		if touchbubbletabel[1].INDEX == w.INDEX then
			return true
		end
	end
	--彩球后面的球不是特殊球
	if w.INDEX == touchbubbletabel[WHERE+1].INDEX and touchbubbletabel[WHERE+1].NORMAL then
		return true
	end
	return false
end
function BubbleGameLayer:playPopAnimations(v)--创建移除气泡前的破碎动画
    v.SPRITE:stopAllActions()
    local animation = display.newAnimation(display.newFrames("pop_%d.png",1,11),0.5/11)
    local animate = cc.Animate:create(animation)
    local function removeCallback()    
        v.SPRITE:removeFromParent()
        v.SPRITE = nil
        currentlong = currentlong + 1
		BubbleData.burstNum =  BubbleData.burstNum + 1
    end
    v.SPRITE:runAction(cc.Sequence:create(animate,cc.CallFunc:create(removeCallback)))
end
--消除气球   maxlong,currentlong,doubblenum 
function BubbleGameLayer:checkbubble( )
	if #touchbubbletabel==0 then
		return
	end
    local function callBack()
        self:produceBubble()
    end
   -- local hasplay = true
	if #touchbubbletabel>= 3 then
		selectNum = #touchbubbletabel
        isTouchEend = false
        self:playSound() --播放音乐音效
		for i,v in ipairs(touchbubbletabel) do
			if v.NORMAL then
				if v.SPRITE then
                    self:playPopAnimations(v)
				end
			else
				self:checkSpecialBubble(v)
			end 
		end
        self:runAction(cc.Sequence:create(cc.DelayTime:create(0.8),cc.CallFunc:create(callBack)))
	else
		for i,v in ipairs(touchbubbletabel) do
            v.SPRITE:stopAllActions()
            local animation = self:backAnimations(v,0)
            v.SPRITE:playAnimationForever(animation)
		end
	end
	touchbubbletabel = {}
end
--特殊球消除算法
function BubbleGameLayer:checkSpecialBubble(bubble)
    math.randomseed(os.clock())
	local function removeFunction(w)
		if w.SPRITE then
            self:playPopAnimations(w)
		end
	end
	if bubble.INDEX == 1 then
		removeFunction(bubble)
	elseif bubble.INDEX == 2 then
		haveBomb = true
		for _,v in ipairs(bubbleArr) do
			for _,w in ipairs(v) do
					if w.indexY == bubble.indexY then
					removeFunction(w)
				end
			end
		end
	elseif bubble.INDEX == 3 then
		haveBomb = true
		for _,v in ipairs(bubbleArr) do
			for _,w in ipairs(v) do
					if w.indexX == bubble.indexX then
					removeFunction(w)
				end
			end
		end
	elseif bubble.INDEX == 4 then
		haveBomb = true
		for _,v in ipairs(bubbleArr) do
			for _,w in ipairs(v) do
					if w.indexX == bubble.indexX or w.indexY == bubble.indexY then
					removeFunction(w)
				end
			end
		end
	elseif bubble.INDEX == 5 then
		removeFunction(bubble)
		doubblenum = doubblenum+1
	elseif bubble.INDEX == 6 then
		self.time = self.time + 5--加5秒时间
		removeFunction(bubble)
    elseif bubble.INDEX == 7 then --金钱包
        local coinnum = math.random(3000,5000)
        BubbleData.LBcoin = BubbleData.LBcoin + coinnum
        removeFunction(bubble)
    elseif bubble.INDEX == 8 then
        local coinnum = math.random(1000,3000)
        BubbleData.LBcoin = BubbleData.LBcoin + coinnum
        removeFunction(bubble)
    elseif bubble.INDEX == 9 then
        local coinnum = math.random(100,1000)
        BubbleData.LBcoin = BubbleData.LBcoin + coinnum
        removeFunction(bubble)
	end
    self.coinLab:setString(BubbleData.LBcoin)
end
--生产气球
function BubbleGameLayer:produceBubble()
	local positionXArr = {}--生产气球时方向的坐标
	local betweenX,betweenY = 20,0 --气球之间的间隔大小，x方向
	local shouldX = (display.width-7*20)/6 --一个气球应该的大小，x方向
	local shouldY = 80*(shouldX/64)--一个气球应该的大小，y方向
	for i=1,6 do
		positionXArr[i]=betweenX*i+(i-0.5)*shouldX
	end
	local surplusArr,indexArr,isnormalArr={},{},{}
	local disappearNum = 0--每一竖条消掉的气球的数量
	for i,v in ipairs(bubbleArr) do
		surplusArr[i]={}
		indexArr[i]={}
		isnormalArr[i]={}
		for j,w in ipairs(v) do
			if w.SPRITE then 
				table.insert(surplusArr[i],w.SPRITE)
				table.insert(indexArr[i],w.INDEX)
				table.insert(isnormalArr[i],w.NORMAL)
			else
				disappearNum = disappearNum+1
			end
		end
		for j=1,disappearNum do			
            local bubblesp = display.newSprite():setScale(shouldX/64):setPosition(positionXArr[i],-(10+(j-0.5)*shouldY)):addTo(self.bubblelay,1)
			local bubbleType =self:bubblekind()
            local animation = self:backAnimations(bubbleType,0)
            bubblesp:playAnimationForever(animation)
			table.insert(surplusArr[i],bubblesp)
			table.insert(indexArr[i],bubbleType.INDEX)
			table.insert(isnormalArr[i],bubbleType.NORMAL)
		end
		disappearNum = 0
	end
	--为bubbleArr的sprite和index重新复赋值
	for i,v in ipairs(bubbleArr) do
		for j,w in ipairs(v) do
			w.SPRITE = surplusArr[i][j]
			w.INDEX = indexArr[i][j]
			w.NORMAL = isnormalArr[i][j]
		end
	end
	if currentlong > BubbleData.maxLong then BubbleData.maxLong = currentlong end
	if haveBomb then
		BubbleData.gameScore = BubbleData.gameScore + 10*selectNum*selectNum+100*selectNum+2*doubblenum*100*selectNum + 100*(currentlong-selectNum)
	else
		BubbleData.gameScore = BubbleData.gameScore + 10*currentlong*currentlong+100*currentlong+2*doubblenum*100*currentlong
	end
	self.pointLab:setString(BubbleData.gameScore)
	currentlong,doubblenum,selectNum,haveBomb=0,0,0,false
	self:bubbleMove()
end
--移动气球
function BubbleGameLayer:bubbleMove()
    local move_ease_out = cc.EaseSineOut:create(cc.MoveBy:create(4, cc.p(0, -1100)))
    local move_ease_outf = cc.EaseSineOut:create(cc.MoveBy:create(4, cc.p(0, -1100)))
    self.bg_img:runAction(move_ease_out)
    self.bg_imgf:runAction(move_ease_outf)
    local function bubblemMoveEnd()
        isTouchEend = true 
    end   
	local function moveCallBack()
		for i,v in ipairs(bubbleArr) do
			for j,w in ipairs(v) do
				w.SPRITE:runAction(cc.MoveTo:create(0.4, cc.p(w.posX,w.posY)))
			end
		end        		
	end
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(moveCallBack),cc.DelayTime:create(0.4),cc.CallFunc:create(bubblemMoveEnd))
	self:runAction(sequence)
end
return BubbleGameLayer

