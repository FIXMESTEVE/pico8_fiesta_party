particles={}
make_dice_particle = function(max_radius, x, y, angle_percent)
    local p={}
    p.type="dice_particle"
    p.max_radius=max_radius
    p.radius=0
    p.originx=x
    p.originy=y
    p.size=3
    p.x=x
    p.y=y
    p.color=7
    p.radiusgrowth=(rnd(2)+1)/2
    p.angle_percent=angle_percent
    p.update=function()
        p.radius+=p.radiusgrowth
        p.size=rnd(2)+1
        if(p.color==7)then
            p.color=10
        else
            p.color=7
        end
        p.x=p.originx + p.radius * cos(p.angle_percent)
        p.y=p.originy + p.radius * sin(p.angle_percent)
    end
    p.draw=function()
        circfill(p.x,p.y,p.size,p.color)
    end
    add(particles,p)
end
particles.clean = function()
    foreach(particles, function(obj)
        if(obj.type=="dice_particle")then
            if(obj.radius > obj.max_radius)then
                del(particles,obj)
            end
        end
    end)
end

function gen_dice_particles(x,y)
    for i=1, 50 do
        make_dice_particle(rnd(20),x,y,rnd(99)/100)
    end
end