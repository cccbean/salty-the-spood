Cricket = {
  enum_orientation = {
    ground = 0,
    ceiling = 1,
    left_climbing = 2,
    right_climbing = 3,
  },
  update = function(self, index)
    if self.sp < 40 then
      if flr(self.anim % 4) == 1 then
        self.flipy = true
      elseif flr(self.anim % 4) == 3 then
        self.flipy = false
      end
    else
      if flr(self.anim % 4) == 1 then
        self.flipx = false
      elseif flr(self.anim % 4) == 3 then
        self.flipx = true
      end
    end

    local detection_box = self:get_detection_box()
    if Collide_objects(detection_box, Player) then
      self.is_moving = true
      self.sp = 44
    end

    if self.is_moving then
      Cricket.move(self)
    end

    local hitbox = self:get_hitbox()
    Enemy.check_player_collision(hitbox, index)
  end,
  move = function(self)
    local target_x = self.target_queue[self.target_index].x
    local x = flr(self.x)
    if x < target_x then
      self.x += self.speed
      self.flipx = false

      if self.x > target_x then
        self.x = target_x
      end
    elseif x > target_x then
      self.x -= self.speed
      self.flipx = true

      if self.x < target_x then
        self.x = target_x
      end
    end

    local target_y = self.target_queue[self.target_index].y
    local y = flr(self.y)
    if y < target_y then
      self.y += self.speed
      self.flipy = true

      if self.y > target_y then
        self.y = target_y
      end
    elseif y > target_y then
      self.y -= self.speed
      self.flipy = false

      if self.y < target_y then
        self.y = target_y
      end
    end

    if x == target_x and y == target_y then
      self.is_moving = false
      self.state = self.target_queue[self.target_index].state
      Cricket.handle_state_change(self)
      if self.target_index == #self.target_queue then
        self.target_index = 1
      else
        self.target_index += 1
      end
    end
  end,
  get_horizontal_hitbox = function(self)
    return {
      x = self.x,
      y = self.y + 8,
      w = self.w,
      h = self.h,
    }
  end,
  get_vertical_hitbox = function(self)
    return {
      x = self.x,
      y = self.y,
      w = self.w,
      h = self.h,
    }
  end,
  change_to_ground = function(self)
    self.w = 16
    self.h = 8
    self.sp = 40
    self.start_sp = 40
    self.end_sp = 42
    self.flipy = false
    self.get_hitbox = Cricket.get_horizontal_hitbox
  end,
  change_to_ceiling = function(self)
    self.w = 16
    self.h = 8
    self.sp = 40
    self.start_sp = 40
    self.end_sp = 42
    self.flipy = true
    self.get_hitbox = Cricket.get_horizontal_hitbox
  end,
  change_to_left_climbing = function(self)
    self.w = 8
    self.h = 16
    self.sp = 8
    self.start_sp = 8
    self.end_sp = 10
    self.flipx = true
    self.get_hitbox = Cricket.get_vertical_hitbox
  end,
  change_to_right_climbing = function(self)
    self.w = 8
    self.h = 16
    self.sp = 8
    self.start_sp = 8
    self.end_sp = 10
    self.flipx = false
    self.get_hitbox = Cricket.get_vertical_hitbox
  end,
  handle_state_change = function(self)
    if self.state == Cricket.enum_orientation.ground then
      Cricket.change_to_ground(self)
    elseif self.state == Cricket.enum_orientation.ceiling then
      Cricket.change_to_ceiling(self)
    elseif self.state == Cricket.enum_orientation.left_climbing then
      Cricket.change_to_left_climbing(self)
    elseif self.state == Cricket.enum_orientation.right_climbing then
      Cricket.change_to_right_climbing(self)
    end
  end,

  gen_light_cricket = function(tile_target_queue)
    Bug_count:inc_total()

    local pixel_target_queue = {}
    for _, tile_point in ipairs(tile_target_queue) do
      local point = {}
      point.x = Get_pxl_from_tile(tile_point[1])
      point.y = Get_pxl_from_tile(tile_point[2])
      point.state = tile_point[3]
      add(pixel_target_queue, point)
    end

    local cricket = {
      x = pixel_target_queue[1].x,
      y = pixel_target_queue[1].y,
      w = 16,
      h = 8,
      speed = 8,
      target_index = 2,
      target_queue = pixel_target_queue,
      sp = 40,
      start_sp = 40,
      end_sp = 42,
      anim = 0,
      flipx = false,
      flipy = false,
      state = pixel_target_queue[1].state,
      is_moving = false,
      update = Cricket.update,
      draw = function(self)
        if not self.is_moving then
          local anim_speed = 0.5
          Enemy.animate(self, anim_speed, 2)
        end
        spr(self.sp, self.x, self.y, 2, 2, self.flipx, self.flipy)
      end,
      move = Cricket.move,
      get_hitbox = function(self)
        return {
          x = self.x,
          y = self.y + 8,
          w = self.w,
          h = self.h,
        }
      end,
      get_detection_box = function(self)
        if self.state == Cricket.enum_orientation.ground or self.state == Cricket.enum_orientation.ceiling then
          if self.flipx then
            return {
              x = self.x - 16,
              y = self.y,
              w = self.w,
              h = self.h + 8,
            }
          else
            return {
              x = self.x + 16,
              y = self.y,
              w = self.w,
              h = self.h + 8,
            }
          end
        elseif
          self.state == Cricket.enum_orientation.left_climbing
          or self.state == Cricket.enum_orientation.right_climbing
        then
          if self.flipy then
            return {
              x = self.x,
              y = self.y + 16,
              w = self.w + 8,
              h = self.h,
            }
          else
            return {
              x = self.x,
              y = self.y - 16,
              w = self.w + 8,
              h = self.h,
            }
          end
        end
      end,
    }

    add(Enemy_array, cricket)
  end,
}
