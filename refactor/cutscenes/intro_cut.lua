intro_cut={}
intro_cut._clk=0.0
intro_cut.xorigin=xcam
intro_cut.yorigin=ycam
intro_cut.xtarget=170
intro_cut.ytarget=270
intro_cut.state=0
intro_cut.dices={}
intro_cut.canhitdices=false
intro_cut.coroutines={}

function intro_cut:init()
    for i=1,#players do
        add(intro_cut.coroutines,nil) --set up empty coroutines
    end
end

function intro_cut:update()
    intro_cut._clk+=clock.past
    if(intro_cut.state==0)intro_cut:camera_move()
    if(intro_cut.state==1)intro_cut:dialog_1()
    if(intro_cut.state==2)intro_cut:decideorder()
    if(intro_cut.state==3)intro_cut:dialog_2()

    for i=1,#particles do
        particles[i].update()
    end

    for i=1,#self.coroutines do --cycle all coroutines, if a coroutine exists then update it
        if self.coroutines[i] and costatus(self.coroutines[i]) != 'dead' then
            coresume(self.coroutines[i], players[i], self.dices[i])
        else
            self.coroutines[i] = nil
        end
    end
end

function intro_cut:draw()
    --draw additionnal elements during the cutscene here
    my_dtb_draw(xcam,ycam)
      
    for i=1,#self.dices do
        self.dices[i]:draw()
    end

    for i=1,#particles do
        particles[i].draw()
    end
    particles.clean()
end

function intro_cut:camera_move()
    local timer = intro_cut._clk/2 % 1
    xcam = lerp(intro_cut.xorigin,intro_cut.xtarget,easeInOut(timer))
    ycam = lerp(intro_cut.yorigin,intro_cut.ytarget,easeInOut(timer))
    if(abs(xcam-intro_cut.xtarget)<0.1)xcam=intro_cut.xtarget
    if(abs(ycam-intro_cut.ytarget)<0.1)ycam=intro_cut.ytarget
    if(xcam==intro_cut.xtarget and ycam==intro_cut.ytarget)then
        intro_cut.state=1
    end
end

function intro_cut:dialog_1()
    intro_disc:build()
    intro_disc:queue()
    my_dtb_update()
end

function intro_cut:dialog_2()
--TODO
end

function intro_cut:spawndices()
    for i=1,#players do
        local yoffset=10
        local d=dice:new(players[i].x+8/2, players[i].y - yoffset)
        add(self.dices,d)
    end
    self.canhitdices=true
end

function intro_cut:decideorder()
    for i=1,#self.dices do
        self.dices[i]:update()
    end
    if(self.canhitdices)then
        for i=1,#players do
            if(is_pressed(5,i-1) and self.coroutines[i]==nil and self.dices[i].state==0)then
                self.coroutines[i] = cocreate(co_anim_player_hit_dice)
            end
        end
    end
end

function co_anim_player_hit_dice(player,dice)
    local player_y_original=player.y
    while(player.y > dice.y+8/2)do  
        player.y-=1
        yield()
    end
    if(player.y <= dice.y+8/2)then
        gen_dice_particles(dice.x+dice.radius/2,dice.y+dice.radius/2)
        dice.state=1
    end
    while(player.y < player_y_original)do  
        player.y+=1
        yield()
    end
    for i=0,20 do
        if(dice.display)then
            dice.display=false
        else
            dice.display=true
        end
        yield()
        yield()
        yield()
        yield()
    end
    dice.display=true
    if(intro_cut:are_all_intro_dices_hit())intro_cut.state=3
end

--this function checks if all dices of the intro have been hit
function intro_cut:are_all_intro_dices_hit()
    for i=1,#self.dices do
        if(self.dices[i].state!=1)return false
    end
    return true
end