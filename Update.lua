function _update()
    
  particles_update()

  -- freeze everything once we’ve won
  if victory then
    -- let player restart
    if btnp(❎) then
      _init()
      music(2) 
    end
    return
  end

  if defeat then
    if btnp(❎) then
      _init()
      _draw()
      music(2)
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
    music(3)

  end

  -- check for falling off the map
  if not defeat
    and player.y > 640 then --where the abyss starts
    defeat = true
    music(-1)
    sfx(5)           
  end
  
  -- compute the normal camera position
  local base_y = mid(
    map_y_start,
    player.y - 59,
    map_y_end - 120
  )
  local base_x = mid(
    map_start,
    player.x - 64 + (player.w/2),
    map_end - 128
  )

  -- if we’re in shake time, add a small random offset
  if time() < shake_time then
    local s = shake_magnitude
    cam_x = base_x + (rnd(s*2) - s)
    cam_y = base_y + (rnd(s*2) - s)
  else
    cam_x = base_x
    cam_y = base_y
  end

  camera(cam_x, cam_y)

  --- apple collection
  for i=#apples,1,-1 do
  local a = apples[i]
  if rect_overlap(
          player.x, player.y, player.w, player.h,
          a.x,      a.y,      8,       8           
        ) then
      del(apples, a)
      game.apples += 1
      sfx(6)
    end
  end

end


    