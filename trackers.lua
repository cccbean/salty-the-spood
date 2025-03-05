-- TODO: add screen that displays this info from menuitem and endgame
-- TODO: save achivements and best time between runs
Bug_count = {
  hunted = 0,
  total = 0,
  inc_hunted = function(self)
    self.hunted += 1
  end,
  inc_total = function(self)
    self.total += 1
  end,
}

Easter_egg = false

Deathless_run = true

Pacifist_run = true

-- speedrun achievement?

-- at achievement screen, display time()
-- pico8 func that tracks time since cart started
