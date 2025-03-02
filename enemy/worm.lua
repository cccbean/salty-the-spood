function Gen_worm(x, y, end_x, end_y, is_upside_down)
  local is_moving_x = (x ~= end_x)
  local sp
  if is_moving_x then
    sp = 30
  else
    sp = 14
  end

  return {
    sp = sp,
    flipx = false,
    flipy = is_upside_down,
    anim = 0,
    x = x,
    y = y,
    w = 8,
    h = 4,
    speed = rnd({ 0.4, 0.5, 0.6 }),
    start_x = x,
    start_y = y,
    end_x = end_x,
    end_y = end_y,
    is_moving_to_end = true,
    is_moving_x = is_moving_x,
    update = function(self, index)
      if self.is_moving_x then
        self:move_x()
      else
        self:move_y()
      end

      self:check_player_collision(index)
    end,
    draw = function(self)
      local anim_speed = 1 - self.speed
      if self.sp == 30 or self.sp == 31 then
        if time() - self.anim > anim_speed then
          self.anim = time()
          self.sp += 1
          if self.sp > 31 then
            self.sp = 30
          end
        end
      else
        if time() - self.anim > anim_speed then
          self.anim = time()
          self.sp += 1
          if self.sp > 15 then
            self.sp = 14
          end
        end
      end

      spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)
    end,
    move_x = function(self)
      local x = flr(self.x)
      if self.is_moving_to_end then
        if x < self.end_x then
          self.x += self.speed
          self.flipx = false
        elseif x > self.end_x then
          self.x -= self.speed
          self.flipx = true
        else
          self.is_moving_to_end = false
        end
      else
        if x < self.start_x then
          self.x += self.speed
          self.flipx = false
        elseif x > self.start_x then
          self.x -= self.speed
          self.flipx = true
        else
          self.is_moving_to_end = true
        end
      end
    end,
    move_y = function(self)
      local y = flr(self.y)
      if self.is_moving_to_end then
        if y < self.end_y then
          self.y += self.speed
          self.flipy = true
        elseif y > self.end_y then
          self.y -= self.speed
          self.flipy = false
        else
          self.is_moving_to_end = false
        end
      else
        if y < self.start_y then
          self.y += self.speed
          self.flipy = true
        elseif y > self.start_y then
          self.y -= self.speed
          self.flipy = false
        else
          self.is_moving_to_end = true
        end
      end
    end,
    check_player_collision = function(self, index)
      -- FIX: I think something's slightly off with the collision
      if Collide_objects(self, Player) then
        if abs(Player.dx) > 2 or abs(Player.dy) > 2 then
          deli(Enemy_array, index)
        end
      end
    end,
  }
end
