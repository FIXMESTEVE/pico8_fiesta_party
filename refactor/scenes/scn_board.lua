scn_board={}
scn_board._init=function()
    debug=false
    -- boardstate="begin"
	boardstate="editor"

	--editor mode vars
	editor_cells_menu={}
	editor_cells={}
	
	linker_cell=nil
	local start_cell={type=1,letter="s",col=5,selected=false,x1=0,x2=0,y1=0,y2=0} --start
	local path_select_cell={type=2,letter="p",col=5,selected=false,x1=0,x2=0,y1=0,y2=0} --path select
	local blue_cell={type=3,letter="b",col=12,selected=false,x1=0,x2=0,y1=0,y2=0} --blue cell
	local red_cell={type=4,letter="r",col=8,selected=false,x1=0,x2=0,y1=0,y2=0} --red cell
	local dummy_cell={type=5,letter="",col=5,selected=false,x1=0,x2=0,y1=0,y2=0} --dummy cell
	local eraser={type=-1,letter="x",col=5,selected=false,x1=0,x2=0,y1=0,y2=0} --eraser tool
	local linker={type=0,letter="|",col=5,selected=false,x1=0,x2=0,y1=0,y2=0} --linker tool
	add(editor_cells_menu,start_cell)
	add(editor_cells_menu,path_select_cell)
	add(editor_cells_menu,blue_cell)
	add(editor_cells_menu,red_cell)
	add(editor_cells_menu,dummy_cell)
	add(editor_cells_menu,eraser)
	add(editor_cells_menu,linker)

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
	--draw_map()
	--draw_special_cells()
	draw_players()
	draw_hud()
	if(boardstate=="begin")cut_mgr:draw()
	if(debug)draw_cells_debug()

	if(boardstate=="editor")then
		draw_editor()
	end
end

function draw_editor()
	--todo: display links between linked cells
	for i=1,#editor_cells do
		drawcell(editor_cells[i].x1,editor_cells[i].y1,editor_cells[i].x2,editor_cells[i].y2,editor_cells[i].letter,editor_cells[i].col,false)
		for j=1,#editor_cells[i].linkedcells do
			local a=editor_cells[i]
			local b=editor_cells[i].linkedcells[j]
			line(a.x1+(a.x2-a.x1)/2,a.y1+(a.y2-a.y1)/2,b.x1+(b.x2-b.x1)/2,b.y1+(b.y2-b.y1)/2,6)
			circ(b.x1+(b.x2-b.x1)/2,b.y1+(b.y2-b.y1)/2,4,6)
		end
	end
	for i=1,#editor_cells_menu do
		if(editor_cells_menu[i].selected==true)then
			if(editor_cells_menu[i].type>0)drawcell(mousex-mousex%8,mousey-mousey%8,(mousex-mousex%8)+7,(mousey-mousey%8)+7,editor_cells_menu[i].letter,editor_cells_menu[i].col,false)
		
			if(linker_cell!=nil and editor_cells_menu[i].type==0)then
				line(linker_cell.x1+(linker_cell.x2-linker_cell.x1)/2,linker_cell.y1+(linker_cell.y2-linker_cell.y1)/2,mousex,mousey,7)
			end
		end
		drawcell(editor_cells_menu[i].x1,editor_cells_menu[i].y1,editor_cells_menu[i].x2,editor_cells_menu[i].y2,editor_cells_menu[i].letter,editor_cells_menu[i].col,editor_cells_menu[i].selected)
	end
	spr(4,mousex,mousey)
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

function update_editor()
	--input
	if(btn(2))ycam-=3
	if(btn(3))ycam+=3
	if(btn(0))xcam-=3
	if(btn(1))xcam+=3
	mousex=stat(32)+xcam
	mousey=stat(33)+ycam
	mouseb=stat(34)

	--refresh editor cells menu pos
	for i=1,#editor_cells_menu do
		local off=(i-1)*8
		local x1=0+off+xcam
		local y1=120+ycam
		local x2=7+off+xcam
		local y2=127+ycam
		editor_cells_menu[i].x1=x1
		editor_cells_menu[i].y1=y1
		editor_cells_menu[i].x2=x2
		editor_cells_menu[i].y2=y2

		if(is_pressed(4,0))then
			if(mousex>=x1 and mousex<=x2 and mousey>=y1 and mousey<=y2)then
				for i=1,#editor_cells_menu do
					editor_cells_menu[i].selected=false
				end
				editor_cells_menu[i].selected=true
				return
			end
			if(editor_cells_menu[i].selected==true)then
				if(editor_cells_menu[i].type==-1)then
					erase_cell_under_cursor(mousex,mousey)
				elseif(editor_cells_menu[i].type==0)then
					link_cell_under_cursor(mousex,mousey)
				else
					if(mousey<=y1)then
						--todo: replace this with a copy constructor
						--todo: prevent cell placement on already existing cell (or erase existing cell)
						local newcell={
							type=editor_cells_menu[i].type,
							letter=editor_cells_menu[i].letter,
							col=editor_cells_menu[i].col,
							selected=false,
							x1=mousex-mousex%8,
							x2=mousex-mousex%8+7,
							y1=mousey-mousey%8,
							y2=mousey-mousey%8+7,
							linkedcells={}
						}
						add(editor_cells,newcell)
					end
				end
			end
		end
	end
end

function link_cell_under_cursor(mousex,mousey)
	local c=find_cell(x,y)
	if(c==nil)return
	if(linker_cell==nil)then
		linker_cell=c
	else
		add(linker_cell.linkedcells,c)
		linker_cell=nil
	end
end

function erase_cell_under_cursor(mousex,mousey)
	local c=find_cell(x,y)
	if(c!=nil)then
		del(editor_cells,c)
		if(c==linker_cell)then
			linker_cell=nil
		end

		--remove links
		for i in all(editor_cells) do
			for j in all(i.linkedcells) do
				if(j==c)del(i.linkedcells,c)
			end
		end
	end
end

function editor_export()
	local s = '{'
	for i=1,#editor_cells do
		local e = dump(editor_cells[i])
		e = sub(e, 1, #e-3)..sub(e, #e-1, #e)
		s=s..e
		if(i!=#editor_cells)s=s..',\n'
	end
	s=s..'}\n'
	for i=1,#editor_cells do
		if(#editor_cells[i].linkedcells>0)then
			for c in all(editor_cells[i].linkedcells) do
				for j=1,#editor_cells do
					if(c==editor_cells[j])then
						s=s.."add(editor_cells["..i.."].linkedcells,editor_cells["..j.."])\n"
					end
				end
			end
		end
	end
	return s
end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  --if type(k) ~= 'number' then k = '"'..k..'"' end
		  if (type(v) ~= 'number' and type(v) ~= 'boolean' and k ~= 'linkedcells') then v = '"'..v..'"' end
		  if(k ~= 'linkedcells') then s = s ..k..' = ' .. dump(v) .. ',' else s = s ..k..' = {},' end 
	   end
	   return s .. '} '
	else
	   return tostr(o)
	end
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
