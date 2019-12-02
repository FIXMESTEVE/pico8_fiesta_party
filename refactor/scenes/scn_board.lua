scn_board={}
scn_board._init=function()
    debug=false
	boardstate="begin"
	--boardstate="editor"

	--TODO: put all this data in a string and write an unserializer to free 1000+ tokens.
	--tip for future self: use an explode function
	editor_cells={make_editor_cell(248,320,255,327,1,'s',5),
	make_editor_cell(248,296,255,303,3,'b',12),
	make_editor_cell(248,272,255,279,4,'r',8),
	make_editor_cell(248,248,255,255,3,'b',12),
	make_editor_cell(248,192,255,199,3,'b',12),
	make_editor_cell(248,168,255,175,3,'b',12),
	make_editor_cell(224,152,231,159,3,'b',12),
	make_editor_cell(200,208,207,215,3,'b',12),
	make_editor_cell(248,112,255,119,4,'r',8),
	make_editor_cell(248,88,255,95,4,'r',8),
	make_editor_cell(248,48,255,55,3,'b',12),
	make_editor_cell(200,48,207,55,3,'b',12),
	make_editor_cell(176,48,183,55,3,'b',12),
	make_editor_cell(152,48,159,55,4,'r',8),
	make_editor_cell(80,48,87,55,4,'r',8),
	make_editor_cell(56,48,63,55,3,'b',12),
	make_editor_cell(56,88,63,95,3,'b',12),
	make_editor_cell(104,88,111,95,3,'b',12),
	make_editor_cell(56,112,63,119,4,'r',8),
	make_editor_cell(56,144,63,151,3,'b',12),
	make_editor_cell(104,144,111,151,3,'b',12),
	make_editor_cell(56,192,63,199,3,'b',12),
	make_editor_cell(80,168,87,175,4,'r',8),
	make_editor_cell(80,128,87,135,4,'r',8),
	make_editor_cell(144,208,151,215,4,'r',8),
	make_editor_cell(72,208,79,215,3,'b',12),
	make_editor_cell(120,208,127,215,3,'b',12),
	make_editor_cell(56,224,63,231,3,'b',12),
	make_editor_cell(56,248,63,255,4,'r',8),
	make_editor_cell(96,296,103,303,4,'r',8),
	make_editor_cell(120,328,127,335,4,'r',8),
	make_editor_cell(144,328,151,335,4,'r',8),
	make_editor_cell(120,296,127,303,3,'b',12),
	make_editor_cell(144,296,151,303,3,'b',12),
	make_editor_cell(168,272,175,279,3,'b',12),
	make_editor_cell(56,272,63,279,3,'b',12),
	make_editor_cell(56,312,63,319,3,'b',12),
	make_editor_cell(72,296,79,303,3,'b',12),
	make_editor_cell(96,328,103,335,3,'b',12),
	make_editor_cell(168,296,175,303,4,'r',8),
	make_editor_cell(200,296,207,303,3,'b',12),
	make_editor_cell(168,232,175,239,3,'b',12),
	make_editor_cell(176,152,183,159,5,'',5),
	make_editor_cell(176,88,183,95,4,'r',8),
	make_editor_cell(176,136,183,143,4,'r',8),
	make_editor_cell(104,168,111,175,5,'',5),
	make_editor_cell(104,128,111,135,5,'',5),
	make_editor_cell(56,328,63,335,5,'',5),
	make_editor_cell(248,152,255,159,2,'p',5),
	make_editor_cell(104,48,111,55,2,'p',5),
	make_editor_cell(56,128,63,135,2,'p',5),
	make_editor_cell(104,112,111,119,5,'!',3),
	make_editor_cell(176,112,183,119,5,'!',3),
	make_editor_cell(128,48,135,55,5,'!',3),
	make_editor_cell(224,48,231,55,5,'!',3),
	make_editor_cell(248,136,255,143,7,'s',3),
	make_editor_cell(248,224,255,231,5,'!',3),
	make_editor_cell(168,208,175,215,6,'i',3),
	make_editor_cell(224,296,231,303,6,'i',3),
	make_editor_cell(96,208,103,215,6,'i',3),
	make_editor_cell(72,328,79,335,6,'i',3),
	make_editor_cell(56,168,63,175,8,'d',8),
	make_editor_cell(248,208,255,215,2,'p',5),
	make_editor_cell(224,208,231,215,4,'r',8),
	make_editor_cell(200,152,207,159,6,'i',3),
	make_editor_cell(56,208,63,215,2,'p',5),
	make_editor_cell(56,296,63,303,2,'p',5)}
	link(1,2)
	link(2,3)
	link(3,4)
	link(4,57)
	link(5,6)
	link(6,49)
	link(7,65)
	link(8,58)
	link(9,10)
	link(10,11)
	link(11,55)
	link(12,13)
	link(13,14)
	link(14,54)
	link(15,16)
	link(16,17)
	link(17,19)
	link(18,52)
	link(19,51)
	link(20,62)
	link(21,46)
	link(22,66)
	link(23,62)
	link(24,47)
	link(25,58)
	link(26,60)
	link(27,25)
	link(28,29)
	link(29,36)
	link(30,33)
	link(31,32)
	link(32,34)
	link(33,34)
	link(34,40)
	link(35,40)
	link(36,67)
	link(37,48)
	link(38,30)
	link(39,31)
	link(40,41)
	link(41,59)
	link(42,35)
	link(43,45)
	link(44,13)
	link(45,53)
	link(46,23)
	link(47,21)
	link(48,61)
	link(49,7)
	link(50,18)
	link(50,15)
	link(51,24)
	link(51,20)
	link(52,47)
	link(53,44)
	link(54,50)
	link(55,12)
	link(56,9)
	link(57,63)
	link(58,42)
	link(59,2)
	link(60,27)
	link(61,39)
	link(62,22)
	link(63,64)
	link(63,5)
	link(64,8)
	link(65,43)
	link(66,26)
	link(66,28)
	link(67,37)
	link(67,38)
	
	linker_cell=nil

	--camera
    xcam=0
    ycam=0
	
    player_start_x=224
    player_start_y=336

	--players
    players={}
    p1=player:new(1,player_start_x,player_start_y,128,0,0,"blue")
    p2=player:new(2,player_start_x+16,player_start_y,144,0,0,"red")
    -- p3=player:new(3,player_start_x+32,player_start_y,160,0,0)
    -- p4=player:new(4,player_start_x+48,player_start_y,176,0,0)
    add(players,p1)
    add(players,p2)
    -- add(players,p3)
    -- add(players,p4)

    map_parts={}
    part1={}
    part1.xbegin=0
    part1.xend=40
    part1.ybegin=0
    part1.yend=32
    part2={}
    part2.xbegin=40
    part2.xend=74
    part2.ybegin=0
    part2.yend=20
    add(map_parts,part1)
    add(map_parts,part2)
	
	if(boardstate=="editor")then
		poke(0x5f2d,1)
		mousex=stat(32)+xcam
		mousey=stat(33)+ycam
		mouseb=stat(34)
	end
end

scn_board._draw=function()
	cls()
	camera(xcam,ycam)
	draw_map()
	draw_special_cells()
	draw_players()
	draw_hud()
	if(boardstate=="begin")cut_mgr:draw()
	if(debug)draw_cells_debug()

	if(boardstate=="editor")then
		draw_editor()
	end
end

function link(n1,n2)
	add(editor_cells[n1].linkedcells,editor_cells[n2])
end

function drawcell(x1,y1,x2,y2,letter,col,selected)
	rectfill(x1,y1,x2,y2,col)
	print(letter,x1+2,y1+2,7)
	if(selected==true)rect(x1,y1,x2,y2,7)
end

scn_board._update=function()
	if(boardstate=="begin")then
		cut_mgr:set_cutscene(intro_cut)
		cut_mgr:enable()
		cut_mgr:update()
	end

	if(boardstate=="editor")then
		update_editor()
	end
end

function make_editor_cell(_x1,_y1,_x2,_y2,_type,_letter,_col)
	return{selected=false,linkedcells={},x1=_x1,y1=_y1,x2=_x2,y2=_y2,type=_type,letter=_letter,col=_col}
end

function draw_map()
    local ysbegin=0
	foreach(map_parts, function(p)
		map(p.xbegin,p.ybegin,0,ysbegin,p.xend,p.yend)
		ysbegin+=p.yend*8
	end)
end

function draw_special_cells()
    for i=1,#editor_cells do
		local c=editor_cells[i]
		if(isboardcell(c))then
			draw_special_cell_circle(c)
		end
	end
end

function isboardcell(c)
	if(c.type>=3 and c.type<=8)return true
	return false
end

function draw_special_cell_circle(c)
	local colfill=1
	local col=1
	local circ_radius=7
	if(c.type==3)then
		colfill=12
		col=10
	end
	if(c.type==4 or c.type==8)then
		colfill=8
		col=10
	end
	if(c.type==5 or c.type==6)then
		colfill=11
		col=10
	end
	circfill(c.x1+4,c.y1+4,circ_radius,colfill)
	circ(c.x1+4,c.y1+4,circ_radius,col)
	if(c.type==5)then
		spr(76,c.x1,c.y1)	
	end
	if(c.type==8)then
		spr(91,c.x1,c.y1)
	end
	if(c.type==6)then
		spr(92,c.x1,c.y1)
	end
end

function draw_players()
    for i=1,#players do
		spr(players[i].char,players[i].x,players[i].y)
	end
end

function draw_hud()
    for i=1,#players do
		local w=32
		local h=16
		local xoffset=0
		local yoffset=0
		if(i==2)then
			xoffset=128-1-w
		elseif(i==3)then
			yoffset=128-1-h
		elseif(i==4)then
			xoffset=128-1-w
			yoffset=128-1-h
		end

		
		local x1=xoffset
		local y1=yoffset
		local x2=x1+w
		local y2=y1+h
		local coinstxtx=x2-12+xcam
		local coinstxty=y1+2+ycam
		local emblemstxtx=x2-12+xcam
		local emblemstxty=y2-6+ycam
		local coinsprx=coinstxtx-8+3
		local coinspry=coinstxty+1
		local emblemsprx=emblemstxtx-8+2
		local emblemspry=emblemstxty-1
		local coinpadding=0
		local emblempadding=0
		local charx=x1+3+xcam
		local chary=y1+3+ycam

		if(players[i].coins < 10)coinpadding+=4
		if(players[i].coins < 100)coinpadding+=4
		if(players[i].emblems < 10)emblempadding+=4
		if(players[i].emblems < 100)emblempadding+=4
		
		rectfill(x1+xcam,y1+ycam,x2+xcam,y2+ycam,1)
		
		--TODO:should we keep this?
		print(players[i].coins,coinstxtx+1+coinpadding,coinstxty+1,1)
		print(players[i].coins,coinstxtx+coinpadding,coinstxty,7)
		print(players[i].emblems,emblemstxtx+1+emblempadding,emblemstxty+1,1)
		print(players[i].emblems,emblemstxtx+emblempadding,emblemstxty,7)

		spr(1,coinsprx,coinspry)
		spr(3,emblemsprx,emblemspry)
		spr(players[i].char,charx,chary)
	end
end
