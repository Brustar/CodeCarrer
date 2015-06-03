--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/11
--此文件由[BabeLua]插件自动生成
local BubbleHelpLayer = class("BubbleHelpLayer",
    function()
    return cc.Layer:create()
    end)

function BubbleHelpLayer:ctor()
    self:infoCSB()
    self:infoTouch()
end

function BubbleHelpLayer:infoCSB()
    
    local CSB = cc.CSLoader:createNode("Bubble/gamehelp.csb")
    CSB:setContentSize(display.size)
    self:addChild(CSB)
    ccui.Helper:doLayout(CSB)

    local pl_alert = CSB:getChildByName("root"):getChildByName("pl_alert")
    self.btn_close = pl_alert:getChildByName("btn_close")
   -- local pl_help_con = pl_alert:getChildByName("pl_help_con")
   -- self.btn_join = pl_help_con:getChildByName("pl_gameact"):getChildByName("btn_join")
   -- self.btn_gift = pl_help_con:getChildByName("pl_gamegift"):getChildByName("Button_1_3")

end   


function BubbleHelpLayer:infoTouch()

    local function CloseCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
     self.btn_close:addTouchEventListener(CloseCallBack)
     --[[
    local function JoinCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        --实现join函数
        print("join function")
        end
    end

    local function GiftCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        --实现领取礼包函数
        print("gift function")
        end
    end

   

    self.btn_join:addTouchEventListener(JoinCallBack)

    self.btn_gift:addTouchEventListener(GiftCallBack)
    --]]
end

return BubbleHelpLayer










--endregion
