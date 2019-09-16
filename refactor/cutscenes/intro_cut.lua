intro_cut={}
intro_cut._clk=0.0

function intro_cut.update()
    intro_cut._clk+=clock.past
    local timer = intro_cut._clk/8 % 1
    local lerpx = lerp(xcam,170,easeInOut(timer))
    local lerpy = lerp(ycam,270,easeInOut(timer))
    xcam=lerpx
    ycam=lerpy
end

function intro_cut.draw()
    --draw additionnal elements during the cutscene here
end