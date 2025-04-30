
function _draw()
    cls(1)

    --camera
    camera(cam_x, cam_y)
    

    map(0,0)
    spr(player.sp,player.x,player.y,2,2,player.flp)
    
    --princess
    spr(43,369, 104,2 ,2)


    --draw enemies sprite
    for e in all(enemies)do
        spr(e.sp, e.x, e.y, 2, 2, e.flip)
    end

    camera(0,0)
    spr(ui_icon, 4, 4, 2,2)

end 

--animate in draw? tehnically? ask grig if it's optimal
function player_animate()
    if player.jumping then
        if btn(❎) then
            player.sp = 45   
        else
            player.sp = 9
        end
    elseif player.falling then
        if btn(❎) then
            player.sp = 45  
        else
            player.sp = 9
        end
    elseif player.sliding then
        player.sp=11
    elseif player.running then
        if time()-player.anim>.1 then
        player.anim=time()
        player.sp+=2
    if player.sp>7 then
        player.sp=5
        end
    end
        else --player idle
            if time()-player.anim>.3 then
            player.anim=time()
            player.sp+=2
            if player.sp>3 then
            player.sp=1
            end
        end
    end
end

function limit_speed(num,maximum)
    return mid(-maximum,num,maximum)
end