BlockSprite = class("BlockSprite", function(imageFilename)
	local png=PngHelper.shared():init(1)
    local sprite = png:spriteFromJson(imageFilename)

    return sprite
end
)

BlockSprite.UP="up"
BlockSprite.DOWN="down"
BlockSprite.LEFT="left"
BlockSprite.RIGHT="right"

BlockSprite.WIDTH=213
BlockSprite.HEIGHT=173

BlockSprite.YPadding={
	blocks_bl_000_0 = -27,
	blocks_bl_000_1= -18,
	blocks_bl_001_0= -20,
	blocks_bl_002_0= 0,
	blocks_bl_003_0= -16,
	blocks_bl_003_1= -22,
	blocks_bl_004_0= 0,
	blocks_bl_004_1=-47,
	blocks_bl_005_0= -37,
	blocks_bl_005_1= -27,
	blocks_bl_006_0= 0,
	blocks_bl_006_1=-16,
	blocks_bl_007_0= -1,
	blocks_bl_007_1= -61,
	blocks_bl_008_0= -19,
	blocks_bl_008_1= -34,
	blocks_bl_008_2= -25
}

function BlockSprite:ctor(imageFilename,x,y,ch)
    --位置
    --[[blocks的key矩阵[1,2,3
    				-- 4,5,6			
    				-- 7,8,9]
    	移动后不变化]]
    local width,height=BlockSprite.WIDTH,BlockSprite.HEIGHT
    if ch==4 then
    	height=height/2
    elseif ch==2 then
    	width=width/2
    end

    self.position_ = cc.p(display.width-108-width*x, display.cy-220+height*y-BlockSprite.YPadding[imageFilename]/2)
    self.key_ = 0					
    self.coordinate_ = 0			--坐标编号,移动后会变化
    self.id_ = 0					--image序号,3,5,6,9,10,12为路径砖块
    self.ch_ = ch
	
    self:setPosition(self.position_)
end


function BlockSprite:canMove(blocks,forward)
	--有多个空卡位
	local blank = setmetatable({1,2,3,4,5,6,7,8,9} ,{__sub=function (tbl,val) 
		for i=#tbl,1,-1 do
		 	if tbl[i]==val then 
		 		table.remove(tbl,i)
		 		break
		 	end
		end
		return tbl
	end})

	for _,v in pairs(blocks) do
		blank=blank-v.coordinate_
	end

	for _,v in pairs(blank) do
		if forward==BlockSprite.UP then
			if self.ch_~=2 and self.coordinate_-3==v then 
				return true
			end
			if self.ch_==2 and self.coordinate_-3==v and table.indexof(blank, self.coordinate_-2) then
				return true
			end
		elseif forward==BlockSprite.DOWN then
			if self.ch_~=2 and self.coordinate_+3==v then 
				return true
			end
			if self.ch_==4 and self.coordinate_+6==v then
				return true
			end	
			if self.ch_==2 and self.coordinate_+3==v and table.indexof(blank, self.coordinate_+4) then
				return true
			end
		elseif forward==BlockSprite.LEFT then
			if self.ch_~=4 and self.coordinate_-1==v then 
				return true
			end
			if self.ch_==4 and self.coordinate_-1==v and table.indexof(blank, self.coordinate_+2) then
				return true
			end
		elseif forward==BlockSprite.RIGHT then
			if self.ch_~=4 and self.coordinate_+1==v then 
				return true
			end
			if self.ch_==2 and self.coordinate_+2==v then
				return true
			end	
			if self.ch_==4 and self.coordinate_+1==v and table.indexof(blank, self.coordinate_+4) then
				return true
			end	
		end	
	end

	return false
end


function BlockSprite:move(forward)
	local offset=0
	local pos=display.CENTER
	if forward==BlockSprite.UP and self.coordinate_>3 then
		pos=cc.p(self.position_.x,self.position_.y+BlockSprite.HEIGHT)
		self.coordinate_=self.coordinate_-3
		offset=-3
	elseif forward==BlockSprite.DOWN and self.coordinate_<7 then
		pos=cc.p(self.position_.x,self.position_.y-BlockSprite.HEIGHT)
		self.coordinate_=self.coordinate_+3
		offset=3
	elseif forward==BlockSprite.LEFT and self.coordinate_%3~=1 then
		pos=cc.p(self.position_.x-BlockSprite.WIDTH,self.position_.y)
		self.coordinate_=self.coordinate_-1
		offset=-1
	elseif forward==BlockSprite.RIGHT and self.coordinate_%3~=0 then
		pos=cc.p(self.position_.x+BlockSprite.WIDTH,self.position_.y)
		self.coordinate_=self.coordinate_+1
		offset=1
	end
	self.position_=pos
	self:setLocalZOrder(self.coordinate_)
	local moveAction = cc.MoveTo:create(0.4,pos)
	self:runAction(moveAction)
	return offset
end


function BlockSprite:hasMoved()
    local x,y=self:getPosition()
    return self.position_.x==x and self.position_.y==y 
end