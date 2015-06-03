local CoinRecord = class("CoinRecord",cc.load("mvc").ViewBase)
function CoinRecord:onCreate()
    self:createResoueceNode("login/lebi_record.csb")
    self:infoCSB(self.resourceNode_)
end
function CoinRecord:infoCSB(CSB)
	local root = CSB:getChildByName("root")
	self.back = root:getChildByName("head"):getChildByName("btn_back") 
	self.findBtn = root:getChildByName("btn_fond")
	self.startTime = root:getChildByName("start_time")
	self.STimeLab = self.startTime:getChildByName("content_time")
	self.SIcon = self.startTime:getChildByName("icon_arrow_1")
	self.endTime = root:getChildByName("end_time")
	self.ETimeLab = self.endTime:getChildByName("content_time")
	self.EIcon = self.endTime:getChildByName("icon_arrow_2")
	self.emptyLab = root:getChildByName("empty")
	self.RecordList = root:getChildByName("record_list")

	self.RecordItem = root:getChildByName("record_item")
	-- self.coinChange = self.RecordItem:getChildByName("num_lebi"):getChildByName("number")
	-- self.gameName = self.RecordItem:getChildByName("panel_type"):getChildByName("text_type")
	-- self.playerid = self.RecordItem:getChildByName("panel_id"):getChildByName("text_id")
	-- self.changeTime = self.RecordItem:getChildByName("panel_time"):getChildByName("time")
	self.RecordItem:setVisible(false)
	self.STimeLab:setString(os.date("%Y-%m-%d"))
	self.ETimeLab:setString(os.date("%Y-%m-%d"))
	self:infoTouch()
end
function CoinRecord:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getApp():enterScene("MainScene")
		end
	end
	self.back:addTouchEventListener(backCallback)
	local function startTimeBack(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showDate(function(result)
				self.STimeLab:setString(result)
			end)
		end
	end
	self.startTime:setTouchEnabled(true)
	self.startTime:addTouchEventListener(startTimeBack)
	local function endTimeBack(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			native.showDate(function(result)
				self.ETimeLab:setString(result)
			end)
		end
	end
	self.endTime:setTouchEnabled(true)
	self.endTime:addTouchEventListener(endTimeBack)
	local function findBack(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			local startime = self.STimeLab:getString()
			local endtime = self.ETimeLab:getString()
			print("startime",startime,endtime)
			if startime == "开始时间"  then DialogBox.run(self,"开始时间为空") return end
			if endtime == "结束时间" then DialogBox.run(self,"结束时间为空") return end
			local coinRecord = LoginPB_pb.PBStoneLogInquiryParams()
		    coinRecord.starttime = startime
		    coinRecord.endtime = endtime
		    -- coinRecord.starttime = "2015-04-01"
		    -- coinRecord.endtime = "2015-04-14"
		    coinRecord.pageinfo.page = 1
		    coinRecord.pageinfo.pagesize = 10
		    print(startime,endtime)
		    local flag,coinReturn = HttpManager.post("http://lxgame.lexun.com/login/stonelog.aspx",coinRecord:SerializeToString())
		    if not flag then return end
		    local obj=LoginPB_pb.PBStoneLogList()
		    obj:ParseFromString(coinReturn)
		    print("obj.list",#obj.list)
		   if #obj.list > 0 then
		   		self:infoListView(obj.list)
		   		self.emptyLab:setVisible(false)
		   else
		   		self.emptyLab:setVisible(true)
		   		DialogBox.run(self,"暂无记录")
		   		print("===没有记录")
		   end
		end
	end
	self.findBtn:addTouchEventListener(findBack)
end
--填写数据
function CoinRecord:infoListView(list)
	for i,v in ipairs(list) do
		local item = self.RecordItem:clone()
		item:setVisible(true)
		local coinChange = item:getChildByName("num_lebi"):getChildByName("number")
		local gameName = item:getChildByName("panel_type"):getChildByName("text_type")
		local playerid = item:getChildByName("panel_id"):getChildByName("text_id")
		local changeTime = item:getChildByName("panel_time"):getChildByName("time")
		--print("===v.appname==",v.appname,"-",v.remark,"-",v.sid,"-",v.sid)
		coinChange:setString(v.addstone)
		gameName:setString(v.appname)
		playerid:setString(v.userid)
		changeTime:setString(v.writetime)
		self.RecordList:pushBackCustomItem(item)
	end
end
return CoinRecord