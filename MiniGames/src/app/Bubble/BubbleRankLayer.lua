--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/11
--此文件由[BabeLua]插件自动生成
local BubbleRankLayer = class("BubbleRankLayer",
    function ()
    return cc.Layer:create()
    end)

function BubbleRankLayer:ctor()

    self:infoCSB()
    self:infoTouch()
end

function BubbleRankLayer:infoCSB()

    local CSB = cc.CSLoader:createNode("Bubble/gamepaihang_score.csb")
    CSB:setContentSize(display.size)
    self:addChild(CSB)
    ccui.Helper:doLayout(CSB)

    local pl_alert = CSB:getChildByName("root"):getChildByName("pl_alert")
    self.btn_close = pl_alert:getChildByName("btn_close")

end

function BubbleRankLayer:infoTouch()

    local function CloseCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end

    self.btn_close:addTouchEventListener(CloseCallBack)
    
end

return BubbleRankLayer

--endregion
