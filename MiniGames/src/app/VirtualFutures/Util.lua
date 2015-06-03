local Util = {}

function Util.parseTime(str)
	local time = os.time{
		year = string.sub(str, 1, 4),
		month = string.sub(str, 6, 7),
		day = string.sub(str, 9, 10),

		hour = string.sub(str, 12, 13),
		min = string.sub(str, 15, 16),
		sec = string.sub(str, 18, 19),
	}
	return time
end

function Util.wrapTextField(textField)
	if not textField then 
		return 
	end
	local size = textField:getContentSize()
	local placeHoler = textField:getPlaceHolder()
	local fontSize = textField:getFontSize()
	textField:addClickEventListener(function(sender, eventType)
		textField:attachWithIME()
	end)
	textField:addEventListener(function(sender, eventType)
        if eventType == ccui.TextFiledEventType.attach_with_ime then
            textField:setPlaceHolder("")
            local cursor = cc.Sprite:create()
            cursor:setName("cursor")
    		cursor:setTextureRect(cc.rect(0, 0, 2, fontSize))
			cursor:setColor(cc.c3b(102, 217, 204))
			cursor:setAnchorPoint(0, 0)
			cursor:setPosition(textField:getAutoRenderSize().width + 5, 0)
		    cursor:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(0.4), cc.FadeIn:create(0.6))))
			textField:addChild(cursor)
        elseif eventType == ccui.TextFiledEventType.detach_with_ime then
        	textField:setPlaceHolder(placeHoler)
            local cursor = textField:getChildByName("cursor")
            cursor:removeFromParent()
        elseif eventType == ccui.TextFiledEventType.insert_text or ccui.TextFiledEventType.delete_backward then
            local cursor = textField:getChildByName("cursor")
            cursor:setPosition(textField:getAutoRenderSize().width + 5, 0)
        end
	end)
end

return Util