scn_title={}
scn_title._display=true
scn_title._clk=0
scn_title._blink=false
scn_title._init=function()
end

scn_title._draw=function()
	cls()
	local w=4
	local h=1
	local logo_s=196
	local logo_x=78
	local logo_y=34
	local part1_s=192
	local part1_x=64-(w*8/2)
	local part1_y=64-(h*8/2)-20
	local part2_s=208
	local part2_x=64-(w*8/2)-1
	local part2_y=64-(h*8/2)-10
	local part3_s=224
	local part3_x=64-(w*8/2)
	local part3_y=64-(h*8/2)
	spr(part1_s,part1_x,part1_y,w,h)
 	spr(part2_s,part2_x,part2_y,w,h)
 	spr(part3_s,part3_x,part3_y,w,h)
	spr(logo_s,logo_x,logo_y)

	if(scn_title._blink)then
		scn_title._clk+=clock.past
		if(scn_title._clk>0.1)then
			scn_title._display=false
			scn_title._clk=0
		else
			scn_title._display=true
		end
	end

	if(scn_title._display)then
		print("press ❎ to play",30,100,10)
	end

	if(btnp(5))then 
		scn_title._blink=true
		tra_mgr:execute()
	end
end

scn_title._update=function()
end