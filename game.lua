local SPR_APPLE = 74   -- choose an unused sprite index

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
      fart_boost=3,
      fart_boost_falling=6,
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
    
    game = {}
    game.apples = 0
    game.apple_goal = 3

    --vars
    gravity = 0.4
    ghost_gravity = 2
    friction = 0.85

    collision_enabled = true
    ghost_time   = nil

    --enemy a
    enemies = {}
    make_enemy(
      {  
        dx=1,
        range=16,})

    make_enemy({  
      x=240,
      y=400,})

    make_enemy({  
      x=480,
      y=312,
      dx=2,})

    fenemies = {}
    make_fenemy({  
      x=440,
      y=280,
      dx=2,
      range=80,})

    
  -- simple camera
    cam_x = 0

  -- horizontal map limits (in pixels)
    map_start = 0
    map_end   = 1024

  -- vertical map limits (in pixels)
    map_y_start = 0
    map_y_end   = 512   -- e.g. 64 tiles × 8px

    -- win/lose flags
    victory = false
    defeat = false

  apples = {}
    for tx=0,127 do
      for ty=0,63 do
          if mget(tx,ty)==SPR_APPLE then
            add(apples,{ x=tx*8, y=ty*8 })
            mset(tx,ty,0)
      end
    end
  end


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
