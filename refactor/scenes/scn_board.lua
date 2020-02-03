scn_board={}
cofuncs={}

scn_board._init=function()
	boardstate="cut_begin"
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
	make_editor_cell(248,224,255,231,5,'!',3),
	make_editor_cell(168,208,175,215,6,'i',3),
	make_editor_cell(224,296,231,303,6,'i',3),
	make_editor_cell(96,208,103,215,6,'i',3),
	make_editor_cell(56,168,63,175,8,'d',8),
	make_editor_cell(248,208,255,215,2,'p',5),
	make_editor_cell(224,208,231,215,4,'r',8),
	make_editor_cell(200,152,207,159,6,'i',3),
	make_editor_cell(56,208,63,215,2,'p',5),
	make_editor_cell(56,296,63,303,2,'p',5),
	make_editor_cell(72,328,79,335,8,'s',3),
	make_editor_cell(248,136,255,143,8,'s',3)}
	link(1,2)
	link(2,3)
	link(3,4)
	link(4,56)
	link(5,6)
	link(6,49)
	link(7,63)
	link(8,57)
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
	link(20,60)
	link(21,46)
	link(22,64)
	link(23,60)
	link(24,47)
	link(25,57)
	link(26,59)
	link(27,25)
	link(28,29)
	link(29,36)
	link(30,33)
	link(31,32)
	link(32,34)
	link(33,34)
	link(34,40)
	link(35,40)
	link(36,65)
	link(37,48)
	link(38,30)
	link(39,31)
	link(40,41)
	link(41,58)
	link(42,35)
	link(43,45)
	link(44,13)
	link(45,53)
	link(46,23)
	link(47,21)
	link(48,66)
	link(49,7)
	link(49,67)
	link(50,18)
	link(50,15)
	link(51,24)
	link(51,20)
	link(52,47)
	link(53,44)
	link(54,50)
	link(55,12)
	link(56,61)
	link(57,42)
	link(58,2)
	link(59,27)
	link(60,22)
	link(61,62)
	link(61,5)
	link(62,8)
	link(63,43)
	link(64,26)
	link(64,28)
	link(65,37)
	link(65,38)
	link(66,39)
	link(67,9)
	
	linker_cell=nil

	--camera
    xcam=0
    ycam=0
	
    player_start_x=224
    player_start_y=336

	--players
	players={}
    reordered_players_tbl={}
    p1=player:new(1,player_start_x,player_start_y,128,0,0,"blue",1)
    p2=player:new(2,player_start_x+16,player_start_y,144,0,0,"red",2)
    -- p3=player:new(3,player_start_x+32,player_start_y,160,0,0,"todo",3)
    -- p4=player:new(4,player_start_x+48,player_start_y,176,0,0,"todo",4)
    add(players,p1)
    add(players,p2)
    -- add(players,p3)
	-- add(players,p4)
	
	player_turn_menu_select=0
	player_turn_menu_done=false
	player_turn_dice_done=false

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

	turn=1
	curr_player=1 --current player

	coroutines={}

	coins={}
	ephem={}
end

scn_board._draw=function()
	cls()
	camera(xcam,ycam)
	draw_map()
	draw_special_cells()
	draw_players()
	draw_hud()
	cut_mgr:draw()

	local p=players[curr_player]

	for i=1,#particles do
        particles[i].draw()
	end
	
	for c in all(coins)do
		c:draw()
	end

	foreach(ephem, ephem_draw)

	if(boardstate=="editor")then
		draw_editor()
	end

	if(boardstate=="cut_nextplayer")then
		play_coroutine("co_nextplayer_cutscene_draw")
	end

	if(coroutines.co_anim_player_get_coins!=nil and costatus(coroutines.co_anim_player_get_coins)!='dead')then
		outline_print("+3 coins",p.x+10,p.y-8,7,12)
	end

	if(coroutines.co_anim_player_lose_coins!=nil and costatus(coroutines.co_anim_player_lose_coins)!='dead')then
		outline_print("-3 coins",p.x+10,p.y-8,7,8)
	end

	if(boardstate=="player_turn")then
		if(p.dice!=nil)p.dice:draw()
		draw_player_menu()
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
	for i=1,#particles do
        particles[i].update()
	end
	particles.clean()
	
	cut_mgr:update()

	if(boardstate=="cut_begin")then
		cut_mgr:set_cutscene(intro_cut)
		cut_mgr:enable()
		if(intro_cut.state==4)then
			cut_mgr:disable()
			place_players()
			place_emblem()
			boardstate="cut_newemblem"
		end
	elseif(boardstate=="cut_newemblem")then
		-- TODO: implement these
		-- cut_mgr:set_cutscene(newemblem_cut)
		-- cut_mgr:enable()
		boardstate="cut_nextplayer"
	elseif(boardstate=="cut_nextplayer")then
		--starts nextplayer coroutine cutscene
		play_coroutine("co_nextplayer_cutscene_update", {xcam,ycam,players[curr_player].x-64,players[curr_player].y-64})
		if(costatus(coroutines.co_nextplayer_cutscene_update)=='dead' and costatus(coroutines.co_nextplayer_cutscene_draw)=='dead')then
			coroutines.co_nextplayer_cutscene_update=nil
			coroutines.co_nextplayer_cutscene_draw=nil
			reset_player_turn_globals()
			boardstate="player_turn"
		end
	elseif(boardstate=="player_turn")then
		xcam=players[curr_player].x-64
		ycam=players[curr_player].y-64
		players[curr_player]:make_dice()
		players[curr_player].dice:update()
		if(player_turn_menu_done==false)then
			update_player_menu()
		else
			if(player_turn_menu_select==0)then
				if(player_turn_dice_done==false)then
					play_coroutine("co_anim_player_hit_dice",{players[curr_player],players[curr_player].dice})
					if(costatus(coroutines.co_anim_player_hit_dice)=='dead')then
						coroutines.co_anim_player_hit_dice=nil
						player_turn_dice_done=true
					end
				else
					play_coroutine("co_player_move")
					if(costatus(coroutines.co_player_move)=='dead')then
						players[curr_player].dice=nil
						if(do_cell_behavior()==true)then
							curr_player+=1
							if(curr_player>#players)curr_player=1
							coroutines.co_player_move=nil
							boardstate="cut_nextplayer"
						end
					end
				end
			end
		end
	elseif(boardstate=="editor")then
		update_editor()
	end
end

function do_cell_behavior()
	local t=players[curr_player].cell.type

	if(t==3)then
		play_coroutine("co_anim_player_get_coins",{3})
		if(costatus(coroutines.co_anim_player_get_coins)=='dead')then
			coroutines.co_anim_player_get_coins=nil
			return true
		end
	end

	if(t==4)then
		play_coroutine("co_anim_player_lose_coins",{3})
		if(costatus(coroutines.co_anim_player_lose_coins)=='dead')then
			coroutines.co_anim_player_lose_coins=nil
			return true
		end
	end

	return false		
end

function reset_player_turn_globals()
	player_turn_menu_select=0
	player_turn_menu_done=false
	player_turn_dice_done=false
end

function draw_player_menu()
	local off=20
	local xrect1=0+xcam
	local yrect1=22+ycam
	local xrect2=40+xcam
	local yrect2=30+ycam
	local xtxt=xrect1+4
	local ytxt=yrect1+2
	local col=1
	if(player_turn_menu_select==0)col=8
	
	if(player_turn_menu_done==false)then
		rectfill(xrect1,yrect1,xrect2,yrect2,col)
		print("hit dice",xtxt,ytxt,7)
	end

	if(#players[curr_player].items>0)then
		col=1
		if(player_turn_menu_select==1)col=8
		rectfill(xrect1,yrect1+off,xrect2,yrect2+off,col)
		print("use item",xtxt,ytxt+off,7)
	end
end

function update_player_menu()
	if(is_pressed(5,players[curr_player].port-1))then
		player_turn_menu_done=true
	end
end

function place_players()
	for p in all(players) do
		local xoff,yoff=get_cell_player_offset(p)
		
		p.x=p.cell.x1+xoff
		p.y=p.cell.y1+yoff
	end
end

function place_emblem()
    for c in all(editor_cells)do
        c.isemblemspace=false
    end
    local i=flr(1+rnd(#editor_cells-1))
    if(editor_cells[i].type==3 or editor_cells[i].type==4)then
        editor_cells[i].isemblemspace=true
    else
        place_emblem()
        return
    end
end

function make_editor_cell(_x1,_y1,_x2,_y2,_type,_letter,_col)
	--TODO: make a cell class and do a new instead of this...
	return{selected=false,linkedcells={},x1=_x1,y1=_y1,x2=_x2,y2=_y2,type=_type,letter=_letter,col=_col,isemblemspace=false}
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
	if(c.type>=3 and c.type<=7)return true
	return false
end

function draw_special_cell_circle(c)
	local colfill=1
	local col=1
	local circ_radius=7
	if(c.type==3)then
		colfill=12
		if(is_player_in_cell(players[curr_player],c)==true)colfill=13
		col=10
	end
	if(c.type==4 or c.type==7)then
		colfill=8
		if(is_player_in_cell(players[curr_player],c)==true)colfill=14
		col=10
	end
	if(c.type==5 or c.type==6)then
		colfill=11
		if(is_player_in_cell(players[curr_player],c)==true)colfill=3
		col=10
	end
	if(c.isemblemspace==true)then
		colfill=5
		col=7
	end
	circfill(c.x1+4,c.y1+4,circ_radius,colfill)
	circ(c.x1+4,c.y1+4,circ_radius,col)
	if(c.isemblemspace==true)then
		sspr(32,96,8,8,c.x1-4.10,c.y1-4.10,16,16)
		return
	end
	if(c.type==5)then
		spr(76,c.x1,c.y1)	
	end
	if(c.type==7)then
		spr(91,c.x1,c.y1)
	end
	if(c.type==6)then
		spr(92,c.x1,c.y1)
	end
end

function is_player_in_cell(p,c)
	if(p.x>c.x1-5)then
		if(p.x+7<c.x2+5)then
			if(p.y>c.y1-5)then
				if(p.y+7<c.y2+5)return true
			end
		end
	end
	return false
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
		
		outline_print(players[i].coins,coinstxtx+coinpadding,coinstxty,7,2)
		outline_print(players[i].emblems,emblemstxtx+emblempadding,emblemstxty,7,2)

		spr(1,coinsprx,coinspry)
		spr(3,emblemsprx,emblemspry)
		spr(players[i].char,charx,chary)
	end
end

function cofuncs.co_nextplayer_cutscene_update(args)
	local xorigin=args[1]
	local yorigin=args[2]
	local xtarget=args[3]
	local ytarget=args[4]

	local time=0
	while(move_camera(xorigin,yorigin,xtarget,ytarget,time)==false)do
		time+=clock.past%1
		yield()
	end
end

function cofuncs.co_nextplayer_cutscene_draw()
	local x1=0
	local y1=64
	local x2=128
	local y2=64
	local upperlineoff=-12
	local bottomlineoff=12
	local pushed=false
	local endco=false
	while(endco==false)do
		if(y2<72 and pushed==false)then
			y1-=1
			y2+=1
		end
		
		if(y2>64 and pushed==true)then
			y1+=1
			y2-=1
		end

		if(y2==64 and pushed==true)then
			endco=true
		end

		upperlineoff+=4
		bottomlineoff-=4

		rectfill(x1+xcam,y1+ycam,x2+xcam,y2+ycam,7)
		line(x1+xcam+upperlineoff,y1+ycam,x1+xcam+12+upperlineoff,y1+ycam,1)
		line(x2+xcam+bottomlineoff,y2+ycam,x2+xcam-12+bottomlineoff,y2+ycam,1)
		
		if(y2>=70)then
			print(players[curr_player].name..", it's your turn!",25+xcam,58+ycam,1)
			print("go!",58+xcam,64+ycam,1)
		end

		if(pushed==false)pushed=is_pressed(5,players[curr_player].port-1)
		yield()
	end
	yield()
end

function cofuncs.co_player_move()
	local time=0
	local p=players[curr_player]
	local done=false
	local xorigin=p.x
	local yorigin=p.y
	while(done==false)do
		if(is_cell_dice_decreasing(p.cell)==false and p.cell.type!=1)then
			--todo: implement appropriate behavior for special, non dice decreasing cells (path select, emblem, shop, etc)
			yield()
		else
			time=(time+clock.past*2)%1

			p:update_dice()

			local xoff,yoff=get_cell_player_offset(p)
			local xtarget=p.cell.linkedcells[1].x1+xoff
			local ytarget=p.cell.linkedcells[1].y1+yoff

			p.x=lerp(xorigin,xtarget,easeOut(time))
			p.y=lerp(yorigin,ytarget,easeOut(time))

			if(abs(p.x-xtarget)<0.1 and abs(p.y-ytarget)<0.1)then
				p.cell=p.cell.linkedcells[1]
				if(is_cell_dice_decreasing(p.cell)==true)p.dice.number-=1
				xorigin=p.x
				yorigin=p.y
				time=0
				if(p.dice.number==0)done=true
				--TODO: implement normal cells (blue, red) and hazards (green) cells behavior
			end

			yield()
		end
	end
end

function cofuncs.co_anim_player_get_coins(args)
	local ncoins=args[1]

	local p=players[curr_player]

	for i=1,ncoins do
		add(coins,coin:new(p.x+2,p.y-70-(16*i)))
	end

	while(#coins>0)do
		for coin in all(coins)do
			coin.y+=2
			if(coin.y>p.y)then
				del(coins,coin)
				make_twinkle(p.x+2,p.y-2,4,16,20)
				p.coins+=1
			end
		end
		yield()
	end

	for i=1,10 do
		yield()
	end
end

function cofuncs.co_anim_player_lose_coins(args)
	--todo: uuuuh use a real math function to make a nice curve instead of this abomination
	local ncoins=args[1]
	local coend=false
	local p=players[curr_player]
	local tick=10

	while(ncoins>0 or #coins>0 or tick<90)do
		if(ncoins>0 and tick>=10)then
			ncoins-=1
			if(p.coins>0)then
				local c=coin:new(p.x+4,p.y+4)
				p.coins-=1
				if(p.coins<0)p.coins=0
				c.falling=false
				c.y_ceiling=p.y-20+rnd(10)
				c.y_die=rnd(25)+p.y+12
				c.x_move=flr(rnd(4 * 100)) / 100 - 2
				c.y_move=flr(rnd(1.25 * 100)) / 100 + 1.75

				add(coins,c)
				tick=0
			end
		end

		for c in all(coins)do
			c.x+=c.x_move
			if(c.y<c.y_ceiling)c.falling=true
			if(c.falling==true)then
				c.y+=c.y_move
			else
				c.y-=c.y_move
			end
	
			if(c.y>c.y_die)then
				make_twinkle(c.x,c.y,4,16,5)
				del(coins,c)
			end
		end
		
		tick+=1
		yield()
	end
end

function is_cell_dice_decreasing(c)
	if(c.isemblemspace==false and (c.type==3 or c.type==4 or c.type==5 or c.type==6 or c.type==7))return true
	return false
end

function get_cell_player_offset(p)
	local xoff=0
	local yoff=0
	if(p.number==1)then
		xoff=-4
		yoff=-4
	end
	if(p.number==2)then
		xoff=4
		yoff=-4
	end
	if(p.number==3)then
		xoff=-4
		yoff=4
	end
	if(p.number==4)then
		xoff=4
		yoff=4
	end

	return xoff,yoff
end