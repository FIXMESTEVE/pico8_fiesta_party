intro_cut={}
intro_cut._clk=0.0
function intro_cut.update()
    intro_cut._clk+=clock.past
    local timer = intro_cut._clk/8 % 1
    local lerped = lerpvec(xcam,ycam,170,270,easeInOut(timer))
    xcam=lerped.x
    ycam=lerped.y
end
function intro_cut.draw()
    --draw additionnal elements during the cutscene here
end