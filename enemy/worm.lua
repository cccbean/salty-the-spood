Worm = {
  enum_color = {
    green = 0,
    pink = 1,
    yellow = 2,
    blue = 3,
  },
  animate = function(self)
    local anim_speed = 1 - self.speed
    Enemy.animate(self, anim_speed, 1)
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
    Enemy.move(self)

    local hitbox = self:get_hitbox()
    Enemy.check_player_collision(hitbox, index)
  end,
  general_worm = function(tile_target_queue, enum_worm_color)
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
      speed = rnd({ 0.4, 0.5, 0.6 }),
      target_index = 2,
      target_queue = pixel_target_queue,
      anim = 0,
      update = Worm.update,
      draw = draw_func,
    }

    return worm
  end,
  gen_ground_worm = function(tile_target_queue, enum_worm_color)
    local worm = Worm.general_worm(tile_target_queue, enum_worm_color)

    worm.w = 8
    worm.h = 5
    worm.sp = 30
    worm.start_sp = 30
    worm.end_sp = 31
    worm.flipx = false
    worm.flipy = false
    worm.get_hitbox = function(self)
      return {
        x = self.x,
        y = self.y + 3,
        w = self.w,
        h = self.h,
      }
    end

    add(Enemy_array, worm)
  end,
  gen_ceiling_worm = function(tile_target_queue, enum_worm_color)
    local worm = Worm.general_worm(tile_target_queue, enum_worm_color)

    worm.w = 8
    worm.h = 5
    worm.sp = 30
    worm.start_sp = 30
    worm.end_sp = 31
    worm.flipx = false
    worm.flipy = true
    worm.get_hitbox = function(self)
      return {
        x = self.x,
        y = self.y,
        w = self.w,
        h = self.h,
      }
    end

    add(Enemy_array, worm)
  end,
  gen_left_climbing_worm = function(tile_target_queue, enum_worm_color)
    local worm = Worm.general_worm(tile_target_queue, enum_worm_color)

    worm.w = 5
    worm.h = 8
    worm.sp = 14
    worm.start_sp = 14
    worm.end_sp = 15
    worm.flipx = true
    worm.flipy = false
    worm.get_hitbox = function(self)
      return {
        x = self.x,
        y = self.y,
        w = self.w,
        h = self.h,
      }
    end

    add(Enemy_array, worm)
  end,
  gen_right_climbing_worm = function(tile_target_queue, enum_worm_color)
    local worm = Worm.general_worm(tile_target_queue, enum_worm_color)

    worm.w = 5
    worm.h = 8
    worm.sp = 14
    worm.start_sp = 14
    worm.end_sp = 15
    worm.anim = 0
    worm.flipx = false
    worm.flipy = false
    worm.get_hitbox = function(self)
      return {
        x = self.x + 3,
        y = self.y,
        w = self.w,
        h = self.h,
      }
    end

    add(Enemy_array, worm)
  end,
}
