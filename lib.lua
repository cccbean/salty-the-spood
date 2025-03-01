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
