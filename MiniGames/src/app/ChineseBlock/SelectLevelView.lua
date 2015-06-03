local BaseView = import(".BaseView")

local SelectLevelView = class("SelectLevelView", BaseView)

SelectLevelView.EVENTS = {
	QUIT = "QUIT",
	SELECTED = "SELECTED",
	PAGE = "PAGE",
}

SelectLevelView.PAGE_SIZE = 9

function SelectLevelView:ctor(data)
	self.super.ctor(self)
	dump(data, "data")
	self.data = data

	self:initHead()
	self:initFoot()
	self:initBody()
end

function SelectLevelView:initHead()
	local moreBtn = ccui.Widget:create()

	local moreBtnStringSprite = self.createStringSprite("moregames", "day.png", false)
	local moreBtnIconSprite = cc.Sprite:create("but-sheet0.png"):setTextureRect(cc.rect(0, 0, 140, 140))

	moreBtnStringSprite:setAnchorPoint(0, 0.5)
	moreBtnStringSprite:setPosition(0, moreBtnIconSprite:getContentSize().height / 2)

	moreBtnIconSprite:setAnchorPoint(0, 0)
	moreBtnIconSprite:setPosition(moreBtnStringSprite:getContentSize().width, 0)

	local moreBtnRect = cc.rectUnion(moreBtnStringSprite:getBoundingBox(), moreBtnIconSprite:getBoundingBox())

	local moreBtn = ccui.Widget:create()
	moreBtn:addChild(moreBtnStringSprite)
	moreBtn:addChild(moreBtnIconSprite)
	moreBtn:setContentSize(moreBtnRect.width, moreBtnRect.height)
	moreBtn:setAnchorPoint(0.5, 0.5)
	moreBtn:setPosition(self.head:getContentSize().width / 2, self.head:getContentSize().height / 2)
	moreBtn:setTouchEnabled(true)
	moreBtn:addClickEventListener(function() 
	    self:dispatchEvent({name = SelectLevelView.EVENTS.QUIT})
	end)
	self.head:addChild(moreBtn)
end

function SelectLevelView:initFoot()
	local footSize = self.foot:getContentSize()

	local page = self.data.page
	local total = self.data.total
	local pageSize = SelectLevelView.PAGE_SIZE

	if page > 1 then
		local preBtnSprite = cc.Sprite:create("but2-sheet0.png"):setTextureRect(cc.rect(0, 0, 75, 75))
		preBtnSprite:setPosition(75 / 2, 75 / 2)
		local preBtn = ccui.Widget:create()
		preBtn:addChild(preBtnSprite)
		preBtn:setContentSize(preBtnSprite:getContentSize())
		preBtn:setAnchorPoint(0, 0.5)
		preBtn:setPosition(20, footSize.height / 2)
		preBtn:setTouchEnabled(true)
		preBtn:addClickEventListener(function() 
		    self:dispatchEvent({name = SelectLevelView.EVENTS.PAGE, page = page - 1})
		end)
		self.foot:addChild(preBtn)
	end

	if not (page * pageSize + 1 > total) then
		local nextBtnSprite = cc.Sprite:create("but-sheet0.png"):setTextureRect(cc.rect(140, 75, 75, 75))
		nextBtnSprite:setPosition(75 / 2, 75 / 2)
		local nextBtn = ccui.Widget:create()
		nextBtn:addChild(nextBtnSprite)
		nextBtn:setContentSize(nextBtnSprite:getContentSize())
		nextBtn:setAnchorPoint(1, 0.5)
		nextBtn:setPosition(footSize.width - 20, footSize.height / 2)
		nextBtn:setTouchEnabled(true)
		nextBtn:addClickEventListener(function() 
		    self:dispatchEvent({name = SelectLevelView.EVENTS.PAGE, page = page + 1})
		end)
		self.foot:addChild(nextBtn)
	end

	local label = self.createStringSprite(page, "day.png", false)
	label:setAnchorPoint(0.5, 0)
	label:setPosition(footSize.width / 2, footSize.height / 2)
	self.foot:addChild(label)
end

function SelectLevelView:initBody()
	local bodySize = self.body:getContentSize()

	local levelStates = self.data.levelStates

	for i, levelState in ipairs(levelStates) do
		if levelState then
			local levelBtn = self:createLevelBtn(levelState)
			levelBtn:setTag(levelState.level)
			levelBtn:setAnchorPoint(0, 1)
			levelBtn:setPosition((25 + math.mod((i - 1), 3) * (96 + 25)), bodySize.height - (20 + math.floor((i - 1) / 3) * (100 + 20)))
			self.body:addChild(levelBtn)
		end
	end
end

function SelectLevelView:createLevelBtn(levelState)
	local sprite = cc.Sprite:create()
	if levelState.isLocked then
		local texture = cc.Director:getInstance():getTextureCache():getTextureForKey("levelsbutton-sheet1.png")
		if not texture then
			texture = cc.Director:getInstance():getTextureCache():addImage("levelsbutton-sheet1.png")
		end
		sprite:setTexture(texture)
		sprite:setTextureRect(cc.rect(96, 0, 96, 100))
	else
		local texture = cc.Director:getInstance():getTextureCache():getTextureForKey("levelsbutton-sheet0.png")
		if not texture then
			texture = cc.Director:getInstance():getTextureCache():addImage("levelsbutton-sheet0.png")
		end
		sprite:setTexture(texture)
		sprite:setTextureRect(cc.rect(math.mod(levelState.star, 2) * 96, math.floor(levelState.star / 2) * 100, 96, 100))
		local label = self.createStringSprite(levelState.level, "day.png", false)
			:setAnchorPoint(0.5, 0.5)
			:setPosition(50, 70)
		sprite:addChild(label)
	end
	sprite:setAnchorPoint(0, 0)
	local btn = ccui.Widget:create()
	btn:addChild(sprite)
	btn:setContentSize(sprite:getContentSize())
	btn:setTouchEnabled(true)
	btn:addClickEventListener(function() 
		if not levelState.isLocked then
			self:dispatchEvent({name = SelectLevelView.EVENTS.SELECTED, levelState = levelState})
		end
	end)
	return btn
end

return SelectLevelView