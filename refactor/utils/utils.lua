--time
clock={}
clock.last=time()
clock.past=0

function clock:update()
    clock.past=time()-clock.last
	clock.last=time()
end