--修改密码
local ChangePwLayer = class("ChangePwLayer",cc.load("mvc").ViewBase)
function ChangePwLayer:onCreate()
    self:createResoueceNode("login/modify_pas.csb")
    self:infoCSB(self.resourceNode_)
end
function ChangePwLayer:infoCSB(CSB)
	local bg = CSB:getChildByName("bg")
	self.back = bg:getChildByName("head"):getChildByName("btn_back")
	self.old_pass = bg:getChildByName("old_pass")
	self.input_old_pas = self.old_pass:getChildByName("input_old_pas")
	self.new_pas = bg:getChildByName("new_pas")
	self.input_new_pas = self.new_pas:getChildByName("input_new_pas")
	self.confirm_pas = bg:getChildByName("confirm_pas")
	self.input_pas = self.confirm_pas:getChildByName("input_pas")
	self.btn_modify = bg:getChildByName("btn_modify")
	self:infoTouch()
end
function ChangePwLayer:infoTouch()
 	AddCursor.info(self.input_old_pas,"原密码")
 	AddCursor.info(self.input_new_pas,"新密码")
 	AddCursor.info(self.input_pas,"确认密码")
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
			self:getApp():enterScene("MainScene")
		end
	end
	self.back:addTouchEventListener(backCallback)
	local function nextCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			local oldPW = self.input_old_pas:getString()
			local newPW = self.input_new_pas:getString()
			local confirmPW = self.input_pas:getString()
			if oldPW==""or newPW=="" or confirmPW=="" then
				DialogBox.run(self,"输入不对")
				return
			elseif newPW ~= confirmPW then
				DialogBox.run(self,"两次输入密码不一致")
				return
			else 
				local changePw = LoginPB_pb.PBModifyPasswordParams()
			    changePw.oldpwd = oldPW
			    changePw.newpwd = newPW
			    changePw.pwdconfirm = confirmPW          
			    local flag,changePwreturn = HttpManager.post("http://lxgame.lexun.com/login/modifypwd.aspx",changePw:SerializeToString())
			    if not flag then return end
			    local obj=LoginPB_pb.PBModifyPasswordReturn()		   
			    obj:ParseFromString(changePwreturn)
			    if obj.msginfo.noerror then
			    	cc.UserDefault:getInstance():setIntegerForKey("is_changePw",1)--是否修改密码成功
			    	--修改密码成功
			    	AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
					self:getApp():enterScene("MainScene")
					if obj.newlxt then
						cc.UserDefault:getInstance():setStringForKey('lxt',obj.newlxt)
					end	
				else	
					DialogBox.run(cc.Director:getInstance():getRunningScene(),obj.msginfo.outmsg)			
			    end
			end
		end
	end
	self.btn_modify:addTouchEventListener(nextCallback)
end
return ChangePwLayer