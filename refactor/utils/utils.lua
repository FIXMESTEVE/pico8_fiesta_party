--time
clock={}
clock.last=time()
clock.past=0

function clock:update()
    clock.past=time()-clock.last
	clock.last=time()
end

function camera_move_to(camx_target,camy_target,smoothly)
    if(smoothly)then
        --TODO: lerp
        local timer = time()/4 % 1
        local lerped = lerp(xcam,ycam,camx_target,camy_target,timer)
        xcam=lerped.x
        ycam=lerped.y
	else
		xcam=camx_target
		ycam=camy_target
	end
end

function lerpvec(x1,y1,x2,y2,t)
    local ret = {}
    ret.x = x1+(x2-x1)*t
    ret.y = y1+(y2-y1)*t
    return ret
end
function lerp(a, b, t)
    return a + (b-a)*t
 end
function easeIn(t)
    return t*t
end
function easeOut(t)
    return 1 - (1-t)*(1-t)
 end
 function easeInOut(t)
    return lerp(easeIn(t), easeOut(t), t)
 end