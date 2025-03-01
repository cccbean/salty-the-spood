Walking_state = {
  value = 0,
}

function Walking_state:update()
  self.dx *= Friction

  -- TODO: update with other collision blocks
  if self.flipy then
    if not Collide_map(self.x, self.y - 1, self.w, self.h, Enum_flag.ground) then
      self.state = Air_state
      return
    end
  else
    if not Collide_map(self.x, self.y + 1, self.w, self.h, Enum_flag.ground) then
      self.state = Air_state
      return
    end
  end

  self:handle_hor_input(1)

  if btnp(5) then
    if self.flipy then
      self:jump(self.x, self.y)
    else
      self:jump(self.x, self.y + 7)
    end
    return
  end

  self.dx = mid(-self.max_dx, self.dx, self.max_dx)

  self:update_is_running()
end

function Walking_state:animate()
  if self.isRunning then
    if time() - self.anim > 0.1 then
      self.anim = time()
      self.sp += 1
      if self.sp > 2 then
        self.sp = 1
      end
    end
  else
    self.sp = 1
  end
end
