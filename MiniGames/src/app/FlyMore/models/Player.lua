
local Player = class("Player")

Player.ORIENTATION_LEFT  = 1
Player.ORIENTATION_RIGHT = 2
Player.GRAVITY = 1600
Player.SPEED_NORMAL = 1000
Player.SPEED_CRAZY = 2000

function Player:ctor()
    self.speed_ = 0
    self.position_ = cc.p(0, 0)
    self.lastPosition_ = cc.p(0, 0)
    self.deltaX_ = 0
    self.minX_ = 0
    self.maxX_ = 0
    self.orientation_ = self.ORIENTATION_LEFT
end

function Player:getSpeed()
    return self.speed_
end

function Player:setSpeed(speed)
    self.speed_ = speed
    return self
end

function Player:getPosition()
    return self.position_
end

function Player:setPosition(position)
    self.position_ = position
    return self
end

function Player:getLastPosition()
    return self.lastPosition_
end

function Player:getOrientation()
    return self.orientation_
end

function Player:setMinX(minX)
    self.minX_ = minX
    return self
end

function Player:setMaxX(maxX)
    self.maxX_ = maxX
    return self
end

function Player:moveX(deltaX)
    if deltaX * self.deltaX_ < 0 then
        self.deltaX_ = 0
    end
    self.deltaX_ = self.deltaX_ + deltaX
    if math.abs(self.deltaX_ / 5) > 0 then
        if self.deltaX_ > 0 then
            self.orientation_ = Player.ORIENTATION_RIGHT
        else
            self.orientation_ = Player.ORIENTATION_LEFT
        end
        local offsetX = math.floor(self.deltaX_ / 5)
        self.position_.x = self.position_.x + offsetX
        if self.position_.x < self.minX_ then
            self.position_.x = self.minX_
        elseif self.position_.x > self.maxX_ then
            self.position_.x = self.maxX_
        end
        self.deltaX_ = self.deltaX_ - offsetX
    end
end

function Player:step(dt)
    self.lastPosition_.x, self.lastPosition_.y = self.position_.x, self.position_.y
    self.position_.y = self.position_.y + self.speed_ * dt
    self:setSpeed(self.speed_ - self.GRAVITY * dt)
    return self
end

return Player