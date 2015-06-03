
local FiveChessView = class("FiveChessView", cc.load("mvc").ViewBase)
local FiveChessBase = import(".FiveChessBase")
local FiveChessAI = import(".FiveChessAI")
local FiveChessTouch = require("app.FiveChess.FiveChessTouch").new()
FiveChessView.click = "FiveChessClick" --控制五子棋音效的开关
local length = 600*(display.width/640)
function FiveChessView:onCreate()
    cc.bind(self, "event")
    self:infoGameLayer()
end
-- 创建矩形区域
function FiveChessView:createRectangleStencil(para)
    local stencil = cc.DrawNode:create()
    local rectanglePoints = {
        cc.p(para.startW, para.startH),
        cc.p(para.width, para.startH),
        cc.p(para.width, para.height),
        cc.p(para.startW, para.height)
    }
    stencil:drawPolygon(rectanglePoints, 4, para.colour, 0, para.colour)
    return stencil
end
-- 创建可裁剪的节点用于指定区域显示
function FiveChessView:createClippingNode(size, pos)
    local clipper = cc.ClippingNode:create()
    clipper:setContentSize(size)
    clipper:setAnchorPoint(cc.p(0,0))
    clipper:setPosition(pos)
    return clipper
end
--初始化游戏界面
function FiveChessView:infoGameLayer()
    self:createResoueceNode("FiveChess/MainScene.csb")
    local CSB = self.resourceNode_
    local bg = CSB:getChildByName("bg")
    local gamePanel = bg:getChildByName("gamemain")
    self.gamePanel = gamePanel
    self.game_bg = gamePanel:getChildByName("game_bg")
    self.img_select = gamePanel:getChildByName("img_select")
    self.select = self.img_select:clone() --因为重构出来的和棋子父亲不一样，所有clone一个加载在棋子的父亲上面
    self.select:setVisible(false)
    self:addChild(self.select)
    self.btn_home = bg:getChildByName("btn_back")
    self.btn_upstep = bg:getChildByName("btn_upstep")
    self.btn_voice = bg:getChildByName("btn_voice")
    self.icon_voice = self.btn_voice:getChildByName("Sprite_2")
    self.timeLabel = bg:getChildByName("time")
    self.head_shown = bg:getChildByName("head_shown")
    self.img_head = self.head_shown:getChildByName("img")
    self.lab_head = self.head_shown:getChildByName("Text_1")
    self.head_shown:setVisible(false)
    gamePanel:setVisible(false)
    --建裁切区
    local para = {
        startW = 0,
        startH = 0,
        width = length,
        height = length,
        colour = cc.c4f(1, 1, 1, 0.8)
    }
    local noteAdStencil = self:createRectangleStencil(para)

    self.noteAdClipper = self:createClippingNode(cc.size(length,length), cc.p(20*display.width/640,140*display.width/640))
    self.noteAdClipper:setStencil(noteAdStencil)
    self:addChild(self.noteAdClipper)

    --放大缩小按钮
    local function upstepBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self.chessBoard:setPosition(length*0.5,length*0.5)
            local gesture = self.head_shown:clone()
            gesture:setVisible(true)
            self.noteAdClipper:addChild(gesture)
            gesture:setPosition(length*0.5,length*0.5)
            local sprite = cc.Sprite:createWithSpriteFrameName("hand_1_wzq.png")
            gesture:addChild(sprite)
            sprite:setPosition(100,122)
            local lab = gesture:getChildByName("Text_1")
            lab:setString("手势放大")
            local action = cc.ScaleTo:create(1,2)
            self.chessBoard:runAction(action)
            performWithDelay(self, function ()
                local action = cc.ScaleTo:create(1,1)
                self.chessBoard:runAction(action)
                lab:setString("手势缩小")
               sprite:setSpriteFrame("hand_2_wzq.png")
                performWithDelay(self, function ()
                    gesture:removeFromParent()

                end,1)
            end,1)
        end
    end
    self.btn_upstep:addTouchEventListener(upstepBack)
    --声音按钮
    local judge = cc.UserDefault:getInstance():getStringForKey(FiveChessView.click)
    if judge == "" or judge == "0" then
       self.icon_voice:setSpriteFrame("icon_voice_wzq.png")
    else
        self.icon_voice:setSpriteFrame("icon_voice_zero_wzq.png")
    end
    self.btn_voice:addTouchEventListener(handler(self,self.voiceControl))
    --返回按钮
    local function homeCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:infoReturnCSB(CSB)
        end
    end
    self.btn_home:addTouchEventListener(homeCallBack)

    self.steps = 0                 --用的步数  
    self.isPlayer = true           --是否轮到玩家下
    self.chess = {}                --棋子数值
    self.chessView = {}            --棋子视图
    self.chessRectSize = 0         --棋子容器大小
    self.chessRect = {}            --棋子左上角坐标
    self.cbX = 0                   --棋盘左上角X坐标
    self.cbY = 0                   --棋盘左下角Y坐标
    self.isGameOver = false        --是否游戏结束
    self.wins = 0                  --玩家赢的局数
    self.isGameStart = false       --游戏是否开始
    self.time = 0.0
    self.scheduler = nil
    self.myUpdate = nil
    self.AI = FiveChessAI.create()
    self.scale = 1
    -- --显示计时
    self.scheduler = cc.Director:getInstance():getScheduler()
    --添加棋盘
    self.chessBoard = ccui.ImageView:create("FiveChess/img_game_bg.png")
    self.chessBoard:setScale9Enabled(true)
    self.chessBoard:setPosition(length*0.5,length*0.5)
    self.noteAdClipper:addChild(self.chessBoard)
    self.chessBoardSize = self.chessBoard:getContentSize().width
    self.cbX = gamePanel:getPositionX()
    self.cbY = gamePanel:getPositionY() 
    self:resetChessBoard()
    self.chessRectSize = self.chessBoardSize / 15 --每个棋子分配的大小
    self:calcChessRect() 

    FiveChessTouch:infoTouchEvent(self)
end
--初始化返回CSB
function FiveChessView:infoReturnCSB(parent)
    local CSB = cc.CSLoader:createNode("FiveChess/gohome.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local dailog_bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    local back_btn = dailog_bg:getChildByName("Button_2")
    local close_btn = dailog_bg:getChildByName("btn_close")
    local function callback(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == back_btn then
                if self.scheduler and self.myUpdate then
                    self.scheduler:unscheduleScriptEntry(self.myUpdate) --取消定时器
                end
                self:getApp():enterScene("FiveChessScene")
            elseif sender == close_btn then
                performWithDelay(self, function ()
                    CSB:removeFromParent()
                end,0.001)
            end
        end
    end
    back_btn:addTouchEventListener(callback)
    close_btn:addTouchEventListener(callback)
end
--五子棋声音控制
function FiveChessView:voiceControl(sender,eventType)
    if eventType == ccui.TouchEventType.ended then
        --0:开状态 1:关状态
        local judge = cc.UserDefault:getInstance():getStringForKey(FiveChessView.click)
        if judge == ""then
            judge = "0" 
        end
        if judge == "0" then
          --  self.icon_voice:setOpacity(128)
            self.icon_voice:setSpriteFrame("icon_voice_zero_wzq.png")
            cc.UserDefault:getInstance():setStringForKey(FiveChessView.click,"1")
        elseif judge == "1" then
        --    self.icon_voice:setOpacity(255)
            self.icon_voice:setSpriteFrame("icon_voice_wzq.png")
            cc.UserDefault:getInstance():setStringForKey(FiveChessView.click,"0")
        end 
    end
end
function FiveChessView:onTouch(event)
    if event.name ~= "began" then
        return true
    end
    if not self.isPlayer or self.isGameOver then --轮到机器人或游戏结束
        return
    end
    
    local x, y = event.x, event.y
    if  x>= self.cbX-self.chessBoardSize*0.5 and x<=self.cbX+self.chessBoardSize*0.5 
        and y>=self.cbY-self.chessBoardSize*0.5 and y<=self.cbY+self.chessBoardSize*0.5 then
        self:startPlayer(x, y)
    end
end

function FiveChessView:onCleanup()
    self:removeAllEventListeners()
end

--重置棋盘
function FiveChessView:resetChessBoard()
    for i = 1, 255 do
        self.chess[i] = FiveChessBase.NO_CHESS
    end
    for i, chess in pairs(self.chessView) do
        self.chessView[i] = nil
        chess:removeSelf()
    end
    
    --初始化参数
    self.steps = 0
    self.isPlayer = true
    self.isGameOver = false
    self.isGameStart = false
    self.time = 0.0
    self.myUpdate = nil
    if self.timeLabel then
        self.timeLabel:setString(self:getTime())
    end
end

--玩家开始下棋
function FiveChessView:startPlayer(x, y)
    self.steps = self.steps + 1
    if cc.UserDefault:getInstance():getStringForKey(FiveChessView.click) == "0" or 
       cc.UserDefault:getInstance():getStringForKey(FiveChessView.click) == "" then
        audio.playSound("Sound/FiveChess/click.mp3", false)
    end
    local index = 0
    for i = 1, 225 do
        local locationInNode = self.chessBoard:convertToNodeSpace(cc.p(x,y))

        local bubble_rect = self.chessRect[i]:getBoundingBox()
        if cc.rectContainsPoint(bubble_rect,locationInNode) then
            index = i
        end
    end
    if index > 0 and self.chess[index] == 0 then
        if not self.isGameStart then
            self.startTime = os.date("%Y-%m-%d %H:%M:%S")
            self.isGameStart = true           
            --定时器：0.1秒更新
            self.myUpdate = self.scheduler:scheduleScriptFunc(function()
                self.time = self.time + 0.1
                self.timeLabel:setString(self:getTime())
            end, 0.1, false)
        end

        local size = self.chessRect[index]:getContentSize()
        local sprite = display.newSprite("FiveChess/chess_black.png")
        sprite:setScale(self.scale)
              :move(size.width*0.5,size.height*0.5)
              :addTo(self.chessRect[index])
        self.chessView[index] = sprite
        self.chess[index] = FiveChessBase.BLACK_CHESS
        if self:isWin(index) then --判断是否赢
            self.wins = self.wins + 1
            self:setGameOver(true)
        else
            self.isPlayer = false
            self:startAI()
        end
    end
end

--机器人开始下棋
function FiveChessView:startAI()
    local temp = 0
    local maxIndex = 0
    local maxWeight = 0
    
    for i = 15, 1, -1 do
        for j = 15, 1, -1 do
            local index = self.AI:getIndex(i, j)
            if self.chess[index] == FiveChessBase.NO_CHESS then
                temp = self.AI:computeWeight(index, self.chess)
                if temp > maxWeight then
                    maxWeight = temp
                    maxIndex = index
                end
            end
       end
    end
    
    local size = self.chessRect[maxIndex]:getContentSize()
    local sprite = display.newSprite("FiveChess/chess_white.png")
    sprite:setScale(self.scale)
          :move(size.width*0.5,size.height*0.5)
          :addTo(self.chessRect[maxIndex])
    self.chessView[maxIndex] = sprite
    self.chess[maxIndex] = FiveChessBase.WHITE_CHESS

    if self:isWin(maxIndex) then --判断是否赢
        self:setGameOver(false)
    else
        self.isPlayer = true
    end
end

--画出所有可以落子的快
function FiveChessView:calcChessRect()
    for row = 1, 15 do
        for col = 1, 15 do
            local eachDye = cc.Sprite:create()
            eachDye:setTextureRect(cc.rect(0,0,self.chessRectSize-3,self.chessRectSize-3))
            eachDye:setColor(cc.c3b(255,0,0))
            eachDye:setOpacity(0)
            self.chessBoard:addChild(eachDye)
            eachDye:setPosition(self.chessRectSize*0.5+(col - 1) * self.chessRectSize,self.chessRectSize*0.5+(row - 1) * self.chessRectSize)
            table.insert(self.chessRect,eachDye)
        end
    end
end

--是否赢
function FiveChessView:isWin(index)
    local info = nil
    local x, y = self.AI:getXY(index)
    local checkColor = FiveChessBase.BLACK_CHESS
    if not self.isPlayer then
        checkColor = FiveChessBase.WHITE_CHESS
    end

    info = self.AI:putDirectX(self.chess, x, y, checkColor,self.chessView) --X方向
    if info.nums >= 5 then
        self.chessView[index]:setColor(cc.c3b(255,0,0)) --结束时5个连一起的变色
        for _,v in ipairs(info.views) do
            v:setColor(cc.c3b(255,0,0))
        end
        return true
    end
    
    info = self.AI:putDirectY(self.chess, x, y, checkColor,self.chessView) --Y方向
    if info.nums >= 5 then
        self.chessView[index]:setColor(cc.c3b(255,0,0))
        for _,v in ipairs(info.views) do
            v:setColor(cc.c3b(255,0,0))
        end
        return true
    end
    
    info = self.AI:putDirectXY(self.chess, x, y, checkColor,self.chessView) --左斜方向
    if info.nums >= 5 then
        self.chessView[index]:setColor(cc.c3b(255,0,0))
        for _,v in ipairs(info.views) do
            v:setColor(cc.c3b(255,0,0))
        end
        return true
    end
    
    info = self.AI:putDirectYX(self.chess, x, y, checkColor,self.chessView) --右斜方向
    if info.nums >= 5 then
        self.chessView[index]:setColor(cc.c3b(255,0,0))
        for _,v in ipairs(info.views) do
            v:setColor(cc.c3b(255,0,0))
        end
        return true
    end
    
    return false
end

--游戏结束
function FiveChessView:setGameOver(isPlayerWin)
    self.endTime = os.date("%Y-%m-%d %H:%M:%S")
    self.isGameOver = true
    self.scheduler:unscheduleScriptEntry(self.myUpdate) --取消定时器
    self.select:setVisible(false)

    local FiveChessEnd = GamePB_pb.PBGobangGamelog_Update_Params()
    FiveChessEnd.starttime = self.startTime
    FiveChessEnd.endtime = self.endTime
    FiveChessEnd.stepnum = self.steps
    FiveChessEnd.costtime = self.time
    if isPlayerWin then
        FiveChessEnd.iswin = 1
    else
        FiveChessEnd.iswin = -1   
    end
    local flag,endReturn = HttpManager.post("http://lxgame.lexun.com/interface/gobang/updategamelog.aspx",FiveChessEnd:SerializeToString())
    if not flag then return end
    local obj=ServerBasePB_pb.PBMessage()
    obj:ParseFromString(endReturn)
    print(obj.outmsg)

    if isPlayerWin then --玩家赢 
        performWithDelay(self, function ()
            self:onPlayerWin()
        end, 1)
    else
        performWithDelay(self, function ()
            self:onPlayerDead()
        end, 1)
    end
end
--初始化结算CSB
function FiveChessView:infoFinishCSB(which)
    local CSB = cc.CSLoader:createNode("FiveChess/replay_game.csb") 
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    self:addChild(CSB)
    local dailog = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg"):getChildByName("dailog")
    self.img_success = dailog:getChildByName("img_success")
    self.img_failed = dailog:getChildByName("img_failed")
    self.dcontent = dailog:getChildByName("dcontent")
    self.btn_regame = dailog:getChildByName("btn_regame")
    self.btn_exit = dailog:getChildByName("btn_exit")
    if which == 1 then
        self.img_success:setVisible(true)
        self.img_failed:setVisible(false)
        self.dcontent:setString("太厉害了，挑战成功")
    elseif which == 2 then
        self.img_success:setVisible(false)
        self.img_failed:setVisible(true)
        self.dcontent:setString("你输了，再挑战一次")
    end
    local function callback(sender,eventTpye)
        if eventTpye == ccui.TouchEventType.ended then
            if sender == self.btn_regame then
                CSB:removeFromParent()
                self:resetChessBoard()          
            elseif sender == self.btn_exit then
                self:getApp():enterScene("FiveChessScene")
            end
        end
    end
    self.btn_regame:addTouchEventListener(callback)
    self.btn_exit:addTouchEventListener(callback)
end
--玩家输提示
function FiveChessView:onPlayerDead()
    self:infoFinishCSB(2)
end

--玩家赢提示
function FiveChessView:onPlayerWin()
    self:infoFinishCSB(1)
end
function FiveChessView:getTime()
    return string.format("计时：%.1f秒", self.time)
end

return FiveChessView