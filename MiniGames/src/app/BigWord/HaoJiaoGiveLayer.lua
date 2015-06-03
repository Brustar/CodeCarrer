--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/22
--此文件由[BabeLua]插件自动生成
local HaoJiaoGiveLayer = class("HaoJiaoGiveLayer",function ()
        return cc.Layer:create()
end)


function HaoJiaoGiveLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function HaoJiaoGiveLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/niupihaojiao_zhuangzen.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")--号角转增提交
    self.btn_confirm = pl_bg_con:getChildByName("btn_confirm")--号角提交确认
    self.player_id = pl_bg_con:getChildByName("pl_id"):getChildByName("pl_xiala"):getChildByName("tf_id")--转增者ID
    local pl_xiala = pl_bg_con:getChildByName("pl_num"):getChildByName("pl_xiala")
    self.btn_down = pl_xiala:getChildByName("btn_down_16")
    self.btn_up = pl_xiala:getChildByName("btn_up_18")
    self.pl_item = pl_xiala:getChildByName("pl_item")
    self.zz_num = self.pl_item:getChildByName("text")--转增数量
    self.lv_list = pl_xiala:getChildByName("lv_list")
end

function HaoJiaoGiveLayer:infoTouch()
     local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.btn_back then
            self:removeFromParent()
            elseif sender == self.btn_confirm then
            self:haojiaoGiven()
            end
        end
    end
    self.btn_back:addTouchEventListener(closeBack)
    self.btn_confirm:addTouchEventListener(closeBack) 
end

function HaoJiaoGiveLayer:haojiaoGiven()
   --转增牛皮号角，先搜索转增者id，id不存在，则提示无改id，然后检索转增数量，数量不足提示转增失败，否则转增成功
   self.player_id:setString("166461")
   self.zz_num:setString("5")
   local players_id,haojiaos_num,isgiven = "166461" ,9,1
   local haojiao_num = tonumber(self.zz_num:getString())
   if players_id == self.player_id:getString() and haojiao_num < haojiaos_num then
        isgiven = haojiaos_num - haojiao_num
    else
        isgiven = 0
    end
    self:addChild(require("app.BigWord.ShowResultLayer").new(3,"确认要将"..haojiao_num.."个牛皮号角","转增给"..players_id.."吗?","haojiaogiven",isgiven))
end

return HaoJiaoGiveLayer


--endregion
