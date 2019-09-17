intro_cut={}
intro_cut._clk=0.0
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
    dtb_draw()
end

function intro_cut.camera_move()
    local timer = intro_cut._clk/8 % 1
    local lerpx = lerp(xcam,intro_cut.xtarget,easeInOut(timer))
    local lerpy = lerp(ycam,intro_cut.ytarget,easeInOut(timer))
    xcam=lerpx
    ycam=lerpy
    printh("--xcam "..tostr(xcam,true).." intro_cut.xtarget "..tostr(intro_cut.xtarget,true),"@clip")
    if(abs(xcam-intro_cut.xtarget)<0.1)then
        --printh("should work","@clip")
        intro_cut.state=1
    end
    
    --xcam 170 intro_cut.xtarget 170
end

function intro_cut.dialog()
    dtb_update()
    dtb_disp("hello")
end
