function _init()
  Cam = init_cam()
  Enemy_array = {
    Gen_worm(Get_pxl_from_tile(5), Get_pxl_from_tile(14), Get_pxl_from_tile(7), Get_pxl_from_tile(14)),
    Gen_worm(Get_pxl_from_tile(2), Get_pxl_from_tile(7), Get_pxl_from_tile(1), Get_pxl_from_tile(7)),
  }

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
  Player:draw()

  for i, v in ipairs(Enemy_array) do
    v:draw()
  end

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
