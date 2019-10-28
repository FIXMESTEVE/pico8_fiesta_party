intro_disc_part3={}
intro_disc_part3.lines={}
intro_disc_part3.isbuilt=false
intro_disc_part3.isqueued=false

function intro_disc_part3:build()
    if(self.isbuilt)return
    my_dtb_init() --reset my_dtb
    my_dtb_portrait=197
    my_dtb_name="the announcer"

    for i=1,#players do
        local order=""
        if(i==1)then
            order=1 .."st"
        elseif(i==2)then
            order=2 .."nd"
        elseif(i==3)then
            order=3 .."rd"
        elseif(i==4)then
            order=4 .."th"
        end

        local call=nil
        if(i==#players)then
            call=function()
                intro_cut.state=4
            end
        end
        local line={line=players[i].name.." will be playing "..order.."!",options=nil,callback=call}

        add(self.lines,line)
    end

    self.isbuilt=true
end

function intro_disc_part3:queue()
    if(self.isqueued)return

    for i=1,#self.lines do
        my_dtb_disp(self.lines[i])
    end

    self.isqueued=true
end