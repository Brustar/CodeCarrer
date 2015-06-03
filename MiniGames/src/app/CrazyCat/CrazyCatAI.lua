
local CrazyCatAI = class("CrazyCatAI")

function CrazyCatAI:ctor()
end

--获取最贪心的路径
function CrazyCatAI:getBestPath(data, front)
    local j = front
    local k = data[front].pre
    data[j].pre = 0
    while (k ~= 1)
    do
        j = k
        k = data[k].pre
        data[j].pre = 0
    end
    
    k = 1
    local tab = {}
    local count = table.getn(data)
    while (k <= count) --正向搜索到pre为0的方块，即构成正向的路径
    do
        if data[k].pre == 0 then
            table.insert(tab, { row = data[k].row, col = data[k].col })
        end
        k = k + 1
    end
    return tab[2].row, tab[2].col
end

--获取小猫的下一位置（广度优先）
--row:小猫行位置 col:小猫列位置 circle:圆形列表
function CrazyCatAI:getNextPath(row, col, circle)
    local i = 1
    local j = 1
    local isFind = false
    local index = self:getIndex(row, col) --猫当前位置
    local queue = {
        front = 0, --队首指针
        back = 1,  --队尾指针
        data = {}
    }
    local list = {}
    for _, v in ipairs(circle) do
        list[v.index] = v.isSelected
    end
    
    list[index] = true
    table.insert(queue.data, self:getData(0, row, col)) --猫当前位置
    while (queue.front ~= queue.back and not isFind)
    do
        queue.front = queue.front + 1
        i = queue.data[queue.front].row
        j = queue.data[queue.front].col
        if i == 1 or j == 1 or i == 9 or j == 9 then
            isFind = true
            local r, c = self:getBestPath(queue.data, queue.front)
            return { row = r, col = c }
        end
        
        for dir = 1, 6 do --六个方向遍历
            if dir == 1 then
                i = queue.data[queue.front].wrap.topLeft.x
                j = queue.data[queue.front].wrap.topLeft.y
            elseif dir == 2 then
                i = queue.data[queue.front].wrap.topRight.x
                j = queue.data[queue.front].wrap.topRight.y
            elseif dir == 3 then
                i = queue.data[queue.front].wrap.left.x
                j = queue.data[queue.front].wrap.left.y
            elseif dir == 4 then
                i = queue.data[queue.front].wrap.right.x
                j = queue.data[queue.front].wrap.right.y
            elseif dir == 5 then
                i = queue.data[queue.front].wrap.bottomLeft.x
                j = queue.data[queue.front].wrap.bottomLeft.y
            elseif dir == 6 then
                i = queue.data[queue.front].wrap.bottomRight.x
                j = queue.data[queue.front].wrap.bottomRight.y
            end
            
            local id = (i - 1) * 9 + j
            if not list[id] then
                queue.back = queue.back + 1
                table.insert(queue.data, self:getData(queue.front, i, j))
                list[id] = true --避免回过来重复搜索
            end
        end
    end
    --小猫已经被围住
    local path = self:isCanMove(row, col, circle)
    return path
    --return { row = 0, col = 0 }
end

--小猫是否可移动
function CrazyCatAI:isCanMove(row, col, circle)
	local r = 1
	local c = 1
    local list = {}
    for _, v in ipairs(circle) do
        list[v.index] = v.isSelected
    end
    
    local wrap = self:getWrap(row, col)
	for dir = 1, 6 do
        if dir == 1 then
            r = wrap.topLeft.x
            c = wrap.topLeft.y
        elseif dir == 2 then
            r = wrap.topRight.x
            c = wrap.topRight.y
        elseif dir == 3 then
            r = wrap.left.x
            c = wrap.left.y
        elseif dir == 4 then
            r = wrap.right.x
            c = wrap.right.y
        elseif dir == 5 then
            r = wrap.bottomLeft.x
            c = wrap.bottomLeft.y
        else
            r = wrap.bottomRight.x
            c = wrap.bottomRight.y
        end
        
        local id = (r - 1) * 9 + c
        if not list[id] then --找到没路障的
            return { row = r, col = c }
        end
	end
    return { row = 0, col = 0 }
end

function CrazyCatAI:getData(pre, row, col)
    return { 
        pre = pre, 
        row = row, 
        col = col,
        wrap = self:getWrap(row, col)
    }
end

--根据行列得到索引
function CrazyCatAI:getIndex(row, col)
    return (row - 1) * 9 + col
end

--根据索引得到行列
function CrazyCatAI:getPos(index)
    local row, col = math.ceil(index / 9), index % 9
    return row, col
end

--获取包围单个圆的六个圆坐标
function CrazyCatAI:getWrap(row, col)
    local tab = {
        left = { x = row, y = col - 1 },
        right = { x = row, y = col + 1 }
    }
    
    if row % 2 == 1 then
        tab.topLeft = { x = row - 1, y = col - 1 }
        tab.topRight = { x = row - 1, y = col }
        tab.bottomLeft = { x = row + 1, y = col - 1 }
        tab.bottomRight = { x = row + 1, y = col }
    else
        tab.topLeft = { x = row - 1, y = col }
        tab.topRight = { x = row - 1, y = col + 1 }
        tab.bottomLeft = { x = row + 1, y = col }
        tab.bottomRight = { x = row + 1, y = col + 1 }
    end
    return tab
end

return CrazyCatAI