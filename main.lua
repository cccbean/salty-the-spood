function _init()
  Cam = init_cam()

  -- debug info
  X1 = 0
  Y1 = 0
  X2 = 5
  Y2 = 5
  --
end

function _update()
  Player:update()
  Cam:update()
end

function _draw()
  cls()
  map()
  Cam:draw()
  Player:draw()

  -- debug info
  rect(X1, Y1, X2, Y2, 7)
  print("x = " .. Player.x, Cam.x, Cam.y, 7)
  print("y = " .. Player.y)
  print("dx = " .. Player.dx)
  print("dy = " .. Player.dy)
  print("state = " .. Player.state.value)
  print("web dist = " .. Player.web.distance)
  print("angle = " .. Player.web.angle)
  print("dangle = " .. Player.web.dangle)
  --
end
