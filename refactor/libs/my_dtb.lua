-- Dialog Text Box Library
-- Credit: Oli414
-- Original version: https://www.lexaloffle.com/bbs/?tid=28465

-- call this before you start using dtb.
-- optional parameter is the number of lines that are displayed. default is 3.
function my_dtb_init()
    my_dtb_queue={}
end

-- this will add a piece of text to the queu. the queu is processed automatically.
function my_dtb_disp(discussion_object)
    add(my_dtb_queue,discussion_object)
end

-- make sure that this function is called each update.
function my_dtb_update()
    
end

-- make sure to call this function everytime you draw.
function my_dtb_draw(xoffset,yoffset)
    if(#my_dtb_queue>0)then
        print(my_dtb_queue[1].line,4+xoffset,119+yoffset,7)
    end
end