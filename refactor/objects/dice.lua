dice={}
dice.__index=dice

function dice:new(x,y)
    local t={
        x=x,
        y=y,
        number=flr(rnd(6)) + 1,

        state=0,
        _clk=0
    }
    setmetatable(t,self)
    return t
end

function dice:update()
    if(self.state==0)then
        self._clk+=clock.past
        if(self._clk>0.05)then
            local n=flr(rnd(6)) + 1
            while(self.number==n)do
                n=flr(rnd(6)) + 1
            end
            self.number=n
            self._clk=0
        end
    end
end

function dice:draw()
    -- rectfill(self.x-2,self.y-2,self.x+6,self.y+6,7)
    circfill(self.x+1,self.y+2,4,7)
    print(""..self.number,self.x-1,self.y,1)
    print(""..self.number,self.x+1,self.y,1)
    print(""..self.number,self.x,self.y+1,1)
    print(""..self.number,self.x,self.y-1,1)
    print(""..self.number,self.x,self.y,10)
end