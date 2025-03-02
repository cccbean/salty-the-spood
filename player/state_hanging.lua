Hanging_state = {
  value = 5,
}

function Hanging_state:update()
  self.isRunning = false

  if btn(4) then
    -- FIX: holding left or right lets you beat out gravity and fly
    if self.web.angle > 90 and self.web.angle < 270 then
      self.web.dangle += Gravity * (270 - self.web.angle) / 40
    elseif self.web.angle == 270 then
    elseif self.web.angle == 90 then
      self.state = Air_state
    elseif self.web.angle > 270 and self.web.angle <= 360 then
      self.web.dangle -= Gravity * (self.web.angle - 270) / 40
    elseif self.web.angle >= 0 then
      self.web.dangle -= Gravity * (self.web.angle + 90) / 40
    end

    if btn(2) then
      self.web.distance -= 1
    elseif btn(3) then
      self.web.distance += 1
    end

    -- BUG: when dist is too large, arc becomes v-shaped
    local dist_mod = self.web.distance / 8
    if btn(0) then
      if self.web.angle > 180 and self.web.angle < 360 then
        self.web.dangle -= 5 / dist_mod
      end
    elseif btn(1) then
      if self.web.angle > 180 and self.web.angle < 360 then
        self.web.dangle += 5 / dist_mod
      end
    else
      if abs(self.web.angle - 270) > 10 then
        self.web.dangle *= 0.98
      else
        self.web.dangle *= 0.88
      end
    end

    self.web.dangle = mid(-self.web.max_dangle, self.web.dangle, self.web.max_dangle)

    -- if self.web.dangle ~= 0 then
    self.web.angle += Round(self.web.dangle)

    -- cos & sin pico funcs can't handle an angle outside of 0 & 360
    if self.web.angle > 360 then
      self.web.angle = 0 + self.web.angle - 360
    elseif self.web.angle < 0 then
      self.web.angle = 360 + self.web.angle
    end

    self.dx = self.web.x + self.web.distance * cos(self.web.angle / 360) - self.x
    self.dy = self.web.y + self.web.distance * sin(self.web.angle / 360) - self.y

    self.dx = mid(-self.max_dx, self.dx, self.max_dx)
    self.dy = mid(-self.max_dy, self.dy, self.max_dy)
    -- end
  else
    self.web.dangle = 0
    self.state = Air_state
    return
  end
end

function Hanging_state:animate()
  self.sp = 6
  self.flipy = false
end

-- function Hanging_state:update_pos_from_angle()
--   self.dx = self.web.x + self.web.distance * cos(self.web.angle / 360) - self.x
--   self.dy = self.web.y + self.web.distance * sin(self.web.angle / 360) - self.y
-- end
