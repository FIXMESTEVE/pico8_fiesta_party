scn_board={}
scn_board._init=function()
    debug=false
	boardstate="begin"
	--boardstate="editor"

	--editor mode vars
	editor_cells_menu={
		make_editor_cell(0,0,0,0,1,'s',5), --start
		make_editor_cell(0,0,0,0,2,'p',5), --path select
		make_editor_cell(0,0,0,0,3,'b',12), --blue cell
		make_editor_cell(0,0,0,0,4,'r',8), --red cell
		make_editor_cell(0,0,0,0,5,'!',3), --green hazard cell
		make_editor_cell(0,0,0,0,6,'i',3), --green get item cell
		make_editor_cell(0,0,0,0,7,'s',3), --shop cell
		make_editor_cell(0,0,0,0,8,'d',8), --red danger cell
		make_editor_cell(0,0,0,0,9,'',5), --dummy cell
		make_editor_cell(0,0,0,0,-1,'x',5), --eraser tool
		make_editor_cell(0,0,0,0,0,'|',5) --linker tool
	}
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
	add(editor_cells[1].linkedcells,editor_cells[2])
	add(editor_cells[2].linkedcells,editor_cells[3])
	add(editor_cells[3].linkedcells,editor_cells[4])
	add(editor_cells[4].linkedcells,editor_cells[57])
	add(editor_cells[5].linkedcells,editor_cells[6])
	add(editor_cells[6].linkedcells,editor_cells[49])
	add(editor_cells[7].linkedcells,editor_cells[65])
	add(editor_cells[8].linkedcells,editor_cells[58])
	add(editor_cells[9].linkedcells,editor_cells[10])
	add(editor_cells[10].linkedcells,editor_cells[11])
	add(editor_cells[11].linkedcells,editor_cells[55])
	add(editor_cells[12].linkedcells,editor_cells[13])
	add(editor_cells[13].linkedcells,editor_cells[14])
	add(editor_cells[14].linkedcells,editor_cells[54])
	add(editor_cells[15].linkedcells,editor_cells[16])
	add(editor_cells[16].linkedcells,editor_cells[17])
	add(editor_cells[17].linkedcells,editor_cells[19])
	add(editor_cells[18].linkedcells,editor_cells[52])
	add(editor_cells[19].linkedcells,editor_cells[51])
	add(editor_cells[20].linkedcells,editor_cells[62])
	add(editor_cells[21].linkedcells,editor_cells[46])
	add(editor_cells[22].linkedcells,editor_cells[66])
	add(editor_cells[23].linkedcells,editor_cells[62])
	add(editor_cells[24].linkedcells,editor_cells[47])
	add(editor_cells[25].linkedcells,editor_cells[58])
	add(editor_cells[26].linkedcells,editor_cells[60])
	add(editor_cells[27].linkedcells,editor_cells[25])
	add(editor_cells[28].linkedcells,editor_cells[29])
	add(editor_cells[29].linkedcells,editor_cells[36])
	add(editor_cells[30].linkedcells,editor_cells[33])
	add(editor_cells[31].linkedcells,editor_cells[32])
	add(editor_cells[32].linkedcells,editor_cells[34])
	add(editor_cells[33].linkedcells,editor_cells[34])
	add(editor_cells[34].linkedcells,editor_cells[40])
	add(editor_cells[35].linkedcells,editor_cells[40])
	add(editor_cells[36].linkedcells,editor_cells[67])
	add(editor_cells[37].linkedcells,editor_cells[48])
	add(editor_cells[38].linkedcells,editor_cells[30])
	add(editor_cells[39].linkedcells,editor_cells[31])
	add(editor_cells[40].linkedcells,editor_cells[41])
	add(editor_cells[41].linkedcells,editor_cells[59])
	add(editor_cells[42].linkedcells,editor_cells[35])
	add(editor_cells[43].linkedcells,editor_cells[45])
	add(editor_cells[44].linkedcells,editor_cells[13])
	add(editor_cells[45].linkedcells,editor_cells[53])
	add(editor_cells[46].linkedcells,editor_cells[23])
	add(editor_cells[47].linkedcells,editor_cells[21])
	add(editor_cells[48].linkedcells,editor_cells[61])
	add(editor_cells[49].linkedcells,editor_cells[7])
	add(editor_cells[50].linkedcells,editor_cells[18])
	add(editor_cells[50].linkedcells,editor_cells[15])
	add(editor_cells[51].linkedcells,editor_cells[24])
	add(editor_cells[51].linkedcells,editor_cells[20])
	add(editor_cells[52].linkedcells,editor_cells[47])
	add(editor_cells[53].linkedcells,editor_cells[44])
	add(editor_cells[54].linkedcells,editor_cells[50])
	add(editor_cells[55].linkedcells,editor_cells[12])
	add(editor_cells[56].linkedcells,editor_cells[9])
	add(editor_cells[57].linkedcells,editor_cells[63])
	add(editor_cells[58].linkedcells,editor_cells[42])
	add(editor_cells[59].linkedcells,editor_cells[2])
	add(editor_cells[60].linkedcells,editor_cells[27])
	add(editor_cells[61].linkedcells,editor_cells[39])
	add(editor_cells[62].linkedcells,editor_cells[22])
	add(editor_cells[63].linkedcells,editor_cells[64])
	add(editor_cells[63].linkedcells,editor_cells[5])
	add(editor_cells[64].linkedcells,editor_cells[8])
	add(editor_cells[65].linkedcells,editor_cells[43])
	add(editor_cells[66].linkedcells,editor_cells[26])
	add(editor_cells[66].linkedcells,editor_cells[28])
	add(editor_cells[67].linkedcells,editor_cells[37])
	add(editor_cells[67].linkedcells,editor_cells[38])
	

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
	--draw_special_cells()
	draw_players()
	draw_hud()
	if(boardstate=="begin")cut_mgr:draw()
	if(debug)draw_cells_debug()

	if(boardstate=="editor")then
		draw_editor()
	end
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

function find_cell(x,y)
	local x=mousex-mousex%8
	local y=mousey-mousey%8
	for c in all(editor_cells) do
		if(c.x1==x and c.y1==y)then
			return c
		end
	end
	return nil
end

function draw_map()
    local ysbegin=0
	foreach(map_parts, function(p)
		map(p.xbegin,p.ybegin,0,ysbegin,p.xend,p.yend)
		ysbegin+=p.yend*8
	end)
end

function draw_special_cells()
    for i=1,#cells do
		local c=cells[i]
		if(c.special)then
			draw_special_cell_circle(c)
		end
	end
end

function draw_special_cell_circle(c)
	local colfill=1
	local col=1
	local circ_radius=7
	if(c.flag==32)then
		colfill=12
		col=10
	end
	if(c.flag==64 or c.flag==192)then
		colfill=8
		col=10
	end
	if(c.flag==16 or c.flag==144)then
		colfill=11
		col=10
	end
	circfill(c.sx+4,c.sy+4,circ_radius,colfill)
	circ(c.sx+4,c.sy+4,circ_radius,col)
	if(c.flag==16)then
		spr(76,c.sx,c.sy)	
	end
	if(c.flag==192)then
		spr(91,c.sx,c.sy)
	end
	if(c.flag==144)then
		spr(92,c.sx,c.sy)
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
