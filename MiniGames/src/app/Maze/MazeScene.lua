local MazeScene = class("MazeScene", cc.load("mvc").ViewBase)

function MazeScene:onCreate()
    self:homeInfoCSB()
    self:homeInfoTouch()
end

function MazeScene:homeInfoCSB()
    self:createResoueceNode("Maze/Home.csb")
    local csbHome = self.resourceNode_:getChildByName("home")
    self.btn_home = csbHome:getChildByName("btn_home")
    self.btn_play = csbHome:getChildByName("btn_play")

    local panel_btn = csbHome:getChildByName("panel_btn")
    self.btn_rank = panel_btn:getChildByName("btn_rank")
    self.btn_help = panel_btn:getChildByName("btn_help")
--    self.btn_top = btnPanel:getChildByName("panel_top"):getChildByName("btn_top")
--    self.btn_message = btnPanel:getChildByName("panel_message"):getChildByName("btn_message")
--    self.btn_talk = btnPanel:getChildByName("panel_talk"):getChildByName("btn_talk")
--    self.btn_home =  CSB:getChildByName("bg"):getChildByName("btn_home")
end


function MazeScene:homeInfoTouch()
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
            self:getApp():enterScene("GameLayer")
        end
    end
    self.btn_play:addTouchEventListener(gameStart)

    --进入排行榜
    local function gameRank(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            --self:getApp():enterScene("RankLayer")
			local rankLayer = require("app.Maze.RankLayer").new(obj)
			self:addChild(rankLayer)
        end
    end
    self.btn_rank:addTouchEventListener(gameRank)

    --进入排行榜
    local function showHelp(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
			local helpLayer = require("app.Maze.HelpLayer").new(obj)
			self:addChild(helpLayer)
        end
    end
    self.btn_help:addTouchEventListener(showHelp)
    
end

return MazeScene