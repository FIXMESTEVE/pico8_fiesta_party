transition_manager={}
transition_manager.__index=transition_manager

function transition_manager:new(current_scn,next_scn,transition)
    local t={
        current_scn = current_scn,
        next_scn = next_scn,
        transition = transition
    }
    setmetatable(t,self)
    return t
end

function transition_manager:execute()
    self.next_scn._init()
    _update60=self.transition._update
    _draw=self.transition._draw
end

function transition_manager:finish()
    scn_mgr:change_scn(self.next_scn)
end