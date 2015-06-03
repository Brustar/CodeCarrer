require("app.BrushThrough.BrushLevel")
local brushThroughScene = class("brushThroughScene",cc.load("mvc").ViewBase)

local gamelevel = 1

local levels=JsonManager.decode(levels)

local matrixs = levels[gamelevel].line
local points = levels[gamelevel].points
local plength = #points
local lastpoint = 0
local totallines = 0
local levelmatrix={}
local time = 120
local centerX=0
local centerY=0

function brushThroughScene:ctor()
    self:createLayer()
    --self:createTopLab()
    self:countdownBegin()
    self:init()
    self.draw = cc.DrawNode:create()
    self.draw:setLocalZOrder(1)
    self:addChild(self.draw, 1)
    self.draw2 = cc.DrawNode:create()
    self:addChild(self.draw2, 2)
    self.draw1 = cc.DrawNode:create()
    self:addChild(self.draw1, 3)    
    self:drawGraph()
    self:TouchBegame()
    self:onTouchEvent()
end

--创建游戏界面
function brushThroughScene:createLayer()
    self.gamelevel = gamelevel
    self:createResoueceNode("BrushThrough/gamepage.csb") 
    local bg = self.resourceNode_:getChildByName("bg")
    
    local img = bg:getChildByName("img")
    self.btn_home = bg:getChildByName("btn_home")
    self.layer = cc.Layer:create()
    self:addChild(self.layer)
   
    local level = bg:getChildByName("level");
    local level_num = level:getChildByName("level_num")
    local text_level = level:getChildByName("text_level")
    level_num:setVisible(false)
    local size = level:getContentSize()
    local testSize = text_level:getContentSize();

    self.level_num = ccui.TextAtlas:create()
    self.level_num:setProperty("1", "BrushThrough/num02.png",57,69,"."):setAnchorPoint(0.5, 0)
    self.level_num:setPosition(testSize.width+(size.width-testSize.width)*0.5,0)
    text_level:addChild(self.level_num)
    self.level_num:setString(self.gamelevel)


    local time = bg:getChildByName("time");
    local numTime = time:getChildByName("num_time")
    self.bar = time:getChildByName("bar")
    numTime:setVisible(false)
    local size = time:getContentSize()

    self.num_time = ccui.TextAtlas:create()
    self.num_time:setProperty("1", "BrushThrough/num01.png",41,43,".")
    self.num_time:setPosition(size.width*0.5,size.height*0.5)  
    time:addChild(self.num_time)
    self.num_time:setString(120)
end

--开始倒计时
function brushThroughScene:countdownBegin()
    
    local delay = cc.DelayTime:create(1)

    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    local function callback()
        time = time - 1
        self.bar:setPercent(100/120*time)
        self.num_time:setString(time)
        self.costtime=time
        if time == 0 then
            self.gamelevel = gamelevel
            gamelevel=1
            self:stopAction(self.countdownaction)
            self.endTime = os.date("%Y-%m-%d %H:%M:%S")
            local account=self:gameAgain()--排名
            local finishlayer = require("src.app.BrushThrough.BrushThroughView").new(1,self,account)
            self:addChild(finishlayer,10)
        end
    end

    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self.countdownaction = cc.RepeatForever:create(sequence)
    self:runAction(self.countdownaction)
end

--返回游戏,继续游戏
function brushThroughScene:TouchBegame()
    local function backCallback(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            local btn_home = cc.CSLoader:createNode("BrushThrough/backhome.csb") 
            self:addChild(btn_home,11)
            btn_home:setContentSize(display.size)
            ccui.Helper:doLayout(btn_home)
            local window = btn_home:getChildByName("bg"):getChildByName("window")
            self.btn_gogame = window:getChildByName("btn_gogame")
            self.btn_backhome = window:getChildByName("btn_backhome")   
            self.text = window:getChildByName("text")
            self.text:setString(string.format("您当前在第%s关哦,确定返回主页吗",gamelevel))
            local function onclose(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                     gamelevel=1
                    self:init()
                    self.level_num:setString(1)
                    self.num_time:setString(120)
                    self:countdownBegin()
                    self:drawGraph() 
                    self:removeFromParent()
                end
            end
            self.btn_backhome:addTouchEventListener(onclose)
            local function onreturn(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                    btn_home:removeFromParent()              
                end
            end
            self.btn_gogame:addTouchEventListener(onreturn)
        end
    end
    self.btn_home:addTouchEventListener(backCallback)
  
end

--画图形
function brushThroughScene:drawGraph()
    for i=1,plength do
        local arr2 = levelmatrix[i]
        for j=1,plength do
            if i<j then
                if arr2[j]>0 then
                    totallines=totallines+1
                end
                self:drawline(arr2[j],i,j,cc.c4f(182/255,244/255,1,1),self.draw,1.5)
            end
        end
    end
    for i=1,plength do
        self.draw2:drawSolidCircle(cc.p(centerX+points[i][1], centerY+points[i][2]),25,math.pi*2,50,cc.c4f(182/255,244/255,1,1))
    end    
end

--数据初始化
function brushThroughScene:init()
    matrixs = levels[gamelevel].line
    points = levels[gamelevel].points
    plength = #points
    lastpoint = 0
    totallines = 0
    time = 120

    --一维数组转二维数组
    local function init(param)
        local arr1 = {}
        for i=1,plength do
            local arr2={}
            for j=1,plength do
                table.insert(arr2,param[(i-1) * plength + j])
            end
            table.insert(arr1,arr2)
        end        
        return arr1
    end
    levelmatrix=init(matrixs)
end

--游戏结算
function brushThroughScene:gameAgain()
    local delay = cc.DelayTime:create(1)
    local BrushThroughEnd = GamePB_pb.PBOnepathGamelog_Update_Params()
    BrushThroughEnd.starttime = self.startTime
    BrushThroughEnd.endtime = self.endTime
    BrushThroughEnd.levels = self.gamelevel
    BrushThroughEnd.costtime =self.costtime
    local flag,endReturn = HttpManager.post("http://lxgame.lexun.com/interface/onepath/updategamelog.aspx",BrushThroughEnd:SerializeToString())
    if not flag then return end
    local obj=ServerBasePB_pb.PBMessage()
    obj:ParseFromString(endReturn)
end

--触摸事件
function brushThroughScene:onTouchEvent()
  
    local touchBeginPoint = nil
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        touchBeginPoint = {x = location.x, y = location.y}        
        for i=1,plength do
            if centerX+points[i][1]+20>=touchBeginPoint.x and centerX+points[i][1]-20<=touchBeginPoint.x and centerY+points[i][2]+20>=touchBeginPoint.y and centerY+points[i][2]-20<=touchBeginPoint.y then
                self.draw1:clear()
                self.draw1:drawCircle(cc.p(centerX+points[i][1], centerY+points[i][2]),25,math.pi*2,50,false,cc.c4f(0,1,0,2))
                self.draw1:drawSolidCircle(cc.p(centerX+points[i][1], centerY+points[i][2]),15,math.pi*2,50,cc.c4f(1,0,0,2))
                if lastpoint>0 and lastpoint~=i then
                    local index1 = lastpoint
                    local index2 = i
                    if lastpoint>i then
                        index1=i
                        index2=lastpoint                    
                    end
                    --游戏失败
                    if levelmatrix[index1][index2]==0 then
                        self.gamelevel = gamelevel
                        self.endTime = os.date("%Y-%m-%d %H:%M:%S")
                        gamelevel=1
                        self:stopAction(self.countdownaction)
                        local account=self:gameAgain()
                        local finishlayer = require("src.app.BrushThrough.BrushThroughView").new(2,self,account)
                        self:addChild(finishlayer,10)
                        
                    else
                        local draw1 = cc.DrawNode:create()
                        self.draw:addChild(draw1,1)
                        self:drawline(levelmatrix[index1][index2],index1,index2,cc.c4f(0,1,0,1),draw1,6)
                        levelmatrix[index1][index2] = 0                        
                        totallines = totallines - 1
                        --进入下一关
                        if totallines<=0 then
                            --通关
                            if gamelevel>=#levels then
                                self.gamelevel = gamelevel
                                self.endTime = os.date("%Y-%m-%d %H:%M:%S")
                                gamelevel=1
                                self:stopAction(self.countdownaction)
                                local account=self:gameAgain()
                                local finishlayer = require("src.app.BrushThrough.BrushThroughView").new(3,self,account)
                                self:addChild(finishlayer,10)
                            else
                                gamelevel=gamelevel+1
                                self.draw:removeAllChildren()
                                self.draw:clear()
                                self.draw1:clear()
                                self.draw2:clear()
                                self:init()
                                self.level_num:setString(gamelevel)
                                self.num_time:setString(120)
                                self:drawGraph()
                                break
                            end
                        end
                    end
                end
                lastpoint=i
                break
            end
        end
    --    return true //吞噬触摸事件
    end

    local function onTouchEnded()
        touchBeginPoint = nil
    end    

    local touchListener = cc.EventListenerTouchOneByOne:create()
    touchListener:setSwallowTouches(true)
    touchListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener, self.layer)
end

--画线
function brushThroughScene:drawline(param,i,j,c4f,draw,r)
    --print(draw:getOpacity())
    if param==1 then
        draw:drawSegment(cc.p(centerX+points[i][1], centerY+points[i][2]), cc.p(centerX+points[j][1], centerY+points[j][2]),r,c4f )
    elseif param==2 then
        draw:drawSegment(cc.p(centerX+points[i][1], centerY+points[i][2]), cc.p(centerX+points[i][1]+40, centerY+points[i][2]+40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+40, centerY+points[i][2]+40), cc.p(centerX+points[i][1]+440, centerY+points[i][2]+40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+440, centerY+points[i][2]+40), cc.p(centerX+points[i][1]+480, centerY+points[i][2]-40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+480, centerY+points[i][2]-40), cc.p(centerX+points[i][1]+480, centerY+points[i][2]-40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+480, centerY+points[i][2]-40), cc.p(centerX+points[j][1], centerY+points[j][2]),r, c4f)
    elseif param==3 then
        draw:drawSegment(cc.p(centerX+points[i][1], centerY+points[i][2]), cc.p(centerX+points[i][1]+40, centerY+points[i][2]-40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+40, centerY+points[i][2]-40), cc.p(centerX+points[i][1]+440, centerY+points[i][2]-40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+440, centerY+points[i][2]-40), cc.p(centerX+points[i][1]+480, centerY+points[i][2]+40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+480, centerY+points[i][2]+40), cc.p(centerX+points[i][1]+480, centerY+points[i][2]+40),r, c4f)
        draw:drawSegment(cc.p(centerX+points[i][1]+480, centerY+points[i][2]+40), cc.p(centerX+points[j][1], centerY+points[j][2]),r, c4f)
    elseif param==4 then
        draw:drawCubicBezier(cc.p(centerX+points[i][1], centerY+points[i][2]),cc.p(centerX+points[i][1]-120, centerY+points[i][2]-200),cc.p(centerX+points[i][1]-120, centerY+points[i][2]+200), cc.p(centerX+points[j][1], centerY+points[j][2]),50,c4f)
    elseif param==5 then
        draw:drawCubicBezier(cc.p(centerX+points[i][1], centerY+points[i][2]),cc.p(centerX+points[i][1]+120, centerY+points[i][2]-200),cc.p(centerX+points[i][1]+120, centerY+points[i][2]+200), cc.p(centerX+points[j][1], centerY+points[j][2]),50,c4f)    
    elseif param==6 then
        draw:drawCubicBezier(cc.p(centerX+points[i][1], centerY+points[i][2]),cc.p(centerX+points[i][1]-160, centerY+points[i][2]-160),cc.p(centerX+points[i][1]-160, centerY+points[i][2]+160), cc.p(centerX+points[j][1], centerY+points[j][2]),50,c4f)        
    end
end

return brushThroughScene