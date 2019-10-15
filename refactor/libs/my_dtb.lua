-- Dialog Text Box Library
-- Credit: Oli414
-- Original version: https://www.lexaloffle.com/bbs/?tid=28465

-- call this before you start using dtb.
-- optional parameter is the number of lines that are displayed. default is 3.
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
    if btnp(4) then
        _dtb_nexttext()
        return
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
        rectfill(x1+xoffset,y1-boxlines*8+yoffset,x2+xoffset,y2+yoffset,0)
        print(my_dtb_queue[1].line,4+xoffset,124-(boxlines+offset)*8+yoffset,7)
    end
end

--private funcs

function _dtb_nexttext()
    if my_dtb_queue[1].callback!=nil then
        my_dtb_queue[1].callback()
    end
    del(my_dtb_queue,my_dtb_queue[1])
    sfx(2)
end