local GameLayer = class("GameLayer",cc.load("mvc").ViewBase)

PeopleSprite = require("app.Maze.PeopleSprite")

local winSize = cc.Director:getInstance():getWinSize()
local MAX_CANVAS_WIDTH = 0
local MARGIN_X = 0 --边距
local MARGIN_Y = 0 --y坐标
local map={}--地图对象
local nums = 0
local levels=1
local oneSize=0
local endX=0
local endY=0
local x=0
local y=0
local stepNums = 0

function GameLayer:onCreate()
    levels = 1
    nums = 6
    oneSize = 0
    stepNums = 0
    self:gameInfoCSB()
    self:gameInfoTouch()
    self:createMap(nums)--初始化地图
    self:createMapItem(math.ceil(nums * nums / 2), 0)-- 随机地图 
    --self:createMapItem(nums * nums, 0)-- 随机地图 
    
    local index=nums*nums - nums + 1 --索引
    self.sprite=PeopleSprite.new(map, 0, nums-1, index, oneSize)

    --画小格子
    self:createGrid()
    --画线
    self:createLine()

    self:setStartAndEnd()

    self:addTouchListenerForBody()

    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    
end

function GameLayer:getXY(posX, posY)
    return MARGIN_X+(posX*oneSize)+oneSize/2, MARGIN_Y+(posY*oneSize)+oneSize/2
end

function GameLayer:gameInfoCSB()
    self:createResoueceNode("Maze/MainScene.csb")
    self.btnBack = self.resourceNode_:getChildByName("btn_back")
    self.gameBackgroud = self.resourceNode_:getChildByName("main_game")
    
    self.leftwall = self.resourceNode_:getChildByName("bg"):getChildByName("img_wall_left")
    self.leftwallbounds = self.leftwall:getBoundingBox()
    self.bounds =  self.gameBackgroud:getBoundingBox()
    
    self.gameBackgroud:setPosition(cc.p(self.bounds.x, self.leftwallbounds.y + (self.leftwallbounds.height - self.bounds.height)/2))
    
    self.people = self.gameBackgroud:getChildByName("img_people")
    self.people:setLocalZOrder(11)
    self.house = self.gameBackgroud:getChildByName("img_house")
    self.house:setLocalZOrder(10)
    self.panelLevel = self.resourceNode_:getChildByName("panel_guan")
    self.levelNum = self.panelLevel:getChildByName("number")
    self.levelNum:setString(1)
    MAX_CANVAS_WIDTH = self.bounds.width - 12
    MARGIN_X = 12
    MARGIN_Y = 12
end

function GameLayer:gameInfoTouch()
    --回游戏主界面
    local function goback(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("MazeScene")
		end
    end
    self.btnBack:addTouchEventListener(goback)
end

--画矩形
function GameLayer:createRectang(draw, x, y, size, fillColor, border, color)
    local points = {
        cc.p(x,y), 
        cc.p(size + x, y), 
        cc.p(x + size, y + size),
        cc.p(x, y + size)
    }  
    draw:drawPolygon(points, table.getn(points), fillColor, border, color)
end

--画左边线
function GameLayer:createLeftLine(draw, x, y, size, border, color)
    draw:drawSegment(cc.p(x,y), cc.p(x,y+size),border,color)
end
--画右边线
function GameLayer:createRightLine(draw, x, y, size, border, color)
    draw:drawSegment(cc.p(x+size,y), cc.p(x+size,y+size),border,color)
end
--画上边线
function GameLayer:createTopLine(draw, x, y, size, border, color)
    draw:drawSegment(cc.p(x,y+size), cc.p(x+size,y+size),border,color)
end
--画下边线
function GameLayer:createbBelowLine(draw, x, y, size, border, color)
    draw:drawSegment(cc.p(x,y), cc.p(x+size,y),border,color)
end

--根据类型获取四边状态 1,表示可以通过，0表示不能通过
function GameLayer:getSide(t)
    if t==0 then
        return 1,1,1,1
    elseif t==1 then
        return 1,1,1,0
    elseif t==2 then
        return 0,1,1,1
    elseif t==3 then
        return 0,1,1,0
    elseif t==4 then
        return 1,0,1,1
    elseif t==5 then
        return 1,0,1,0
    elseif t==6 then
        return 0,0,1,1
    elseif t==7 then
        return 0,0,1,0
    elseif t==8 then
        return 1,1,0,1
    elseif t==9 then
        return 1,1,0,0
    elseif t==10 then
        return 0,1,0,1
    elseif t==11 then
        return 0,1,0,0
    elseif t==12 then
        return 1,0,0,1
    elseif t==13 then
        return 1,0,0,0
    elseif t==14 then
        return 0,0,0,1
    elseif t==15 then
        return 0,0,0,0
    end
end


--初始化地图
function GameLayer:createMap(nums)
    self.nums = nums
    map={}
    for i=1,nums*nums do        
        local x=(i-1)%nums--x坐标，从0开始
        local y=math.ceil(i/nums)-1--y坐标，从0开始
        local item={1,1,1,1,x,y,-1}--下，右，上，左，x,y,是否使用
        table.insert(map,item)
    end

    oneSize = (MAX_CANVAS_WIDTH-12)/self.nums--小格子
end

--随机生成地图
function GameLayer:createMapItem(n,o)
    local item=map[n]
    local p1=1--下
    local p2=1--右
    local p3=1--上
    local p4=1--左

    if o==1 then
        p1,p2,p3,p4=self:getSide(4)
    elseif o==2 then
        p1,p2,p3,p4=self:getSide(8)
    elseif o==4 then
        p1,p2,p3,p4=self:getSide(1)
    elseif o==8 then
        p1,p2,p3,p4=self:getSide(2)
    end
    item[1]=p1
    item[2]=p2
    item[3]=p3
    item[4]=p4

    local len=#(map)--地图方格数    
    local directs = {0,1,2,3}--存储未用的方向。0,1,2,3表示下右上左    
    
    --遍历item的四个方向
    while #(directs) > 0 do        
        local x=item[5]
        local y=item[6]
        local t=0
        --随机位置
        local p = self:createRandom(1,#directs)
        p = self:createRandom(1,#directs)
        local r = directs[p]
        table.remove(directs,p)--删除第r个索引
        if r==0 then--下            
            y=y-1
            t=2
        elseif r==1 then--右
            x=x+1
            t=4
        elseif r==2 then--上
            y=y+1
            t=8
        elseif r==3 then--左
            x=x-1
            t=1
        end

        local index=y*self.nums+x+1--下一个位置的索引
        if index<=len and x>=0 and y>=0 and x<self.nums and y<self.nums then
            local _item=map[index] --拆墙的格子
            if _item[7]==-1 then
                local _p1=0--下
                local _p2=0--右
                local _p3=0--上
                local _p4=0--左                
                --t位置的图形
                _p1,_p2,_p3,_p4=self:getSide(t)
                --位与
                p1=bit.band(_p1,p1)
                p2=bit.band(_p2,p2)
                p3=bit.band(_p3,p3)
                p4=bit.band(_p4,p4)
                item[1]=p1
                item[2]=p2
                item[3]=p3
                item[4]=p4
                item[7]=1
                self:createMapItem(index,t)
            end            
        end
    end    
end

--画小格子
function GameLayer:createGrid()
    for n,v in ipairs(map) do
        local item=map[n]        
        local r=self:createRandom(0,10)
        local color=cc.c4f(251/255, 243/255, 206/255,10)
        if r==0 then
            color=cc.c4f(247/255, 236/255, 167/255,10)
        elseif r==1 then
            color = cc.c4f(233/255, 231/255, 183/255,10)
        end

        local i=item[5]
        local j=item[6]
        local x = MARGIN_X + i * oneSize
        local y = MARGIN_Y + j * oneSize
        local draw = cc.DrawNode:create()        
        self:createRectang(draw, x, y, oneSize, color, 0, color)
        self.gameBackgroud:addChild(draw) 
    end
end

--画线
function GameLayer:createLine()
    for n,v in ipairs(map) do
        local item=map[n]
        local i=item[5]
        local j=item[6]
        local x = MARGIN_X + i * oneSize
        local y = MARGIN_Y + j * oneSize        
        local color = cc.c4f(138/255, 206/255, 97/255,10)        
        if item[4]==1 and i~=0 then--画左边线
            local draw = cc.DrawNode:create()
            self:createLeftLine(draw, x, y, oneSize, 1, color)
            self.gameBackgroud:addChild(draw)
        end
        if item[3]==1 and (j+1)%self.nums~=0 then--画上边线
            local draw = cc.DrawNode:create()
            self:createTopLine(draw, x, y, oneSize, 1, color)
            self.gameBackgroud:addChild(draw)
        end
        if item[2]==1 and (i+1)%self.nums~=0 then--画右边线
            local draw = cc.DrawNode:create()
            self:createRightLine(draw, x, y, oneSize, 1, color)
            self.gameBackgroud:addChild(draw)
        end
        if item[1]==1 and j~=0 then--画下边线
            local draw = cc.DrawNode:create()
            self:createbBelowLine(draw, x, y, oneSize, 1, color)
            self.gameBackgroud:addChild(draw)
        end
    end
end

function GameLayer:setStartAndEnd()
    x=0
    y=0
    --设置精灵的位置
    local curX, curY = GameLayer:getXY(0, self.nums - 1)
    self.people:setPosition(curX, curY)
    self.people:setScale(6/self.nums)
    --随机一个终点坐标
    endX=self:createRandom(math.ceil(self.nums/2)-1, self.nums-2)
    endY=self:createRandom(1, math.ceil(self.nums/2) - 1)
    curX, curY = GameLayer:getXY(endX, endY)
    self.house:setPosition(curX, curY)
    self.house:setScale(6/self.nums)
end

function  GameLayer:addTouchListenerForBody()
    local layer = cc.Layer:create()
    self:addChild(layer)
    local function onTouchBegan(touch,event)
        self.fristTouchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
        return true
    end

    local  function onTouchMoved(touch,event)

    end

    local function onTouchEnded(touch,event)
        self.lastTouchPoint = event:getCurrentTarget():convertToNodeSpace(touch:getLocation())
        local offsetX = self.lastTouchPoint.x - self.fristTouchPoint.x
        local offsetY = self.lastTouchPoint.y - self.fristTouchPoint.y
        local forward=""

        if offsetX<0 and math.abs(offsetX)>math.abs(offsetY) then --left forward
            forward=PeopleSprite.LEFT
        elseif offsetY>0 and math.abs(offsetX)<math.abs(offsetY) then --up forward
            forward=PeopleSprite.UP
        elseif offsetX>0 and math.abs(offsetX)>math.abs(offsetY) then --right forward
            forward=PeopleSprite.RIGHT
        elseif offsetY<0 and math.abs(offsetX)<math.abs(offsetY) then --down  forward
            forward=PeopleSprite.DOWN
        end

        local canMove, posX, posY =  self.sprite:move(forward)

        if canMove == true then
            local curX, curY = GameLayer:getXY(posX, posY)
            self.people:setPosition(cc.p(curX, curY))
            stepNums = stepNums + 1
        end
        if posX==endX and posY==endY then
            self.endTime = os.date("%Y-%m-%d %H:%M:%S")
            levels = levels + 1
            self.nums = self.nums + 1
            self:SumbitData()

            self:createMap(self.nums)--初始化地图
            self:createMapItem(1,0)--随机地图 
            
            local index= self.nums* self.nums - self.nums + 1--索引
            self.sprite=PeopleSprite.new(map, 0, self.nums - 1, index, oneSize)
            --画小格子
            self:createGrid()
            --画线
            self:createLine()
            self:setStartAndEnd()
            self.levelNum:setString(levels)
        end

    end
    -- 注册单点触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
end

--产生随机数n-m
function GameLayer:createRandom(n,m)
    return math.random(n,m)
end


function GameLayer:SumbitData()
	local params = GamePB_pb.PBMazeGamelog_Update_Params()
	params.starttime = self.startTime
	params.endtime = self.endTime
	params.levels = levels - 1
	params.stepnum = stepNums
    
	local flag,retData = HttpManager.post("http://lxgame.lexun.com/interface/Maze/updategamelog.aspx",params:SerializeToString())
	if not flag then return end
    local obj= ServerBasePB_pb.PBMessage()
    obj:ParseFromString(retData)
end

return GameLayer