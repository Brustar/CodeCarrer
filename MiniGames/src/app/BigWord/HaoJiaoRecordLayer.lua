--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/22
--此文件由[BabeLua]插件自动生成
local HaoJiaoRecordLayer = class("HaoJiaoRecordLayer",function ()
        return cc.Layer:create()
end)


function HaoJiaoRecordLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function HaoJiaoRecordLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/haojiao_jilv.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    local pl_tab = pl_bg_con:getChildByName("pl_tab")
    self.btn_today = pl_tab:getChildByName("btn_dt")--当天按钮
    self.btn_sevenday = pl_tab:getChildByName("btn_7day")
    self.btn_fifteenday = pl_tab:getChildByName("btn_15day")
    self.btn_thirtyday = pl_tab:getChildByName("btn_30day")

    self.lv_list = pl_bg_con:getChildByName("lv_list")--号角记录列表
    self.pl_list_item = pl_bg_con:getChildByName("pl_list_item")--号角记录单元
    self.zz_time = self.pl_list_item:getChildByName("text_mc_5")
    self.name_text = self.pl_list_item:getChildByName("text_nc_7")
    self.zz_num = self.pl_list_item:getChildByName("text_zzsl_9")
end

function HaoJiaoRecordLayer:infoTouch()
     local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
    self.btn_back:addTouchEventListener(closeBack)
end

return HaoJiaoRecordLayer
--endregion
