--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/21
--此文件由[BabeLua]插件自动生成
local GameHelpLayer = class("GameHelpLayer",function ()
        return cc.Layer:create()
end)


function GameHelpLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function GameHelpLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/game_help.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.sv_gd = pl_bg_con:getChildByName("sv_gd")
    self.pl_con = pl_bg_con:getChildByName("pl_con1")

end

function GameHelpLayer:infoTouch()
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
    self.btn_back:addTouchEventListener(closeBack)
end

return GameHelpLayer


--endregion
