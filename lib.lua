function Get_distance(x1, y1, x2, y2)
  return flr(sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2))
end

function Round(x)
  if x - flr(x) < 0.5 then
    return flr(x)
  else
    return ceil(x)
  end
end

function Collide_map(x, y, w, h, flag)
  local x1 = x / 8
  local y1 = y / 8
  local x2 = (x + w - 1) / 8
  local y2 = (y + h - 1) / 8

  -- debug info
  X1 = x1 * 8
  Y1 = y1 * 8
  X2 = x2 * 8
  Y2 = y2 * 8
  --

  return fget(mget(x1, y1), flag) or fget(mget(x1, y2), flag) or fget(mget(x2, y1), flag) or fget(mget(x2, y2), flag)
end

function Collide_objects(rect1, rect2)
  return (
    rect1.x < rect2.x + rect2.w
    and rect1.x + rect1.w > rect2.x
    and rect1.y < rect2.y + rect2.h
    and rect1.y + rect1.h > rect2.y
  )
end

function Get_pxl_from_tile(tilecord)
  return tilecord * 8
end

function Animation_player(self)
  local anim_speed = 1 - self.speed
  if time() - self.anim > anim_speed then
    self.anim = time()
    self.sp += 1
    if self.sp > self.end_sp then
      self.sp = self.start_sp
    end
  end
end
