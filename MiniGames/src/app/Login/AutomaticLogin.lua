local AutomaticLogin = class("AutomaticLogin")
require("app.UserData")
require("app.DialogBox")
require("app.Login.AddCursor")
AutomaticLogin.UserAccout_Key = "UserAccout"
AutomaticLogin.UserPassword_Key = "UserPassword"
AutomaticLogin.UserAccoutList_Key = "UserAccoutList"
AutomaticLogin.UserLastLogin_Key = "UserLastLogin"

function AutomaticLogin:ctor()
    self:defaultLogin()
end
--判断是账号登录还是快速登录
function AutomaticLogin:defaultLogin()
    local userDefault = cc.UserDefault:getInstance()
    local loginType = userDefault:getIntegerForKey(AutomaticLogin.UserLastLogin_Key)
    if loginType == 0 then
        self:quickLogin()
    else
        if not self:defaultAccountLogin() then
          userDefault:setIntegerForKey(AutomaticLogin.UserLastLogin_Key,0)
          self:quickLogin()
        end
    end
end
-- 默认账号登陆
function AutomaticLogin:defaultAccountLogin()
  local userDefault = cc.UserDefault:getInstance()
  local account = userDefault:getStringForKey(AutomaticLogin.UserAccout_Key)
    local password = userDefault:getStringForKey(AutomaticLogin.UserPassword_Key)
    if "" == account or "" == password then
      printLog("------本地账号信息异常，快速登录")
      return false
    end
    self:accountLogin(account, password)
    return true
end
--账号登录
function AutomaticLogin:accountLogin(account, password)
    local userDefault = cc.UserDefault:getInstance()
    local AccountLogin = LoginPB_pb.PBLoginParams()
    AccountLogin.account = account
    AccountLogin.password = md5.sumhexa(password)
    local flag,loginreturn = HttpManager.post("http://lxgame.lexun.com/login/login.aspx",AccountLogin:SerializeToString())
    if not flag then
        self:NoNetwork() 
        return
    end
    local obj=LoginPB_pb.PBUserList()
    obj:ParseFromString(loginreturn)
    if obj.msginfo.noerror then
        --更新PBBaseInfo里面的 lxt
        if obj.userlist[1].lxt then
          cc.UserDefault:getInstance():setStringForKey('lxt',obj.userlist[1].lxt)
        end
        local getData = LoginPB_pb.PBGetUserParams()
        getData.userid = obj.userlist[1].userid
        local flag,datareturn = HttpManager.post("http://lxgame.lexun.com/login/userinfo.aspx",getData:SerializeToString())
        if not flag then
            self:NoNetwork()
            return
        end
        obj=LoginPB_pb.PBUserList()
        obj:ParseFromString(datareturn)
        --保存登录状态
        userDefault:setIntegerForKey(AutomaticLogin.UserLastLogin_Key,1)
        --初始化玩家信息
        self:infoUserData(obj.userlist[1])
        --保存账号密码
        self:saveUserAccountPassword(account,password)
        --跳转页面
        AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
        require("app.MyApp"):create():run()
    else
        cc.UserDefault:getInstance():setIntegerForKey("is_login",1)--是否登录失败
        print(obj.msginfo.outmsg)
        cc.UserDefault:getInstance():setStringForKey("is_login_msg",obj.msginfo.outmsg)
        require("app.MyApp"):create():run("LoginController")       
    end
end
--登录成功后把账号密码信息存起来
function AutomaticLogin:saveUserAccountPassword(account,password)
    local userDefault = cc.UserDefault:getInstance()
    userDefault:setStringForKey(AutomaticLogin.UserAccout_Key,tostring(account))
    userDefault:setStringForKey(AutomaticLogin.UserPassword_Key,tostring(password))
    --历史登录账号列表
    local listStr = userDefault:getStringForKey(AutomaticLogin.UserAccoutList_Key)
    if listStr and listStr ~= "" then
      local AccountList = JsonManager.decode(listStr)
    end
    if AccountList then
      AccountList[tostring(account)] = tostring(password)
    else
      local AccountList = {}
      AccountList[tostring(account)] = tostring(password)
    end
    userDefault:setStringForKey(AutomaticLogin.UserAccoutList_Key,JsonManager.encode(AccountList))
    userDefault:flush()
end
--快速登录注册
function AutomaticLogin:quickLogin()
    local Autologin = LoginPB_pb.PBAutoRegisterParams()
    local key = "DDF29B1DC8C74BD9BEA2E353A502C91B"
    Autologin.randkey = tostring(math.random(100000,999999))
    Autologin.sign = md5.sumhexa(key..Autologin.randkey)
    local flag,loginreturn = HttpManager.post("http://lxgame.lexun.com/login/autoregister.aspx",Autologin:SerializeToString())
    if not flag then
        self:NoNetwork() 
        return
    end
    local obj=LoginPB_pb.PBUserList()
    obj:ParseFromString(loginreturn)
    if obj.msginfo.noerror then
        --更新PBBaseInfo里面的 lxt
        if obj.userlist[1].lxt then
          cc.UserDefault:getInstance():setStringForKey('lxt',obj.userlist[1].lxt)
        end
        local getData = LoginPB_pb.PBGetUserParams()
        getData.userid = obj.userlist[1].userid
        local flag,datareturn = HttpManager.post("http://lxgame.lexun.com/login/userinfo.aspx",getData:SerializeToString())
        if not flag then
            self:NoNetwork()
            return
        end
        obj=LoginPB_pb.PBUserList()
        obj:ParseFromString(datareturn)
        --初始化玩家信息
        self:infoUserData(obj.userlist[1])
        --跳转页面
        AddCursor.lastField = nil --跳转页面之前，上一个页面的输入框去掉
        require("app.MyApp"):create():run()
    else
        cc.UserDefault:getInstance():setIntegerForKey("is_login",1)--是否登录失败
        cc.UserDefault:getInstance():setStringForKey("is_login_msg",obj.msginfo.outmsg)
        require("app.MyApp"):create():run("LoginController")      
    end
end
--网络不通提示
function AutomaticLogin:NoNetwork()
    cc.UserDefault:getInstance():setIntegerForKey("is_login",1)--是否登录失败
    cc.UserDefault:getInstance():setStringForKey("is_login_msg","连接失败，请检查你的网络设置。")
    require("app.MyApp"):create():run("LoginController")  
end
--初始化userdata
function AutomaticLogin:infoUserData(Data)
    UserData.userid=Data.userid
    UserData.nick=Data.nick
    UserData.stone=Data.stone
    UserData.facesmall=Data.facesmall
    UserData.phone = Data.phone       
    UserData.initpwd = Data.initpwd     
    UserData.isbind = Data.isbind      
    --将玩家头像信息存入UserDefault
    HttpManager.downIcon(UserData.facesmall)
    local _,_,_,file=parseUrl(UserData.facesmall) 
    if file then
        cc.UserDefault:getInstance():setStringForKey('userHeadIcon',device.writablePath..file)
    end
end
return AutomaticLogin