--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/22
--此文件由[BabeLua]插件自动生成
local ZiDongBeginLayer = class("ZiDongBeginLayer",function ()
        return cc.Layer:create()
end)


function ZiDongBeginLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function ZiDongBeginLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/bailei_chenggong.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.text_submit = pl_bg_con:getChildByName("img_text_submit")--停止摆擂

    self.bailei_list = pl_bg_con:getChildByName("lv_list")--摆擂列表
    
    self.title_text = pl_bg_con:getChildByName("pl_item"):getChildByName("text_item_title")
    self.answer_text = pl_bg_con:getChildByName("pl_item"):getChildByName("text_daan_con")--摆擂答案
end

function ZiDongBeginLayer:infoTouch()
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:removeFromParent()
            print("stop bailei function")
        end
    end
    self.text_submit:addTouchEventListener(closeBack) 
end




return ZiDongBeginLayer


--endregion
