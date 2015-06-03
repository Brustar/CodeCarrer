require("app.Warrior.PngHelper")

local startscene = class("StartScene",cc.load("mvc").ViewBase)
--local winSize = cc.Director:getInstance():getWinSize()
local pngIndex=4

function startscene:onCreate()
    self:createLayer()   
   -- self:bgCsb() 
    self:gameInfoTouch()
end

function startscene:createLayer()	
  
    self.png = PngHelper.shared():init(3)
    self.png:spriteFromJson("main_back"):move(cc.p(display.cx,display.cy)):addTo(self)
    self:setScaleX(display.width/640)
    self:setScaleY(display.height/960)
    self.png=PngHelper.shared():init(pngIndex)
    local _ps=self.png:spriteFromJson("main_up"):move(cc.p(display.width+display.cx,display.cy-200)):addTo(self)
    self.bgArr={} --装后面画出的所有背景
    self.bgArr[#self.bgArr+1]=_ps
    self:bgMove()
    
     self:bgCsb() 
    self:addBtn()  
    

end

function startscene:bgCsb()
   --加uI
     cc.SpriteFrameCache:getInstance():addSpriteFrames("Warrior/picture.plist")
    self:createResoueceNode("Warrior/home.csb")

    local csbGame = self.resourceNode_:getChildByName("bg")
    self.mainBack = csbGame:getChildByName("img")
    self.mainBack:setVisible(false)--动画背景
    self.btn_teach = csbGame:getChildByName("btn_teach")
    --setTag
     :setPosition(display.cx+8,display.cy-250)
    self.btn_home = csbGame:getChildByName("btn_home"):move(cc.p(display.left+100,860))
    self.btn_start= csbGame:getChildByName("btn_start")
    self.btn_start:setVisible(false)--开始屏蔽
    --帮助
    self.btn_help= csbGame:getChildByName("btn_help")
    --排名
    self.btn_top = csbGame:getChildByName("btn_ranking")
    --聊天
    self.btn_message = csbGame:getChildByName("btn_chat")
    --论坛
    self.btn_talk = csbGame:getChildByName("btn_forum")

    --返回主页
    --self.png = PngHelper.shared():init(1)
    --[[
    fileNormal,fileSelected="game_btn_close","game_close_btn"
    local normalSprite,selectedSprite=self.png:spriteFromJson(fileNormal),self.png:spriteFromJson(fileSelected)
    self.refresh = cc.MenuItemSprite:create(normalSprite,selectedSprite,normalSprite)
    self.refresh:registerScriptTapHandler(function()
         require("app.MyApp"):create():run()
      --  self:initUI()
    end)
    local menu = cc.Menu:create():move(cc.p(display.width-100,display.height-100)):addTo(self)--返回的位置
    menu:addChild(self.refresh)
     ]]
    end
--背景移动
function startscene:bgMove()    
    local _ps = self.png:spriteFromJson("main_up"):move(cc.p(display.width+display.cx,display.cy-200))    
    self.bgArr[1]:addChild(_ps)
    self.bgArr[#self.bgArr+1]=_ps
    local moveAction = cc.MoveTo:create(1,cc.p(display.cx,display.cy-200))
    self.bgArr[1]:runAction(cc.EaseOut:create(moveAction,1))
end

function startscene:addBtn()

   
    self.png = PngHelper.shared():init(3)
    local normalSprite,selectedSprite=self.png:spriteFromJson("intro_btn_start"),self.png:spriteFromJson("title_start_btn")
    local btn = cc.MenuItemSprite:create(normalSprite,selectedSprite,normalSprite)

     btn:registerScriptTapHandler(function()
         cc.UserDefault:getInstance():setIntegerForKey('buttonTag',1001)
        if cc.UserDefault:getInstance():getIntegerForKey('Warrior') == 1 then
   
            self:getApp():enterScene("GameScene")
        else
            cc.UserDefault:getInstance():setIntegerForKey('Warrior',1)
            self:getApp():enterScene("StoryScene")
       end
    end)
    cc.Menu:create():move(cc.p(display.cx+10,display.cy-100)):addChild(btn):addTo(self)
end
function startscene:gameInfoTouch()
--回首页
    local function backHome(sender, eventType)
    print("eventType",eventType)
        if eventType == ccui.TouchEventType.ended then
            --require("app.Warrior.PngHelper")
            require("app.MyApp"):create():run()
        end
    end
    self.btn_home:addTouchEventListener(backHome)

    local function teachGame(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            cc.UserDefault:getInstance():setIntegerForKey('buttonTag',1002)
           -- cc.UserDefault:getInstance():getIntegerForKey('test')

            self:getApp():enterScene("GameScene")
        end
    end
    self.btn_teach:addTouchEventListener(teachGame)
    --
    --
    local function gameHelp(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            --游戏帮助
            local gamelayer = require("app.Warrior.HelpLayer").new()
            self:addChild(gamelayer)
        end
    end
    self.btn_help:addTouchEventListener(gameHelp)
    local function gameRank(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            --游戏排行
            local gamelayer = require("app.Warrior.ranklayer").new()
            self:addChild(gamelayer)
        end
    end
    self.btn_top:addTouchEventListener(gameRank)
    local function gameMessage(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            --游戏聊天
            native.showPage("http://clubc.lexun.com/crazywords-fee/chatlist.aspx")
        end
    end
    self.btn_message:addTouchEventListener(gameMessage)
    local function gameTalk(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            native.showPage("http://f2.lexun.com/list.php?bid=27082")
            --游戏论坛
        end
    end
    self.btn_talk:addTouchEventListener(gameTalk)


end
function startscene:onCleanup()
    PngHelper.clearTexture()
end

return startscene