local MainScene = class("MainScene", cc.load("mvc").ViewBase)

require("app.views.LoadingLayer")
MainScene.recentGame_first = "recentFirst"
MainScene.recentGame_second = "recentSecond"
MainScene.recentGame_three = "recentThree"
MainScene.recentGame = "recentGame"
local userDefault = cc.UserDefault:getInstance()

function MainScene:onCreate() 
  cc.SpriteFrameCache:getInstance():removeSpriteFrames()
  self:infoCSB()
  self:onMoreBtn()
  self:infoRecentGame()
  performWithDelay(self, function ()
      self:getGameList()
      --是否从修改密码跳转过来
      if userDefault:getIntegerForKey("is_changePw") == 1 then
        userDefault:setIntegerForKey("is_changePw",0)
        DialogBox.run(cc.Director:getInstance():getRunningScene(),"修改密码成功") 
      end
      --是否从绑定手机来
      if userDefault:getIntegerForKey("is_bind") == 1 then
        userDefault:setIntegerForKey("is_bind",0)
        DialogBox.run(cc.Director:getInstance():getRunningScene(),"绑定手机成功") 
      end
  end,0.001)
end


--拉取游戏列表(只有登陆的时候才会拉游戏列表)
function MainScene:getGameList() 
  local function updateFunction()
      local PAGE = ServerBasePB_pb.PBPageInfo()
      PAGE.page  = 1
      PAGE.pagesize  = 20
      local flag,gamelistReturn = HttpManager.post("http://lxgame.lexun.com/interface/gamelist.aspx",PAGE:SerializeToString())
      if not flag then 
        if not gamelistReturn then
          DialogBox.run(cc.Director:getInstance():getRunningScene(),"连接失败，网络超时。")
        end
        return 
      end
      local obj=GamePB_pb.PBGameLobbyList()
      obj:ParseFromString(gamelistReturn)
      if #obj.list > 0 then
          local urls = self:getIcons(obj.list)
          HttpManager.downloads(urls)
          self:infoGameList(obj.list)
          userDefault:setStringForKey("GameList",util.toHexString(gamelistReturn))
          return true
      end
      return false
  end 
  local flag,upReturn = HttpManager.post("http://lxgame.lexun.com/interface/lobbyupvs.aspx")
  if not flag then return end
  local obj=GamePB_pb.PBGameLobbyConfig()
  obj:ParseFromString(upReturn)
  if obj.upvs > userDefault:getIntegerForKey("upvs") then
      if updateFunction() then
        userDefault:setIntegerForKey("upvs",obj.upvs)
      end
  else  
      local obj=GamePB_pb.PBGameLobbyList()
      obj:ParseFromString(util.hextoString(userDefault:getStringForKey("GameList")))
      self:infoGameList(obj.list)
  end
end


function MainScene:itemCallBack(sender,eventType)
  self:touchAction(sender,eventType)
  if eventType == ccui.TouchEventType.ended then    
      if sender.attribute.gameid == 1 then
        cc.SpriteFrameCache:getInstance():addSpriteFrames("FoundWord/game_cz.plist")
        local load=LoadingLayer.infoLoading(1) --添加找字的loading
        self:addChild(load)
        performWithDelay(self, function ()
            self:getApp():enterScene("FoundWordscene")
        end,0.001)
      elseif sender.attribute.gameid == 2 then
          cc.SpriteFrameCache:getInstance():addSpriteFrames("Maze/game_mg.plist")
          self:getApp():enterScene("MazeScene")
      elseif sender.attribute.gameid == 3 then
        self:getApp():enterScene("CrazyCatScene")
      elseif sender.attribute.gameid == 10 then
        cc.SpriteFrameCache:getInstance():addSpriteFrames("FiveChess/game_wzq.plist")
        local load=LoadingLayer.infoLoading(10) --添加五子棋的loading
        self:addChild(load)
        performWithDelay(self, function ()
            self:getApp():enterScene("FiveChessScene")
        end,0.001)
      elseif sender.attribute.gameid == 4 then
       --cc.SpriteFrameCache:getInstance():addSpriteFrames("BrushThrough/yibihua.plist")
        self:getApp():enterScene("BrushThroughLayer")
      elseif sender.attribute.gameid == 6 then
        self:getApp():enterScene("FlyMoreScene")
      elseif sender.attribute.gameid == 5 then
        self:getApp():enterScene("BubbleScene")
      elseif sender.attribute.gameid == 8 then
        self:getApp():enterScene("StartScene")
      elseif sender.attribute.gameid == 7 then
        self:getApp():enterScene("SuperDyeScene")
      elseif sender.attribute.gameid == 9 then
       self:getApp():enterScene("CrazyBlockScene")
      elseif sender.attribute.gameid == 11 then
        cc.Director:getInstance():replaceScene(require("app.VirtualFutures.IndexScene"):create())
      elseif sender.attribute.gameid == 12 then
        self:getApp():enterScene("BigWordScene")
      end

      local UPDATE = GamePB_pb.PBGameUpdateParams()
      UPDATE.gameid = sender.attribute.gameid
      local flag,updateReturn = HttpManager.post("http://lxgame.lexun.com/interface/upgrade.aspx",UPDATE:SerializeToString())
      if not flag then return end
      local obj=GamePB_pb.PBGameLobby()
      obj:ParseFromString(updateReturn)
      if obj.version - APP_VERSION[sender.attribute.gameid].version >0 then 
        HttpManager.download(obj.filepath,obj.filemd5)
      end

      self:infoRecentList(obj)
  end
end


--得到所有有游戏的icon
function MainScene:getIcons(datalist)
    local urls = {}
    for i,v in ipairs(datalist) do
        table.insert(urls,{url=v.gamelogo,code=v.logomd5})
    end
    return urls
end


--初始化游戏列表
function MainScene:infoGameList(gamelist)
    self.GameItemTab = {}
    for i,v in ipairs(gamelist) do
        local item = self.listItem:clone()
        self.GameItemTab[i] = item
        item:setVisible(true)
        item.listLogo = item:getChildByName("game_logo")
        item.listgameName = item:getChildByName("Text_7")
        item.listgameDiscribe = item:getChildByName("Text_8")
        item.attribute = v
        item.listgameName:setString(v.gamename)
        item.listgameDiscribe:setString(v.description)
        local _,_,_,file=parseUrl(v.gamelogo)
        display.loadImage(device.writablePath..file, function (texture)
          item.listLogo:loadTexture(file)
        end)
        self.listpanel:pushBackCustomItem(item)
        item:addTouchEventListener(handler(self,self.itemCallBack))
    end
end


--准备最近在玩的游戏列表
function MainScene:infoRecentList(oneGameDate)
    local oneDate = {}
    oneDate.gameid = oneGameDate.gameid
    oneDate.gamelogo = oneGameDate.gamelogo
    oneDate.gamename = oneGameDate.gamename
    oneDate.version = oneGameDate.version
    local function recentGameFunction(gametab)
        local recentGameList = {}
        for i=1,3 do
            recentGameList[i] = gametab[i]
        end
        return recentGameList
    end
    local datajson = userDefault:getStringForKey(MainScene.recentGame)
    local DataList = util.unserialize(util.hextoString(datajson))

    local LIST
    if not DataList then 
      LIST = recentGameFunction({oneDate,{},{}})
    elseif DataList[1].gameid == oneDate.gameid then 
      LIST = recentGameFunction({oneDate,DataList[2],DataList[3]}) 
    elseif DataList[2].gameid == oneDate.gameid then 
      LIST = recentGameFunction({oneDate,DataList[1],DataList[3]}) 
    else 
      LIST = recentGameFunction({oneDate,DataList[1],DataList[2]}) 
    end
    userDefault:setStringForKey(MainScene.recentGame,util.toHexString(LIST))
end

--初始化最近在玩游戏
function MainScene:infoRecentGame()
    local gameArrString = userDefault:getStringForKey(MainScene.recentGame)
    if gameArrString == "" then
      return
    end
    local gameArr = util.unserialize(util.hextoString(gameArrString))
    local itemArr = {self.historyItem1,self.historyItem2,self.historyItem3}
    for i,v in ipairs(gameArr) do
        if v.gameid then
          itemArr[i]:setVisible(true)
          itemArr[i]:getChildByName("game_name"):setString(v.gamename)
          local _,_,_,logo = parseUrl(v.gamelogo)
          display.loadImage(device.writablePath..logo, function (texture)
            itemArr[i]:getChildByName("game_logo"):loadTexture(logo)
          end)
          itemArr[i].attribute = {}
          itemArr[i].attribute.version = v.version
          itemArr[i].attribute.gameid = v.gameid
          itemArr[i]:setTouchEnabled(true)
          itemArr[i]:addTouchEventListener(handler(self,self.itemCallBack))
        end
    end

end
--载入主界面csb文件
function MainScene:infoCSB()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("login/gameout.plist")
    self:createResoueceNode("login/MainScene.csb")

    local root = self.resourceNode_:getChildByName("root")
    local head = root:getChildByName("head")
    self.avater_user = head:getChildByName("avater"):getChildByName("avater_user")
    self.username = head:getChildByName("user_name")
    self.coinnumber = head:getChildByName("coin_number")
    self.btn_modify = head:getChildByName("btn_modify")
    self.btn_more = head:getChildByName("btn_more")
    self.btn_gift = head:getChildByName("btn_gift")

    self.historyItem1 = root:getChildByName("game_history1")
    self.historyLogo1 = self.historyItem1:getChildByName("game_logo")
    self.historyName1 = self.historyItem1:getChildByName("game_name")
    self.historyItem2 = root:getChildByName("game_history2")
    self.historyLogo2 = self.historyItem2:getChildByName("game_logo")
    self.historyName2 = self.historyItem2:getChildByName("game_name")
    self.historyItem3 =  root:getChildByName("game_history3")
    self.historyLogo3 = self.historyItem3:getChildByName("game_logo")
    self.historyName3 = self.historyItem3:getChildByName("game_name")
    self.historyItem1:setVisible(false)
    self.historyItem2:setVisible(false)
    self.historyItem3:setVisible(false)
    --pushBackCustomItem
    self.listpanel = root:getChildByName("hot_game"):getChildByName("hot_game_list")
    self.listItem = root:getChildByName("hot_game"):getChildByName("list_item")
    self.listLogo = self.listItem:getChildByName("game_logo")
    self.listgameName = self.listItem:getChildByName("Text_7")
    self.listgameDiscribe = self.listItem:getChildByName("Text_8")
    self.listItem:setVisible(false)

    self.root = root
    self.moreList = root:getChildByName("more_list")
    self.modify_pass = self.moreList:getChildByName("modify_pass")
    self.binding_phone = self.moreList:getChildByName("binding_phone")
    self.exchange_id = self.moreList:getChildByName("exchange_id")
    self.coin_record = self.moreList:getChildByName("coin_record")

    self.username:setString(UserData.nick)
    self.coinnumber:setString(UserData.stone)
    display.loadImage(userDefault:getStringForKey('userHeadIcon'), function (texture)
      self.avater_user:loadTexture(userDefault:getStringForKey('userHeadIcon'))
    end)
end
--模拟点击放大动画
function MainScene:touchAction(sender,eventType)
    for i,v in ipairs(self.GameItemTab) do  --游戏列表
       if sender == v then
          sender:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
          if eventType == ccui.TouchEventType.began then
              sender:setBackGroundColor(cc.c3b(125,125,125))
          elseif eventType == ccui.TouchEventType.ended then
            if sender then
              sender:setBackGroundColor(cc.c3b(255,255,255))
            end
          elseif eventType == ccui.TouchEventType.canceled then
            if sender then
              sender:setBackGroundColor(cc.c3b(255,255,255))
            end
          end
          return 
       end
    end 
    local action = cc.ScaleTo:create(0.01,1.1)
    local actionReverse = cc.ScaleTo:create(0.01,1)
    if eventType == ccui.TouchEventType.began then
      sender:runAction(action)
    elseif eventType == ccui.TouchEventType.ended then
      if sender then
        sender:runAction(actionReverse)
      end
    elseif eventType == ccui.TouchEventType.canceled then
      if sender then
        sender:runAction(actionReverse)
      end
    end
end
function MainScene:MoreBtnLayer()
    local layer = cc.Layer:create()
    self.root:addChild(layer,10)

    local touchListener = cc.EventListenerTouchOneByOne:create()
    local function onTouchBegan()
        return true
    end
    local function onTouchEnded()
        layer:removeFromParent()
        self.moreList:setVisible(false)
        self.moreBtnState = false
    end
   -- touchListener:setSwallowTouches(true)
    touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener,layer)
end
--控制更多菜单
function MainScene:onMoreBtn()
  local function giftCallback(sender,eventType)
      self:touchAction(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
         self:getApp():enterScene("GiftRecordLayer")
      end
  end
  self.btn_gift:addTouchEventListener(giftCallback)

  self.moreList:setVisible(false)
  self.moreBtnState = false  --更多菜单按钮状态
  local function moreBtnCallback(sender,eventType)
      self:touchAction(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
        if self.moreBtnState then
          self.moreList:setVisible(false)
          self.moreBtnState = false
        else 
          self:MoreBtnLayer()
          self.moreList:setVisible(true)
          self.moreBtnState = true
        end
      end
  end
  self.btn_more:addTouchEventListener(moreBtnCallback)
  --乐币记录
  local function coinRecordCallback(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
          self:getApp():enterScene("CoinRecord")
      end
  end
  self.coin_record:addTouchEventListener(coinRecordCallback)
  --切换账号
  local function changeCallback(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
          self:getApp():enterScene("LoginController")
      end
  end
  self.exchange_id:addTouchEventListener(changeCallback)
  --绑定手机
  local function bindingcallback(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
          userDefault:setIntegerForKey("change_bind",2)
          self:getApp():enterScene("FindPwLayer")
      end
  end
  self.binding_phone:addTouchEventListener(bindingcallback)
  --修改密码
  local function changepwcallback(sender,eventType)
      if eventType == ccui.TouchEventType.ended then
          if UserData.initpwd == 0 then
            self:getApp():enterScene("ChangePwLayer")
          else 
            userDefault:setIntegerForKey("change_bind",2)
            userDefault:setIntegerForKey("is_bind_phone",1)--是否已经绑定手机
            self:getApp():enterScene("FindPwLayer")     
          end
      end
  end
  self.modify_pass:addTouchEventListener(changepwcallback)
end

return MainScene