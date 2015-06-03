
local CrazyCatScene = class("CrazyCatScene", cc.load("mvc").ViewBase)
local CrazyCatAI = import(".CrazyCatAI")
local CrazyCatSprite = import(".CrazyCatSprite")

--Create
function CrazyCatScene:onCreate()
    self:infoCSB()
    self:createBackground()
    self:createMenu()
    self:init()
    
    cc.bind(self, "event")
end
function CrazyCatScene:infoCSB()
    self:createResoueceNode("CrazyCat/MainScene.csb")
    local CSB=self.resourceNode_
    self.layer = CSB:getChildByName("root")
    self.back_btn = self.layer:getChildByName("btn_home")
    local panel_foot = self.layer:getChildByName("panel_foot")
    self.num_foot = panel_foot:getChildByName("num_foot")
    self.num_foot:setString(0)
    local panel_cutdown = self.layer:getChildByName("panel_cutdown")
    self.num_cutdown = panel_cutdown:getChildByName("num_cutdown")
    self.num_cutdown:setString(200)
    self.layer:onTouch(handler(self, self.onTouch))
    local function backCallback(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self.scheduler:unscheduleScriptEntry(self.myUpdate) --取消定时器
            self:getApp():enterScene("CrazyCatScene")
        end
    end
    self.back_btn:addTouchEventListener(backCallback)
end
--Touch
function CrazyCatScene:onTouch(event)
    if event.name ~= "began" then
        return
    end
end
--创建背景
function CrazyCatScene:createBackground()
    self.step = 0        --当前步数
    self.countdown = 120 --倒计时（秒）
    self.scheduler = nil
    self.myUpdate = nil
    self.circle = {}
    self.radius = 0
    self.top = 0
    self.AI = CrazyCatAI.create()

    --计时器
    self.scheduler = cc.Director:getInstance():getScheduler()
    self:setUpdate()
    
    self.scale = 1.4
    self.catSprite = nil
end

function CrazyCatScene:createMenu()
    local width = 0
    if display.width >= 480 then
        self.radius = 22.3 * self.scale
        width = 20 * self.radius
    else
        self.radius = display.width * self.scale / 19
        width = 19 * self.radius
    end
    
    self.menuLeft = (display.width - width) / 2
    self.menu = cc.Menu:create()
        :setPosition(self.menuLeft, 0)
    self.layer:addChild(self.menu)
end

--初始化
function CrazyCatScene:init()
    local m = 0 --列数
    local n = 0 --行数
    local x = 0 --圆心X坐标
    local y = 0 --圆心Y坐标
    local isSelected = false
    self.isPlayer = true    --是否轮到玩家
    self.isGameOver = false --是否游戏结束
    self.cat = { row = 5, col = 5 } --小猫默认位置
    math.randomseed(os.time()) --随机种子
    local barrier = math.random(11, 18) --路障数
	for i = 1, 81 do
	    m = i % 9
	    if m == 0 then
	        m = 9
	    end 
	    n = math.floor((i - 1) / 9)
	    
	    if n % 2 == 1 then --偶数行缩进
            x = self.radius + self.radius * ((m - 1) * 2 + 1)+self.radius*0.5
        else --奇数行顶格
            x = self.radius * ((m - 1) * 2 + 1)+self.radius*0.5
	    end
        --y = 5 * self.radius + self.radius * (n * 2 + 1)
        y = 1.5*self.radius + self.radius * (n * 2 + 1) +(display.height-960)*0.4
        isSelected = false
        local r = math.random(1, 81)
        if r <= barrier then
            if i ~= 31 and i ~= 32 and i ~= 40 and i ~= 41 and i ~= 42 and i ~= 49 and i ~= 50 then --起始点及周围不能设
                isSelected = true
            end
        end
        self:drawCircle(self:getMenuItem(i, x, y, isSelected))
        
        if i == 41 then
            self:catMove(i)
        end
	end
end

--绘制圆形
function CrazyCatScene:drawCircle(info)
    local temp = self.circle[info.index]
    if temp then
        self.circle[info.index] = nil
        self.menu:removeChild(temp.menuItem, true)
    end

    self.circle[info.index] = info
    self.menu:addChild(info.menuItem)
end

--获取圆形参数
function CrazyCatScene:getMenuItem(index, x, y, isSelected)
    local image = nil
    if isSelected then
        image = "CrazyCat/pot2.png"
    else
        image = "CrazyCat/pot1.png"
    end
    
    local menuItem = cc.MenuItemImage:create(image, image)
        :setScale(self.scale*45/64)
        :setPosition(x, y)
        :onClicked(function() --玩家点击
            local info = self.circle[index]
            if not self.isGameOver and self.isPlayer and not info.isSelected then
                self.circle[index].isSelected = true
                self.isPlayer = false
                self.step = self.step + 1
                self.num_foot:setString(self.step)
                self:drawCircle(self:getMenuItem(index, x, y, true))
                self:checkWin()
            end
        end)
    return { index = index, menuItem = menuItem, x = x, y = y, isSelected = isSelected }
end

--小猫移动
function CrazyCatScene:catMove(index)
    if self.catSprite then
        self.catSprite:removeFromParent()
        self.catSprite = nil
    end

    local tab = self.circle[index]
    self.catSprite = CrazyCatSprite.create():getCatSprite(self.scale, tab.x + self.menuLeft, tab.y)
    self.layer:addChild(self.catSprite)
    
    self.isPlayer = true
end

--重置游戏
function CrazyCatScene:reset()
    self.step = 0
    self.countdown = 120
    self.num_foot:setString(self.step)
    self.num_cutdown:setString(self.countdown)
    self:setUpdate()
    self:init()
end

--计时开始
function CrazyCatScene:setUpdate()
    self.startTime = os.date("%Y-%m-%d %H:%M:%S")
    self.myUpdate = self.scheduler:scheduleScriptFunc(function()
        if self.countdown > 0 then
            self.countdown = self.countdown - 1
            self.num_cutdown:setString(self.countdown)
            if  self.countdown <= 0 then
                local path = self.AI:getNextPath(self.cat.row, self.cat.col, self.circle)
                if path.row > 0 and path.col > 0 then
                    self:onPlayEnd(-1)
                end
            end
        end
    end, 1, false)
end

--是否获胜
function CrazyCatScene:checkWin()
    if self.cat.row == 1 or self.cat.col == 1 or self.cat.row == 9 or self.cat.col == 9 then --边缘
        self:onPlayEnd(0)
        return
    end
    
    local path = self.AI:getNextPath(self.cat.row, self.cat.col, self.circle)
    if path.row > 0 and path.col > 0 then
        self.cat = path
        self:catMove(self.AI:getIndex(path.row, path.col))
    else
        self:onPlayEnd(1)
    end
end


--游戏结束
function CrazyCatScene:onPlayEnd(flag)
    if self.isGameOver then
        return
    end
    self.scheduler:unscheduleScriptEntry(self.myUpdate) --取消定时器
    --发送游戏结束的命令
    local crazyCat = GamePB_pb.PBCatGamelog_Update_Params()
    crazyCat.starttime  = self.startTime
    crazyCat.endtime  = os.date("%Y-%m-%d %H:%M:%S")
    crazyCat.stepnum = self.step
    crazyCat.costtime = 120 -self.countdown
    if flag == 1 then
        crazyCat.iscatch = 1
    else
        crazyCat.iscatch = -1
    end
    print("===",crazyCat.starttime,crazyCat.endtime,crazyCat.stepnum,crazyCat.costtime,crazyCat.iscatch)
    local jud,catReturn = HttpManager.post("http://lxgame.lexun.com/interface/cat/updategamelog.aspx",crazyCat:SerializeToString())
    if not jud then return end
    local obj=GamePB_pb.PBCatGamelog_Update_Return()
    obj:ParseFromString(catReturn)
   -- dump(obj) 
    local isBreak = false
    if crazyCat.stepnum < obj.bestscore.stepnum then
        isBreak = true
    elseif crazyCat.stepnum == obj.bestscore.stepnum and crazyCat.costtime <obj.bestscore.costtime then
        isBreak = true
    end
    self.isGameOver = true
    if flag == 1 then
        local CSB=cc.CSLoader:createNode("CrazyCat/GameWin.csb") 
        CSB:setContentSize(display.size)
        ccui.Helper:doLayout(CSB)
        self:addChild(CSB)
        local function callback(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
                self:getApp():enterScene("CrazyCatScene")
            end
        end
        local function shareback(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
                --炫耀暂时做重玩处理
                CSB:removeFromParent()
                self:reset()
            end
        end
        local win= CSB:getChildByName("dialog"):getChildByName("lose")
        local titelShowUp = win:getChildByName("panel_star"):getChildByName("title_text_2")
        local titleSurround = win:getChildByName("panel_star"):getChildByName("title_text_1")
        local text_content = win:getChildByName("text_content")
        local btn_share = win:getChildByName("btn_share")
        local shareimage = btn_share:getChildByName("img_text_share")
        local btn_back = win:getChildByName("btn_back")
        if isBreak then
            titelShowUp:setVisible(true)
            titleSurround:setVisible(false)
            text_content:setString("恭喜您成功围住神经猫啦，您的成绩是:"..crazyCat.stepnum.."步，耗时"..crazyCat.costtime.."秒，打破当前最高记录:"..obj.bestscore.stepnum.."步"..obj.bestscore.costtime.."秒，快炫耀一下吧！")
        else
            titleSurround:setVisible(true)
            titelShowUp:setVisible(false)
            text_content:setString("恭喜您成功围住神经猫啦，您的成绩是:"..crazyCat.stepnum.."步，耗时"..crazyCat.costtime.."秒，可惜没能打破当前最高记录:"..obj.bestscore.stepnum.."步"..obj.bestscore.costtime.."秒，快来继续挑战吧！")
            shareimage:loadTexture("text_replay_sjm.png",1)
        end
        btn_back:addTouchEventListener(callback)
        btn_share:addTouchEventListener(shareback)
    elseif flag == -1 or flag == 0 then
        local CSB=cc.CSLoader:createNode("CrazyCat/GameLose.csb") 
        CSB:setContentSize(display.size)
        ccui.Helper:doLayout(CSB)
        self:addChild(CSB)
        local function callback(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
               self:getApp():enterScene("CrazyCatScene")
            end
        end
        local function againback(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
                CSB:removeFromParent()
                self:reset()
            end
        end
        local lost= CSB:getChildByName("dialog"):getChildByName("lose")
        local text_content = lost:getChildByName("text_content")
        local btn_again = lost:getChildByName("btn_retry")
        local btn_back = lost:getChildByName("btn_back")
        local panel_star = lost:getChildByName("panel_star")
        local title1 = panel_star:getChildByName("title_text_img") --时间到了
        local title2 = panel_star:getChildByName("title_text_img_2") --挑战失败
        if  flag == -1 then
            title1:setVisible(true)
            title2:setVisible(false)
            text_content:setString("挑战失败，您没有在120秒内围住神经猫，快来再挑战一次吧！")
        else
            title1:setVisible(false)
            title2:setVisible(true)
            text_content:setString("挑战失败，您没有围住神经猫，快来继续挑战吧！")
        end
        btn_back:addTouchEventListener(callback)
        btn_again:addTouchEventListener(againback)
    end
end

return CrazyCatScene