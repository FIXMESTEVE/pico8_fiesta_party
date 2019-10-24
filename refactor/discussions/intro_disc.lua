intro_disc={}
intro_disc.lines={}
intro_disc.isbuilt=false
intro_disc.isqueued=false

function intro_disc:build()
    if(self.isbuilt)return --this function will only be fired once

    my_dtb_init() --reset my_dtb
    my_dtb_portrait=197
    local yesno={"yes","no"}
    local line1={line="welcome to pico-8 fiesta party!",options=nil,callback=nil}
    local line2={line="do you want to know the rules of this game?",options=yesno,callback=function(option) 
        if(option==2)then
            intro_disc_part2:build()
            intro_disc_part2:queue()         
        end
    end}
    add(self.lines,line1)
    add(self.lines,line2)

    intro_disc.isbuilt=true
end

function intro_disc:queue()
    if(self.isqueued)return --this function will only be fired once

    for i=1,#self.lines do
        my_dtb_disp(self.lines[i])
    end

    self.isqueued=true
end