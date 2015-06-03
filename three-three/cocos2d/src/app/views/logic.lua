module("logic",package.seeall)

local verify={
	{1,8+1,2*8+1},{2,8+2,2*8+2},{3,8+3,2*8+3},{4,8+4,2*8+4},{5,8+5,2*8+5},{6,8+6,2*8+6},{7,8+7,2*8+7},{8,8+8,2*8+8},
	{1,2,3},{3,4,5},{5,6,7},{7,8,1},
	{1+8,2+8,3+8},{3+8,4+8,5+8},{5+8,6+8,7+8},{7+8,8+8,1+8},
	{1+16,2+16,3+16},{3+16,4+16,5+16},{5+16,6+16,7+16},{7+16,8+16,1+16}
}

function canMove(chesses,curChess,coor)
	return containChess(chesses,curchess) and canDown(chesses, coor)
end

function canDown(chesses,coor)
	return not table.indexof(calcoors(chesses),coor）
end

function canCovered(chesses,curChess,curPlayerColor)
	return curChess.color~=curPlayerColor and containChess(chesses,curChess)
end

function lined(chesses,curChess)
	for _,coorline in ipairs(linedCoors(chesses,curChess)) do
		if sameColorline(chesses,coorline,curChess) then
			return true
		end
	end
	return false
end

function gameEnded(chesses,curChess)
	if #chesses==24 and not lined(chesses,curChess) then
		return true
	end
	return false
end

local function linedCoors(chesses,curChess)
	local chs=verifyChesses(curChess)
	local coors={}
	for _,v in ipairs(chs) do
		for _,coor in ipairs(v) do
			local count=0
			if not table.indexof(calcoors(chesses),coor) then
				break;
			end
			count=count+1
		end
		if count==3 then
			coors[#coors+1]=v
		end
	end
	return coors
end

local function calcolorBycoor(chesses,coor)
	for _,v in ipairs(chesses) do
		if v.coor==coor then 
			return v.color
		end
	end
	return nil
end

local function sameColorline(chesses,coorline,curChess)
	for _,coor in ipairs(line) do
		if curChess.color~=calcolorBycoor(chesses,coor) then
			return false
		end
	end
	return #line>0
end

local function verifyChesses(curChess)
	local chs={}
	for _,v in ipairs(verify) do
		if table.indexof(v,curChess.coor) then
			chs[#chs+1]=v
		end
	end
	return chs
end

local function calcoors(chesses)
	local cs={}
	for _,v in ipairs(chesses) do
		cs[#cs+1]=v
	end
end

local function containChess(chesses,curChess)
	return table.indexof(coors(chesses),curChess.v)
end