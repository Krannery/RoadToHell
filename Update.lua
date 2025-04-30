function _update()
  
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

  --camera…
  cam_y = player.y - 59
  cam_x = mid(map_start, player.x-64+(player.w/2), map_end-128)
  camera(cam_x, cam_y)
end


    