local ResetPwLayer = class("ResetPwLayer",cc.load("mvc").ViewBase)

function ResetPwLayer:onCreate()
    self:createResoueceNode("login/resetting_pas.csb")
    self:infoCSB(self.resourceNode_)
    local phonenum=cc.UserDefault:getInstance():getStringForKey("pw_number")
	local codenum=cc.UserDefault:getInstance():getStringForKey("pw_codeNum")
    self:infoTouch(phonenum,codenum)
end
function ResetPwLayer:infoCSB(CSB)
	local bg = CSB:getChildByName("bg")
	self.back = bg:getChildByName("head"):getChildByName("btn_back")
	self.new_pas = bg:getChildByName("new_pas")
	self.input_new_pas = self.new_pas:getChildByName("input_new_pas")
	self.confirm_pas = bg:getChildByName("confirm_pas")
	self.input_pas = self.confirm_pas:getChildByName("input_pas")
	self.sureBtn = bg:getChildByName("btn_ensure")
end
function ResetPwLayer:infoTouch(phonenum,codenum)
	AddCursor.info(self.input_new_pas,"输入新密码")
	AddCursor.info(self.input_pas,"确认新密码")
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
			self:getApp():enterScene("FindPwLayer")
		end
	end
	self.back:addTouchEventListener(backCallback)
	local function nextCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
				if self.input_pas:getString() == "" or 
					self.input_pas:getString() ~= self.input_new_pas:getString() then
					DialogBox.run(self,"输入密码错误")
					return 
				end
				local resetpw = LoginPB_pb.PBFindPasswordParams()
				resetpw.mobilenum = phonenum
				resetpw.userid = cc.UserDefault:getInstance():getIntegerForKey("pw_idNum")
				resetpw.optype = 3
				resetpw.code = codenum
				resetpw.password = self.input_pas:getString()
				print("=======resetpw.userid===",resetpw.userid,resetpw.mobilenum,resetpw.password)
				local flag,resetpwreturn = HttpManager.post("http://lxgame.lexun.com/login/findpwd.aspx",resetpw:SerializeToString())
				if not flag then return end
				local obj=LoginPB_pb.PBUserList()
			    obj:ParseFromString(resetpwreturn)
			    if obj.msginfo.noerror then
			    	--重置密码成功
			    	AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
					self:getApp():enterScene("MainScene")
			    else
			    	DialogBox.run(self,obj.msginfo.outmsg)
			    end
		end
	end
	self.sureBtn:addTouchEventListener(nextCallback)
end
return ResetPwLayer