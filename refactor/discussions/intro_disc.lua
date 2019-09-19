intro_disc={}
intro_disc.lines={}
intro_disc.isbuilt=false
intro_disc.isqueued=false

function intro_disc:build()
    if(self.isbuilt)return

    local line1="yo"
    local line2="it works"
    add(self.lines,line1)
    add(self.lines,line2)

    intro_disc.isbuilt=true
end

function intro_disc:queue()
    if(self.isqueued)return

    for i=1,#self.lines do
        dtb_disp(self.lines[i])
    end

    self.isqueued=true
end