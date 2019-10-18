-- Dialog Text Box Library
-- Credit: Oli414
-- Original version: https://www.lexaloffle.com/bbs/?tid=28465

-- call this before you start using dtb.
-- optional parameter is the number of lines that are displayed. default is 3.

--global param
my_dtb_option=1
player_control=0

function my_dtb_init()
    my_dtb_queue={}
    boxlines=3
end

-- this will add a piece of text to the queu. the queu is processed automatically.
function my_dtb_disp(discussion_object)
    add(my_dtb_queue,discussion_object)
end

-- make sure that this function is called each update.
function my_dtb_update()
    if(#my_dtb_queue>0)then
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
    local y1=125
    local x2=125
    local y2=125
    local offset=0
    
    if(#my_dtb_queue>0)then
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

        --display the box
        rectfill(x1+xoffset,y1-boxlines*8+yoffset,x2+xoffset,y2+yoffset,0)

        --print the words
        local lettercount=0
        local letterw=4
        local lettery=6
        local wordxoffset=0
        local wordyoffset=0
        for i=1,#words do
            print(words[i].." ",x1+6+xoffset+wordxoffset,y1+2-(boxlines+offset)*8+yoffset+wordyoffset,7) --i wrote this y calculation and it's garbage
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
            if(my_dtb_option==1)col=8
            print(option1,x1+6+xoffset,y1+2-(boxlines+offset)*8+yoffset+6*2+2,col)
            col=7
            if(my_dtb_option==2)col=8
            print(option2,x1+110+xoffset,y1+2-(boxlines+offset)*8+yoffset+6*2+2,col)
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