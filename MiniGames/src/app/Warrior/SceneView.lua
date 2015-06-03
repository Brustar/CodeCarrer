
local SceneView = class("SceneView",function()
    return cc.Layer:create()
    end)

function SceneView:ctor(which,parent)
    
    self:gameEnd(which,parent)

end
function SceneView:gameEnd(which,parent)
     if which==1 then
        self:timeOut(which,parent)
     elseif which ==2 then
        self:finshGame(which,parent)  
     end 
end
--结算
function SceneView:gameAgain(which,parent)

    local delay = cc.DelayTime:create(1)
    local Account = GamePB_pb.PBWarriorGamelog_Update_Params()
    parent.endTime = os.date("%Y-%m-%d %H:%M:%S")
    Account.starttime = parent.startTime
    Account.endtime = parent.endTime
    Account.levels = parent.level-1 
    Account.starnum = parent.allStars
    Account.stepnum=parent.allStep
    Account.costtime = parent.costtime
    print("===",Account.starttime,Account.endtime,Account.levels, Account.starnum, Account.stepnum,Account.costtime)
    local flag,endReturn = HttpManager.post("http://lxgame.lexun.com/interface/warrior/updategamelog.aspx",Account:SerializeToString())
    if not flag then return end
    local obj=ServerBasePB_pb.PBMessage()
    obj:ParseFromString(endReturn)
end

--通关
function SceneView:finshGame(which,parent)
    self:gameAgain(which,parent)
    local passLevel = cc.CSLoader:createNode("Warrior/pass.csb")
    self:addChild(passLevel,1009)
    passLevel:setContentSize(display.size)
    ccui.Helper:doLayout(passLevel)
    local window = passLevel:getChildByName("bg"):getChildByName("window")
    self.backPage = window:getChildByName("btn_back")--返回
    self.rePlayGame = window:getChildByName("btn_new")--继续
    self.btn_close =window:getChildByName("btn_close")--返回X
    local round = window:getChildByName("article_bg"):getChildByName("round")
    self.leveText = round:getChildByName("num")
    local star = window:getChildByName("article_bg"):getChildByName("star")
    self.starText = star:getChildByName("num_2")
    local walk = window:getChildByName("article_bg"):getChildByName("walk")
    self.walkText = walk:getChildByName("num_3")
    self.leveText:setString(parent.level-1)
    self.walkText:setString(parent.allStep)
    self.starText:setString(parent.allStars)
    self.laughCry= window:getChildByName("tu"):getChildByName("img1")
    self.title= window:getChildByName("tu"):getChildByName("title")
    local tuTitle = window:getChildByName("tu")
    local function onclose(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
         parent:stopAction(parent.countdownaction)
         -- parent.time =60
          --self:getParent():removeFromParent()
          parent:getApp():enterScene("StartScene")
        end
    end
    self.btn_close:addTouchEventListener(onclose)
    self.backPage:addTouchEventListener(onclose)

     local function onreturn(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                   -- self:getParent():removeFromParent()     
                    self:removeFromParent()
                    parent.level = 1
                    parent.allStars = 0
                    parent.allStep = 0
                    parent.num_time:setString(180)
                    parent:countdownBegin()
                    parent:initUI()
                end
    end
    self.rePlayGame:addTouchEventListener(onreturn)
end

--时间用完
function SceneView:timeOut(which,parent)
    self:gameAgain(which,parent)
    local timeout = cc.CSLoader:createNode("Warrior/time.csb")
    self:addChild(timeout,1009)
    timeout:setContentSize(display.size)
    ccui.Helper:doLayout(timeout)
    local window = timeout:getChildByName("bg"):getChildByName("window")
    self.backPage = window:getChildByName("btn_back")--返回
    self.rePlayGame = window:getChildByName("btn_new")--继续
    self.btn_close =window:getChildByName("btn_close")--返回X
    local round = window:getChildByName("article_bg"):getChildByName("round")
    self.leveText = round:getChildByName("num")
    local star = window:getChildByName("article_bg"):getChildByName("star")
    self.starText = star:getChildByName("num_2")
    local walk = window:getChildByName("article_bg"):getChildByName("walk")
    self.walkText = walk:getChildByName("num_3")
    self.leveText:setString(parent.level-1)
    self.walkText:setString(parent.allStep)
    self.starText:setString(parent.allStars)
    self.laughCry= window:getChildByName("tu"):getChildByName("img1")
    self.title= window:getChildByName("tu"):getChildByName("title")
    --返回
    local function onclose(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
         parent:stopAction(parent.countdownaction)
         -- parent.time =60
          --self:getParent():removeFromParent()
          parent:getApp():enterScene("StartScene")
        end
    end
    self.backPage:addTouchEventListener(onclose)
    self.btn_close:addTouchEventListener(onclose)
    --重玩
    local function onreturn(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                   -- self:getParent():removeFromParent()     
                    self:removeFromParent()
                parent.level = 1
                parent.allStars = 0
                parent.allStep = 0
                parent.num_time:setString(180)

                parent:countdownBegin()
                parent:initUI()
                end
    end
    self.rePlayGame:addTouchEventListener(onreturn)
end

return SceneView