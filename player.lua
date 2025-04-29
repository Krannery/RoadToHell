
function player_update()
    -- pick the right gravity
      g = gravity
    -- gravity for when ghosted
    if ghost_time and time() <= ghost_time then
      g = ghost_gravity
    end

    -- apply gravity
    player.dy = player.dy + g
    player.dx = player.dx * friction

    --controls
    if btn(⬅️) then
      player.dx-=player.acc
      player.running=true
      player.flp=true
    end
    if btn(➡️) then
      player.dx+=player.acc
      player.running=true
      player.flp=false
    end
  
    --slide
    if player.running
    and not btn(⬅️)
    and not btn(➡️)
    and not player.falling
    and not player.jumping then
      player.running=false
      player.sliding=true
    end
  
    --jump
    if btnp(⬆️) 
    and player.landed then
      player.dy-=player.boost
      player.landed=false
    end

    --fart
    if btnp(❎) 
    and player.landed
    and not player.running 
    and not player.sliding then
      player.sp=13  
      sfx(1)
    end

    --air fart
    if btnp(❎)
      and player.jumping then 
        player.dy-=player.fart_boost
        sfx(1)
        player.fart_time = time()
    end

    --air fart but when falling
    if btnp(❎) 
    and player.falling then
      player.dy-=player.fart_boost_falling
      sfx(1)
    end
  
    --check collision up and down
    if player.dy>0 then
      player.falling=true
      player.landed=false
      player.jumping=false
  
      player.dy=limit_speed(player.dy,player.max_dy)
  
      if collide_map(player,"down",0) then
        player.landed=true
        player.falling=false
        player.dy=0
        player.y-=((player.y+player.h+1)%8)-1
      end
    elseif player.dy<0 then
      player.jumping=true
      if collide_map(player,"up",1) then
        player.dy=0
      end
    end
  
    --check collision left and right
    if player.dx<0 then
  
      player.dx=limit_speed(player.dx,player.max_dx)
  
      if collide_map(player,"left",1) then
        player.dx=0
      end
    elseif player.dx>0 then
  
      player.dx=limit_speed(player.dx,player.max_dx)
  
      if collide_map(player,"right",1) then
        player.dx=0
      end
    end
  
    --stop sliding
    if player.sliding then
      if abs(player.dx)<.2
      or player.running then
        player.dx=0
        player.sliding=false
      end
    end
  
    player.x+=player.dx
    player.y+=player.dy
  
    --limit player to map
    if player.x<map_start then
      player.x=map_start
    end
    if player.x>map_end-player.w then
      player.x=map_end-player.w
    end
  end
  
