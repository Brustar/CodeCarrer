
local BrushThroughLayer = class("BrushThroughLayer", cc.load("mvc").ViewBase)

function BrushThroughLayer:onCreate()

    self:gameInfoCSB()
    self:gameInfoTouch()
end

function BrushThroughLayer:gameInfoCSB()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("BrushThrough/yibihua.plist")
    self:createResoueceNode("BrushThrough/game.csb")
    local csbGame = self.resourceNode_:getChildByName("bg")
    self.btn_home = csbGame:getChildByName("btn_home")
    self.btn_stratgame = csbGame:getChildByName("btn_stratgame")
    
    local btn_list = csbGame:getChildByName("btn_list")
    self.btn_help = btn_list:getChildByName("btn_help"):getChildByName("help")
    self.btn_ranking = btn_list:getChildByName("btn_ranking"):getChildByName("ranking")
    self.btn_chitchat = btn_list:getChildByName("btn_chitchat"):getChildByName("chitchat")--聊天
    self.btn_forum = btn_list:getChildByName("btn_forum"):getChildByName("forum")--论坛
 
end


function BrushThroughLayer:gameInfoTouch()

    --回首页
    local function backHome(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            require("app.MyApp"):create():run()
        end
    end
    self.btn_home:addTouchEventListener(backHome)

    --进入游戏界面
    local function gameStart(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
         
        local btscene = require("src.app.BrushThrough.BrushThroughScene").new()
        self:addChild(btscene)
        end
    end
    self.btn_stratgame:addTouchEventListener(gameStart)
  
    --进入排行榜
    local function gameRank(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local rankLayer = require("app.BrushThrough.BrushThroughRank").new(obj)
            self:addChild(rankLayer)
        end
    end
    self.btn_ranking:addTouchEventListener(gameRank)

    --进入帮助
    local function showHelp(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local HelpLayer = require("app.BrushThrough.BrushThroughHelpLayer").new(obj)
            self:addChild(HelpLayer)
        end
    end
    self.btn_help:addTouchEventListener(showHelp)

     --进入聊天
    local function showHelp(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            native.showPage("http://clubc.lexun.com/crazywords-fee/chatlist.aspx")
        end
    end
   self.btn_chitchat:addTouchEventListener(showHelp)

     --进入论坛
    local function showHelp(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            native.showPage("http://f2.lexun.com/list.php?bid=27082")   
        end
    end
    self.btn_forum:addTouchEventListener(showHelp)

end

return BrushThroughLayer

