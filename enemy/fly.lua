Fly = {
  enum_color = {
    light = 0,
    dark = 1,
  },
  animate = function(self)
    local anim_speed = 1 - self.speed
    if time() - self.anim > anim_speed then
      self.anim = time()
      self.sp += 1
      if self.sp > self.end_sp then
        self.sp = self.start_sp
      end
    end
  end,
  update = function(self, index)
    Enemy.move(self)

    local hitbox = self:get_hitbox()
    Enemy.check_player_collision(hitbox, index)
  end,
  gen_light_fly = function(tile_target_queue)
    Bug_count:inc_total()

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      add(pixel_target_queue, point)
    end

    local fly = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 8,
      h = 5,
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 62,
      start_sp = 62,
      end_sp = 63,
      anim = 0,
      flipx = false,
      flipy = false,
      update = Fly.update,
      draw = function(self)
        Fly.animate(self)
        spr(self.sp, self.x, self.y, 1, 1, self.flipx, false)
      end,
      move = Fly.move,
      get_hitbox = function(self)
        return {
          x = self.x,
          y = self.y,
          w = self.w,
          h = self.h,
        }
      end,
    }

    add(Enemy_array, fly)
  end,
  gen_dark_fly = function(tile_target_queue)
    Bug_count:inc_total()

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      add(pixel_target_queue, point)
    end

    local fly = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 8,
      h = 5,
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 62,
      start_sp = 62,
      end_sp = 63,
      anim = 0,
      flipx = false,
      flipy = false,
      update = Fly.update,
      draw = function(self)
        Fly.animate(self)
        pal({ [4] = 1, [9] = 1 })
        spr(self.sp, self.x, self.y, 1, 1, self.flipx, false)
        pal()
      end,
      move = Fly.move,
      get_hitbox = function(self)
        return {
          x = self.x,
          y = self.y,
          w = self.w,
          h = self.h,
        }
      end,
    }

    add(Enemy_array, fly)
  end,
}
