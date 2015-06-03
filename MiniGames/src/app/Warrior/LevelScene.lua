require("app.Warrior.PngHelper")
require('app.Warrior.map')
local levelscene = class("LevelScene",cc.load("mvc").ViewBase)

local level = 1--当前关卡
local pngIndex=3

function levelscene:onCreate()	
    self.png=PngHelper.shared():init(pngIndex)
    if cc.UserDefault:getInstance():getIntegerForKey('wLevel')~=0 then
        level = cc.UserDefault:getInstance():getIntegerForKey('wLevel')
    end
    self:createLayer()
    self:createLevel()
    self:createBackBtn()
end


function levelscene:createLayer()	
    self.png:spriteFromJson("main_back"):move(cc.p(display.cx,display.cy)):addTo(self)
    self:setScaleX(display.width/640)
    self:setScaleY(display.height/960)

    self.png:spriteFromJson("levels_back"):move(cc.p(display.cx,display.bottom+338/2)):addTo(self)

    self.png:spriteFromJson("levels_back_second"):move(cc.p(display.cx,display.cy+250)):addTo(self)
end


--生成关卡
function levelscene:createLevel()
    local maps= JsonManager.decode(WARRIOR_MAP)
    local m = 0 --列数
    local n = 0 --行数
    local x = 0 --X坐标
    local y = 0 --Y坐标    
    for i = 1, #maps do
	    m = i % 5
	    if m == 0 then
	        m = 5
	    end 
	    n = math.floor((i - 1) / 5)
        x = (80*m)+80
        y = (display.cy + 150) - n*80
    	self:addBtn(i,x,y)
    end
end

function levelscene:addstars(i,btn)
    local key = string.format('stars_%d',i)
    local num = cc.UserDefault:getInstance():getIntegerForKey(key)
    if num>0 then
        for i=1,num do
            self.png:spriteFromJson("levels_z_14_3"):setPosition(cc.p(15+22*(i-1),20)):addTo(btn)
        end
    end
end


function levelscene:addBtn(i,x,y)
	local fileNormal = "levels_lock_2" 
    local  fileSelected="levels_lock_2"   
    if i<= level then
        fileNormal = string.format("levels_btn_lev_%d",i)
        fileSelected = string.format("levels_lev_btn_%d",i)
    end
    local normalSprite,selectedSprite=self.png:spriteFromJson(fileNormal),self.png:spriteFromJson(fileSelected)
    local btn = cc.MenuItemSprite:create(normalSprite,selectedSprite,normalSprite)
    btn:setPosition(0,0)
    self:addstars(i,btn)
    if i<= level then
        btn:registerScriptTapHandler(function ()
            cc.UserDefault:getInstance():setIntegerForKey('cLevel',i)
            self:getApp():enterScene('GameScene')
        end)
    end
    cc.Menu:create():move(cc.p(x,y)):addChild(btn):addTo(self)
end

function levelscene:createBackBtn()
    local filename,fileSelected="levels_btn_close","levels_close_btn"
    local normalSprite,selectedSprite=self.png:spriteFromJson(filename),self.png:spriteFromJson(fileSelected)
    local btn = cc.MenuItemSprite:create(normalSprite,selectedSprite,normalSprite)
    btn:registerScriptTapHandler(function ()
        self:getApp():enterScene("StartScene")
    end)
    cc.Menu:create():move(cc.p(display.cx,display.cy-250)):addChild(btn):addTo(self)
end

function levelscene:onCleanup()
    PngHelper.clearTexture()
end

return levelscene