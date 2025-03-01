Climbing_state = {
  value = 1,
}

function Climbing_state:update()
  self.dy *= Friction
  if self.flipx then
    -- TODO: check collision for other block times
    if not Collide_map(self.x - 1, self.y, self.w, self.h, Enum_flag.ground) then
      self.state = Air_state
      return
    end
  else
    -- TODO: check collision for other block times
    if not Collide_map(self.x + 1, self.y, self.w, self.h, Enum_flag.ground) then
      self.state = Air_state
      return
    end
  end

  self:handle_vert_input(1)

  if btnp(5) then
    if self.flipx then
      self:jump(self.x, self.y + 4)
    else
      self:jump(self.x + 7, self.y + 4)
    end
    return
  end

  self.dy = mid(-self.max_dy, self.dy, self.max_dy)

  self:update_is_running()
end

function Climbing_state:animate()
  if self.isRunning then
    if time() - self.anim > 0.1 then
      self.anim = time()
      self.sp += 1
      if self.sp > 4 then
        self.sp = 3
      end
    end
  else
    self.sp = 3
  end
end
