--输入框光标
AddCursor = class("AddCursor")
function AddCursor.info(textField,PlaceText)
	local function textFieldBgTouch(sender, eventType)
        if eventType == ccui.TextFiledEventType.attach_with_ime then
            textField:setPlaceHolder("")
            AddCursor.run(textField,1)
        elseif eventType == ccui.TextFiledEventType.detach_with_ime then
            textField:setPlaceHolder(PlaceText)
            AddCursor.run(textField,2)
        elseif eventType == ccui.TextFiledEventType.insert_text then
            AddCursor.run(textField,3)
        elseif eventType == ccui.TextFiledEventType.delete_backward then
            AddCursor.run(textField,4)
        end
    end
    textField:addEventListener(textFieldBgTouch)
end
function AddCursor.run(textField,type)
	if type == 1 then
		if AddCursor.lastField == textField then 
			return 
		end
		if AddCursor.lastField then
			AddCursor.Cursor:removeFromParent() 
			AddCursor.isTwo = true --是否从第一个输入框直接点击第二个输入框
		end
		AddCursor.lastField = textField
		local size = textField:getContentSize()
		AddCursor.Cursor = cc.Sprite:create()
		AddCursor.Cursor:setTextureRect(cc.rect(0,0,2,size.height))
		AddCursor.Cursor:setColor(cc.c3b(125,125,125))
		textField:addChild(AddCursor.Cursor)
		AddCursor.Cursor:setPosition(5+textField:getAutoRenderSize().width,size.height*0.5)
	    local fadein = cc.FadeIn:create(0.6)
	    local fadeout = cc.FadeOut:create(0.4)
	    local foreverAction = cc.RepeatForever:create(cc.Sequence:create(fadeout,fadein))
	    AddCursor.Cursor:runAction(foreverAction)
	elseif type == 2 then
		if AddCursor.isTwo then 
			AddCursor.isTwo = false
			return 
		end
		if AddCursor.lastField == nil then return end
		AddCursor.Cursor:removeFromParent() 
		AddCursor.lastField = nil
	elseif type == 3 or type == 4 then
		performWithDelay(textField, function ()
			local size = textField:getContentSize()
			AddCursor.Cursor:setPosition(AddCursor.lastField:getAutoRenderSize().width+5,size.height*0.5)
		end,0.001)
	end
end