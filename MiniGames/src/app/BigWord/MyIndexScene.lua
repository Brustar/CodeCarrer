--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/18
--此文件由[BabeLua]插件自动生成
local MyIndexScene = class("MyIndexScene",cc.load("mvc").ViewBase)
local isShowplset = false
function MyIndexScene:onCreate()

    self:infoCSB()
    self:infoTouch()
end
function MyIndexScene:infoCSB()
  self:createResoueceNode("BigWord/myindex.csb")
  local CSB = self.resourceNode_
  
  local pl_top = CSB:getChildByName("root"):getChildByName("pl_top")
  self.btn_set = pl_top:getChildByName("btn_set")
  self.pl_set = CSB:getChildByName("root"):getChildByName("pl_set"):setVisible(false)
  self.pl_set:setPosition(cc.p(self.pl_set:getPositionX(),self.pl_set:getPositionY() + 450))
  self.pl_bailei = self.pl_set:getChildByName("pl_bailei")-- 摆擂
  self.pl_plbl = self.pl_set:getChildByName("pl_plbl")--批量摆擂
  self.pl_ltjl = self.pl_set:getChildByName("pl_ltjl")--擂台记录
  self.pl_wdhj = self.pl_set:getChildByName("pl_wdhj") --我的号角
  self.pl_yxph = self.pl_set:getChildByName("pl_yxph") --游戏排名
  self.pl_libao = self.pl_set:getChildByName("pl_libao") --礼包
  self.pl_yxbz = self.pl_set:getChildByName("pl_yxbz") --游戏帮助

  local pl_tab = CSB:getChildByName("root"):getChildByName("pl_tab")
  self.pl_tab_con = pl_tab:getChildByName("tab_content"):getChildByName("sv_tab"):getChildByName("pl_tab_con")
  self.btn_tab_fuhao = self.pl_tab_con:getChildByName("btn_tab_fuhao")
  self.btn_tab_niuren = self.pl_tab_con:getChildByName("btn_tab_niuren")
  self.btn_tab_jingying = self.pl_tab_con:getChildByName("btn_tab_jingying")
  self.btn_tab_niuwang = self.pl_tab_con:getChildByName("btn_tab_niuwang")
  self.btn_tab_laoniao = self.pl_tab_con:getChildByName("btn_tab_laoniao")
  self.btn_tab_xinshou = self.pl_tab_con:getChildByName("btn_tab_xinshou")
  self.btn_tab_cainiao = self.pl_tab_con:getChildByName("btn_tab_cainiao")
  self.btn_tab_xinren = self.pl_tab_con:getChildByName("btn_tab_xinren")
  self.pl_btn_right = pl_tab:getChildByName("pl_btn_right")






end
 
function MyIndexScene:infoTouch()
    local function btnsetCallBack(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
           if not isShowplset then 
              self.pl_set:setVisible(true):runAction(cc.MoveBy:create(0.6,cc.p(0,-508)))
               isShowplset = true
           else
              local function plsetCallBack()
                self.pl_set:setVisible(false)
              end
             self.pl_set:runAction(cc.Sequence:create(cc.MoveBy:create(0.6,cc.p(0,508)),cc.CallFunc:create(plsetCallBack)))
             isShowplset = false
           end
        end
    end
    self.btn_set:addTouchEventListener(btnsetCallBack)

    local function getInLayer(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender == self.pl_bailei then 
                self:addChild(require("app.BigWord.FastBaiLeiLayer").new())
            elseif sender == self.pl_plbl then
                self:addChild(require("app.BigWord.PiLiangBaiLeiLayer").new())
            elseif sender == self.pl_ltjl then
                self:addChild(require("app.BigWord.GameRecordLayer").new()) 
            elseif sender == self.pl_wdhj then
                self:addChild(require("app.BigWord.MyHaoJiaoLayer").new())
            elseif sender == self.pl_yxph then
                self:addChild(require("app.BigWord.GaoShouLayer").new())
            elseif sender == self.pl_libao then
                self:addChild(require("app.BigWord.LiBaoLayer").new())
            elseif sender == self.pl_yxbz then
                self:addChild(require("app.BigWord.GameHelpLayer").new())
            end
        end
    end
    self.pl_bailei:addTouchEventListener(getInLayer)
    self.pl_plbl:addTouchEventListener(getInLayer)
    self.pl_ltjl:addTouchEventListener(getInLayer)
    self.pl_wdhj:addTouchEventListener(getInLayer)
    self.pl_yxph:addTouchEventListener(getInLayer)
    self.pl_libao:addTouchEventListener(getInLayer)
    self.pl_yxbz:addTouchEventListener(getInLayer)



end

return MyIndexScene
--endregion
