
local Timer = class("Timer")

Timer.INIT_SECONDS = 60

function Timer:ctor()
    self.leftSeconds_ = self.INIT_SECONDS
end

function Timer:getLeftSeconds()
    return self.leftSeconds_
end

function Timer:step(dt)
    self.leftSeconds_ = self.leftSeconds_ - dt
    if self.leftSeconds_ < 0 then self.leftSeconds_ = 0 end
    return self
end

return Timer