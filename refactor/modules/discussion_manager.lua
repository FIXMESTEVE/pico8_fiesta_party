discussion_manager={}
discussion_manager.__index=discussion_manager

function discussion_manager:new()
    local t={
        disc=nil,
        enabled=false
    }
    setmetatable(t,self)
    return t
end

function discussion_manager:set_discussion(discussion)
    self.disc=discussion
end

function discussion_manager:enable(discussion)
    self.enabled=true
end

function discussion_manager:disable(discussion)
    self.enabled=false
end

function discussion_manager:draw()
    if(self.enabled)self.disc.draw()
end

function discussion_manager:update()
    if(self.enabled)self.disc.update()
end
