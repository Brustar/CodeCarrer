local RankLayer = class("RankLayer", cc.load("mvc").ViewBase)

local page = 1
local pagesize = 10
local lastData = {}

function RankLayer:onCreate()
    self:createCSBInfo()
    self:touchEvent()
    self:getData()
    self:displayRank()
    self:loadMoreData()
end


function RankLayer:createCSBInfo()
    self:createResoueceNode("Maze/Rank.csb")
    local content = self.resourceNode_:getChildByName("dialog"):getChildByName("content")
    self.btn_close = content:getChildByName("btn_closed")
    local rank = content:getChildByName("rank")
    self.myRank = rank:getChildByName("my_top")
    self.myRank:setVisible(false)
    self.otherRank = rank:getChildByName("item_top")
    self.otherRank:setVisible(false)
    self.ranklist = rank:getChildByName("list_rank")
end

function RankLayer:touchEvent()
    local function back(sender, event) 
        self:removeFromParent()
    end
    self.btn_close:addTouchEventListener(back)
end


function RankLayer:getData()
    page = 1
    pagesize = 10
    local params = ServerBasePB_pb.PBPageInfo()
	params.page = page
	params.pagesize = pagesize
    
	local flag,retData = HttpManager.post("http://lxgame.lexun.com/interface/Maze/rank.aspx",params:SerializeToString())
	if not flag then return end
    local obj= GamePB_pb.PBMazeBestscoreList()
    obj:ParseFromString(retData)
    self.data = obj
    lastData = obj
end

function RankLayer:displayRank()
    for i, v in ipairs(self.data.list) do
        if v.userid ==0 then return end
   
        local item = self.otherRank:clone()
        item:setVisible(true)
        local img_top = item:getChildByName("img_top")
        dump(img_top)
--        img_top:setVisible(false)

        local num_top = item:getChildByName("num_top")
        num_top:setProperty(v.rank, "Maze/number_top_wzq.png", 24, 40, ".")
        num_top:setVisible(true)

        local headimg = item:getChildByName("avater"):getChildByName("img_avater")

        --下载玩家头像
        HttpManager.download(v.headimg)
        local _,_,_,file=parseUrl(v.headimg)
        headimg:loadTexture(device.writablePath..file)

        local nickname = item:getChildByName("nickname")
        nickname:setString(v.nick)

        local userid = item:getChildByName("ID")
        userid:setString(v.userid)

        local rankstr = item:getChildByName("win")
        rankstr:setString(v.levels.."关，"..v.stepnum.."步")

        self.ranklist:pushBackCustomItem(item)
        if(#lastData.list >= 10) then
            self.ranklist:setBounceEnabled(true)
        end
    end

    self.myRank.img_num = self.myRank:getChildByName("img_num")
    self.myRank.num_top = self.myRank:getChildByName("num_top")
    self.myRank.nickname = self.myRank:getChildByName("nickname")
    self.myRank.headimg = self.myRank:getChildByName("avater"):getChildByName("img_avater")
    self.myRank.userid = self.myRank:getChildByName("ID")
    self.myRank.rankstr = self.myRank:getChildByName("win")
    self.myRank.myrank = self.myRank:getChildByName("mark"):getChildByName("my_rank")
    self.myRank.line = self.myRank:getChildByName("line")
    self.myRank.line:setVisible(false)

    --暂无成绩
    if page == 1 then
        if self.data.bestscore.userid ==0 then 
            self.myRank.nickname:setString(UserData.nick)
            self.myRank.userid:setString(UserData.userid)
            self.myRank.rankstr:setString("赶快来试玩一下吧")
            self.myRank.myrank:setString("暂无成绩")
            self.myRank.img_num:setVisible(false)
            self.myRank.num_top:setProperty(0, "Maze/number_top_wzq.png", 24, 40, ".")
            self.myRank.num_top:setVisible(true)
            self.myRank.headimg:loadTexture(cc.UserDefault:getInstance():getStringForKey('userHeadIcon'))
            self.myRank:setVisible(true)
        else
            self.myRank.img_num:setVisible(false)
            self.myRank.num_top:setProperty(self.data.bestscore.rank, "Maze/number_top_wzq.png", 24, 40, ".")
            self.myRank.num_top:setVisible(true)
            --下载玩家头像
            HttpManager.download(self.data.bestscore.headimg)
            local _,_,_,file=parseUrl(self.data.bestscore.headimg)
            self.myRank.headimg:loadTexture(device.writablePath..file)
            self.myRank.nickname:setString(self.data.bestscore.nick)
            self.myRank.userid:setString(self.data.bestscore.userid)
            self.myRank.rankstr:setString(self.data.bestscore.levels.."关，"..self.data.bestscore.stepnum.."步")
            self.myRank:setVisible(true)
        end
    end
end

--滑到底部再拉数据
function RankLayer:loadMoreData()
    self.TIME_T = os.clock()
    local function onScroll(_,eventType)
        if eventType == ccui.ScrollviewEventType.scrollToBottom then--滑到底部
            if os.clock()-self.TIME_T>1 and #lastData.list>=10 then --防止拉取数据太快
                page = page + 1 
                self.TIME_T = os.clock()
                local params = ServerBasePB_pb.PBPageInfo()
	            params.page = page
	            params.pagesize = pagesize
                local flag,retData = HttpManager.post("http://lxgame.lexun.com/interface/Maze/rank.aspx",params:SerializeToString())
                if not flag then return end
                local obj=GamePB_pb.PBMazeBestscoreList()
                obj:ParseFromString(retData)
                self.data = obj
                lastData = obj
                self:displayRank()
            end
        end
    end
   self.ranklist:addScrollViewEventListener(onScroll)
end
return RankLayer