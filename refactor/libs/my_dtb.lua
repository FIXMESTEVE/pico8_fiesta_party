--global param
my_dtb_option=1
player_control=0
my_dtb_clk=0.0
my_dtb_queue={}
boxlines=3
my_dtb_portrait=nil
    
-- call this before you start using dtb.
function my_dtb_init()
    textbox_lerpedx2=0
    textbox_lerpedy2=0
    portrait_lerpedx2=0
    portrait_lerpedy1=0
    boxready=false
    my_dtb_portrait=nil
end

-- this will add a piece of text to the queu. the queu is processed automatically.
function my_dtb_disp(discussion_object)
    add(my_dtb_queue,discussion_object)
end

-- make sure that this function is called each update.
function my_dtb_update()
    if(#my_dtb_queue>0)then
        my_dtb_clk+=clock.past
        if(not boxready)return
        if (is_pressed(4,player_control)) then --O button
            _dtb_nexttext(my_dtb_option)
            return
        elseif (is_pressed(0,player_control)) then --Left arrow
            my_dtb_option=1
        elseif (is_pressed(1,player_control)) then --Right arrow
            my_dtb_option=2
        end
    end
end

-- make sure to call this function everytime you draw.
function my_dtb_draw(xoffset,yoffset)
    local x1=2
    local y1=125-boxlines*8
    local x2=125
    local y2=125
    local portrait_x1=x1
    local portrait_y1=y1-17
    local portrait_x2=x1+17
    local portrait_y2=y1
    local offset=0
    local timer = my_dtb_clk*3 % 1
    
    if(#my_dtb_queue>0)then
        --FIXMESTEVE: replace this with a coroutine
        if(abs(textbox_lerpedx2-x2)<1)then
            textbox_lerpedx2=x2
            boxready=true
        else
            textbox_lerpedx2 = lerp(x1,x2,easeInOut(timer))
        end
        if(abs(textbox_lerpedy2-y2)<1)then
            textbox_lerpedy2=y2
            boxready=true
        else
            textbox_lerpedy2 = lerp(y1,y2,easeInOut(timer))
        end

        if(my_dtb_portrait!=nil)then
            if(abs(portrait_lerpedx2-portrait_x2)<1)then
                portrait_lerpedx2=portrait_x2
            else
                portrait_lerpedx2 = lerp(portrait_x1,portrait_x2,easeInOut(timer))
            end
            if(abs(portrait_lerpedy1-portrait_y1)<1)then
                portrait_lerpedy1=portrait_y1
            else
                portrait_lerpedy1 = lerp(portrait_y2,portrait_y1,easeInOut(timer))
            end 

            rectfill(portrait_x1+xoffset,portrait_lerpedy1+yoffset,portrait_lerpedx2+xoffset,portrait_y2+yoffset,0)
        end

        rectfill(x1+xoffset,y1+yoffset,textbox_lerpedx2+xoffset,textbox_lerpedy2+yoffset,0)
        if(not boxready)return
        if(my_dtb_portrait!=nil)spr(my_dtb_portrait,portrait_x1+1+xoffset,portrait_y1+1+yoffset,2,2)

        --get the words
        local str=my_dtb_queue[1].line
        local words={}
        local w=""
        for i=1,#str do
            if(sub(str,i,i)!=" ")w=w..sub(str,i,i)
            if(sub(str,i,i)==" " or i==#str)then
                add(words, w)
                w=""
            end
        end

        --print the words
        local lettercount=0
        local letterw=4
        local lettery=6
        local wordxoffset=0
        local wordyoffset=0
        for i=1,#words do
            print(words[i].." ",x1+6+xoffset+wordxoffset,y1+2-offset*8+yoffset+wordyoffset,7) --i wrote this y calculation and it's garbage
            wordxoffset+=#words[i]*letterw+4 --add 4 for space
            lettercount+=#words[i]
            if(lettercount>15 and wordyoffset==0)then
                wordyoffset+=lettery
                wordxoffset=0
            end
        end

        --print the options
        if(my_dtb_queue[1].options!=nil)then
            local option1=my_dtb_queue[1].options[1]
            local option2=my_dtb_queue[1].options[2]
            local col=7
            local txt=option1
            
            if(my_dtb_option==1)then
                txt="🅾️"..option1
                col=8
            end
            print(txt,x1+6+xoffset,y1+2-(offset)*8+yoffset+6*2+2,col)
            
            txt=option2
            col=7
            if(my_dtb_option==2)then
                txt="🅾️"..option2
                col=8
            end
            print(txt,x1+105+xoffset,y1+2-(offset)*8+yoffset+6*2+2,col)
        else
            local col=8
            print("🅾️next",x1+100+xoffset,y1+2-(offset)*8+yoffset+6*2+2,col)
        end
    end
end

--private funcs

function _dtb_nexttext(option)
    if my_dtb_queue[1].callback!=nil then
        my_dtb_queue[1].callback(option)
    end

    --cleaning
    del(my_dtb_queue,my_dtb_queue[1])
    sfx(2)
    my_dtb_option=1
end