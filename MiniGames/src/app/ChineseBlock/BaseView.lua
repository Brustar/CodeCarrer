local BaseView = class("BaseView", 
	function()
		return cc.Node:create() 
	end)

function BaseView:ctor()
	cc.bind(self, "event")

	local winSize = cc.Director:getInstance():getWinSize()

	local containerWidth = 384
	local containerHeight = 160 + 384 + 140 + 10 * 2

    local scale = 1
    local scaleX, scaleY = winSize.width / containerWidth, winSize.height / containerHeight
    if scaleX < scaleY then
        scale = scaleX
    else
        scale = scaleY
    end

	local container = cc.LayerColor:create(cc.c4b(44, 44, 44, 255), containerWidth, containerHeight)
	container:ignoreAnchorPointForPosition(false)
	container:setAnchorPoint(cc.p(0.5, 0.5))
	container:setPosition(winSize.width / 2, winSize.height / 2)
	container:setScale(scale)
	self:addChild(container)

	--head
	local head = cc.Sprite:create("sprite-sheet1.png")
	head:setTextureRect(cc.rect(2, 2, 384, 160))
	head:setAnchorPoint(cc.p(0, 1))
	head:setPosition(0, 160 + 384 + 140 + 10 * 2)
	container:addChild(head)
	self.head = head

	--body
	local body = cc.Sprite:create("sprite-sheet0.png")
	body:setTextureRect(cc.rect(0, 0, 384, 384))
	body:setAnchorPoint(cc.p(0, 0))
	body:setPosition(0, 140 + 10)
	container:addChild(body)
	self.body = body

	--foot
	local foot = cc.Sprite:create("sprite-sheet1.png")
	foot:setTextureRect(cc.rect(2, 162, 384, 140))
	foot:setAnchorPoint(cc.p(0, 0))
	foot:setPosition(0, 0)
	container:addChild(foot)
	self.foot = foot
end

function BaseView.createStringSprite(str, image, vertical)
	str = tostring(str)
	local node = cc.Node:create()
	local width, height = 0, 0
	for i = 1, string.len(str) do
		local sprite = BaseView.createFontSprite(string.sub(str, i, i + 1), image)
		if sprite then
			sprite:setAnchorPoint(0, 0)
			local size = sprite:getContentSize()
			if vertical then
				if width < size.width then
					width = size.width
				end
				sprite:setPosition(0, height)
				height = height + size.height
			else
				if height < size.height then
					height = size.height
				end
				sprite:setPosition(width, 0)
				width = width + size.width
			end
			node:addChild(sprite)
		end
	end
	node:setContentSize(width, height)
	return node
end

function BaseView.createFontSprite(char, image)
	if not image or (image ~= "day.png" and  image ~= "day2.png") then
		image = "day.png"
	end
	local texture = cc.Director:getInstance():getTextureCache():getTextureForKey(image)
	if not texture then
		texture = cc.Director:getInstance():getTextureCache():addImage(image)
	end
	local sprite = cc.Sprite:createWithTexture(texture)
	local rect = cc.rect(0, 0, 0, 0)
	local charCode = string.byte(char)
	if charCode >= 65 and charCode < 65 + 26 then
		rect = cc.rect(math.mod((charCode - 65), 2) * (18 + 10), math.floor((charCode - 65) / 2) * (35 + 8) + 5, 18, 35)
	end
	if charCode >= 97 and charCode < 97 + 26 then
		rect = cc.rect(math.mod((charCode - 97), 2) * (18 + 10), math.floor((charCode - 97) / 2) * (35 + 8)  + 564, 18, 35)
	end
	if charCode >= 48 and charCode < 48 + 10 then
		rect = cc.rect(math.mod((charCode - 48), 2) * (18 + 10), math.floor((charCode - 48) / 2) * (35 + 8)  + 1123, 18, 35)
	end
	sprite:setTextureRect(rect)
	return sprite
end

return BaseView