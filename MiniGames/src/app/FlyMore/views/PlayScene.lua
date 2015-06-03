
local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

cc.FileUtils:getInstance():addSearchPath("res/FlyMore")

local GameView = import(".GameView")

PlayScene.events = {
    EXIT_EVENT = "EXIT_EVENT",
}

PlayScene.WIDTH = 320
PlayScene.HEIGHT = 416

PlayScene.NUMBER_FRAMES_1 = {}
for i = 0, 9 do
    PlayScene.NUMBER_FRAMES_1[i] = cc.SpriteFrame:create("cs_jmp.png", cc.rect(670 + math.mod(i, 3) * 33, 330 + math.floor(i / 3) * 47, 33, 47)):retain()
end

PlayScene.NUMBER_FRAMES_2 = {}
for i = 0, 9 do
    PlayScene.NUMBER_FRAMES_2[i] = cc.SpriteFrame:create("cs_jmp.png", cc.rect(120 + i * 10, 153, 10, 18)):retain()
end

function PlayScene:onCreate()
    dump(self:getAnchorPoint(), "self:getAnchorPoint()")

    self.hisGameHeight_ = 0

    self:newGame()
    
    -- bind the "event" component
    cc.bind(self, "event")
end

function GameView:onCleanup()
    self:removeAllEventListeners()
end

function PlayScene:newGame()
    self:removeAllChildren()
    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    local scale = 1
    local scaleX, scaleY = display.width / GameView.WIDTH, display.height / GameView.HEIGHT
    if scaleX < scaleY then
        scale = scaleX
    else
        scale = scaleY
    end
    self.gameView_ = GameView:create()
        :addEventListener(GameView.events.GAME_OVER_EVENT, handler(self, self.onGameOver))
        :start()
        :setScale(scale)
        :addTo(self)
end

function PlayScene:onGameOver(event)
    self.gameView_:stop()

    self:showResultMenu()

    performWithDelay(self, function ()
        self:submitResult()
     end,0.001)
end

function PlayScene:showResultMenu()
    self.endTime = os.date("%Y-%m-%d %H:%M:%S")

    local container = cc.Node:create()
        :setContentSize(GameView.WIDTH, GameView.HEIGHT)
        :setAnchorPoint(cc.p(0.5, 0.5))
        :setPosition(GameView.WIDTH / 2, GameView.HEIGHT / 2)
        :addTo(self.gameView_, 1000)
    
    local board = cc.Sprite:create("cs_jmp.png"):setTextureRect(cc.rect(320, 0, 304, 175))
        :setPosition(GameView.WIDTH / 2, GameView.HEIGHT / 2 + 75)
        :addTo(container)
    
    local idx = 0
    local num = 0
    local height = 0
    
    idx = 0
    num = 0
    height = self.gameView_:getGameHeight()
    if height > self.hisGameHeight_ then
        self.hisGameHeight_ = height
    end
    while height > 0 do
        idx = idx + 1
        num = math.floor(math.mod(height, 10) / 1)
        cc.Sprite:create():setSpriteFrame(PlayScene.NUMBER_FRAMES_1[num])
            :setAnchorPoint(cc.p(0, 0))
            :setPosition(260 - idx * 33, 50)
            :addTo(board)
        height = math.floor(height / 10)
    end
    
    idx = 0
    num = 0
    height = self.hisGameHeight_
    while height > 0 do
        idx = idx + 1
        num = math.floor(math.mod(height, 10) / 1)
        cc.Sprite:create():setSpriteFrame(PlayScene.NUMBER_FRAMES_2[num])
            :setAnchorPoint(cc.p(0, 0))
            :setPosition(220 - idx * 10, 10)
            :addTo(board)
        height = math.floor(height / 10)
    end
        
    local menu = cc.Menu:create()
        :setPosition(GameView.WIDTH / 2, GameView.HEIGHT / 2 - 100)
        :addTo(container)
        
    cc.MenuItemFont:create("重玩")
        :setPosition(-60, 0)
        :addTo(menu)
        :onClicked(function()
            self:newGame()
        end)
    
    cc.MenuItemFont:create("退出")
        :setPosition(60, 0)
        :addTo(menu)
        :onClicked(function()
            self:dispatchEvent({name = PlayScene.events.EXIT_EVENT})
        end)
end

function PlayScene:submitResult()
    local FlyMoreEnd = GamePB_pb.PBFlyjumpGamelog_Update_Params()
    FlyMoreEnd.starttime = self.startTime
    FlyMoreEnd.endtime = self.endTime
    FlyMoreEnd.height = self.hisGameHeight_
    self.costtime = self.gameView_.timer_:getModel().INIT_SECONDS - self.gameView_.timer_:getModel():getLeftSeconds()
    FlyMoreEnd.costtime =self.costtime
    print(self.hisGameHeight_)
    print(self.costtime)
    local flag,endReturn = HttpManager.post("http://lxgame.lexun.com/interface/flyjump/updategamelog.aspx",FlyMoreEnd:SerializeToString())
    if not flag then return end
    local obj=ServerBasePB_pb.PBMessage()
    obj:ParseFromString(endReturn)
    print(obj.outmsg)
end

return PlayScene
