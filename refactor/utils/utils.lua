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
	else
		xcam=camx_target
		ycam=camy_target
	end
end