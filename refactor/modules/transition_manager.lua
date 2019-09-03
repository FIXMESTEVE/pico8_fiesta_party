transition_manager={}
transition_manager.__index=transition_manager

function transition_manager:new(current_scn,next_scn)
    local t={
        current_scn = current_scn,
        next_scn = next_scn
    }
    setmetatable(t,self)
    return t
end