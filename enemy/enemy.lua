Enemy = {
  check_player_collision = function(enemy, enemy_index)
    if Collide_objects(enemy, Player) then
      if abs(Player.dx) > 2 or abs(Player.dy) > 2 then
        Bug_count:inc_hunted()
        deli(Enemy_array, enemy_index)

        Pacifist_run = false
      end
    end
  end,
  -- FIX: diagonal movement is a bit wonky, may have to do with speed? it doesn't always happen,
  --      I'm gonna leave it and see how the fly likes it
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
}
