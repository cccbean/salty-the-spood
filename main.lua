function _init()
  Cam = init_cam()
  Enemy_array = {}
  -- first map
  Gen_worm(10, 30, 12, 30, false)
  Gen_worm(5, 25, 3, 25, false)
  Gen_worm(9, 20, 10, 20, true)
  --

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

  for i, v in ipairs(Enemy_array) do
    v:update(i)
  end
end

function _draw()
  cls()
  map()
  Cam:draw()

  for i, v in ipairs(Enemy_array) do
    v:draw()
  end

  Player:draw()

  -- debug info
  -- rect(X1, Y1, X2, Y2, 7)
  -- print("x = " .. Player.x, Cam.x, Cam.y, 7)
  -- print("y = " .. Player.y)
  -- print("dx = " .. Player.dx)
  -- print("dy = " .. Player.dy)
  -- print("state = " .. Player.state.value)
  -- print("web dist = " .. Player.web.distance)
  -- print("angle = " .. Player.web.angle)
  -- print("dangle = " .. Player.web.dangle)
  --
end
