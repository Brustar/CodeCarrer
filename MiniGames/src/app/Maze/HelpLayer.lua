local HelpLayer = class("HelpLayer", cc.load("mvc").ViewBase)

function HelpLayer:onCreate()
    self:createCSBInfo()
    self:touchEvent()
end

function HelpLayer:createCSBInfo()
    self:createResoueceNode("Maze/Help.csb")
    local dailog_bg = self.resourceNode_:getChildByName("alert_bg"):getChildByName("dailog_bg")
    self.btn_close = dailog_bg:getChildByName("btn_close")
end

function HelpLayer:touchEvent()
    local function back(sender, event) 
        self:removeFromParent()
    end
    self.btn_close:addTouchEventListener(back)
end

return HelpLayer