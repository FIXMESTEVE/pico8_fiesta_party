coin={}

function coin:new(x,y)
    local t={
        x=x,
        y=y,
        spr=1
    }
    return t
end

function coin:update()

end

function coin:draw()
    spr(self.spr,self.x,self.y)
end
