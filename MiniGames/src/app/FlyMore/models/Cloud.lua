
local Cloud = class("Cloud")

Cloud.COLOR_BLUE = 1
Cloud.COLOR_GREEN = 2
Cloud.COLOR_ORANGE = 3
Cloud.COLOR_PURPLE = 4
Cloud.COLORS = {Cloud.COLOR_BLUE, Cloud.COLOR_GREEN, Cloud.COLOR_ORANGE, Cloud.COLOR_PURPLE}

function Cloud:ctor()
    self.color_ = nil
    self.originColor_ = nil
    self.position_ = cc.p(0, 0)
end

function Cloud:getColor()
    return self.color_
end

function Cloud:setColor(color)
    self.originColor_ = color
    self.color_ = color
    return self
end

function Cloud:changeColor(color)
    self.color_ = color
    return self
end

function Cloud:restoreColor()
    if self.originColor_ then
        self.color_ = self.originColor_
    end
    return self
end

function Cloud:getPosition()
    return self.position_
end

function Cloud:setPosition(position)
    self.position_ = position
    return self
end

function Cloud:step(dt)
    return self
end

return Cloud