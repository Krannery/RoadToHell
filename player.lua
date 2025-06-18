function player_update()
    -- gravity & friction
    local g = gravity
    if ghost_time and time() <= ghost_time then
      g = ghost_gravity
    end
    player.dy = player.dy + g
    player.dx = player.dx * friction

    -- horizontal controls
    if btn(⬅️) then
      player.dx -= player.acc
      player.running = true
      player.flp = true
    elseif btn(➡️) then
      player.dx += player.acc
      player.running = true
      player.flp = false
    end

    -- slide
    if player.running and not btn(⬅️) and not btn(➡️)
      and not player.falling and not player.jumping then
      player.running = false
      player.sliding = true
    end

    -- jump
    if btnp(⬆️) and player.landed then
      player.dy -= player.boost
      player.landed = false
    end

      -- ground fart (visual)
    if btnp(❎)
      and player.landed
      and not player.running
      and not player.sliding then
      player.sp = 13
      sfx(1)
      spawn_fart()
    end

    -- air fart with cooldown
    if btnp(❎) and player.jumping
      and time() - player.last_fart_time >= player.fart_cooldown then
        player.dy -= player.fart_boost
        sfx(1)
        player.last_fart_time = time()
        spawn_fart(-4, -6)
    end

    -- falling fart with cooldown
    if btnp(❎) and player.falling
      and time() - player.last_fart_time >= player.fart_cooldown then
        player.dy -= player.fart_boost_falling
        sfx(1)
        player.last_fart_time = time()
        spawn_fart(-4, -6)
    end

    -- vertical collisions
    if player.dy > 0 then
      player.falling = true
      player.landed = false
      player.jumping = false
      player.dy = limit_speed(player.dy, player.max_dy)
      if collide_map(player, "down", 0) then
        player.landed = true
        player.falling = false
        player.dy = 0
        player.y -= ((player.y + player.h + 1) % 8) - 1
      end
    elseif player.dy < 0 then
      player.jumping = true
      if collide_map(player, "up", 1) then player.dy = 0 end
    end

    -- horizontal collisions
    if player.dx < 0 then
      player.dx = limit_speed(player.dx, player.max_dx)
      if collide_map(player, "left", 1) then player.dx = 0 end
    elseif player.dx > 0 then
      player.dx = limit_speed(player.dx, player.max_dx)
      if collide_map(player, "right", 1) then player.dx = 0 end
    end

    -- stop sliding
    if player.sliding and (abs(player.dx) < .2 or player.running) then
      player.dx = 0
      player.sliding = false
    end

    -- apply motion
    player.x += player.dx
    player.y += player.dy

    -- map boundaries
    player.x = mid(map_start, player.x, map_end - player.w)
end