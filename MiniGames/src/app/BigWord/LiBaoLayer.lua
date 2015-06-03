--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/21
--此文件由[BabeLua]插件自动生成
local LiBaoLayer = class("LiBaoLayer",function ()
        return cc.Layer:create()
end)


function LiBaoLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function LiBaoLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/mylibao.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("root"):getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.input_text = pl_bg_con:getChildByName("pl_input"):getChildByName("TextField_1")
    self.btn_comfirm = pl_bg_con:getChildByName("btn_confirm")--礼包提交

end

function LiBaoLayer:infoTouch()
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.btn_back then
                self:removeFromParent()
            else
                self:checkLiBao()
            end
        end
    end
    self.btn_back:addTouchEventListener(closeBack)
    self.btn_comfirm:addTouchEventListener(closeBack)
end

function LiBaoLayer:checkLiBao()--检测激活码是否使用
     local num = 3
   --[[
   检测激活码，分别返回三种状态 
   --]] 
   if num == 1 then 
        self:addChild(require("app.BigWord.ShowResultLayer").new(3,"","获得xx物品",""))
   elseif num == 2 then 
        self:addChild(require("app.BigWord.ShowResultLayer").new(3,"","请输入有效的激活码",""))
   else
        self:addChild(require("app.BigWord.ShowResultLayer").new(3,"","该激活码已使用,请联系运营商!","")) 
   end
end




return LiBaoLayer
--endregion
