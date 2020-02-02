coin={}
coin.__index=coin

function coin:new(x,y)
    local t={
        x=x,
        y=y,
        spr=1
    }
    setmetatable(t,self)
    return t
end

function coin:update()

end

function coin:draw()
    outline_sprite(self.spr,1,self.x,self.y,1,1,false,false)
end
