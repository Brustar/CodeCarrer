local FiveChessScene = class("FiveChessScene", cc.load("mvc").ViewBase)
function FiveChessScene:onCreate()
    self:createResoueceNode("FiveChess/Home.csb")
    local CSB = self.resourceNode_
    local bg = CSB:getChildByName("bg")
    self.btn_paly = bg:getChildByName("btn_paly")
    local panel_btn = bg:getChildByName("panel_btn")
    self.rule = panel_btn:getChildByName("rule")
    self.top = panel_btn:getChildByName("top")
    self.message = panel_btn:getChildByName("message")
    self.talk = panel_btn:getChildByName("talk")
    self.back = bg:getChildByName("btn_home")
    local function touchBack(sender,eventTpye)
        if eventTpye == ccui.TouchEventType.ended then
            if sender == self.rule then
                local gamelayer = require("app.FiveChess.helplayer").new()
                self:addChild(gamelayer)
               -- print("规则界面")
            elseif sender == self.top then
                local gamelayer = require("app.FiveChess.ranklayer").new(self)
                self:addChild(gamelayer)
                --print("排行界面")
            elseif sender == self.message then
                native.showPage("http://clubc.lexun.com/gobang/chatlist.php")
                print("留言")
            elseif sender == self.talk then
                native.showPage("http://f.lexun.com/list.php?bid=27082")
                print("论坛")
            elseif sender == self.btn_paly then
                print("开始游戏")
                self:getApp():enterScene("FiveChessView")
            elseif sender == self.back then           
                self:getApp():enterScene("MainScene")
            end
        end
    end
    self.rule:addTouchEventListener(touchBack)
    self.top:addTouchEventListener(touchBack)
    self.message:addTouchEventListener(touchBack)
    self.talk:addTouchEventListener(touchBack)
    self.btn_paly:addTouchEventListener(touchBack)
    self.back:addTouchEventListener(touchBack)
end

return FiveChessScene