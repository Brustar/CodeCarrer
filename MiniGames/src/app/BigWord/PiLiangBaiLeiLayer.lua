--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/19
--此文件由[BabeLua]插件自动生成
local PiLiangBaiLeiLayer = class("PiLiangBaiLeiLayer",function ()
        return cc.Layer:create()
end)


function PiLiangBaiLeiLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function PiLiangBaiLeiLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/pilangbailei.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("root"):getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.text_submit = pl_bg_con:getChildByName("img_text_submit")
    --第一个下拉菜单
    local first_xiala = pl_bg_con:getChildByName("pl_leijing"):getChildByName("pl_xiala")
    self.btn_down = first_xiala:getChildByName("btn_down")
    self.btn_up = first_xiala:getChildByName("btn_up")
    self.pl_item = first_xiala:getChildByName("pl_item")
    self.item_text = self.pl_item:getChildByName("text_28")
    self.lv_list = first_xiala:getChildByName("lv_list")
    --第二个下拉菜单
    local second_xiala = pl_bg_con:getChildByName("pl_leijing_0"):getChildByName("pl_xiala")
    self.btn_downs = second_xiala:getChildByName("btn_down")
    self.btn_ups = second_xiala:getChildByName("btn_up")
    self.pl_items = second_xiala:getChildByName("pl_item")
    self.item_texts = self.pl_item:getChildByName("text")
    self.lv_lists = second_xiala:getChildByName("lv_list")

end

function PiLiangBaiLeiLayer:infoTouch()
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.btn_back then
               self:removeFromParent()
            elseif sender == self.text_submit then
                self:addChild(require("app.BigWord.PiLiangConfirmLayer").new())
            end  
           
        end
    end
    self.btn_back:addTouchEventListener(closeBack) 
    self.text_submit:addTouchEventListener(closeBack) 
end

return PiLiangBaiLeiLayer
--endregion
