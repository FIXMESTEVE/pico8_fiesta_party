scn_board={}
scn_board._init=function()
    debug=false
    -- boardstate="begin"
	boardstate="editor"
	editor_cells={}
	local start_cell={type=1,letter="s",selected=false} --start
	local path_select_cell={type=2,letter="p",selected=false} --path select
	add(editor_cells,start_cell)
	add(editor_cells,path_select_cell)

    xcam=0
    ycam=0
	
    player_start_x=224
    player_start_y=336

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

    cells={}
    cells.get_cell = function(mapx,mapy)
        --printh("Looking for cell MAPX :"..mapx.." MAPY: "..mapy)
        for i=1,#cells do
            local c=cells[i]
            if(c.mapx==mapx and c.mapy==mapy)then
                --printh(" ");
                --printh("cell found ")
                --printh("X: "..c.sx.." Y: "..c.sy.." MAPX: "..c.mapx.." MAPY: "..c.mapy)
                return c
            end
        end
    end

    startcell=nil

	init_map_raw()
	
	if(boardstate=="editor")then
		poke(0x5f2d,1)
		mousex=stat(32)
		mousey=stat(33)
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

function draw_editor()
	for i=1,#editor_cells do
		rect(editor_cells[i].x1,editor_cells[i].y1,editor_cells[i].x2,editor_cells[i].y2,6)
		if(editor_cells[i].selected==true)rectfill(x1,y1,x2,y2,6)
		print(editor_cells[i].letter,x1+1,y1+2,6)
	end
	spr(4,mousex,mousey)
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

function update_editor()
	--input
	if(btn(2))ycam-=3
	if(btn(3))ycam+=3
	if(btn(0))xcam-=3
	if(btn(1))xcam+=3
	mousex=stat(32)+xcam
	mousey=stat(33)+ycam
	mouseb=stat(34)

	--refresh editor cells pos
	for i=1,#editor_cells do
		local off=i-1*8
		local x1=0+off
		local y1=119
		local x2=8+off
		local y1=127
		editor_cells[i].x1=x1
		editor_cells[i].y1=y1
		editor_cells[i].x2=x2
		editor_cells[i].y2=y2

		if(b==1)then
			if(mousex>=x1 and mousex<=x2 and mousey>=y1 and mousey<=y2)then
				editor_celles[i].selected=true
			end
		end
	end
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

function init_map_raw()
	--the sort of code that fucks your brain right here
	startcell=make_cell(71,7)
	local path_cell=add_neighbours(startcell,71,6)
	for i=5,0,-1 do
		path_cell=add_neighbours(path_cell[1],71,i)
	end
	for i=31,26,-1 do
		path_cell=add_neighbours(path_cell[1],31,i)
	end
	--now add two neighbours
	path_cell=add_neighbours(path_cell[1],31,25,30,26)
	local path_cell_alternative=add_neighbours(path_cell[2],29,26)
	for i=28,21,-1 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],i,26)
	end
	for i=26,31 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],21,i)
	end
	for i=0,5 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],61,i)
	end
	for i=61,70 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],i,5)
	end
	path_cell_alternative[1].n1=cells.get_cell(71,5)

	for i=25,19,-1 do
		path_cell=add_neighbours(path_cell[1],31,i)
	end
	path_cell=add_neighbours(path_cell[1],31,18,30,19)
	path_cell_alternative=add_neighbours(path_cell[2],29,19)
	for i=29,22,-1 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],i,19);
	end
	for i=19,7,-1 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],22,i)
	end
	for i=18,6,-1 do
		path_cell=add_neighbours(path_cell[1],31,i)
	end
	for i=30,13,-1 do
		path_cell=add_neighbours(path_cell[1],i,6)
	end
	path_cell_alternative[1].n1=cells.get_cell(22,6)
	
	path_cell=add_neighbours(path_cell[1],12,6,13,7)
	path_cell_alternative=add_neighbours(path_cell[2],13,8)
	for i=9,21,1 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],13,i);
	end
	for i=13,8,-1 do
		path_cell_alternative=add_neighbours(path_cell_alternative[1],i,21);
	end
	--todo alternative path top left
	for i=11,7,-1 do
		path_cell=add_neighbours(path_cell[1],i,6)
	end
	for i=7,31,1 do
		path_cell=add_neighbours(path_cell[1],7,i)
	end
	for i=0,5,1 do
		path_cell=add_neighbours(path_cell[1],47,i)
	end
	path_cell_alternative[1].n1=cells.get_cell(7,21)
	for i=47,60,1 do
		path_cell=add_neighbours(path_cell[1],i,5)
	end
	path_cell[1].n1=cells.get_cell(61,5)
end


function add_neighbours(c,n1x,n1y,n2x,n2y)
	newcells={}
	c.n1=make_cell(n1x,n1y,c)
	add(newcells,c.n1)
	if(n2x!=nil)then
		c.n2=make_cell(n2x,n2y)
		add(newcells,c.n2)
	end
	return newcells
end

function make_cell(mapx,mapy,parent)
	local c={}
	c.flag=fget(mget(mapx,mapy))
	c.special=false
	if(c.flag==16 or c.flag==32 or c.flag==64 or c.flag==192 or c.flag==144)then
		c.special=true
	end
	c.mapx=mapx
	c.mapy=mapy
	local mapxoffset=0
	local mapyoffset=0
	if(c.mapx>31)then
		mapxoffset=-40
		mapyoffset=32
	end
	c.sx=(c.mapx+mapxoffset)*8
	c.sy=(c.mapy+mapyoffset)*8
	--next cells
	c.n1=nil
	c.n2=nil
	c.p=nil
	if(parent!=nil)c.p=parent
	add(cells,c)
	return c
end