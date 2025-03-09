Enemy = {
  animate = function(self, anim_speed, sp_inc)
    if time() - self.anim > anim_speed then
      self.anim = time()
      self.sp += sp_inc
      if self.sp > self.end_sp then
        self.sp = self.start_sp
      end
    end
  end,
  check_player_collision = function(enemy, enemy_index)
    if Collide_objects(enemy, Player) then
      if abs(Player.dx) > 2 or abs(Player.dy) > 2 then
        Bug_count:inc_hunted()
        Bug_count.draw_timer = 25
        deli(Enemy_array, enemy_index)

        Pacifist_run = false
      end
    end
  end,
  -- FIX: diagonal movement is a bit wonky, may have to do with speed? it doesn't always happen,
  --      I'm gonna leave it and see how the fly likes it
  --      OKAY, I think it's bc the animation just looks weird since the sprite is moving
  --      diagonally so discretely, I wonder why the player doesn't have this issue tho?
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
      if self.target_index == #self.target_queue then
        self.target_index = 1
      else
        self.target_index += 1
      end
    end
  end,
}
