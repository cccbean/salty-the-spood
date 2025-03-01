Air_state = {
  value = 3,
}

function Air_state:update()
  self.isRunning = false
  self.flipy = false

  self.dx *= Friction * 1.1
  self.dy += Gravity

  self:handle_hor_input(1)

  if btnp(4) and self.web.isVisible then
    self.dx = 0
    self.dy = 0
    self.web.distance = Get_distance(self.x, self.y, self.web.x, self.web.y)
    self.web.angle = Round(atan2(self.x - self.web.x, self.y - self.web.y) * 360)
    self.state = Hanging_state
    return
  end

  self.dx = mid(-self.max_dx, self.dx, self.max_dx)

  if self.dy > 0 then
    self.dy = mid(-self.max_dy / 2, self.dy, self.max_dy / 2)
    self.sp = 6
  else
    self.dy = mid(-self.max_dy, self.dy, self.max_dy)
    self.sp = 2
  end
end

function Air_state:animate() end
