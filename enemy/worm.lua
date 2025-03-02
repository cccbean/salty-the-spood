function Gen_worm(x, y, end_x, end_y)
  return {
    sp = 30,
    flipx = false,
    flipy = false,
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
    update = function(self, index)
      self:move()
      self:check_player_collision(index)
    end,
    draw = function(self)
      if time() - self.anim > 0.4 then
        self.anim = time()
        self.sp += 1
        if self.sp > 31 then
          self.sp = 30
        end
      end

      spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)
    end,
    move = function(self)
      -- TODO: this can be refactored for sure, waiting to see how this will tie in to
      --       other entities
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
    check_player_collision = function(self, index)
      if Collide_objects(self, Player) then
        deli(Enemy_array, index)
      end
    end,
  }
end
