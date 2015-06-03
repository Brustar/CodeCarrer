local FinishLayer = class("finishlayer",
	function ()
		return cc.Layer:create()
	end)

function FinishLayer:ctor()

	self:infoCSB()
    self:showData()
    self:infoTouch()
    
end
function FinishLayer:infoCSB()
    local CSB
    if BubbleData.haveLB then
        
        CSB = cc.CSLoader:createNode("Bubble/alert_timeover01.csb") 
    else
        CSB = cc.CSLoader:createNode("Bubble/alert_timeover02.csb") 
    end    
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg= CSB:getChildByName("root"):getChildByName("pl_box")
    self.mAgain = bg:getChildByName("pl_btn_again")
    self.mBack = bg:getChildByName("pl_btn_back")
    local textContent = bg:getChildByName("pl_alert"):getChildByName("pl_alert_con")
    --haveLB为true时显示乐币数，为false时显示历史最高得分
    local pl_score = textContent:getChildByName("pl_score")
    local pl_lebi = textContent:getChildByName("pl_lebi")
    local pointLab = pl_score:getChildByName("al_big_score")
    local bestPointLab = pl_lebi:getChildByName("AtlasLabel_4")
    self.maxLink = textContent:getChildByName("pl_data"):getChildByName("text_lt_num")
    self.burstNum = textContent:getChildByName("pl_data"):getChildByName("text_lt_num_0")
    pointLab:setVisible(false)
    bestPointLab:setVisible(false)
    
    self.pointLab = ccui.TextAtlas:create()
                    :setProperty(0,"Bubble/img_big_num.png",34,52,".")
                    :setPosition(pointLab:getPosition())
    pl_score:addChild(self.pointLab)

    if BubbleData.haveLB then
    self.leBi = ccui.TextAtlas:create()
                    :setProperty(0,"Bubble/img_big_num.png",34,52,".")
                    :setPosition(cc.p(bestPointLab:getPositionX()-70,bestPointLab:getPositionY()))
                    :setScale(0.6)
    pl_lebi:addChild(self.leBi)
    else
    self.bestPoint = ccui.TextAtlas:create()
                    :setProperty(0,"Bubble/img_num_zi.png",20,33,".")
                    :setPosition(cc.p(bestPointLab:getPositionX()-70,bestPointLab:getPositionY()))
    pl_lebi:addChild(self.bestPoint)
   end

    
end
function FinishLayer:infoTouch()
    local function touchCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.mAgain then
                self:removeFromParent()
            elseif sender == self.mBack then
                cc.SimpleAudioEngine:getInstance():stopMusic()
                self:getParent():getApp():enterScene("BubbleScene")
            end 
        end
    end

    self.mAgain:addTouchEventListener(touchCallBack)
    self.mBack:addTouchEventListener(touchCallBack)
    
end

function FinishLayer:showData()

    UserData.stone = UserData.stone + BubbleData.LBcoin --改变乐币的数量

    local userdefault = cc.UserDefault:getInstance()
    local hightScore = userdefault:getIntegerForKey("HistoryScore",0)
    if BubbleData.gameScore > hightScore then
    hightScore = BubbleData.gameScore
    end
    userdefault:setIntegerForKey("HistoryScore",hightScore)--保存历史最高得分
    userdefault:flush()
    self.burstNum:setString(BubbleData.burstNum)
    self.maxLink:setString(BubbleData.maxLong)
    self.pointLab:setString(BubbleData.gameScore)

    if BubbleData.haveLB then
        self.leBi:setString(BubbleData.LBcoin)
    else
        self.bestPoint:setString(hightScore)
    end
end


return FinishLayer