CoolSprite = class("CoolSprite")

function CoolSprite:ctor(ch)
    self.ch_=ch
    self.position_=display.center
    self.coordinate_ = 0
end

function CoolSprite:move(offset)
	self.coordinate_=self.coordinate_+offset
end