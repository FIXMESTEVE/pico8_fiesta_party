scn_title={}
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

	print("press ❎ to play", 30,100)
end

scn_title._update=function()
    if(btnp(5))scn_mgr:change_scn(scn_board)
end