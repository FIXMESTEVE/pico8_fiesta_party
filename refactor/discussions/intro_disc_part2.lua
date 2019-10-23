intro_disc_part2={}
intro_disc_part2.lines={}
intro_disc_part2.isbuilt=false
intro_disc_part2.isqueued=false

function intro_disc_part2:build()
    if(self.isbuilt)return
    local line1={line="let's decide the order of the players!",options=nil,callback=function(option) 
        intro_cut:spawndices()
        intro_cut.state=2            
    end}
    add(self.lines,line1)

    intro_disc_part2.isbuilt=true
end

function intro_disc_part2:queue()
    if(self.isqueued)return

    for i=1,#self.lines do
        my_dtb_disp(self.lines[i])
    end

    self.isqueued=true
end