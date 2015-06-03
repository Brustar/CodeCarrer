local helplayer = class("helplayer",
	function ()
		return cc.Layer:create()
	end)
local winSize = cc.Director:getInstance():getWinSize()
function helplayer:ctor()
	self:infoCSB()
	self:infoTouch()
    self:initData()
end
function helplayer:infoCSB()
    local CSB = cc.CSLoader:createNode("ChineseBlock/gamehelp.csb") 
    self:addChild(CSB)
    CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    local bg = CSB:getChildByName("bg"):getChildByName("window")
    local bg_article = bg:getChildByName("bg_article")
    self.btn_join = bg_article:getChildByName("btn_join")
    self.btn_close = bg:getChildByName("btn_close")

    self.line = bg_article:getChildByName("line")
    self.title_game_activity = bg_article:getChildByName("title_game_activity")
    self.title_game_rule = bg_article:getChildByName("title_game_rule")
    self.title_my_bag = bg_article:getChildByName("title_my_bag")
    self.link_explain = bg_article:getChildByName("link_explain")
    self.link_film = bg_article:getChildByName("link_film")

    self.title_my_bag = bg_article:getChildByName("title_my_bag")
    self.text_section04 = bg_article:getChildByName("text_section04")
    self.link_films = bg_article:getChildByName("link_films")
    self.btn_open = bg_article:getChildByName("btn_open")
    self.line_blue_0 = bg_article:getChildByName("line_blue_0")
    self.line_0 = bg_article:getChildByName("line_0")
    self.line_blue_1 = bg_article:getChildByName("line_blue_1")
    self.text_section03_3 = bg_article:getChildByName("text_section03_3")

    self.text_section03s=bg_article:getChildByName("text_section03s")
    self.text_section03_0s=bg_article:getChildByName("text_section03_0s")
    self.text_section03_2s=bg_article:getChildByName("text_section03_2s")


    --self.link_explain:setVisible(false)
    self.line:setVisible(false)
   -- self.star:setVisible(false)
    self.title_game_activity:setVisible(false)
    self.title_game_rule:setVisible(false)
    self.title_my_bag:setVisible(false)
   -- self.game_content:setVisible(false)
    --self.btn_join:setVisible(false)

    self.title_my_bag:setVisible(false)
    self.text_section04:setVisible(false)
    self.link_films:setVisible(false)
    self.link_film:setVisible(false)
    self.btn_open:setVisible(false)
    self.line_blue_0:setVisible(false)
    self.line_0:setVisible(false)
    self.line_blue_1:setVisible(false)
    self.link_explain:setVisible(false)
    self.text_section03_3:setVisible(false)
end
function helplayer:infoTouch()
	local function backCallback(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:removeFromParent()
		end
	end
	self.btn_close:addTouchEventListener(backCallback)
	local function joingame(sender,eventType)
		if eventType == ccui.TouchEventType.ended then
			self:getParent():getApp():enterScene("GameView")
		end
	end
	self.btn_join:addTouchEventListener(joingame)
end

function helplayer:initData()
    local reActivity = GameActivityPB_pb.PBGameActivty_Params()
    reActivity.gameid = 9
    local flag,rankReturn = HttpManager.post("http://lxgame.lexun.com/interface/gameactivity.aspx", reActivity:SerializeToString())
    if not flag then return end
    local obj = GameActivityPB_pb.PBGameActivity()
    obj:ParseFromString(rankReturn)
    print(rankReturn)

    print(obj.acname)
    print(obj.conditiondesc)
    print(obj.remark)

    self.text_section03s:setString(obj.acname)
    self.text_section03_0s:setString(obj.conditiondesc)
    self.text_section03_2s:setString(obj.remark)


end
return helplayer