--提示信息
DialogBox = class("DialogBox")
--node 提示框的载体 message 提示的信息
function DialogBox.run(node,message)
	--创建底
	local layer = cc.LayerColor:create(cc.c4b(0, 0, 0,0))
   	node:addChild(layer,100)
    local touchListener = cc.EventListenerTouchOneByOne:create()
	local function onTouchBegan()
		return true
	end
	local function onTouchEnded()
		layer:removeFromParent()
	end
	touchListener:setSwallowTouches(true)
	touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = node:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener,layer)
	--创建提示信息
	local Dialog = cc.Sprite:create()
	Dialog:setTextureRect(cc.rect(0,0,display.width,50))
	Dialog:setColor(cc.c3b(0,0,0))
	Dialog:setOpacity(0)
	layer:addChild(Dialog)
	Dialog:setAnchorPoint(cc.p(0,0))
	Dialog:setPosition(0,0)
	local label = cc.Label:create()
    label:setDimensions(display.width,100)
    label:setSystemFontSize(35)
    label:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
    label:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
    label:setString(message)
    label:setAnchorPoint(cc.p(0.5, 0.5))
    label:setPosition(display.width*0.5,25)
    layer:addChild(label)
    --自动消失
    local delay = cc.DelayTime:create(1)
    local fadein = cc.FadeIn:create(0.5)
    local fadeout = cc.FadeOut:create(1)
    local function removeCall()
    	layer:removeFromParent()
    end
    Dialog:runAction(cc.Sequence:create(fadein,delay,fadeout,cc.CallFunc:create(removeCall)))
end