function _update()
  
  -- freeze everything once we’ve won
  if victory then
    -- let player restart
    if btnp(❎) then
      _init()
      music(2)   -- back to your normal level track
    end
    return
  end

  if defeat then
    if btnp(❎) then
      _init()
      music(2)  -- back to normal track
    end
    return
  end

  --physics & animation
  player_update()
  player_animate()

  -- force ghost sprite during ghosting
  if ghost_time then
    player.sp = SPR_GHOST
  end

  --expire ghost mode before we check collisions
  if ghost_time and time() > ghost_time then
    collision_enabled = true
    ghost_time   = nil
    if player._prev_sp then
      player.sp       = player._prev_sp
      player._prev_sp = nil
      ui_icon      = normal_icon
    end
  end

  --update enemies
  for e in all(enemies) do
    e:update()
  end

  --check for the one‐time collision trigger
  if not ghost_time then
    for e in all(enemies) do
      if player.x < e.x + e.w
      and player.x + player.w > e.x
      and player.y < e.y + e.h
      and player.y + player.h > e.y then
        player_ghost()
        break  -- stop checking once we hit one
      end
    end
  end

  -- check for reaching the princess
  if not victory
    and player.x   < 369+16
    and player.x+player.w > 369
    and player.y   < 104+16
    and player.y+player.h > 104 then

    victory = true
    music(3)   -- play your victory soundtrack
  end

  -- check for falling off the map
  if not defeat
    and player.y > 640 then     -- 64px is where the abyss starts
    defeat = true
    music(-1)
    sfx(5)                    -- your “loss” tune
  end
  
  --camera…
  cam_y = player.y - 59
  cam_x = mid(map_start, player.x-64+(player.w/2), map_end-128)
  camera(cam_x, cam_y)
end


    