--登录注册逻辑控制
local winSize = cc.Director:getInstance():getWinSize()
local LoginController = class("LoginController",cc.load("mvc").ViewBase)
function LoginController:onCreate()
    --切换到登录界面后统一把登录状态保存为快速登录
    cc.UserDefault:getInstance():setIntegerForKey("UserLastLogin",0)
    self:infoCSB()
    self:infoLoginLayer()
    performWithDelay(self, function ()
        if cc.UserDefault:getInstance():getIntegerForKey("is_login") == 1 then
            cc.UserDefault:getInstance():setIntegerForKey("is_login",0)
            DialogBox.run(cc.Director:getInstance():getRunningScene(),cc.UserDefault:getInstance():getStringForKey("is_login_msg")) 
        end
    end,0.2)
end
--加载json
function LoginController:infoCSB()  
    cc.SpriteFrameCache:getInstance():addSpriteFrames("login/gameout.plist")
    self:createResoueceNode("login/login.csb")
    local bg = self.resourceNode_:getChildByName("bg")
    local loginPanel = bg:getChildByName("login")
    local namePanel = loginPanel:getChildByName("user_name")
    self.nameText = namePanel:getChildByName("input_name")
    self.name_del = namePanel:getChildByName("del_ico")
    local pwPanel = loginPanel:getChildByName("user_password")
    self.pwText = pwPanel:getChildByName("input_pw")
    self.loginBtn = loginPanel:getChildByName("btn_login")
    self.pw_Err = loginPanel:getChildByName("pw_erro")
    self.err_tips = self.pw_Err:getChildByName("erro_tips")
    self.findPw = loginPanel:getChildByName("find_pw")
    self.pw_Err:setVisible(false)
end
--初始化登录界面
function LoginController:infoLoginLayer()
    local function loginGame(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:login()
        end
    end
    self.loginBtn:addTouchEventListener(loginGame)

    AddCursor.info(self.nameText,"用户名")
    AddCursor.info(self.pwText,"密码")
    local function findPWCallBack(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            cc.UserDefault:getInstance():setIntegerForKey("change_bind",1)
            AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
            self:getApp():enterScene("FindPwLayer")
        end
    end
    self.findPw:setTouchEnabled(true)
    self.findPw:addTouchEventListener(findPWCallBack)
end
function LoginController:login()--发登录协议
    if "" == self.nameText:getString() then
        DialogBox.run(self,"账号为空")
    elseif "" == self.pwText:getString() then
        DialogBox.run(self,"密码为空")
    else
        local account = self.nameText:getString()
        local password = self.pwText:getString()
        if account == "" or password == "" then return end
        require("app.Login.AutomaticLogin"):accountLogin(account, password)
    end
end
return LoginController
