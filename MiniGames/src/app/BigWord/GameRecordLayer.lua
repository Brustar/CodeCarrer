--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/19
--此文件由[BabeLua]插件自动生成
local GameRecordLayer = class("GameRecordLayer",function ()
        return cc.Layer:create()
end)


function GameRecordLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function GameRecordLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/game_jilv.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    local pl_tab = pl_bg_con:getChildByName("pl_tab")
    self.btn_today = pl_tab:getChildByName("btn_dt")--当天按钮
    self.btn_sevenday = pl_tab:getChildByName("btn_7day")
    self.btn_fifteenday = pl_tab:getChildByName("btn_15day")
    self.btn_thirtyday = pl_tab:getChildByName("btn_30day")

    local pl_list = pl_bg_con:getChildByName("pl_list")
    self.lv_list = pl_list:getChildByName("lv_list")--摆擂列表
    self.pl_item_sel = pl_list:getChildByName("pl_item_sel")
    self.text_title = self.pl_item_sel:getChildByName("text_title_26")--摆擂主题

    self.shou_img = self.pl_item_sel:getChildByName("pl_shou_46"):getChildByName("img_qi_35")
    self.shou_text = self.pl_item_sel:getChildByName("pl_shou_46"):getChildByName("text_28")
    self.gong_img = self.pl_item_sel:getChildByName("pl_gong_48"):getChildByName("img_qi_39")
    self.gong_text = self.pl_item_sel:getChildByName("pl_gong_48"):getChildByName("text_30")
    self.lebicoin_text = self.pl_item_sel:getChildByName("pl_jb_50"):getChildByName("text_32")

    self.sheng_img = self.pl_item_sel:getChildByName("pl_shengfu_60"):getChildByName("img_sheng_45")
    self.bai_img = self.pl_item_sel:getChildByName("pl_shengfu_60"):getChildByName("img_sb_47")
    self.sheng_face = self.pl_item_sel:getChildByName("pl_shengfu_60"):getChildByName("pl_sheng_face_55")
    self.bai_face = self.pl_item_sel:getChildByName("pl_shengfu_60"):getChildByName("pl_sb_face_59")
end

function GameRecordLayer:infoTouch()
     local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
    self.btn_back:addTouchEventListener(closeBack)
end


return GameRecordLayer


--endregion
