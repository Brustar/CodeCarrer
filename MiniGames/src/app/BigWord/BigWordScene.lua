
local BigWordScene = class("BigWordScene",cc.load("mvc").ViewBase)

function BigWordScene:onCreate()

	self:infoCSB()
end
 
   
 
function BigWordScene:infoCSB()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("BigWord/bg_img.plist","BigWord/bg_img.png")
	self:createResoueceNode("BigWord/index.csb")
	local CSB = self.resourceNode_
    local function startGame(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self:getApp():enterScene("MyIndexScene")
        end
    end
    self.btn_play = CSB:getChildByName("root"):getChildByName("pl_bg"):getChildByName("btn_play"):addTouchEventListener(startGame)
     
end

return BigWordScene









