
--机器人算法
local FiveChessBase = import(".FiveChessBase")

local FiveChessAI = class("FiveChessAI", FiveChessBase)

function FiveChessAI:ctor()
    FiveChessAI.super.ctor(self)
end

--计算下棋子到index的权重
function FiveChessAI:computeWeight(index, chess)
    local x, y = self:getXY(index)
    local weight = 15 - (math.abs(y - 7) + math.abs(y - 7)) --基于棋盘位置权重，越靠中间权重越大
    local info = {}
    
    --X方向
    info = self:putDirectX(chess, x, y, FiveChessBase.WHITE_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --机器人下棋子权重
    info = self:putDirectX(chess, x, y, FiveChessBase.BLACK_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --玩家下棋子权重
    
    --Y方向
    info = self:putDirectY(chess, x, y, FiveChessBase.WHITE_CHESSS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --机器人下棋子权重
    info = self:putDirectY(chess, x, y, FiveChessBase.BLACK_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --玩家下棋子权重
    
    --左斜方向
    info = self:putDirectXY(chess, x, y, FiveChessBase.WHITE_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --机器人下棋子权重
    info = self:putDirectXY(chess, x, y, FiveChessBase.BLACK_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --玩家下棋子权重
    
    --右斜方向
    info = self:putDirectYX(chess, x, y, FiveChessBase.WHITE_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --机器人下棋子权重
    info = self:putDirectYX(chess, x, y, FiveChessBase.BLACK_CHESS)
    weight = weight + self:getWeight(info.nums, info.side1, info.side2, true) --玩家下棋子权重
    
    return weight
end

--下棋子到index，X方向结果
function FiveChessAI:putDirectX(chess, x, y, chessColor,chessview)
    local nums = 1
    local side1 = false
    local side2 = false
    local viewarr ={}
    
    for m = x - 1, 1, -1 do --X向左
        local ix = self:getIndex(m, y)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side1 = true
            end
            break
        end
    end
    
    for m = x + 1, 15, 1 do --X向右
        local ix = self:getIndex(m, y)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side2 = true
            end
            break
        end
    end
    return { nums = nums, side1 = side1, side2 = side2 ,views=viewarr}
end

--下棋子到index，Y方向结果
function FiveChessAI:putDirectY(chess, x, y, chessColor,chessview)
    local nums = 1
    local side1 = false
    local side2 = false
    local viewarr ={}
    for m = y - 1, 1, -1 do --Y向上
        local ix = self:getIndex(x, m)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side1 = true
            end
            break
        end
    end
    
    for m = y + 1, 15, 1 do --Y向下
        local ix = self:getIndex(x, m)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side2 = true
            end
            break
        end
    end
    return { nums = nums, side1 = side1, side2 = side2 ,views=viewarr}
end

--下棋子到index，XY方向结果
function FiveChessAI:putDirectXY(chess, x, y, chessColor,chessview)
    local nums = 1
    local side1 = false
    local side2 = false
    local viewarr ={}
    local n = y - 1
    
    for m = x - 1, 1, -1 do
        if n <= 0 then
            break
        end
        
        local ix = self:getIndex(m, n)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side1 = true
            end
            break
        end
        n = n - 1
    end
    
    n = y + 1
    for m = x + 1, 15 do
        if n > 15 then
            break
        end
        
        local ix = self:getIndex(m, n)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side2 = true
            end
            break
        end
        n = n + 1
    end
    return { nums = nums, side1 = side1, side2 = side2 ,views=viewarr}
end

--下棋子到index，YX方向结果
function FiveChessAI:putDirectYX(chess, x, y, chessColor,chessview)
    local nums = 1
    local side1 = false
    local side2 = false
    local viewarr ={}
    local n = y + 1

    for m = x - 1, 1, -1 do
        if n > 15 then
            break
        end

        local ix = self:getIndex(m, n)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side1 = true
            end
            break
        end
        n = n + 1
    end

    n = y - 1
    for m = x + 1, 15 do
        if n <= 0 then
            break
        end

        local ix = self:getIndex(m, n)
        if chess[ix] == chessColor then
            nums = nums + 1
            if chessview then
                table.insert(viewarr,chessview[ix])
            end
        else
            if chess[ix] == FiveChessBase.NO_CHESS then
                side2 = true
            end
            break
        end
        n = n - 1
    end
    return { nums = nums, side1 = side1, side2 = side2 ,views=viewarr}
end

--获取权重 独：两边为空可下子，单：一边为空
function FiveChessAI:getWeight(nums, side1, side2, isAI)
    local weight = 0
    if nums == 1 then
        if side1 and side2 then --独一
            if isAI then
                weight = 15
        else
            weight = 10
        end
        end
    elseif nums == 2 then
        if side1 and side2 then --独二
            if isAI then
                weight = 100
        else
            weight = 50
        end
        elseif side1 or side2 then --单二
            if isAI then
                weight = 10
        else
            weight = 5
        end
        end
    elseif nums == 3 then
        if side1 and side2 then --独三
            if isAI then
                weight = 500
            else
                weight = 200
            end
        elseif side1 or side2 then --单三
            if isAI then
                weight = 30
            else
                weight = 20
            end
        end
    elseif nums == 4 then
        if side1 and side2 then --独四
            if isAI then
                weight = 5000
            else
                weight = 2000
            end
        elseif side1 or side2 then --单四
            if isAI then
                weight = 400
            else
                weight = 100
            end
        end
    elseif nums == 5 then
        if isAI then
            weight = 100000
        else
            weight = 10000
        end
    else
        if isAI then
            weight = 500000
        else
            weight = 250000
        end
    end

    return weight
end

--根据索引获取坐标
function FiveChessAI:getXY(index)
    local x = math.ceil(index / 15)
    local y = index % 15
    return x, y
end

--根据坐标获取索引
function FiveChessAI:getIndex(x, y)
    return (x - 1) * 15 + y
end

return FiveChessAI