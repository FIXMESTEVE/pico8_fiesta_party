intro_disc={}
intro_disc.lines={}
intro_disc.isbuilt=false
intro_disc.isqueued=false

function intro_disc:build()
    if(self.isbuilt)return
    local yesno={"yes","no"}
    local line1={line="welcome to pico-8 fiesta party!",options=nil,callback=nil}
    local line2={line="do you want to know the rules of this game?",options=yesno,callback=function(option) 
        if(option==2)then
            intro_cut:spawndices()
            intro_cut.state=2            
        end
    end}
    add(self.lines,line1)
    add(self.lines,line2)

    intro_disc.isbuilt=true
end

function intro_disc:queue()
    if(self.isqueued)return

    for i=1,#self.lines do
        -- dtb_disp(self.lines[i].line,self.lines[i].callback)
        my_dtb_disp(self.lines[i])
    end

    self.isqueued=true
end