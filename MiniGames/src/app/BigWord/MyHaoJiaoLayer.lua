--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/20
--此文件由[BabeLua]插件自动生成
local MyHaoJiaoLayer = class("MyHaoJiaoLayer",function ()
        return cc.Layer:create()
end)


function MyHaoJiaoLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end 

function MyHaoJiaoLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
     local CSB = cc.CSLoader:createNode("BigWord/niupihaojiao.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("root"):getChildByName("btn_back")--返回

    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_alert_con"):getChildByName("pl_bg_con")
    self.haojiao_num = pl_bg_con:getChildByName("text_num")--牛皮号角的数量
    local pl_btn = pl_bg_con:getChildByName("pl_btn")
    self.btn_dh = pl_btn:getChildByName("btn_dh")--兑换牛皮号角
    self.btn_zz = pl_btn:getChildByName("btn_zz")--转增
    self.btn_jl = pl_btn:getChildByName("btn_jl")--记录
end

function MyHaoJiaoLayer:infoTouch()
     local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
    self.btn_back:addTouchEventListener(closeBack)
    local function haojiaoCallBack(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
         if sender == self.btn_dh then
            self:haojiaoExchange()
         elseif sender == self.btn_zz then
            self:addChild(require("app.BigWord.HaoJiaoGiveLayer").new())
         else
            self:addChild(require("app.BigWord.HaoJiaoRecordLayer").new())
         end
      end
    end

    self.btn_dh:addTouchEventListener(haojiaoCallBack)
    self.btn_zz:addTouchEventListener(haojiaoCallBack)
    self.btn_jl:addTouchEventListener(haojiaoCallBack)
end

function MyHaoJiaoLayer:haojiaoExchange()
    self.haojiao_num:setString("12")
    local exnum = tonumber(self.haojiao_num:getString())
    if exnum >= 10 then
        self:addChild(require("app.BigWord.ShowResultLayer").new(1,"恭喜你,兑换成功","消耗10个牛皮号角,获得4亿乐币",""))
    else
        self:addChild(require("app.BigWord.ShowResultLayer").new(2,"兑换失败!","您当前的牛皮号角数量不足",""))
    end
end



return MyHaoJiaoLayer


--endregion
