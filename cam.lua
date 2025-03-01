function init_cam()
  return {
    x = 0,
    y = 0,
    update = function(self)
      self.x = flr((Player.x + (Player.w / 2)) / 128) * 128
      self.y = flr((Player.y + (Player.h / 2)) / 128) * 128
    end,
    draw = function(self)
      camera(self.x, self.y)
    end,
  }
end
