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
        port=port,
        items={},
        dice=nil
    }
    setmetatable(t,self)
    return t
end

function player:make_dice()
    if(self.dice==nil)self.dice=dice:new(self.x+8/2, self.y-10)
end

function player:update_dice()
    if(self.dice!=nil)then
        self.dice.x=self.x+8/2
        self.dice.y=self.y-10
    end
end
