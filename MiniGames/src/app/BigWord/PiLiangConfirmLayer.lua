--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/21
--此文件由[BabeLua]插件自动生成
local PiLiangConfirmLayer = class("PiLiangConfirmLayer",function ()
        return cc.Layer:create()
end)


function PiLiangConfirmLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function PiLiangConfirmLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
    local CSB = cc.CSLoader:createNode("BigWord/pilangbailei_confirm.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.btn_confirm = pl_bg_con:getChildByName("img_text_submit")
    self.pl_hyp = pl_bg_con:getChildByName("pl_num"):getChildByName("pl_hyp")
    self.pl_list = pl_bg_con:getChildByName("lv_list")
    self.pl_item = pl_bg_con:getChildByName("pl_item")
    self.text_con = self.pl_item:getChildByName("text_con")
    --
end

function PiLiangConfirmLayer:infoTouch()
    local function submitBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.btn_confirm then
                self:baiLeiResult()
            elseif sender == self.pl_hyp then
                self:removeFromParent()
            end
        end
    end
    self.btn_confirm:addTouchEventListener(submitBack)
    self.pl_hyp:addTouchEventListener(submitBack)
end

function PiLiangConfirmLayer:baiLeiResult()
    local piliangnum = 100000
    if piliangnum >= 6000000 then
        self:addChild(require("app.BigWord.ShowResultLayer").new(1,"恭喜你摆擂成功!","就等着别人来上当吧,哈哈哈哈!","piliang"))
    else 
        self:addChild(require("app.BigWord.ShowResultLayer").new(2,"操作失败","当前乐币不足!","piliang"))
    end
end


return PiLiangConfirmLayer


--endregion
