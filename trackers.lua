-- TODO: add screen that displays this info from menuitem and endgame
-- TODO: save achivements and best time between runs
-- TODO: make question marks appear as an actual counter after you beat the game
Bug_count = {
  hunted = 0,
  total = 0,
  draw_timer = 0,
  inc_hunted = function(self)
    self.hunted += 1
  end,
  inc_total = function(self)
    self.total += 1
  end,
  draw_bug_count = function(self)
    if self.draw_timer > 0 then
      rectfill(Cam.x + 95, Cam.y + 1, Cam.x + 95 + 30, Cam.y + 1 + 6, 1)
      print(Bug_count.hunted .. "/" .. Bug_count.total .. " ?/?", Cam.x + 96, Cam.y + 2, 7)
      self.draw_timer -= 1
    end
  end,
}

Easter_egg = false

Deathless_run = true

Pacifist_run = true

-- speedrun achievement?

-- at achievement screen, display time()
-- pico8 func that tracks time since cart started
