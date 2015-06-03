require('app.Warrior.map')
require("app.Warrior.PngHelper")
require('app.Warrior.BlockSprite')
require('app.Warrior.CoolSprite')
require('app.Warrior.GameLayer')
local time = 180
local gamescene = class("GameScene",cc.load("mvc").ViewBase)
local maps= JsonManager.decode(WARRIOR_MAP)
local pngIndex=1
local  GameLayer =  require('app.Warrior.GameLayer').new()
function gamescene:onCreate()
    cc.UserDefault:getInstance():getIntegerForKey('buttonTag')
    self.leveltimes=0
    self.allStars = 0
    self.allStep =0
    self.allLevel =0
    self.level=1
    if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1002 then--教学模式
        self.levelTeach=1;
    elseif  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then--挑战模式
        self.level=1; 
    end
    if cc.UserDefault:getInstance():getIntegerForKey('cLevel')~=0 then
    end
      if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then--挑战模式
         self:countdownBegin()
     end
    self:initUI()
    self:addTouchListenerForBody()
end
--挑战模式
function gamescene:animationFish()
    self.level = 1;
    self:countdownBegin()
    self:initUI()
end
function gamescene:initUI()
    local rand = math.random(1,#maps)--随机
    if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1002 then--教学模式
        self.gameConfigs = maps[self.levelTeach]
    elseif    cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then--挑战模式
        self.gameConfigs = maps[rand]
    end
    self.isFinished=false
    self.isPass =false
    self.step=0
    self.png=PngHelper.shared():init(pngIndex)
    self:removeAllChildren()
    if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1002 then--教学模式
        if self.levelTeach==1 then --第一关时添加滑动提示 
           self:slideHint()
        end
    end
    self:createLayer()
    self.blocks = {}
    local width = self.gameConfigs.map_width 
    local height = self.gameConfigs.map_height 
    for i=1,width do
        for j=1,height do
            local coordinate=width*(i-1)+j
            local block=self.gameConfigs.blocks[coordinate]
            self:createBlock(block.id,block.md,3-j,3-i,coordinate,block.ch)
        end
    end
    self:createWidgets()
end
--创建倒计时UI
function gamescene:createTopLab()
  --  cc.SpriteFrameCache:getInstance():addSpriteFrames("Warrior/picture.plist")
    local timeBackGround = cc.Sprite:createWithSpriteFrameName("game_9.png"):move(display.cx+140,display.cy+270):addTo(self)
    local size = timeBackGround:getContentSize()
    local firstSpite=cc.Sprite:createWithSpriteFrameName("icon_time.png"):move(size.width*0.15,size.height*0.6):addTo(timeBackGround)
    local secondSpite=cc.Sprite:createWithSpriteFrameName("text_second.png"):move(size.width-20,size.height*0.6):addTo(timeBackGround)
    self.num_time=ccui.TextAtlas:create():setProperty("1", "Warrior/num.png",19,24,"."):move(size.width*0.5,size.height*0.6):addTo(timeBackGround):setString(time)
end
--开始倒计时
function gamescene:countdownBegin()
    local delay = cc.DelayTime:create(1)
    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    local function callback()
    if not self.isFinished then
        time = time - 1
        self.num_time:setString(time)
        self.costtime=180-time
     end   
        if time == 0 then  
                self:stopAction(self.countdownaction) 
                time=180
                local finishlayer = require("src.app.Warrior.SceneView").new(1,self)--account
                self:addChild(finishlayer,1009)
        end
    end
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self.countdownaction = cc.RepeatForever:create(sequence)
    self:runAction(self.countdownaction)
end
function gamescene:createLayer()	
    self.png:spriteFromJson("game_back"):move(display.cx,display.cy+130):addTo(self)--关卡背景
end
function gamescene:createWidgets()
    self.png:spriteFromJson("game_down_up"):move(display.cx,display.cy-435):addTo(self):setLocalZOrder(100)
	self.leveLable=ccui.Text:create(string.format("Level %d",self.level),display.DEFAULT_TTF_FONT,28):move(display.cx-190,display.cy+275):setColor(display.COLOR_WHITE):addTo(self):setLocalZOrder(100)
    self.steps=ccui.Text:create(string.format("%d",self.step),display.DEFAULT_TTF_FONT,38):move(display.cx-280,display.cy-350):setColor(display.COLOR_WHITE):addTo(self):setLocalZOrder(100)
    ccui.Text:create(self.gameConfigs.steps_1,display.DEFAULT_TTF_FONT,18):move(display.cx-180,display.cy-315):setColor(display.COLOR_WHITE):addTo(self):setLocalZOrder(100)
    ccui.Text:create(self.gameConfigs.steps_2,display.DEFAULT_TTF_FONT,18):move(display.cx-195,display.cy-340):setColor(display.COLOR_WHITE):addTo(self):setLocalZOrder(100)
    ccui.Text:create(self.gameConfigs.steps_3,display.DEFAULT_TTF_FONT,18):move(display.cx-210,display.cy-360):setColor(display.COLOR_WHITE):addTo(self):setLocalZOrder(100)
    local menu = cc.Menu:create():move(cc.p(display.left+30,display.top-100)):addTo(self)--返回主界面
    local backHomeBg = cc.Sprite:createWithSpriteFrameName("icon_btnbg.png")
    local size = backHomeBg:getContentSize()
    local firstSpite=cc.Sprite:createWithSpriteFrameName("icon_home.png"):move(size.width*0.5,size.height*0.5):addTo(backHomeBg)
    local home=cc.MenuItemSprite:create(backHomeBg,backHomeBg,backHomeBg):move(80,0):addTo(menu)
    home:registerScriptTapHandler(function()
          time = 180
        self:getApp():enterScene("StartScene")
    end)

    local helper = PngHelper.shared():init(2)
    helper:framecacheFromJson("princess_prnc_anim_",11):move(cc.p(display.cx,display.cy+300)):addTo(self)
    self.warrior = helper:framecacheFromJson("hero_s_stay_anim_",146):move(cc.p(display.cx+210,display.cy-310)):addTo(self):setLocalZOrder(100)
    -- if self.level ~=1  then
    if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ~=1002 then--教学模式
       self:createTopLab()
    end
end
--id 对应的图形和图形对应的坐标x,y
function gamescene:createBlock(id,md,x,y,coordinate,ch)
    local block = nil
    if id~=-1 then
        if ch~=8 and ch~=1 then
            block = BlockSprite:create(self:block_name(id,md,ch,coordinate),x,y,ch):addTo(self)
            block.coordinate_=coordinate
            block.key_=coordinate
            block.id_=id
            block:setLocalZOrder(block.coordinate_)
            self.blocks[#self.blocks+1]=block
        else
            block = CoolSprite:create(ch)
            block.coordinate_=coordinate
            block.key_=coordinate
            block.id_=id
            self.blocks[#self.blocks+1]=block
        end
    end
end
function gamescene:addTouchListenerForBody()
    -- 触摸开始
    local function onTouchBegan(touch, event)
		if not self.isFinished then
			self.targetBlock = nil
	        local touchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
	        for _, block in ipairs(self.blocks) do
	    		if block.ch_~=8 and block.ch_~=1 and block:hasMoved() and cc.rectContainsPoint(block:getBoundingBox(), touchPoint) then
					self.targetBlock = block
	    	        self.lastTouchPoint = touchPoint
                    return true
                end
            end
		end
        return false                     
    end
    -- 触摸移动
    local function onTouchMoved(touch, event)
    end
    -- 触摸结束
    local function onTouchEnded(touch, event)
        local touchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
        local offsetX = touchPoint.x - self.lastTouchPoint.x
        local offsetY = touchPoint.y - self.lastTouchPoint.y
        local forward=""

        if offsetX<0 and math.abs(offsetX)>math.abs(offsetY) then --left forward
            forward=BlockSprite.LEFT
        elseif offsetY>0 and math.abs(offsetX)<math.abs(offsetY) then --up forward
            forward=BlockSprite.UP
        elseif offsetX>0 and math.abs(offsetX)>math.abs(offsetY) then --right forward
            forward=BlockSprite.RIGHT
        elseif offsetY<0 and math.abs(offsetX)<math.abs(offsetY) then --down  forward
            forward=BlockSprite.DOWN
        end

        if self.targetBlock and self.targetBlock:canMove(self.blocks,forward) then
            local offset=self.targetBlock:move(forward)
            local coolBlock=self:calCoolBlock(self.targetBlock)
            if coolBlock then
                coolBlock:move(offset)
            end 
            self.step=self.step+1
            self.steps:setString(string.format("%d",self.step))
            local index=self:calcIndex(self.targetBlock.key_)
            self.blocks[index]=self.targetBlock
            if coolBlock then
                index=self:calcIndex(coolBlock.key_)
                self.blocks[index]=coolBlock
            end
            if self.step==1 then
                if self.HintLayer then
                    self.HintLayer:setVisible(false)
                end
            end
        end
        self:finishGame()
        self.lastTouchPoint = touchPoint
    end 
    -- 注册单点触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function gamescene:persistence()
    local key = string.format('stars_%d',self.level)
    local stars = cc.UserDefault:getInstance():getIntegerForKey(key)
    self.crrentStars=0
    if self.step<=self.gameConfigs.steps_1 then
        self.crrentStars=3
    elseif self.step>self.gameConfigs.steps_1 and self.step<=self.gameConfigs.steps_2 then
        self.crrentStars=2
    elseif self.step>self.gameConfigs.steps_2 and self.step<=self.gameConfigs.steps_3 then
        self.crrentStars=1
    end
    if stars< self.crrentStars then
        cc.UserDefault:getInstance():setIntegerForKey(key,self.crrentStars)
    end
    --总星星数量
     if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then--挑战模式
        self.allStars = self.allStars+self.crrentStars
         --总步数
         self.allStep = self.allStep+self.step
         self.level = self.level+1
    end

    if self.level>cc.UserDefault:getInstance():getIntegerForKey('wLevel') then
        cc.UserDefault:getInstance():setIntegerForKey('wLevel',self.level)
    end
end
function gamescene:finishGame()
    local startCoor = 3*(self.gameConfigs.start_y) + self.gameConfigs.start_x + 1 + 3
    local endCoor = 3*(self.gameConfigs.finish_y) + self.gameConfigs.finish_x + 1 - 3
    self.path={-1,startCoor} --结束动画路径
    --local   a = true
    if self:matchPath(BlockSprite.DOWN,self:calcID(startCoor)) and self:verify(startCoor,endCoor,BlockSprite.DOWN) then
        self.isFinished=true
        self:persistence()
        if self.HintLayer then  --删除第一关滑动提示
            self.HintLayer:stopAction(self.HintAction)
            self.HintLayer:removeFromParent()
            self.HintLayer = nil
        end
        local actions={}
        for i=#self.path,1,-1 do
            local pos=self:calcPos(self.path[i])
            local action=cc.MoveTo:create(0.5,pos)
            actions[#actions+1]=action
        end
        self.warrior:runAction(cc.Sequence:create(actions))
        
        performWithDelay(self,function()
            if    cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then--挑战模式
                self.leveltimes = self.leveltimes+1
            end
            --if self.level>#maps then       前10关--通关了
            if  self.leveltimes>9 then
                self:stopAction(self.countdownaction)
                self.isPass=true
                local passLevel = require("app.Warrior.SceneView").new(2,self)--account
                self:addChild(passLevel,1008)
            end

            if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1002 then
                      self:createPassAction()--如果是教学模式
            end    
                if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then
                    if  self.isPass==false then
                         self:initUI() --直接进入下一关，去掉过关动画
                     end
                end            
        end,#self.path*0.5)
    end
end
function gamescene:calcDirection(coordinate,direction)
    local dire=""
    local id = self:calcID(coordinate)
    if id>0 then
        for _,v in ipairs(table.keys(GameLayer.VERIFY_MAP[id])) do
            if v==BlockSprite.UP and coordinate-3>0 and coordinate-3<10 and direction~=BlockSprite.DOWN then
                dire=v
            elseif v==BlockSprite.DOWN and coordinate+3>0 and coordinate+3<10 and direction~=BlockSprite.UP then
                dire=v
            elseif v==BlockSprite.LEFT and coordinate-1>0 and coordinate-1<10 and direction~=BlockSprite.RIGHT then
                dire=v
            elseif v==BlockSprite.RIGHT and coordinate+1>0 and coordinate+1<10 and direction~=BlockSprite.LEFT then
                dire=v
            end 
        end
    end
    return dire
end

function gamescene:verify(coordinate,endCoor,direction)
    local startId = self:calcID(coordinate)
    local nextCoor=0
    local nextDire=""
    if startId>0 and direction~="" then
        for _,v in ipairs(table.keys(GameLayer.VERIFY_MAP[startId])) do
            if v==BlockSprite.UP and coordinate-3>0 and coordinate-3<10 and direction~=BlockSprite.DOWN then
                nextCoor=coordinate-3
                nextDire=v
            elseif v==BlockSprite.DOWN and coordinate+3>0 and coordinate+3<10 and direction~=BlockSprite.UP then
                nextCoor=coordinate+3
                nextDire=v
            elseif v==BlockSprite.LEFT and coordinate-1>0 and coordinate-1<10 and direction~=BlockSprite.RIGHT then
                nextCoor=coordinate-1
                nextDire=v
            elseif v==BlockSprite.RIGHT and coordinate+1>0 and coordinate+1<10 and direction~=BlockSprite.LEFT then
                nextCoor=coordinate+1
                nextDire=v
            end 
        end
    end
    self.path[#self.path+1]=nextCoor
    local nextId = self:calcID(nextCoor)
    local endId=self:calcID(endCoor)
    if nextCoor==endCoor and endId>0 and self:matchPath(BlockSprite.UP,endId) then
        return true
    end
    if nextId>0 and nextCoor>0 and nextDire~="" and self:matchPath(nextDire,nextId) then
        return self:verify(nextCoor,endCoor,nextDire)
    end
    self.path={}
    return false
end
function gamescene:matchPath(direction,id)
    if id==0 then
        return false
    end
    local nextDire = table.keys(GameLayer.VERIFY_MAP[id])
    for _,v in ipairs(nextDire) do
        if direction==BlockSprite.UP and v==BlockSprite.DOWN then
            return true
        elseif direction==BlockSprite.DOWN and v==BlockSprite.UP then
            return true
        elseif direction==BlockSprite.LEFT and v==BlockSprite.RIGHT then
            return true
        elseif direction==BlockSprite.RIGHT and v==BlockSprite.LEFT then
            return true
        end
    end
    return false
end
function gamescene:calcID(coordinate)
    local id = 0
    table.walk(self.blocks,function(v,k)
        if v.coordinate_==coordinate then
            id = v.id_
        end
    end)
    return id
end
function gamescene:calcIndex(key)
    local index = 0
    table.walk(self.blocks,function(v,k)
        if v.key==key then
            index = k
        end
    end)
    return index
end
function gamescene:block_name(id,md,ch,index)
    local name=""
    local blocks= JsonManager.decode(BLOCKS)
    local pid=0
    for i,v in ipairs(blocks) do
        if ch==2 then
            pid=self.gameConfigs.blocks[index+1].id
            if v.path==pid and v.path_2==id and v.chain==ch then
                name=v.block
            end
        elseif ch==4 then
            pid=self.gameConfigs.blocks[index+3].id
            if v.path==pid and v.path_2==id and v.chain==ch then
                name=v.block
            end
        else
            if v.path==id then
                name=v.block
            end
        end
    end
    return string.format("blocks_%s_%d",name,md)
end
function gamescene:calCoolBlock(block)
    local cool = nil
    table.walk(self.blocks,function(v,k)
        if v.ch_==8 and block.ch_==2 then
            cool=v
        end
        if v.ch_==1 and block.ch_==4 then
            cool=v
        end
    end)
    return cool
end
function gamescene:calcPos(coordinate)
    local x , y = (3-coordinate%3)%3 , math.floor(3-coordinate/3)
    return cc.p(display.width-110-BlockSprite.WIDTH*x, display.cy - 190 + BlockSprite.HEIGHT*y)
end
--过关的动画
function gamescene:createPassAction()
    local actionLayer = cc.Layer:create()
    self:addChild(actionLayer,101)
    --防止触摸穿透
    local touchListener = cc.EventListenerTouchOneByOne:create()
    local function onTouchBegan()
        return true
    end
    touchListener:setSwallowTouches(true)
    touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener, actionLayer)
    local png = PngHelper.shared():init(1)
    local star = self.png:spriteFromJson("game_wrays"):move(cc.p(display.cx,display.cy)):addTo(actionLayer):setScale(display.width*1.6/283)
    local rotateAction=cc.RotateBy:create(10, 360)   
    star:runAction(cc.RepeatForever:create(rotateAction))
    --星星
    local star1 = self.png:spriteFromJson("game_zv1"):move(cc.p(display.cx-150+500,display.cy+280+500)):addTo(actionLayer):setScale(6)
    local star2 = self.png:spriteFromJson("game_zv2"):move(cc.p(display.cx+500,display.cy+300+500)):addTo(actionLayer):setScale(6)
    local star3 = self.png:spriteFromJson("game_zv3"):move(cc.p(display.cx+150+500,display.cy+280+500)):addTo(actionLayer):setScale(6)
    local starArr = {{sprite=star1, position=cc.p(display.cx-150,display.cy+280)},
                     {sprite=star2, position=cc.p(display.cx,display.cy+300)},
                     {sprite=star3, position=cc.p(display.cx+150,display.cy+280)}}
    for i=1,self.crrentStars do
        local delay = cc.DelayTime:create(i*0.5-0.5)
        local function callback()
            local moveAction = cc.MoveTo:create(0.3,starArr[i].position)
            local scaleAction = cc.ScaleTo:create(0.3,1)
            starArr[i].sprite:runAction(moveAction)
            starArr[i].sprite:runAction(scaleAction)
        end
        local sequence = cc.Sequence:create(delay,cc.CallFunc:create(callback))
        actionLayer:runAction(sequence)
    end
    png = PngHelper.shared():init(2)
    --公主与勇士    
    local backHomeBg = cc.Sprite:createWithSpriteFrameName("icon_pic7.png"):move(display.cx,display.cy+115):addTo(actionLayer)
    local passLevel = cc.Sprite:createWithSpriteFrameName("text_study.png"):move(display.cx,display.cy-50):addTo(actionLayer)                
   -- png:spriteFromJson("game_prog"):move(cc.p(display.cx,display.cy)):addTo(actionLayer)
    --按钮 不是关数
    png = PngHelper.shared():init(3) 
    local normalSprite,selectedSprite=png:spriteFromJson("intro_btn_start"),png:spriteFromJson("title_start_btn")
    local btn = cc.MenuItemSprite:create(normalSprite,selectedSprite,normalSprite):setEnabled(false)
    btn:registerScriptTapHandler(function()
    cc.UserDefault:getInstance():setIntegerForKey('buttonTag',1001)    
       self:animationFish()--挑战模式
    end)
    cc.Menu:create():move(cc.p(display.cx,display.cy-300)):addChild(btn):addTo(actionLayer)
    performWithDelay(self,function ()
        btn:setEnabled(true)
    end,0.5*self.crrentStars)
    return actionLayer
end
--滑动提示
function gamescene:slideHint()
    local actionLayer = cc.Layer:create()
    self:addChild(actionLayer,101)
    self.HintLayer = actionLayer
    --亲，滑动方块
    self.png:spriteFromJson("game_hlp_back"):move(cc.p(display.width*5/6,display.cy)):setAnchorPoint(cc.p(1,0)):addTo(actionLayer):setLocalZOrder(5)
    --手指 
    local finger = self.png:spriteFromJson("game_hlp"):move(cc.p(display.width*5/6,display.cy)):setAnchorPoint(cc.p(0,1)):addTo(actionLayer):setLocalZOrder(5):setOpacity(0):setScale(2)
    local function callback1()
        local moveBy = cc.MoveBy:create(1,cc.p(0,-250*display.height/960))
        local scale = cc.ScaleTo:create(1,1)
        local fade = cc.FadeIn:create(1)
        finger:runAction(moveBy)
        finger:runAction(scale)
        finger:runAction(fade)
    end
    local function callback2()
        finger:setScale(2):setOpacity(0):move(cc.p(display.width*5/6,display.cy))
    end
    local delay = cc.DelayTime:create(2)
    self.HintAction = self.HintLayer:runAction(cc.RepeatForever:create(cc.Sequence:create(
        cc.CallFunc:create(callback1),
        delay,
        cc.CallFunc:create(callback2))))
    return actionLayer
end
function gamescene:onCleanup()
    PngHelper.clearTexture()
end
return gamescene