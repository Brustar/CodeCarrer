--找回密码和绑定手机
local FindPwLayer = class("FindPwLayer",cc.load("mvc").ViewBase)

function FindPwLayer:onCreate()
	local index = cc.UserDefault:getInstance():getIntegerForKey("change_bind")
 	self:createResoueceNode("login/find_pw.csb")
    self:infoCSB(self.resourceNode_,index)
    performWithDelay(self, function ()
	    if cc.UserDefault:getInstance():getIntegerForKey("is_bind_phone") == 1 then
	    	cc.UserDefault:getInstance():setIntegerForKey("is_bind_phone",0)
	    	DialogBox.run(cc.Director:getInstance():getRunningScene(),"请先绑定手机") 
	    end
	end,0.2)
end
function FindPwLayer:infoCSB(CSB,index)
	local bg = CSB:getChildByName("bg")
	self.back = bg:getChildByName("top_handle"):getChildByName("btn_back")
	self.headLab = bg:getChildByName("top_handle"):getChildByName("Text_1")
	local panel = bg:getChildByName("login")
	self.f_phone = panel:getChildByName("f_phone")
	self.input_phone = self.f_phone:getChildByName("input_phone")
	self.f_qcode = panel:getChildByName("f_qcode")
	self.input_qcode = self.f_qcode:getChildByName("input_qcode")
	self.btn_getcode = self.f_qcode:getChildByName("btn_getcode")
	self.btn_next = panel:getChildByName("btn_next")
	if index == 1 then
		self.headLab:setString("找回密码")

		local panel_x,panel_y = panel:getPosition()
		panel:setPosition(panel_x,panel_y-50)
		self.f_userid_panel = self.f_phone:clone()
		panel:addChild(self.f_userid_panel)
		local panelSize = panel:getContentSize()
		self.f_userid_panel:setPosition(0,panelSize.height)
		local f_phone_size = self.f_phone:getContentSize()
		local f_qcode_y = self.f_qcode:getPositionY()
		local H=(panelSize.height-f_qcode_y-2*f_phone_size.height)*0.5
		self.f_phone:setPosition(0,f_qcode_y+f_phone_size.height+H)
		self.f_userid = self.f_userid_panel:getChildByName("input_phone")
		self.f_userid:setPlaceHolder("输入用户ID")
		
		AddCursor.info(self.f_userid,"输入用户ID")
	elseif index == 2 then
		self.headLab:setString("绑定手机")
		if UserData.isbind == 0 then
			self.input_phone:setString(UserData.phone)
			self.btn_getcode:setTitleText("已绑定")
			self.btn_getcode:setTouchEnabled(false)
		end
	end
	self:infoTouch(index)
end
function FindPwLayer:infoTouch(index)
    AddCursor.info(self.input_phone,"输入绑定手机号")
    AddCursor.info(self.input_qcode,"输入验证码")
    --获取验证码
    local function getcodeback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			if index == 1 then
				local phoneNum = self.input_phone:getString() 
				if phoneNum == "" then DialogBox.run(self,"手机号为空") return end
				local getcode = LoginPB_pb.PBFindPasswordParams()
				getcode.mobilenum = phoneNum
				getcode.userid = UserData.userid
				getcode.optype = 1
				local flag,getcodereturn = HttpManager.post("http://lxgame.lexun.com/login/findpwd.aspx",getcode:SerializeToString())
				if not flag then return end
				local obj=LoginPB_pb.PBUserList()
			    obj:ParseFromString(getcodereturn)
			    if obj.msginfo.noerror then
			    	DialogBox.run(self,obj.msginfo.outmsg)
			    else
			    	DialogBox.run(self,obj.msginfo.outmsg)
			    end
			elseif index ==2 then
				local phoneNum = self.input_phone:getString() 
				if phoneNum == "" then DialogBox.run(self,"手机号为空") return end
				local getcode = LoginPB_pb.PBBindingParams()
				getcode.mobilenum = phoneNum
				getcode.optype = 1       
			    local flag,getcodereturn = HttpManager.post("http://lxgame.lexun.com/login/bindphone.aspx",getcode:SerializeToString())
			    if not flag then return end
			    local obj=ServerBasePB_pb.PBMessage()
			    obj:ParseFromString(getcodereturn)
			    if obj.noerror then
			    	DialogBox.run(self,obj.outmsg)
			    else
			    	DialogBox.run(self,obj.outmsg)
			    end
			end

			self.btn_getcode:setTouchEnabled(false)
			self.btn_getcode:setTitleText("60秒")
			local time = 60
			local delay = cc.DelayTime:create(1)
			local function callback()
				time = time - 1
				self.btn_getcode:setTitleText(tostring(time).."秒")
				if time == 0 then
					self.btn_getcode:setTouchEnabled(true)
					self.btn_getcode:setTitleText("获得验证码")
					self:stopAction(self.countdownaction )
				end 
			end
			local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
		    self.countdownaction = cc.RepeatForever:create(sequence)
		    self:runAction(self.countdownaction)
		end
	end
	self.btn_getcode:addTouchEventListener(getcodeback)

	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			if index == 2 then 
				AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
				self:getApp():enterScene("MainScene")
			else
				AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
				self:getApp():enterScene("LoginController")
			end
		end
	end
	self.back:addTouchEventListener(backCallback)
	local function nextCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			if index == 1 then
				local useridNum	= self.f_userid:getString()
				if useridNum == "" then DialogBox.run(self,"用户id为空") return end
				local phoneNum = self.input_phone:getString() 
				if phoneNum == "" then DialogBox.run(self,"手机号为空") return end
				local codeNum = self.input_qcode:getString()
				if codeNum == "" then DialogBox.run(self,"验证码为空") return end
				local getcode = LoginPB_pb.PBFindPasswordParams()
				getcode.mobilenum = phoneNum
				getcode.userid = UserData.userid
				getcode.optype = 2
				getcode.code = codeNum
				local flag,getcodereturn = HttpManager.post("http://lxgame.lexun.com/login/findpwd.aspx",getcode:SerializeToString())
				if not flag then return end
				local obj=LoginPB_pb.PBUserList()
			    obj:ParseFromString(getcodereturn)
			    if obj.msginfo.noerror then
			    	cc.UserDefault:getInstance():setStringForKey("pw_number",phoneNum)
			    	cc.UserDefault:getInstance():setStringForKey("pw_codeNum",codeNum)
			    	cc.UserDefault:getInstance():setIntegerForKey("pw_idNum",useridNum)
			    	AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
            		self:getApp():enterScene("ResetPwLayer")
            	else
            		DialogBox.run(cc.Director:getInstance():getRunningScene(),obj.msginfo.outmsg) 
			    end 
        	elseif index == 2 then
        		if UserData.isbind == 0 then
        			DialogBox.run(self,"已绑定手机")
        			return 
        		end
        		local phoneNum = self.input_phone:getString() 
				if phoneNum == "" then DialogBox.run(self,"手机号为空") return end
				local codeNum = self.input_qcode:getString()
				if codeNum == "" then DialogBox.run(self,"验证码为空") return end
				local bindphone = LoginPB_pb.PBBindingParams()
				bindphone.mobilenum = phoneNum
				bindphone.code = codeNum
				bindphone.optype = 2       
			    local flag,bindphonereturn = HttpManager.post("http://lxgame.lexun.com/login/bindphone.aspx",bindphone:SerializeToString())
			    if not flag then return end
			    local obj=ServerBasePB_pb.PBMessage()
			    obj:ParseFromString(bindphonereturn)
			   	if obj.noerror then
		    		cc.UserDefault:getInstance():setIntegerForKey("is_bind",1)
		    		AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
		    		self:getApp():enterScene("MainScene")
		    	else
		    		DialogBox.run(cc.Director:getInstance():getRunningScene(),obj.outmsg) 
			    end    		
        	end
		end
	end
	self.btn_next:addTouchEventListener(nextCallback)
end
return FindPwLayer