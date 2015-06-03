local gamelayer = class("gamelayer",cc.load("mvc").ViewBase)
local Times = 1
local winSize = cc.Director:getInstance():getWinSize()
local SIMALL_BACKROUND_LONG = 583*640/640
function gamelayer:onCreate()
	self:infoCSB()
	self:infoTouch()
	performWithDelay(self, function ()
		local flag,levelReturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/levellist.aspx")
	    if not flag then return end
	    local level=GamePB_pb.PBCrazywordsLevelsList()
	    level:ParseFromString(levelReturn)
	    local flag,wordReturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/textlist.aspx")
	    if not flag then return end
	    local word=GamePB_pb.PBCrazywordsWordsList()
	    word:ParseFromString(wordReturn)
		--游戏开始
		self.levelarr = level.list
		self.wordarr = word.list
		local allLattice=self:createAllLattice(self.levelarr[Times].sqrtnum)
		self:createEachFonts(allLattice)
		self:countdownBegin()
	end,0.001)
end
function gamelayer:infoCSB()
    self:createResoueceNode("FoundWord/Main.csb")
    local CSB=self.resourceNode_
    local root = CSB:getChildByName("root")
    local panel_top = root:getChildByName("panel_top")
    self.countTime = panel_top:getChildByName("countdown"):getChildByName("time")
    self.countTime:setString("02:00")
    self.btn_back = panel_top:getChildByName("btn_back")
    local panel_guan = panel_top:getChildByName("panel_guan")
    local numberguan = panel_guan:getChildByName("number_guan")
    numberguan:setVisible(false)
    local size = panel_guan:getContentSize()

    self.number_guan = ccui.TextAtlas:create()
    self.number_guan:setProperty("1", "FoundWord/number_guan_cz.png", 42, 54, ".")
    self.number_guan:setPosition(size.width*0.5,size.height*0.5)  
    panel_guan:addChild(self.number_guan)

    self.background = root:getChildByName("panel_content"):getChildByName("img_bg")
 end
function gamelayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			local CSB = cc.CSLoader:createNode("FoundWord/go_home.csb") 
    		self:addChild(CSB)
    		CSB:setContentSize(display.size)
    		ccui.Helper:doLayout(CSB)
    		local dailog_bg = CSB:getChildByName("alert_bg"):getChildByName("dailog_bg")
    		self.btn_return = dailog_bg:getChildByName("btn_next")
		    self.btn_close = dailog_bg:getChildByName("btn_close")   
		    self.content = dailog_bg:getChildByName("c_content")
		    self.content:setString(string.format("您已通过%s关",Times-1))
		    local function onclose(sender,eventType)
		    	if eventType == ccui.TouchEventType.ended then
		    		self:getApp():enterScene("FoundWordscene")
		    	end
		    end
		    self.btn_close:addTouchEventListener(onclose)
		    local function onreturn(sender,eventType)
		    	if eventType == ccui.TouchEventType.ended then
		    		CSB:removeFromParent()	    		
		    	end
		    end
		    self.btn_return:addTouchEventListener(onreturn)
		end
	end
	self.btn_back:addTouchEventListener(backCallback)
end
--开始倒计时
function gamelayer:countdownBegin()
	self.number_guan:setString(self.levelarr[Times].levelid)
	self.startTime = os.date("%Y-%m-%d %H:%M:%S")
	self.time = 120
	local delay = cc.DelayTime:create(1)
	local function callback()
		self.time = self.time - 1
		local timeString = ""
		if self.time >= 60 then
			timeString = timeString.."01:"..tostring(self.time-60)
		else
			if self.time < 10 then
				timeString = timeString.."00:0"..tostring(self.time)
			else
				timeString = timeString.."00:"..tostring(self.time)
			end
		end
		self.countTime:setString(timeString)
		if self.time == 0 then
			self:stopAction(self.countdownaction)
			local account,msg = self:TransPerformance()
			self.time = 1
			Times = 1
			local finishlayer = require("src.app.FoundWord.finishlayer").new(1,self,account,msg)
			self:addChild(finishlayer,10)
		end
	end
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self.countdownaction = cc.RepeatForever:create(sequence)
    self:runAction(self.countdownaction)
end
--在每个格子上面写上字，allLattice--所有的格子
function gamelayer:createEachFonts(allLattice)
	math.randomseed(os.clock())
	local Fontsindex = math.random(1,#self.wordarr)
	local Latticeindex = math.random(1,#allLattice)
	local function Rightcallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self.background:removeAllChildren()
			Times = Times+1
			if Times >= 10 then
				self.number_guan:setScale(0.7)
			else
				self.number_guan:setScale(1)
			end
			self.number_guan:setString(self.levelarr[Times].levelid)
			if not self.levelarr[Times] then
				self:stopAction(self.countdownaction)
				local account,msg = self:TransPerformance()
				Times = 1
				print("====通关")
				local finishlayer = require("src.app.FoundWord.finishlayer").new(3,self,account,msg)
				self:addChild(finishlayer,10)
				return
			end		
			local allLattice=self:createAllLattice(self.levelarr[Times].sqrtnum) --每一个行有多少个格子
			self:createEachFonts(allLattice)
		end
	end
	local function Errorcallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:stopAction(self.countdownaction)
			local account,msg=self:TransPerformance()
			Times = 1
			local finishlayer = require("src.app.FoundWord.finishlayer").new(2,self,account,msg)
			self:addChild(finishlayer,10)
		end
	end
	for i,v in ipairs(allLattice) do
		local label
		if i==Latticeindex then
			label =ccui.Text:create(self.wordarr[Fontsindex].word2, "Arial", self.oneLong-10)
			label:addTouchEventListener(Rightcallback)
		else
			label =ccui.Text:create(self.wordarr[Fontsindex].word1, "Arial", self.oneLong-10)
			label:addTouchEventListener(Errorcallback)
		end
		label:setColor(cc.c3b(255,255,255))
		label:setTouchEnabled(true)
	    label:setPosition(self.oneLong*0.5,self.oneLong*0.5)
	    v:addChild(label,10)
	end
end
--发送结算协议
function gamelayer:TransPerformance()
	self.endTime = os.date("%Y-%m-%d %H:%M:%S")
	local Account = GamePB_pb.PBCrazywordsGamelog_Update_Params()
	Account.starttime = self.startTime
	Account.endtime = self.endTime
	Account.levels = Times -1 
	Account.costtime = 120-self.time
	print("===",Account.starttime,Account.endtime,Account.levels,Account.costtime)
	local flag,getAccountreturn = HttpManager.post("http://lxgame.lexun.com/interface/CrazyWords/updategamelog.aspx",Account:SerializeToString())
	if not flag then return end
	local obj=GamePB_pb.PBCrazywordsBestscore_Return()
    obj:ParseFromString(getAccountreturn)
    print("===obj.msginfo.noerror===",obj.msginfo.noerror,obj.msginfo.outmsg)
    if obj.msginfo.noerror then
    --	print("obj.bestscore.userid,obj.bestscore.levels,obj.bestscore.costtime,obj.bestscore.rank")
    --	print(obj.bestscore.userid,obj.bestscore.levels,obj.bestscore.costtime,obj.bestscore.rank)
    	obj.bestscore.levels = Account.levels
    	obj.bestscore.costtime = Account.costtime
    	return obj.bestscore,obj.msginfo.outmsg
    else
    	DialogBox.run(cc.Director:getInstance():getRunningScene(),obj.msginfo.out) 
    end
end
--创建每个小格子，howmany--每一个多少个格子
function gamelayer:createAllLattice(howmany)
	local allLattice = {}
	local Betweentwo = 12 --两个格子之间的间距
	local allLong = SIMALL_BACKROUND_LONG-15*2-Betweentwo*(howmany-1)
	local oneLong = allLong/howmany --每个格子的长度
	self.oneLong = oneLong
	local allPosition = self:getEachPosition(howmany)
	for i,v in ipairs(allPosition) do
		local latticeback = ccui.ImageView:create("FoundWord/bg_white_cz.png")		
		latticeback:setScale9Enabled(true)
		latticeback:setContentSize(cc.size(oneLong,oneLong))
		latticeback:setColor(cc.c3b(13,103,9))
		latticeback:setPosition(v.x,v.y)
		self.background:addChild(latticeback)
		table.insert(allLattice,latticeback)
	end
	return allLattice
end
--计算每个字格的位置,howmany--每一个多少个格子
function gamelayer:getEachPosition(howmany)
	local Betweentwo = 12 --两个格子之间的间距
	local Distance = 15 --格子边到底的边的最小距离
	local allPosition = {}
	local allLong = SIMALL_BACKROUND_LONG-Distance*2-Betweentwo*(howmany-1)
	local oneLong = allLong/howmany --每个格子的长度
	for i=1,howmany*howmany do
		local onePosition = {}
		if i%howmany > 0 then
			onePosition.x = Distance+((i%howmany)-1)*(oneLong+Betweentwo)+oneLong*0.5
		elseif i%howmany == 0 then
			onePosition.x = Distance+(howmany-1)*(oneLong+Betweentwo)+oneLong*0.5
		end
		onePosition.y = (SIMALL_BACKROUND_LONG)-(math.ceil(i/howmany)-1)*(oneLong+Betweentwo)-oneLong*0.5
		table.insert(allPosition,onePosition)
	end
	return allPosition
end
return gamelayer