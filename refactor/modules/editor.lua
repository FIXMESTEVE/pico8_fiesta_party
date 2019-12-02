--editor mode vars
editor_cells_menu={
	make_editor_cell(0,0,0,0,1,'s',5), --start
	make_editor_cell(0,0,0,0,2,'p',5), --path select
	make_editor_cell(0,0,0,0,3,'b',12), --blue cell
	make_editor_cell(0,0,0,0,4,'r',8), --red cell
	make_editor_cell(0,0,0,0,5,'!',3), --green hazard cell
	make_editor_cell(0,0,0,0,6,'i',3), --green get item cell
	make_editor_cell(0,0,0,0,7,'d',8), --red danger cell
	make_editor_cell(0,0,0,0,8,'s',3), --shop cell
	make_editor_cell(0,0,0,0,9,'',5), --dummy cell
	make_editor_cell(0,0,0,0,-1,'x',5), --eraser tool
	make_editor_cell(0,0,0,0,0,'|',5) --linker tool
}

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
						erase_cell_under_cursor(mousex,mousey)
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
	elseif(linker_cell==nil)then
		return
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
		local e = dump_cell(editor_cells[i])
		--e = sub(e, 1, #e-3)..sub(e, #e-1, #e)
		s=s..e
		if(i!=#editor_cells)s=s..',\n'
	end
	s=s..'}\n'
	for i=1,#editor_cells do
		if(#editor_cells[i].linkedcells>0)then
			for c in all(editor_cells[i].linkedcells) do
				for j=1,#editor_cells do
					if(c==editor_cells[j])then
						s=s.."link("..i..","..j..")\n"
					end
				end
			end
		end
	end
	return s
end


function dump_cell(c)
	return "make_editor_cell("..c.x1..","..c.y1..","..c.x2..","..c.y2..","..c.type..",'"..c.letter.."',"..c.col..")"
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