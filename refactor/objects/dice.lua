dice={}
dice.__index=dice

function dice:new(x,y)
    local t={
        x=x,
        y=y,
        number=flr(rnd(6)) + 1,

        _state=0,
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