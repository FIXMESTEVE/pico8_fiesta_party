player={}
player.__index=player

function player:new(number,x,y,char,coins,emblems,name,port)
    local t={
        number=number,
        x=x,
        y=y,
        char=char,
        coins=coins,
        emblems=emblems,
        name=name,
        cell=editor_cells[1], --init start cell
        port=port
    }
    setmetatable(t,self)
    return t
end
