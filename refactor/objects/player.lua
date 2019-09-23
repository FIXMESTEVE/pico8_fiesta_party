player={}
player.__index=player

function player:new(number,x,y,char,coins,emblems)
    local t={
        number=number,
        x=x,
        y=y,
        char=char,
        coins=coins,
        emblems=emblems
    }
    setmetatable(t,self)
    return t
end
