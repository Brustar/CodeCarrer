local StoryScene = class("StoryScene",cc.load("mvc").ViewBase)
function StoryScene:onCreate()
	self:createBack()
	self:createMoveLayer()
end
function StoryScene:createBack()
	--[[
	  cc.UserDefault:getInstance():getIntegerForKey('buttonTag')
     print("buttonTag:",buttonTag)
     if  cc.UserDefault:getInstance():getIntegerForKey('buttonTag') ==1001 then
        print("1001")
        else
            print("1002")
        end
        ]]
	local png = PngHelper.shared():init(3)
    local back = png:spriteFromJson("main_back"):move(cc.p(display.cx,display.cy)):addTo(self)

    back:setScaleX(display.width/640)
    back:setScaleY(display.height/960)
end
function StoryScene:createMoveLayer()
	local layer = cc.Layer:create()
	self:addChild(layer)
	layer:setPosition(display.width,0)
	layer:setScaleX(display.width/640)
    layer:setScaleY(display.height/960)

	local png = PngHelper.shared():init(4) 
    local distantView = png:spriteFromJson("intro_back_1")
	    :move(cc.p(display.cx-2,display.cy+110))
	    :addTo(layer)
	    :setOpacity(0)
	local delay = cc.DelayTime:create(1)
	local fade = cc.FadeIn:create(1)
	distantView:runAction(cc.Sequence:create(delay,fade))

	png = PngHelper.shared():init(3)
	local smallBg = png:spriteFromJson("intro_up_1"):move(cc.p(display.cx,display.cy)):addTo(layer)

	local normalSprite,selectedSprite=png:spriteFromJson("intro_btn_start"),png:spriteFromJson("title_start_btn")
    local btn = cc.MenuItemSprite:create(normalSprite,selectedSprite,normalSprite)
    btn:registerScriptTapHandler(function()
        --self:getApp():enterScene("LevelScene")
        self:getApp():enterScene("GameScene")

    end)
    cc.Menu:create():move(cc.p(display.cx,display.cy-(453*0.5+100))):addChild(btn):addTo(layer)
    
    local moveAction = cc.MoveTo:create(1,cc.p(0,0))
    layer:runAction(moveAction)

    --创建裁切区域
    local distantViewSize =  distantView:getContentSize()
    local para = {
        startW = 0,
        startH = 0,
        width = distantViewSize.width,
        height = distantViewSize.height,
        colour = cc.c4f(0.5, 0.5, 0.5, 0.8)
    }
    local noteAdStencil = self:createRectangleStencil(para)
    local noteAdClipper = self:createClippingNode(cc.size(distantViewSize.width,distantViewSize.height), cc.p(0,0))
    noteAdClipper:setStencil(noteAdStencil)
    distantView:addChild(noteAdClipper)
    png = PngHelper.shared():init(4)
    
    local princess = png:spriteFromJson("intro_s_1_1")
    :addTo(noteAdClipper)
    :setAnchorPoint(1,0)
    :setScale(2)
    :setOpacity(0)
    local princessSize = princess:getContentSize()
    princess:setPosition(distantViewSize.width,-180)
    local princessdelay = cc.DelayTime:create(1)
	local princessfade = cc.FadeIn:create(1)
    princess:runAction(cc.Sequence:create(princessdelay,princessfade))
    local function princessCallBack()
	    local scale = cc.ScaleTo:create(1,1)
	    local move = cc.MoveTo:create(1,cc.p(distantViewSize.width,0))
	    princess:runAction(scale)
	    princess:runAction(move)
	end
	layer:runAction(cc.Sequence:create(cc.DelayTime:create(2),cc.CallFunc:create(princessCallBack)))
	local view1 = png:spriteFromJson("intro_s_1_2")
					:addTo(noteAdClipper)
					:setAnchorPoint(0,0)
					:move(80-display.width,0)
	local view2 = png:spriteFromJson("intro_s_1_3")
					:addTo(noteAdClipper)
					:setAnchorPoint(0,0)
					:move(20-display.width,0)
	local view3 = png:spriteFromJson("intro_s_1_4")
					:addTo(noteAdClipper)
					:setAnchorPoint(0,0)
					:move(20-display.width,0)
	local function viewCallBack()
		view1:runAction(cc.MoveTo:create(0.6,cc.p(80,0)))
		view2:runAction(cc.Sequence:create(cc.DelayTime:create(0.5),cc.MoveTo:create(0.4,cc.p(20,0))))
		view3:runAction(cc.Sequence:create(cc.DelayTime:create(0.6),cc.MoveTo:create(0.6,cc.p(20,0))))
	end
	layer:runAction(cc.Sequence:create(cc.DelayTime:create(2.4),cc.CallFunc:create(viewCallBack)))

	--创建骑士
	performWithDelay(self, function ()
	    local knightFrame = png:spriteFromJson("intro_up_2"):setAnchorPoint(0,0):move(0,0):addTo(smallBg)
		local knightBg = png:spriteFromJson("intro_back_2")
							:setAnchorPoint(0,0)
							:move(23,26)
							:addTo(knightFrame)
							:setOpacity(0)
		knightBg:runAction(cc.FadeIn:create(1))
		--创建裁剪区
		local size = knightBg:getContentSize()
	    local para = {
	        startW = 0,
	        startH = 0,
	        width = size.width,
	        height = size.height,
	        colour = cc.c4f(0.5, 0.5, 0.5, 0.8)
	    }
	    local noteAdStencil = self:createRectangleStencil(para)
	    local noteAdClipper = self:createClippingNode(cc.size(size.width,size.height), cc.p(2,2))
	    noteAdClipper:setStencil(noteAdStencil)
	    knightBg:addChild(noteAdClipper)
	    --创建骑士
	    local knight = png:spriteFromJson("intro_s_1_5"):setAnchorPoint(0,0):move(10,0):addTo(noteAdClipper)
	    local knightAction1 = cc.MoveTo:create(0.2,cc.p(25,-20))
	    local knightAction2 = cc.MoveTo:create(0.2,cc.p(10,0))
	    local knightAction3 = cc.MoveTo:create(0.2,cc.p(-10,-10))
	    local knightAction = knight:runAction(cc.RepeatForever:create(cc.Sequence:create(
	    	knightAction2,knightAction1,knightAction2,knightAction3
	    	)))
	    --创建公主
	    performWithDelay(self, function ()
	    	knight:stopAction(knightAction)
		    local princessFrame = png:spriteFromJson("intro_up_3"):setAnchorPoint(1,0):move(smallBg:getContentSize().width,0):addTo(smallBg)
			local princessBg = png:spriteFromJson("intro_back_3")
								:setAnchorPoint(0,0)
								:move(6,26)
								:addTo(princessFrame)
								:setOpacity(0)
			princessBg:runAction(cc.FadeIn:create(1))
					--创建裁剪区
			size = princessBg:getContentSize()
		    para = {
		        startW = 0,
		        startH = 0,
		        width = size.width,
		        height = size.height,
		        colour = cc.c4f(0.5, 0.5, 0.5, 0.8)
		    }
		    noteAdStencil = self:createRectangleStencil(para)
		    noteAdClipper = self:createClippingNode(cc.size(size.width,size.height), cc.p(2,2))
		    noteAdClipper:setStencil(noteAdStencil)
		    princessBg:addChild(noteAdClipper)
		    --创建公主
		    local prinecess = png:spriteFromJson("intro_s_1_6")
		    					:setAnchorPoint(1,0)
		    					:move(size.width-3+100,0-100)
		    					:addTo(noteAdClipper)
		    					:setOpacity(50)
			local function prinecessCallBack()
				prinecess:runAction(cc.FadeIn:create(1))
				prinecess:runAction(cc.MoveTo:create(1,cc.p(size.width-3,0)))

				local scale1 = cc.ScaleBy:create(0.5, 0.8, 1.2)
				local scale2 = cc.ScaleBy:create(0.5, 1.2, 0.8)
				btn:runAction(cc.RepeatForever:create(cc.Sequence:create(scale1,scale2)))
			end
			prinecess:runAction(cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(prinecessCallBack)))
		end,3)
	end,3.7)

end
-- 创建矩形区域
function StoryScene:createRectangleStencil(para)
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
function StoryScene:createClippingNode(size, pos)
    local clipper = cc.ClippingNode:create()
    clipper:setContentSize(size)
    clipper:setAnchorPoint(cc.p(0,0))
    clipper:setPosition(pos)
    return clipper
end

function StoryScene:onCleanup()
    PngHelper.clearTexture()
end

return StoryScene