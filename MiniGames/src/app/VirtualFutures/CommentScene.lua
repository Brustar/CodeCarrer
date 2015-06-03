import(".pb.FuturesPB_pb")

local Util = import(".Util")

local CommentScene = class("CommentScene", 
	function()
		return cc.Scene:create()
	end)

function CommentScene:ctor(typeid)
	self.typeid = typeid

	self:initWithCSB()

	self:loadExpectDetail()

	self:reloadCommentList()
end

function CommentScene:initWithCSB()
    local node = cc.CSLoader:createNode("zaixian.csb")
    node:setVisible(true)
    self:addChild(node)
    node:setContentSize(cc.Director:getInstance():getWinSize())
    ccui.Helper:doLayout(node)

	local root = node:getChildByName("root")

	local pl_top = node:getChildByName("pl_top")
	self.pl_back_32 = pl_top:getChildByName("pl_back_32")
	self.pl_back_32:addClickEventListener(function(sender, eventType) 
		cc.Director:getInstance():popScene() 
	end)

	local pl_pinglun = node:getChildByName("pl_pinglun")
	local pl_kanhao = pl_pinglun:getChildByName("pl_kanhao")
	self.pl_kanhao_num = pl_kanhao:getChildByName("pl_kanhao_num")
	self.pl_kanhao_num:addClickEventListener(function(sender, eventType)
		self:commitExpect(1)
	end)
	self.text_kanhao_num = self.pl_kanhao_num:getChildByName("text_kanhao_num")

	self.pl_kanhao_num_0 = pl_kanhao:getChildByName("pl_kanhao_num_0")
	self.pl_kanhao_num_0:addClickEventListener(function(sender, eventType)
		self:commitExpect(2)
	end)
	self.text_kanhao_num_48 = self.pl_kanhao_num_0:getChildByName("text_kanhao_num_48")

	self.pl_progress = pl_kanhao:getChildByName("pl_progress")
	self.pl_progress_kanhao = self.pl_progress:getChildByName("pl_progress_kanhao")

	self.pl_pinglun_item = pl_pinglun:getChildByName("pl_pinglun_item")
	self.pl_pinglun_item:setVisible(false)

	self.lv_pinglun = pl_pinglun:getChildByName("lv_pinglun")
	self.lv_pinglun:setClippingEnabled(true)
	self.lv_pinglun:addScrollViewEventListener((function()
		local seconds = 1
		local lasttime = os.clock()
		return function(sender, eventType)
	        if eventType == ccui.ScrollviewEventType.scrollToBottom then
				if os.clock() - lasttime > seconds then
					lasttime = os.clock()
					self:loadCommentList()
		    	end
	        end
        end
	end)())

	local pl_bottom_kanfa = node:getChildByName("pl_bottom_kanfa")
	self.tf_kanfa = pl_bottom_kanfa:getChildByName("pl_input"):getChildByName("tf_kanfa")
	self.tf_kanfa:setColor(cc.c3b(0, 0, 0))
	Util.wrapTextField(self.tf_kanfa)
	self.img_kanfa = pl_bottom_kanfa:getChildByName("pl_input"):getChildByName("img_kanfa")
	self.img_kanfa:setTouchEnabled(true)
	self.img_kanfa:addClickEventListener(function(sender, eventType)
		self:commitComment()
	end)
end

function CommentScene:getTouserid()
	return 0
end

function CommentScene:getContent()
	return self.tf_kanfa:getString()
end

function CommentScene:loadExpectDetail()
    local pbRequest = FuturesPB_pb.PBExpectDetailRequest()
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/expectdetail.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBExpect()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	self.expect = pbResponse
	self.text_kanhao_num:setString(self.expect.more)
	self.text_kanhao_num_48:setString(self.expect.less)

	local size = self.pl_progress:getContentSize()
	if self.expect.more == self.expect.less then
		size.with = size.width / 2
	else
		size.width = size.width * self.expect.more / (self.expect.more + self.expect.less)
	end
	self.pl_progress_kanhao:setContentSize(size)
end

function CommentScene:reloadCommentList()
    self:removeCommentList()
    self:loadCommentList()
end

function CommentScene:removeCommentList()
    self.page = 0
    self.pagesize = 20
    self.total = 0
	self.comments = {}
	self.lv_pinglun:removeAllChildren()
end

function CommentScene:loadCommentList()
    if self.total > 0 and self.total <= self.page * self.pagesize then
        return
    end
    local pbRequest = FuturesPB_pb.PBCommentListRequest()
    pbRequest.page = self.page + 1
    pbRequest.pagesize = self.pagesize
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/commentlist.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBCommentList()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	if not pbResponse.list or #pbResponse.list <= 0 then
		return
	end
    self.page = pbResponse.pageinfo.page
    self.pagesize = pbResponse.pageinfo.pagesize
    self.total = pbResponse.pageinfo.total
    if not self.comments then
    	self.comments = {}
	end
    for i, comment in ipairs(pbResponse.list) do 
    	table.insert(self.comments, comment)
        local item = self.pl_pinglun_item:clone()
        item:getChildByName("pl_tx_con"):getChildByName("text_username"):setAnchorPoint(0.5, 0.5):setString(comment.userid)
    	item:getChildByName("pl_tx_con"):getChildByName("text_tx_time"):setAnchorPoint(0, 0.5):setString(comment.addtime)
    	item:getChildByName("pl_pinglun_con"):getChildByName("text_pinglun_con"):setString(comment.content)
    	item:getChildByName("text_huifu_con"):setVisible(true)
    	item:getChildByName("pl_btn_pinglun"):setVisible(true)
    	item:setVisible(true)
    	self.lv_pinglun:pushBackCustomItem(item)
    end
end

function CommentScene:commitExpect(op)
    local pbRequest = FuturesPB_pb.PBExpectRequest()
    pbRequest.op = op
    pbRequest.typeid = self.typeid
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/expect.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBCommonResponse()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	self:loadExpectDetail()
end

function CommentScene:commitComment()
	local op = 1
	local typeid = self.typeid
	local touserid = self:getTouserid()
	local content = self:getContent()

    local pbRequest = FuturesPB_pb.PBCommentRequest()
    pbRequest.op = op
    pbRequest.typeid = typeid
    pbRequest.touserid = touserid
    pbRequest.content = content
    local _, data = HttpManager.post("http://g.lexun.com/qh_app/comment.aspx", pbRequest:SerializeToString())
    local pbResponse = FuturesPB_pb.PBCommonResponse()
    pbResponse:ParseFromString(data)
    if not pbResponse then
    	return
	end
	self:reloadCommentList()
end

return CommentScene