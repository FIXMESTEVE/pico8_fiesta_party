scn_board={}
scn_board._init=function()
    debug=false
    globalstate="title"
    boardstate="begin"
    xcam=0
    ycam=0
    textbox_x1=-1
    textbox_y1=-1
    textbox_x2=-1
    textbox_y2=-1
    textbox_x1_max=10
    textbox_y1_max=80
    textbox_x2_max=100
    textbox_y2_max=10
    player_start_x=224
    player_start_y=336

    players={}
    p1={}
    p2={}
    p3={}
    p4={}
    p1.number=1
    p1.x=player_start_x
    p1.y=player_start_y
    p1.char=128
    p1.coins=0
    p1.dice={}
    p1.emblems=0
    p2.number=2
    p2.x=player_start_x+16
    p2.y=player_start_y
    p2.char=144
    p2.coins=0
    p2.emblems=0
    p2.dice={}
    p3.number=3
    p3.x=player_start_x+32
    p3.y=player_start_y
    p3.char=160
    p3.coins=0
    p3.emblems=0
    p3.dice={}
    p4.number=4
    p4.x=player_start_x+48
    p4.y=player_start_y
    p4.char=176
    p4.coins=0
    p4.emblems=0
    p4.dice={}
    add(players,p1)
    add(players,p2)
    add(players,p3)
    add(players,p4)

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

    cells={}
    startcell=nil
end

function make_dice(p)

end

scn_board._draw=function()
    cls()
    draw_map()
	draw_special_cells()
	draw_players()
	draw_hud()
	if(debug)draw_cells_debug()
end
scn_board._update=function()
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
    for i=1,4 do
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
		--rect(x1+xcam,y1+ycam,x2+xcam,y2+ycam,10)
		--circfill(charx+4,chary+4,8,1)
		print(players[i].coins,coinstxtx+1+coinpadding,coinstxty+1,1)
		print(players[i].coins,coinstxtx+coinpadding,coinstxty,7)
		print(players[i].emblems,emblemstxtx+1+emblempadding,emblemstxty+1,1)
		print(players[i].emblems,emblemstxtx+emblempadding,emblemstxty,7)

		spr(1,coinsprx,coinspry)
		spr(3,emblemsprx,emblemspry)
		spr(players[i].char,charx,chary)
	end
end

function draw_cells_debug()
    --fixmesteve: use the list, maybe
	local col=12
	foreach(cells, function(c)
		col+=1
		if(col>15)col=12
		rect(c.sx,c.sy,c.sx+8,c.sy+8,7)
		
		local show_neighbours=function(n)
			--left
			if(n.sx<c.sx)circ(c.sx+2,c.sy+4,1,7)
			--right
			if(n.sx>c.sx)circ(c.sx+8-2,c.sy+4,1,7)
			--up
			if(n.sy<c.sy)circ(c.sx+4,c.sy+2,1,7)
			--down
			if(n.sy>c.sy)circ(c.sx+4,c.sy+8-2,1,7)
		end
		if(c.n1!=nil)then
			show_neighbours(c.n1)
		end
		if(c.n2!=nil)then
			show_neighbours(c.n2)
		end		
	end)
end