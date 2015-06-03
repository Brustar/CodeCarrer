--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/19
--此文件由[BabeLua]插件自动生成
local FastBaiLeiLayer = class("FastBaiLeiLayer",function ()
        return cc.Layer:create()
end)

function FastBaiLeiLayer:ctor()
     self:infoCSB()
     self:infoTouch()  
end    


function FastBaiLeiLayer:infoCSB()
    cc.LayerColor:create(cc.c4b(0,0,0,180)):addTo(self)
    local CSB = cc.CSLoader:createNode("BigWord/kuaishubailei.csb"):setContentSize(display.size):addTo(self)
    ccui.Helper:doLayout(CSB)
    self.btn_back = CSB:getChildByName("root"):getChildByName("btn_back")
    local pl_bg_con = CSB:getChildByName("root"):getChildByName("pl_alert"):getChildByName("pl_bg_con")

    self.input_field = pl_bg_con:getChildByName("pl_input"):getChildByName("tf_titile")--摆擂话题输入
    self.btn_submit = pl_bg_con:getChildByName("img_text_submit")--话题提交按钮
   
    local pl_xiala = pl_bg_con:getChildByName("pl_leijing"):getChildByName("pl_xiala")
    self.btn_down = pl_xiala:getChildByName("btn_down")
    self.btn_up = pl_xiala:getChildByName("btn_up")
    self.pl_item = pl_xiala:getChildByName("pl_item"):setVisible(false)--列表单元
    self.item_text = self.pl_item:getChildByName("text")
    self.lv_list = pl_xiala:getChildByName("lv_list")--下拉列表


    self.ckb_zhen = pl_bg_con:getChildByName("pl_myanswer"):getChildByName("pl_zheng"):getChildByName("pl_ckb")
    self.ckb_jia = pl_bg_con:getChildByName("pl_myanswer"):getChildByName("pl_jia"):getChildByName("pl_ckb")
    self.zhen_img = self.ckb_zhen:getChildByName("img"):setVisible(false)--答案为真
    self.jia_img = self.ckb_jia:getChildByName("img"):setVisible(false)--答案为假

    self.pl_plbl = pl_bg_con:getChildByName("pl_bailei"):getChildByName("pl_plbl")--批量摆擂
    self.pl_zdbl = pl_bg_con:getChildByName("pl_bailei"):getChildByName("pl_plbl_0")--自动摆擂

end

function FastBaiLeiLayer:infoTouch()
    local function closeBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
        self:removeFromParent()
        end
    end
    self.btn_back:addTouchEventListener(closeBack)

    local function choosAnswer(sender,eventType)
       if eventType == ccui.TouchEventType.ended then
            if sender == self.ckb_zhen then
                self.zhen_img:setVisible(true)
                self.jia_img:setVisible(false)
            elseif sender == self.ckb_jia then
                self.zhen_img:setVisible(false)
                self.jia_img:setVisible(true)
            end 
       end 
    end
    self.ckb_zhen:addTouchEventListener(choosAnswer)
    self.ckb_jia:addTouchEventListener(choosAnswer)

    local function choosLayer(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
             if sender == self.pl_plbl then
               self:addChild(require("app.BigWord.PiLiangBaiLeiLayer").new())
            elseif sender == self.pl_zdbl then
               self:addChild(require("app.BigWord.ZiDongBaiLeiLayer").new())
            end 
        end
    end
    self.pl_plbl:addTouchEventListener(choosLayer)
    self.pl_zdbl:addTouchEventListener(choosLayer)

    local function submitCallBack(sender,eventType)
        local isTrue = false
         if eventType == ccui.TouchEventType.ended then
            self:addChild(require("app.BigWord.ShowResultLayer").new(self:setValue(isTrue)))
        end
    end

    self.btn_submit:addTouchEventListener(submitCallBack)
end

function FastBaiLeiLayer:setValue(isTrue)
    local ishave,texta,textb,funtype
    if isTrue then
        ishave = 1
        texta = "恭喜你摆擂成功!"
        textb = "就等着别人来上当吧,哈哈哈哈!"
    else
        ishave = 2
        texta = "操作失败"
        textb = "当前乐币不足!"
    end
    funtype = ""
    return ishave,texta,textb,funtype
end

function FastBaiLeiLayer:createList()
    local num = 0
    for i = 1,1 do
       num = num + 100
       local item = self.pl_item:clone()
       item:setVisible(true)
       local text = item:getChildByName("text")
       text:setString(string:format("%d万",num))
       self.lv_list:pushBackCustomItem(item)
    end
end

return FastBaiLeiLayer
--endregion
