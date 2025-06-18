function print_centered(txt, x, y, col)
    -- assume 4px/char width
  local w = #txt * 4
    print(txt, x - w/2, y, col)
end

function _draw()
    cls(1)
    camera(0,0)

    if victory then
            rectfill(0,0,128,128,0)
            if game.apples >= game.apple_goal then
                print_centered("WHY DID U EAT SO MANY BEANS?",64,48,11)
            else
                print_centered("DID YOU NOT EAT YOURS BEANS?",64,48, 8)
            end
            print_centered("press ❎ to play again",64,64,7)
        return
    end

    if defeat then
            rectfill(0,0,128,128,0)
            print_centered("YOU FELL INTO THE ABYSS", 64, 48, 7)
            print_centered("press ❎ to try again", 64, 64, 6)
        return
    end

    -- world draw
    camera(cam_x, cam_y)
    map(0,0)
    particles_draw()
    spr(player.sp, player.x, player.y, 2, 2, player.flp)
    spr(43, 369, 104, 2, 2) -- princess
    for e in all(enemies) do spr(e.sp, e.x, e.y, 2, 2, e.flip) end

    for a in all(apples) do
        spr(SPR_APPLE, a.x, a.y)
    end

    -- UI draw
    camera(0,0)
    spr(ui_icon, 4, 4, 2, 2)

    -- draw apple counter at top-right
    local txt = game.apples.."/"..game.apple_goal
    local text_width = #txt * 4 
    local icon_w = 12           
    local padding = 2
    local x_txt = 128 - text_width - icon_w - padding

    -- counter
    print(txt, x_txt, 10, 7)
    local icon_y = 8
    spr(SPR_APPLE, 128 - icon_w, icon_y)

    -- fart cooldown meter 
    local meter_x, meter_y = 24, 10
    local meter_w, meter_h = 30, 3
    local cd = time() - player.last_fart_time
    local fill = flr(mid(0, (cd / player.fart_cooldown) * meter_w, meter_w))
    rect(meter_x-1, meter_y-1, meter_x+meter_w+1, meter_y+meter_h+1, 7)
    rectfill(meter_x, meter_y, meter_x + fill, meter_y + meter_h, 3)


end

function player_animate()
    if player.jumping then
        player.sp = (time() - player.last_fart_time < 0.05) and 45 or 9
    elseif player.falling then
        player.sp = (time() - player.last_fart_time < 0.05) and 45 or 9
    elseif player.sliding then
        player.sp = 11
    elseif player.running then
        if time() - player.anim > .1 then
            player.anim = time()
            player.sp += 2
            if player.sp > 7 then player.sp = 5 end
        end
    else
        if time() - player.anim > .3 then
            player.anim = time()
            player.sp += 2
            if player.sp > 3 then player.sp = 1 end
        end
    end
end

function limit_speed(num, maximum)
    return mid(-maximum, num, maximum)
end