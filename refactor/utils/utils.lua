--time
clock={}
clock.last=time()
clock.past=0

function clock:update()
    clock.past=time()-clock.last
	clock.last=time()
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
