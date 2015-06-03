--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/21
--此文件由[BabeLua]插件自动生成
local ShowResultLayer = class("ShowResultLayer",function ()
        return cc.Layer:create()
end)


function ShowResultLayer:ctor(...)
     self:infoCSB(...)
       
end 
 
function ShowResultLayer:infoCSB(...)
    local CSB = cc.CSLoader:createNode("BigWord/alert_blcg.csb"):setContentSize(display.size):addTo(self) 
    ccui.Helper:doLayout(CSB)
    local pl_alert = CSB:getChildByName("root"):getChildByName("pl_alert")
    self.btn_close = pl_alert:getChildByName("btn_close")
    self.failed_img = pl_alert:getChildByName("img_title_n"):setVisible(false)
    self.success_img = pl_alert:getChildByName("img_title_l"):setVisible(false)
    self.text_one = pl_alert:getChildByName("text_title_con")
    self.text_two = pl_alert:getChildByName("text_title_con_0")
    self.btn_confirm = pl_alert:getChildByName("btn_confirm")
    local ishave ,texta,textb,functype,leftnum  =  ...
    self.left_haojiao_num = leftnum
    self.text_one:setString(texta)
    self.text_two:setString(textb)
    if ishave == 1 then
       self.success_img:setVisible(true) 
       self.failed_img:setVisible(false)
    elseif ishave == 2 then
       self.success_img:setVisible(false) 
       self.failed_img:setVisible(true)
    elseif ishave == 3 then
       self.success_img:setVisible(false) 
       self.failed_img:setVisible(false) 
    end
    self:infoTouch(functype)
end

function ShowResultLayer:infoTouch(functype)
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.btn_close then
                self:removeFromParent()
            elseif sender == self.btn_confirm then
               self:handlerResult(functype)
            end
        end
    end
    self.btn_close:addTouchEventListener(closeBack)
    self.btn_confirm:addTouchEventListener(closeBack)
end

function ShowResultLayer:handlerResult(functype)  
     if functype == "piliang" then 
          self:getParent():removeFromParent()
     elseif functype == "haojiaogiven" then
          if self.left_haojiao_num > 0 then
         self:addChild(require("app.BigWord.ShowResultLayer").new(3,"转增成功!","您当前剩余"..self.left_haojiao_num.."个牛皮号角","piliang"))
         else
         self:addChild(require("app.BigWord.ShowResultLayer").new(3,"转增失败!","您当前的牛皮号角数量不足","piliang"))
          end 
     else
          self:removeFromParent()
     end
end


return ShowResultLayer


--endregion
