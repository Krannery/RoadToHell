function _init()
    player={
      sp=1,
      x=16,
      y=488,
      w=16,
      h=16,
      flp=false,
      dx=0,
      dy=0,
      max_dx=2,
      max_dy=3,
      acc=0.5,
      boost=5,
      fart_boost=4,
      fart_boost_falling=8,
      anim=0,
      running=false,
      jumping=false,
      falling=false,
      sliding=false,
      landed=false,
      -- fart cooldown properties
      fart_cooldown=1,       -- seconds between boosts
      last_fart_time=-0.5      -- init so boost ready immediately
    }

    --vars
    gravity = 0.4
    ghost_gravity = 2
    friction = 0.85

    collision_enabled = true
    ghost_time   = nil

    --enemy array and calling the function
    enemies = {}
    make_enemy()
    make_enemy({  
      x=240,
      y=400,
      dx=4
    })
    
    --simple camera
    cam_x=0
  
    --map limits
    map_start=0
    map_end=1024

    -- win/lose flags
    victory = false
    defeat = false
end

--music
music(2)

local SPR_GHOST = 41 -- ghost sprite for when little guy gets hit by big angry demon
normal_icon = 37
ghost_icon  = 39
ui_icon = normal_icon

function player_ghost()
    collision_enabled = false
    ghost_time = time() + 0.5 -- timer for ghosting
    -- ghost icon 
    ui_icon = ghost_icon
    sfx(4)

    -- remember prev sprite and set ghost
    player._prev_sp = player.sp
    player.sp = SPR_GHOST
end
