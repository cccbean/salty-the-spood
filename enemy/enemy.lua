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
}
