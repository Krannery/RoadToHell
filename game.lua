
function _init()
    player={
      sp=1,
      x=59,
      y=59,
      w=8,
      h=8,
      flp=false,
      dx=0,
      dy=0,
      max_dx=2,
      max_dy=3,
      acc=0.5,
      boost=4,
      anim=0,
      running=false,
      jumping=false,
      falling=false,
      sliding=false,
      landed=false
    }
  
    gravity=0.3
    friction=0.85
  
    --simple camera
    cam_x=0
  
    --map limits
    map_start=0
    map_end=1024
  end
  -->8
  --update and draw
  
  function _update()
    player_update()
    player_animate()
  
    --simple camera
    cam_x=player.x-64+(player.w/2)
    if cam_x<map_start then
       cam_x=map_start
    end
    if cam_x>map_end-128 then
       cam_x=map_end-128
    end
    camera(cam_x,0)
  end
  
  function _draw()
    cls()
    map(0,0)
    spr(player.sp,player.x,player.y,2,2,player.flp)
  end