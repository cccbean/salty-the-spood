-- FIX: collision boxes aren't pixel perfect
Worm = {
  enum_color = {
    green = 0,
    pink = 1,
    yellow = 2,
    blue = 3,
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
  draw_green_worm = function(self)
    Worm.animate(self)
    spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)
  end,
  draw_pink_worm = function(self)
    Worm.animate(self)
    pal({ [11] = 15, [3] = 14 })
    spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)
    pal()
  end,
  draw_blue_worm = function(self)
    Worm.animate(self)
    pal({ [11] = 12, [3] = 3 })
    spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)
    pal()
  end,
  draw_yellow_worm = function(self)
    Worm.animate(self)
    pal({ [11] = 10, [3] = 9 })
    spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)
    pal()
  end,
  assign_draw_func = function(enum_worm_color)
    if enum_worm_color == Worm.enum_color.pink then
      return Worm.draw_pink_worm
    elseif enum_worm_color == Worm.enum_color.yellow then
      return Worm.draw_yellow_worm
    elseif enum_worm_color == Worm.enum_color.blue then
      return Worm.draw_blue_worm
    else
      return Worm.draw_green_worm
    end
  end,
  update = function(self, index)
    self:move()
    Enemy.check_player_collision(self, index)
  end,
  -- FIX: diagonal movement is a bit wonky, may have to do with speed?
  move = function(self)
    local target_x = self.target_queue[self.target_index].x
    local x = flr(self.x)
    if x < target_x then
      self.x += self.speed
      self.flipx = false
    elseif x > target_x then
      self.x -= self.speed
      self.flipx = true
    end

    local target_y = self.target_queue[self.target_index].y
    local y = flr(self.y)
    if y < target_y then
      self.y += self.speed
      self.flipy = true
    elseif y > target_y then
      self.y -= self.speed
      self.flipy = false
    end

    if x == target_x and y == target_y then
      if self.target_index == #self.target_queue then
        self.target_index = 1
      else
        self.target_index += 1
      end
    end
  end,
  gen_ground_worm = function(tile_target_queue, enum_worm_color)
    Bug_count:inc_total()

    local draw_func = Worm.assign_draw_func(enum_worm_color)

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      add(pixel_target_queue, point)
    end

    local worm = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 8,
      h = 4,
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 30,
      start_sp = 30,
      end_sp = 31,
      anim = 0,
      flipx = false,
      flipy = false,
      update = Worm.update,
      draw = draw_func,
      move = Worm.move,
    }

    add(Enemy_array, worm)
  end,
  gen_ceiling_worm = function(tile_target_queue, enum_worm_color)
    Bug_count:inc_total()

    local draw_func = Worm.assign_draw_func(enum_worm_color)

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      add(pixel_target_queue, point)
    end

    local worm = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 8,
      h = 4,
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 30,
      start_sp = 30,
      end_sp = 31,
      anim = 0,
      flipx = false,
      flipy = true,
      update = Worm.update,
      draw = draw_func,
      move = Worm.move,
    }

    add(Enemy_array, worm)
  end,
  gen_left_climbing_worm = function(tile_target_queue, enum_worm_color)
    Bug_count:inc_total()

    local draw_func = Worm.assign_draw_func(enum_worm_color)

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      add(pixel_target_queue, point)
    end

    local worm = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 4,
      h = 8,
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 14,
      start_sp = 14,
      end_sp = 15,
      anim = 0,
      flipx = true,
      flipy = false,
      update = Worm.update,
      draw = draw_func,
      move = Worm.move,
    }

    add(Enemy_array, worm)
  end,
  gen_right_climbing_worm = function(tile_target_queue, enum_worm_color)
    Bug_count:inc_total()

    local draw_func = Worm.assign_draw_func(enum_worm_color)

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      add(pixel_target_queue, point)
    end

    local worm = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 4,
      h = 8,
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 14,
      start_sp = 14,
      end_sp = 15,
      anim = 0,
      flipx = false,
      flipy = false,
      update = Worm.update,
      draw = draw_func,
      move = Worm.move,
    }

    add(Enemy_array, worm)
  end,
}
