intro_disc={}
intro_disc.lines={}
intro_disc.isbuilt=false
intro_disc.isqueued=false

function intro_disc:build()
    if(self.isbuilt)return

    local line1={line="welcome to pico-8 fiesta party!",callback=nil}
    local line2={line="do you want to know the rules of this game?",callback=function() intro_cut:spawndices() end}
    add(self.lines,line1)
    add(self.lines,line2)

    intro_disc.isbuilt=true
end

function intro_disc:queue()
    if(self.isqueued)return

    for i=1,#self.lines do
        dtb_disp(self.lines[i].line,self.lines[i].callback)
    end

    self.isqueued=true
end