--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/20
--此文件由[BabeLua]插件自动生成
local GaoShouLayer = class("GaoShouLayer",function ()
        return cc.Layer:create()
end)


function GaoShouLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function GaoShouLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/gaoshoupaihang.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")

    pl_bg_con:getChildByName("pl_list_title"):getChildByName("text_zzsl"):setString("数量")
    local pl_tab = pl_bg_con:getChildByName("pl_tab")
    self.btn_today = pl_tab:getChildByName("btn_dt")--当天按钮
    self.btn_sevenday = pl_tab:getChildByName("btn_7day")
    self.btn_fifteenday = pl_tab:getChildByName("btn_15day")
    self.btn_thirtyday = pl_tab:getChildByName("btn_30day")

    
    self.gaoshou_list = pl_bg_con:getChildByName("lv_list")--高手排行列表
    self.pl_list_item = pl_bg_con:getChildByName("pl_list_item")
    self.img_mc = self.pl_list_item:getChildByName("img_mc")
    self.text_my_mc = self.pl_list_item:getChildByName("text_my_mc")
    self.text_my_zzsl = self.pl_list_item:getChildByName("text_my_zzsl")
    self.player_img = self.pl_list_item:getChildByName("pl_nc"):getChildByName("img_tx")
    self.player_text = self.pl_list_item:getChildByName("pl_nc"):getChildByName("Text_2")

    local pl_xiala = pl_bg_con:getChildByName("pl_xiala")
    self.btn_up = pl_xiala:getChildByName("btn_up")
    self.btn_down = pl_xiala:getChildByName("btn_down")
    self.pl_item = pl_xiala:getChildByName("pl_item")
    self.bailei_text = self.pl_item:getChildByName("text")
    self.bailei_list = pl_xiala:getChildByName("lv_list")

end

function GaoShouLayer:infoTouch()
   local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
    self.btn_back:addTouchEventListener(closeBack)  
end



return GaoShouLayer


--endregion
