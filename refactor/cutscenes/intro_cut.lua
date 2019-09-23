intro_cut={}
intro_cut._clk=0.0
intro_cut.xorigin=xcam
intro_cut.yorigin=ycam
intro_cut.xtarget=170
intro_cut.ytarget=270
intro_cut.state=0
intro_cut.dices={}
intro_cut.canhitdices=false
function intro_cut:update()
    intro_cut._clk+=clock.past
    if(intro_cut.state==0)intro_cut:camera_move()
    if(intro_cut.state==1)intro_cut:dialog()
    if(intro_cut.state==2)intro_cut:decideorder()
end

function intro_cut:draw()
    --draw additionnal elements during the cutscene here
    dtb_draw(xcam,ycam)
      
    for i=1,#self.dices do
        self.dices[i]:draw()
    end
end

function intro_cut:camera_move()
    local timer = intro_cut._clk/2 % 1
    xcam = lerp(intro_cut.xorigin,intro_cut.xtarget,easeInOut(timer))
    ycam = lerp(intro_cut.yorigin,intro_cut.ytarget,easeInOut(timer))
    if(abs(xcam-intro_cut.xtarget)<0.1)xcam=intro_cut.xtarget
    if(abs(ycam-intro_cut.ytarget)<1)ycam=intro_cut.ytarget
    if(xcam==intro_cut.xtarget and ycam==intro_cut.ytarget)then
        intro_cut.state=1
    end
end

function intro_cut:dialog()
    intro_disc:build()
    intro_disc:queue()
    dtb_update()
end

function intro_cut:spawndices()
    for i=1,#players do
        local yoffset=10
        local d=dice:new(players[i].x+8/2, players[i].y - yoffset)
        add(self.dices,d)
    end
    self.canhitdices=true
    intro_cut.state=2
end

function intro_cut:decideorder()
    for i=1,#self.dices do
        self.dices[i]:update()
    end
    if(self.canhitdices)then
        --TODO: implement input listening for hitting dices with each player
    end
end