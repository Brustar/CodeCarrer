local PeopleSprite = class("PeopleSprite")

PeopleSprite.UP="up"
PeopleSprite.DOWN="down"
PeopleSprite.LEFT="left"
PeopleSprite.RIGHT="right"

function PeopleSprite:ctor(map, posX, posY, index, oneSize)
    --精灵当前的位置
    self._posX = posX
    self._posY = posY
    self._map = map
    self._index = index
    self._cell = map[index]
    self._nums = math.sqrt(#map)
    self._oneSize = oneSize
end

function PeopleSprite:move(forward)
    local nextPosX = 0
    local nextPosY = 0
    local curSide = 0 
    local nextSide = 0 
    local canMove = false
    if forward == PeopleSprite.UP then
         nextPosX = self._posX
         nextPosY = self._posY + 1
         curSide = 3
         nextSide = 1
    elseif forward == PeopleSprite.DOWN then
        nextPosX = self._posX
        nextPosY = self._posY - 1
        curSide = 1
        nextSide = 3
    elseif forward == PeopleSprite.LEFT then
        nextPosX = self._posX - 1
        nextPosY = self._posY
        curSide = 4
        nextSide = 2
    elseif forward == PeopleSprite.RIGHT then
        nextPosX = self._posX + 1
        nextPosY = self._posY
        curSide = 2
        nextSide = 4
    end

    if nextPosX >= 0 and nextPosX < self._nums and nextPosY >= 0 and nextPosY < self._nums then
         --获取一下一个方格
         local nextIndex=nextPosY*self._nums+nextPosX+1--索引
         local nextCell = self._map[nextIndex]
         --判断是否有墙
         if self._cell[curSide] == 0 and nextCell[nextSide] == 0 then
             self._cell = nextCell
             self._posX = nextPosX
             self._posY = nextPosY
             self._index = nextIndex
             canMove = true
         end
     end
    return canMove,self._posX,self._posY
end

return PeopleSprite