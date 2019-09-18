intro_cut={}
intro_cut._clk=0.0
intro_cut.xorigin=xcam
intro_cut.yorigin=ycam
intro_cut.xtarget=170
intro_cut.ytarget=270
intro_cut.state=0
function intro_cut.update()
    intro_cut._clk+=clock.past
    if(intro_cut.state==0)intro_cut.camera_move()
    if(intro_cut.state==1)intro_cut.dialog()    
end

function intro_cut.draw()
    --draw additionnal elements during the cutscene here
    --dtb_draw(xcam,ycam)
end

function intro_cut.camera_move()
    if(abs(xcam-intro_cut.xtarget)<0.1)return
    -- printh("--xcam "..tostr(xcam,true).." intro_cut.xtarget "..tostr(intro_cut.xtarget,true),"@clip")
    printh("--xcam "..xcam.." intro_cut.xtarget "..intro_cut.xtarget,"@clip")
    --xcam 0x00a8.c492 intro_cut.xtarget 0x00aa.0000
    --xcam 168.7679 intro_cut.xtarget 170

    local timer = intro_cut._clk/2 % 1
    xcam = lerp(intro_cut.xorigin,intro_cut.xtarget,easeInOut(timer))
    ycam = lerp(intro_cut.yorigin,intro_cut.ytarget,easeInOut(timer))
    -- if(abs(xcam-intro_cut.xtarget)<1)xcam=intro_cut.xtarget
    -- if(abs(ycam-intro_cut.ytarget)<1)ycam=intro_cut.ytarget
    if(xcam==intro_cut.xtarget and ycam==intro_cut.ytarget)then
        intro_cut.state=1
    end
    --xcam 0x00a9.e82f intro_cut.xtarget 0x00aa.0000
    --xcam 170 intro_cut.xtarget 170
end

function intro_cut.dialog()
    dtb_update()
    dtb_disp("hello")
end
