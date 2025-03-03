Enum_flag = {
  solid = 0,
  hazard = 1,
  bouncy = 2,
}

Player = {
  x = 8,
  y = 8 * 14,
  w = 8,
  h = 8,
  dx = 0,
  dy = 0,
  max_dx = 7,
  max_dy = 7,
  acc = 0.4,
  boost = 7,
  sp = 1,
  flipx = false,
  flipy = false,
  anim = 0,
  isRunning = false,
  state = Walking_state,
  web = {
    x = 0,
    y = 0,
    distance = 0,
    angle = 270,
    dangle = 0,
    max_dangle = 14,
    isVisible = false,
    update = function(self, x, y, isVis)
      self.x = x
      self.y = y
      self.isVisible = isVis
    end,
  },
}

Gravity = 0.7
Friction = 0.7

function Player:update()
  self.state.update(self)
  self:move()
end

function Player:handle_hor_input(mult)
  if btn(0) then
    self.dx -= self.acc * mult
    self.flipx = true
  end

  if btn(1) then
    self.dx += self.acc * mult
    self.flipx = false
  end
end

function Player:handle_vert_input(mult)
  if btn(2) then
    self.dy -= self.acc * mult
    self.flipy = false
  end

  if btn(3) then
    self.dy += self.acc * mult
    self.flipy = true
  end
end

function Player:jump(x, y)
  self.state = Air_state
  self.web:update(x, y, true)

  if btn(1) and btn(2) then
    self.dx += self.boost - 1
    self.dy -= self.boost - 1
  elseif btn(0) and btn(2) then
    self.dx -= self.boost - 1
    self.dy -= self.boost - 1
  elseif btn(1) and btn(3) then
    self.dx += self.boost - 1
    self.dy += self.boost
  elseif btn(0) and btn(3) then
    self.dx -= self.boost - 1
    self.dy += self.boost
  elseif btn(1) then
    self.dx += self.boost
  elseif btn(0) then
    self.dx -= self.boost
  elseif btn(3) then
    self.dy += self.boost
  elseif btn(2) then
    self.dy -= self.boost
  end
end

function Player:move()
  local move_x = Round(self.dx)
  if move_x ~= 0 then
    local sign_x = sgn(move_x)
    while move_x ~= 0 do
      if not Collide_map(self.x + sign_x, self.y, self.w, self.h, Enum_flag.solid) then
        self.x += sign_x
        move_x -= sign_x
      else
        self.dx = 0
        self.dy = 0
        self.web.dangle = 0
        self.state = Climbing_state
        self.web.isVisible = false

        if sign_x > 0 then
          self.flipx = false
        else
          self.flipx = true
        end
        break
      end
    end
  end

  local move_y = Round(self.dy)
  if move_y ~= 0 then
    local sign_y = sgn(move_y)
    while move_y ~= 0 do
      if not Collide_map(self.x, self.y + sign_y, self.w, self.h, Enum_flag.solid) then
        self.y += sign_y
        move_y -= sign_y
      else
        -- self.dx = 0
        self.dy = 0
        self.web.dangle = 0
        self.state = Walking_state
        self.web.isVisible = false

        if sign_y > 0 then
          self.flipy = false
        else
          self.flipy = true
        end
        break
      end
    end
  end
end

function Player:update_is_running()
  if Round(self.dx) == 0 and Round(self.dy) == 0 then
    self.isRunning = false
  else
    self.isRunning = true
  end
end

function Player:draw()
  self.state.animate(self)

  spr(self.sp, self.x, self.y, 1, 1, self.flipx, self.flipy)

  -- FIX: better web animation so that web can't be attached to nothing
  if self.web.isVisible then
    line(self.x, self.y, self.web.x, self.web.y, 6)
  end
  rect(self.x, self.y, self.x, self.y, 8)
  rect(self.web.x, self.web.y, self.web.x, self.web.y, 7)
end
