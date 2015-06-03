local gamelayer = class("gamelayer",cc.load("mvc").ViewBase)
local DyeColorArr = {
	"icon_box_orange.png",
	"icon_box_purple.png",
	"icon_box_blue.png",
	"icon_box_fenshe.png",
	"icon_box_red.png",
	"icon_box_green.png"
}
local DyeArr,alreadyDye= {},{}
function gamelayer:onCreate()
	self:infoCSB()
	self:infoBack()
	self:infoCountDown()
	self:infoCreateDye()
	self:infoTouch()
	self:initAlreadyDye()
end
function gamelayer:infoCreateDye()
	self:createDye(self:getEachPosition())
end
function gamelayer:infoCSB()
    self:createResoueceNode("SuperDye/playgameing.csb")
    local CSB=self.resourceNode_
    local bg = CSB:getChildByName("root")
    local top = bg:getChildByName("pl_top")
    self.btn_back = top:getChildByName("pl_yun"):getChildByName("Button_1")
    local stepLab = top:getChildByName("pl_shua"):getChildByName("text_ba_num")
    local timeLab = top:getChildByName("pl_miao"):getChildByName("text_miao_num")
    stepLab:setVisible(false)
    timeLab:setVisible(false)

    self.stepLab = ccui.TextAtlas:create()
    self.stepLab:setProperty(0, "SuperDye/num.png", 20, 29, ".")
    self.stepLab:setPosition(stepLab:getPosition()) 
    self.stepLab:setAnchorPoint(1,0.25)
    top:getChildByName("pl_shua"):addChild(self.stepLab)
    self.timeLab = ccui.TextAtlas:create()
    self.timeLab:setProperty(0, "SuperDye/num.png", 20, 29, ".")
    self.timeLab:setPosition(timeLab:getPosition()) 
    self.timeLab:setAnchorPoint(1,0.25)
    top:getChildByName("pl_miao"):addChild(self.timeLab)


    local gamePanel = bg:getChildByName("pl_game")
    local shua_panel = gamePanel:getChildByName("pl_btn_shua")
    self.btn_orange = shua_panel:getChildByName("pl_shua_orange")
    self.btn_purple = shua_panel:getChildByName("pl_shua_purple")
    self.btn_blue = shua_panel:getChildByName("pl_shua_blue")
    self.btn_fenshe = shua_panel:getChildByName("pl_shua_fenshe")
    self.btn_red = shua_panel:getChildByName("pl_shua_red")
    self.btn_green = shua_panel:getChildByName("pl_shua_green")
    local dyePanel = gamePanel:getChildByName("pl_game_con")
    self.img_red = dyePanel:getChildByName("img_box_red")
    self.img_orange = dyePanel:getChildByName("img_box_orange")
    self.img_blue = dyePanel:getChildByName("img_box_blue")
    self.img_purple = dyePanel:getChildByName("img_box_purple")
    self.img_green = dyePanel:getChildByName("img_box_green")
    self.img_fenshe = dyePanel:getChildByName("img_box_fenshe")
    self.dyePanel = dyePanel
    self.img_red:setVisible(false)
    self.img_orange:setVisible(false)
    self.img_blue:setVisible(false)
    self.img_purple:setVisible(false)
    self.img_green:setVisible(false)
    self.img_fenshe:setVisible(false)
    self.size = self.img_red:getContentSize()
end
--点击事件
function gamelayer:infoTouch()
	local function touchCall(sender,touchType)
		if touchType == ccui.TouchEventType.ended then
			local index 
			if sender == self.btn_orange then
				index = 1
			elseif sender == self.btn_purple then
				index = 2
			elseif sender == self.btn_blue then
				index = 3
			elseif sender == self.btn_fenshe then
				index = 4
			elseif sender == self.btn_red then
				index = 5
			elseif sender == self.btn_green then
				index = 6
			end
			self:eachStep(index)
		end
	end
	self.btn_orange:addTouchEventListener(touchCall)
    self.btn_purple:addTouchEventListener(touchCall)
    self.btn_blue:addTouchEventListener(touchCall)
    self.btn_fenshe:addTouchEventListener(touchCall)
    self.btn_red:addTouchEventListener(touchCall)
    self.btn_green:addTouchEventListener(touchCall)
end
--染色
function gamelayer:dyeingDye(targetColor)
	local color = DyeColorArr[targetColor]
	for i,v in ipairs(alreadyDye) do
		v.SPRITE:loadTexture(color,1)
	end
	if #alreadyDye == 11*12 then
		print("结束了---")
		DyeArr = {}
		alreadyDye = {}
		self:stopAction(self.countdownaction)
		self:infoFinish(targetColor)
		performWithDelay(self, function ()
  			local SuperDyeFinish = GamePB_pb.PBMagicwallGamelog_Update_Params()
		    SuperDyeFinish.starttime = self.startTime
		    SuperDyeFinish.endtime = os.date("%Y-%m-%d %H:%M:%S")
		    SuperDyeFinish.stepnum = self.stepNum
		    SuperDyeFinish.costtime = self.time
		    local flag,DyeReturn = HttpManager.post("http://lxgame.lexun.com/interface/magicwall/updategamelog.aspx",SuperDyeFinish:SerializeToString())
		    if not flag then return end
		    local obj=ServerBasePB_pb.PBMessage()
		    obj:ParseFromString(DyeReturn)
		    dump(obj)
    	end,0.001)
	end
end
--结束
function gamelayer:infoFinish(targetColor)
	local CSB = cc.CSLoader:createNode("SuperDye/success_alert.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("root"):getChildByName("pl_alert")
    local mclose = bg:getChildByName("btn_close")
    local magain = bg:getChildByName("btn_again")
    local mback = bg:getChildByName("img_btn_back")
    local text = bg:getChildByName("text_con")
    local color
    if targetColor == 1 then color = "橙色" end
    if targetColor == 2 then color = "紫色" end
    if targetColor == 3 then color = "蓝色" end
    if targetColor == 4 then color = "粉色" end
    if targetColor == 5 then color = "红色" end
    if targetColor == 6 then color = "绿色" end
    text:setString("哇，您只用"..self.time.."秒"..self.stepNum.."把刷子就把墙刷成"..color.."啦，今天心情一定美美哒！")
    local function finishCall(sender,touchType)
		if touchType == ccui.TouchEventType.ended then
			if sender == mclose then
				CSB:removeFromParent()
				self.dyePanel:removeAllChildren()
				self:infoCountDown()
				self:infoCreateDye()
				self:initAlreadyDye()
			elseif sender == magain then
				CSB:removeFromParent()
				self.dyePanel:removeAllChildren()
				self:infoCountDown()
				self:infoCreateDye()
				self:initAlreadyDye()
			elseif sender == mback then
				DyeArr = {}
				alreadyDye = {}
				self:getApp():enterScene("SuperDyeScene")
			end
		end
	end
    mclose:addTouchEventListener(finishCall)
    magain:addTouchEventListener(finishCall)
    mback:addTouchEventListener(finishCall)
end
--初始化alreadyDye
function gamelayer:initAlreadyDye()
	table.insert(alreadyDye,DyeArr[1][1])
	local function findAllUnit(v)
		local judgDyeArr = self:getAdjacentUnit(v)
		for j,w in ipairs(judgDyeArr) do
			if w.INDEX == alreadyDye[1].INDEX and not self:isInalreadyDye(w) then
				table.insert(alreadyDye,w)
				findAllUnit(w)
			end
		end
	end
	findAllUnit(alreadyDye[1])
end
--算每一次染色之后alreadyDye中的元素
function gamelayer:eachStep(targetColor)
	local oldNum = #alreadyDye
	local function findAllUnit(v)
		local judgDyeArr = self:getAdjacentUnit(v)
		for j,w in ipairs(judgDyeArr) do
			if w.INDEX == targetColor and not self:isInalreadyDye(w) then
				table.insert(alreadyDye,w)
				findAllUnit(w)
			end
		end
	end
	local NAlreadDye = {} --边界元素
	for i,v in ipairs(alreadyDye) do
		if not self:judgeColor(v,alreadyDye[1].INDEX) then
			table.insert(NAlreadDye,v)
		end
	end
	for i,v in ipairs(NAlreadDye) do --把每一个边界元素当做索引找指定颜色的方块
		findAllUnit(v)
	end

	if #alreadyDye == oldNum then
		print("===========没有新的",#alreadyDye)
	else
		for i,v in ipairs(alreadyDye) do
		 	v.INDEX = targetColor
		end
		self.stepNum = self.stepNum + 1
		self.stepLab:setString(self.stepNum)
		self:dyeingDye(targetColor)
	end
end
--得到相邻的元素
function gamelayer:getAdjacentUnit(unit)
	local judgDyeArr = {}
	if unit.indexX-1>0 and unit.indexX-1<=11 and unit.indexY>0 and unit.indexY<=12 then
		table.insert(judgDyeArr,DyeArr[unit.indexY][unit.indexX-1])
	end
	if unit.indexX+1>0 and unit.indexX+1<=11 and unit.indexY>0 and unit.indexY<=12 then
		table.insert(judgDyeArr,DyeArr[unit.indexY][unit.indexX+1])
	end
	if unit.indexX>0 and unit.indexX<=11 and unit.indexY-1>0 and unit.indexY-1<=12 then
		table.insert(judgDyeArr,DyeArr[unit.indexY-1][unit.indexX])
	end
	if unit.indexX>0 and unit.indexX<=11 and unit.indexY+1>0 and unit.indexY+1<=12 then
		table.insert(judgDyeArr,DyeArr[unit.indexY+1][unit.indexX])
	end
	return judgDyeArr
end
--判断一个元素是否已经在alreadyDye中
function gamelayer:isInalreadyDye(oneUnit)
	for i,v in ipairs(alreadyDye) do
		if oneUnit.indexX == v.indexX and oneUnit.indexY == v.indexY then
			return true
		end
	end
	return false
end
--判断一个元素是否是边界元素
function gamelayer:judgeColor(unitDye,whichColor)
	local judgDyeArr =self:getAdjacentUnit(unitDye)
	for _,v in ipairs(judgDyeArr) do
		if v then
			if v.INDEX ~=  whichColor then --是边界元素
				return false
			end
		end
	end
	return true
end
--初始化倒计时
function gamelayer:infoCountDown()
	self.stepNum = 0
	self.stepLab:setString(self.stepNum)
	self.time = 0
	self.timeLab:setString(self.time)
	self.startTime = os.date("%Y-%m-%d %H:%M:%S")
	local delay = cc.DelayTime:create(1)
	local function callback()
		self.time = self.time+1
		self.timeLab:setString(self.time)
	end
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self.countdownaction = cc.RepeatForever:create(sequence)
    self:runAction(self.countdownaction)
end
function gamelayer:infoBack()
	local function onBack(event,touchType)
		if touchType == ccui.TouchEventType.ended then
			local CSB = cc.CSLoader:createNode("SuperDye/gameback_alert.csb") 
		    self:addChild(CSB)
		    CSB:setContentSize(display.size)
		    ccui.Helper:doLayout(CSB)
		    local bg = CSB:getChildByName("root"):getChildByName("pl_alert")
		    local mClose = bg:getChildByName("btn_close")
		    local mPlay = bg:getChildByName("btn_again")
		    local mBack = bg:getChildByName("img_btn_back")
		    local function callBack(event,touchType)
		    	if touchType == ccui.TouchEventType.ended then
		    		if event == mClose then
		    			CSB:removeFromParent()
		    		elseif event == mPlay then
		    			CSB:removeFromParent()
		    		elseif event == mBack then
		    			DyeArr = {}
						alreadyDye = {}
		    			self:getApp():enterScene("SuperDyeScene")
		    		end
		   		end
		    end
		    mClose:addTouchEventListener(callBack)
		    mPlay:addTouchEventListener(callBack)
		    mBack:addTouchEventListener(callBack)
		end
	end
	self.btn_back:addTouchEventListener(onBack)
end
--画染色体
function gamelayer:createDye(PositionArr)
	math.randomseed(os.time())
	for i=1,12 do
		DyeArr[i] = {}
	end
	for i,v in ipairs(PositionArr) do
		local whichColor = math.random(1,#DyeColorArr)
		local eachDye = ccui.ImageView:create()
	    eachDye:loadTexture(DyeColorArr[whichColor],1)
	    eachDye:setPosition(v.x,v.y)
	    self.dyePanel:addChild(eachDye,i)
		local arrOne,arrTwo
		if i%11 > 0 then
			arrTwo = i%11
		elseif i%11 == 0 then
			arrTwo = 11
		end
		arrOne = math.ceil(i/11)
		DyeArr[arrOne][arrTwo] = {}		
		DyeArr[arrOne][arrTwo].SPRITE = eachDye
		DyeArr[arrOne][arrTwo].INDEX = whichColor
		DyeArr[arrOne][arrTwo].indexX = arrTwo
		DyeArr[arrOne][arrTwo].indexY = arrOne
	end
end
--得到每一个染色体的位置
function gamelayer:getEachPosition()
	local SIZE = self.dyePanel:getContentSize()
	local size = self.size
	local PositionArr = {}
	for i=1,11*12 do
		local onePosition = {}
		if i%11 > 0 then
			onePosition.x = (i%11-1)*(size.width-1)+0.5*(size.width-1)+5
		elseif i%11 == 0 then
			onePosition.x = 10*(size.width-1)+0.5*(size.width-1)
		end
		onePosition.y = SIZE.height - math.ceil(i/11)*(size.height-1) + 0.5*(size.height-1)
		table.insert(PositionArr,onePosition)
	end
	return PositionArr
end
return gamelayer