
local ComboTrigger = class("ComboTrigger")

ComboTrigger.MODE_NORMAL = 1
ComboTrigger.MODE_CRAZY = 2

ComboTrigger.MAX_POWER_POINTS = {}
ComboTrigger.MAX_POWER_POINTS[ComboTrigger.MODE_NORMAL] = 10
ComboTrigger.MAX_POWER_POINTS[ComboTrigger.MODE_CRAZY] = 6

function ComboTrigger:ctor()
    self.mode_ = ComboTrigger.MODE_NORMAL
    self.comboColor_ = nil
    self.comboNum_ = 1
    self.powerPoint_ = 0
    self.totalPowerPoint_ = 0
    
    -- bind the "event" component
    cc.bind(self, "event")
end

function ComboTrigger:getMode()
    return self.mode_
end

function ComboTrigger:getComboColor()
    return self.comboColor_
end

function ComboTrigger:getComboNum()
    return self.comboNum_
end

function ComboTrigger:getPowerPoint()
    return self.powerPoint_
end

function ComboTrigger:getTotalPowerPoint()
    return self.totalPowerPoint_
end

function ComboTrigger:trigger(color)
    local result = false
    if color == self.comboColor_ then
        self.comboNum_ = self.comboNum_ + 1
    else
        self.comboNum_ = 1
    end
    self.comboColor_ = color
    if self.comboNum_ > 1 and self.comboNum_ < 5 then
        self.totalPowerPoint_ = self.totalPowerPoint_ + 1
        self.powerPoint_ = self.powerPoint_ + 1
    elseif self.comboNum_ >= 5 then
        self.comboNum_ = 1
        result = true
    end
    return result
end

function ComboTrigger:changeMode()
    local result = false
    if self.powerPoint_ >= ComboTrigger.MAX_POWER_POINTS[self.mode_] then
        if self.mode_ == ComboTrigger.MODE_NORMAL then
            self.mode_ = ComboTrigger.MODE_CRAZY
        else
            self.mode_ = ComboTrigger.MODE_NORMAL
        end
        self.powerPoint_ = 0
    end
    return result
end

return ComboTrigger