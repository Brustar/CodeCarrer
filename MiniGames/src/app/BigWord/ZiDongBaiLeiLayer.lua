--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/19
--此文件由[BabeLua]插件自动生成
local ZiDongBaiLeiLayer = class("ZiDongBaiLeiLayer",function ()
        return cc.Layer:create()
end)


function ZiDongBaiLeiLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function ZiDongBaiLeiLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/zidongbailei.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("root"):getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.text_submit = pl_bg_con:getChildByName("img_text_submit")
 
end

function ZiDongBaiLeiLayer:infoTouch()
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.btn_back then
                self:removeFromParent()
            else 
                self:addChild(require("app.BigWord.ZiDongBeginLayer").new())
            end
        end
    end
    self.btn_back:addTouchEventListener(closeBack) 
    self.text_submit:addTouchEventListener(closeBack)
end

return ZiDongBaiLeiLayer


--endregion
