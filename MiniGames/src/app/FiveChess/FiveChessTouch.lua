local FiveChessTouch = class("FiveChessTouch",FiveChessView)
local length = 600*(display.width/640)
--注册点击事件
function FiveChessTouch:infoTouchEvent(view)
    local beginPoint1,endPoint1,beginPoint2,endPoint2
    local movepoint1_x,movepoint1_y,movepoint2_x,movepoint2_y,betmovepoint,pointGL
    local ischange = false -- 是否进过ended
    view.BoardScale = 1 --棋盘缩放的比例
    local function onTouchBegan(touchs, event)
        local judpoint = view.noteAdClipper:convertToNodeSpace(touchs[1]:getLocation())
        if judpoint.x <0 or judpoint.y<0 or judpoint.x > length or judpoint.y > length then
            return
        end
        ischange = false
        beginPoint1 = touchs[1]:getLocation()
        movepoint1_x,movepoint1_y = beginPoint1.x,beginPoint1.y --移动时点击的初始点
        if touchs[2] then
            print("=====beginTwo")
            beginPoint2 = touchs[2]:getLocation()
            movepoint2_x,movepoint2_y = beginPoint2.x,beginPoint2.y
            --两个初始点之间的距离
            betmovepoint = math.sqrt(math.pow((movepoint2_x-movepoint1_x),2)+math.pow((movepoint2_y-movepoint1_y),2))
            pointGL = cc.p((beginPoint1.x+beginPoint2.x)*0.5,(beginPoint1.y+beginPoint2.y)*0.5)
        end
        return true
    end
    local function onTouchMove(touchs, event)
        local judpoint = view.noteAdClipper:convertToNodeSpace(touchs[1]:getLocation())
        if judpoint.x <0 or judpoint.y<0 or judpoint.x > length or judpoint.y > length then
            return
        end
        if touchs[2] == nil then
             print("====onePoint")
           -- local point = view.gamePanel:convertToNodeSpace(touchs[1]:getLocation())--点击点相对于scrllview的坐标
            if not ischange then --保证放大缩小手指离开时不会拖动棋盘
                local point=touchs[1]:getLocation()
                local BP_x,BP_y = view.chessBoard:getPosition()
                local EP_x,EP_y = BP_x+point.x-movepoint1_x,BP_y+point.y-movepoint1_y
                local moveX,moveY = point.x-movepoint1_x,point.y-movepoint1_y
                local isX1,isX2,isY1,isY2 = false,false,false,false --是否是边界
                if EP_x >length*0.5+(length*view.BoardScale-length)/2 then
                    isX1 = true
                end
                if EP_x <length*0.5-(length*view.BoardScale-length)/2 then
                    isX2= true
                end
                if EP_y >length*0.5+(length*view.BoardScale-length)/2 then
                    isY1 = true
                end
                if EP_y <length*0.5-(length*view.BoardScale-length)/2 then
                    isY2 = true
                end
                -- 控制各种滑到边界的情况
                if isX1 and isX2 and isY1 and isY2 then
                    return
                end
                if isX1 then
                    if moveX > 0 then
                        moveX = 0
                    end
                end
                if isX2 then
                    if moveX <0 then
                        moveX = 0
                    end
                end
                if isY1 then
                    if moveY > 0 then
                        moveY = 0 
                    end
                end
                if isY2 then
                    if moveY < 0 then
                        moveY = 0
                    end
                end
                local move = cc.MoveBy:create(0.001,cc.p(moveX,moveY))
                view.chessBoard:runAction(move)
                BP_x,BP_y = view.chessBoard:getPosition()
                print("=BP_x,BP_y===",BP_x,BP_y)
                movepoint1_x,movepoint1_y = point.x,point.y --更改初始点
            end
        else
            local judpoint2 = view.noteAdClipper:convertToNodeSpace(touchs[1]:getLocation())
            if judpoint2.x <0 or judpoint2.y<0 or judpoint2.x > length or judpoint2.y > length then
                return
            end
            print("====twoPoint")
            local point1 = touchs[1]:getLocation()
            local point2 = touchs[2]:getLocation()
            --移动后两点之间的距离
            local betmovepoint2 = math.sqrt(math.pow((point1.x-point2.x),2)+math.pow((point1.y-point2.y),2))
            --根据移动中两点的距离算出棋盘缩放的比例
            if betmovepoint then
                if betmovepoint2/betmovepoint*view.BoardScale < 1 then
                    view.chessBoard:setPosition(length*0.5,length*0.5)
                    return
                end
                if -0.01< view.BoardScale - betmovepoint2/betmovepoint*view.BoardScale and 
                view.BoardScale - betmovepoint2/betmovepoint*view.BoardScale <0.01 then
                    view.BoardScale=betmovepoint2/betmovepoint*view.BoardScale
                    return
                end
                view.BoardScale=betmovepoint2/betmovepoint*view.BoardScale
            else
                betmovepoint = betmovepoint2
                return
             end
            --点击的两点之间的中点
            local pointGL2=cc.p((point1.x+point2.x)*0.5,(point1.y+point2.y)*0.5)
            if not pointGL then
                pointGL = pointGL2
            end
            local pointBoard1 = view.chessBoard:convertToNodeSpace(pointGL)--中点在棋盘中的位置
            --对棋盘进行缩放
            view.chessBoard:setScale(view.BoardScale) 
            --对棋盘进行位移
            local pointBoard2 = view.chessBoard:convertToNodeSpace(pointGL2)
            local move = cc.MoveBy:create(0.001,cc.p(pointBoard2.x-pointBoard1.x,pointBoard2.y-pointBoard1.y))
            view.chessBoard:runAction(move)
            --不能超过范围
            local EP_x,EP_y=view.chessBoard:getPosition()
            print("===EP_x,EP_y==",EP_x,EP_y)
            if EP_x >length*0.5+(length*view.BoardScale-length)/2 then
                view.chessBoard:setPosition(length*0.5+(length*view.BoardScale-length)/2,EP_y)
                EP_x = length*0.5+(length*view.BoardScale-length)/2
            end
            if EP_x <length*0.5-(length*view.BoardScale-length)/2 then
                view.chessBoard:setPosition(length*0.5-(length*view.BoardScale-length)/2,EP_y)
                EP_x = length*0.5-(length*view.BoardScale-length)/2
            end
            if EP_y >length*0.5+(length*view.BoardScale-length)/2 then
                view.chessBoard:setPosition(EP_x,length*0.5+(length*view.BoardScale-length)/2)
            end
            if EP_y <length*0.5-(length*view.BoardScale-length)/2 then
                view.chessBoard:setPosition(EP_x,length*0.5-(length*view.BoardScale-length)/2)
            end
            --对betmovepoint进行重新赋值
            betmovepoint = betmovepoint2
            pointGL = pointGL2
        end
    end
    local function onTouchEnded(touchs, event)
        local judpoint = view.noteAdClipper:convertToNodeSpace(touchs[1]:getLocation())
        if judpoint.x <0 or judpoint.y<0 or judpoint.x > length or judpoint.y > length then
            return
        end
        betmovepoint = nil
        pointGL = nil
        ischange = true
        if not view.isPlayer or view.isGameOver then --轮到机器人或游戏结束
            return
        end 
        endPoint1 = touchs[1]:getLocation()
        if touchs[2] then
            endPoint2 = touchs[2]:getLocation()
        end

        if touchs[2] then
        else
            if beginPoint1.x == endPoint1.x or beginPoint1.y==endPoint1.y then 
                local x, y = endPoint1.x, endPoint1.y
                if  x>= view.cbX-view.chessBoardSize*0.5 and x<=view.cbX+view.chessBoardSize*0.5 
                and y>=view.cbY-view.chessBoardSize*0.5 and y<=view.cbY+view.chessBoardSize*0.5 then
                    view:startPlayer(x, y)
                end
            end
        end
    end
    
    local touchListener = cc.EventListenerTouchAllAtOnce:create()
    touchListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCHES_BEGAN)
    touchListener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCHES_MOVED)
    touchListener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCHES_ENDED)
    view.touchListener =touchListener
    view.eventDispatcher = view:getEventDispatcher()
    view.eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener,view)
end
return FiveChessTouch