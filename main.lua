-- TODO: bug count appears in top right corner for a bit when killing an enemy
--       0/Bug_count
--       ?/? (change question marks once game is completed once)
function _init()
  Cam = init_cam()

  Enemy_array = {}
  -- level 1
  Worm.gen_ground_worm({ { 10, 30 }, { 12, 30 } }, Worm.enum_color.pink)
  Worm.gen_ceiling_worm({ { 9, 20 }, { 10, 20 } }, Worm.enum_color.blue)
  Worm.gen_right_climbing_worm({ { 13, 19 }, { 13, 17 } }, Worm.enum_color.green)

  Fly.gen_light_fly({ { 7, 25 }, { 10, 23 } })

  Cricket.gen_light_cricket({
    { 3, 24, Cricket.enum_orientation.ground },
    { 1, 21, Cricket.enum_orientation.left_climbing },
    { 5, 17, Cricket.enum_orientation.ceiling },
    { 13, 26, Cricket.enum_orientation.right_climbing },
  })
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

  -- TODO: add level id to each enemy on gen so that they only get rendered once the
  --       player gets to that level
  for i, v in ipairs(Enemy_array) do
    v:update(i)
  end

  -- debug info
  -- printh(Bug_count.hunted .. " " .. Bug_count.total)
  --
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
