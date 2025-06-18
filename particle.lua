
pi = 3.14159265358979
particles = {}

-- call once at start
    function particles_init()
    particles = {}
    end

-- call every frame before your camera logic
    function particles_update()
    for i=#particles,1,-1 do
        local p = particles[i]
        p.x += p.dx
        p.y += p.dy
        p.dy += (p.gravity or 0)
        p.ttl -= 1
        if p.ttl <= 0 then
        del(particles, p)
        end
    end
    end

    function particles_draw()
        for p in all(particles) do
        -- draw each particle at exactly p.color
        circfill(p.x, p.y, p.size or 1, p.color)
        end
    end

    function spawn_particles(x, y, count, opts)
    for i=1,count do
        local angle = rnd() * (opts.spread or 1) * 2 * pi - (opts.spread or 1)*pi
        local spd   = rnd(opts.speed_max-opts.speed_min) + opts.speed_min
        local vx    = cos(angle) * spd
        local vy    = sin(angle) * spd
        add(particles, {
        x      = x + (opts.x_off or 0),
        y      = y + (opts.y_off or 0),
        dx     = vx,
        dy     = vy,
        gravity= opts.gravity or 0.1,
        ttl    = flr(rnd(opts.ttl_max-opts.ttl_min) + opts.ttl_min),
        init_ttl = flr(rnd(opts.ttl_max-opts.ttl_min) + opts.ttl_min),
        size   = opts.size or 1,
        color  = opts.color or 7
        })
    end
    end

function spawn_fart(off_x, off_y)
    -- if you passed nil, fall back to your defaults:
    local OFFSET_X = off_x or -6     
    local OFFSET_Y = off_y or -4  

    -- anchor at bottom center of player
    local x0 = player.x + player.w/2
    local y0 = player.y + player.h

    -- apply flipped X offset
    if player.flp then
        x0 -= OFFSET_X
    else
        x0 += OFFSET_X
    end
    y0 += OFFSET_Y

    -- determine how many particles to spawn:
    local base = 10
    local extra = (game.apples or 0) * 50
    local count = base + extra

    -- decide “behind” direction
    local dir = player.flp and -1 or 1

    for i=1,count do
        local speed = rnd() * (1.5 - 0.2) + 0.2
        add(particles, {
        x        = x0,
        y        = y0,
        dx       = -dir * speed,
        dy       = rnd() * 0.8 - 0.4,
        gravity  = 0.001,
        ttl      = flr(rnd(50 - 15) + 15),
        init_ttl = flr(rnd(50 - 15) + 15),
        size     = 2,
        color    = 3
        })
    end
end

function spawn_hit(x,y)
    spawn_particles(
        x, y,
        20, {               
        speed_min = 1,    
        speed_max = 2,
        gravity   = 0.1,  
        ttl_min   = 10,   
        ttl_max   = 20,
        size      = 1,
        color     = 6,   
        spread    = 1     
        }
    )
end

