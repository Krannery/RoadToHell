-- enemy.lua

function make_enemy(params)
    local e = {
        x = 160,
        y = 400,
        w = 16,
        h = 16,
        dx = 1,                              
        _start_x = nil,                     
        range        = 40,                 
        walk_frames  = {33, 35},          
        update       = enemy_update,
    }
    for k,v in pairs(params or {}) do e[k]=v end
    add(enemies, e)
    return e
end

function fenemy_update(self)

    -- initialise patrol
    if not self._start_x then
        self._start_x = self.x
    end

    -- patrol movement
    self.x = self.x + self.dx
    if self.x >= self._start_x + self.range then
        self.x  = self._start_x + self.range
        self.dx = -self.dx
    elseif self.x <= self._start_x then
        self.x  = self._start_x
        self.dx = -self.dx
        
end

    -- pick one of the two frames based on time:
    -- multiply time() by the desired fps (e.g. 4), floor it, mod 2
    local fi = flr(time() * 4) % 2 + 1
    self.sp   = self.walk_frames[fi]

    -- flip horizontally when moving left
    self.flip = (self.dx < 0)
end
