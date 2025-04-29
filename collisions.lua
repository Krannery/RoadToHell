        -- global toggle for collision
collision_enabled = true
ghost_time   = nil 

function collide_map(obj, aim, flag)

    if not collision_enabled then
        return false
    end

    local x = obj.x  local y = obj.y
    local w = obj.w  local h = obj.h
    local x1, y1, x2, y2 = 0, 0, 0, 0

    if aim == "left" then
        x1 = x - 1      y1 = y
        x2 = x          y2 = y + h - 1
    elseif aim == "right" then
        x1 = x + w - 1  y1 = y
        x2 = x + w      y2 = y + h - 1
    elseif aim == "up" then
        x1 = x + 2      y1 = y - 1
        x2 = x + w - 3  y2 = y
    elseif aim == "down" then
        x1 = x + 2      y1 = y + h
        x2 = x + w - 3  y2 = y + h
    end

    x1 = flr(x1 / 8)  y1 = flr(y1 / 8)
    x2 = flr(x2 / 8)  y2 = flr(y2 / 8)

    return fget(mget(x1, y1), flag)
        or fget(mget(x1, y2), flag)
        or fget(mget(x2, y1), flag)
        or fget(mget(x2, y2), flag)
end