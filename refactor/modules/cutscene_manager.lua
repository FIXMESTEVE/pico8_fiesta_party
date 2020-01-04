cutscene_manager={}
cutscene_manager.__index=cutscene_manager

function cutscene_manager:new()
    local t={
        cut=nil,
        enabled=false
    }
    setmetatable(t,self)
    return t
end

function cutscene_manager:set_cutscene(cutscene)
    if(self.cut==cutscene)return
    self.cut=cutscene
    self.cut:init()
end

function cutscene_manager:enable(cutscene)
    self.enabled=true
end

function cutscene_manager:disable(cutscene)
    self.enabled=false
end

function cutscene_manager:draw()
    if(self.enabled)self.cut:draw()
end

function cutscene_manager:update()
    if(self.enabled)self.cut:update()
end
