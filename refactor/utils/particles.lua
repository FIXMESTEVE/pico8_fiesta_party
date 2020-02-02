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

--the original twinkle/ephem code is from super poulet poulet by @retsynNL
function make_twinkle(x, y, amount, sprnb)
    for i = 1, amount do
        make_ephem(ephem, x, y, sprnb)
    end
end

function make_ephem(e,x,y,k)
    local e = {}
    -- k for kind!
    e.k = k
    e.x = x
    e.y = y
    e.ax = 0
    e.ay = 0
    -- lower the better
    e.animspeed = 20
    e.frame = 0
    -- randomize the direction
    e.ax += (-(rnd(.5)))
    e.ax += rnd(.5)
    e.ay += (-(rnd(.5)))
    e.ay += rnd(.5)

    add(ephem, e) 
end


function ephem_draw(e)
    e.x += e.ax
    e.y += e.ay

    e.animspeed -= 1
    
    if(e.animspeed <= 0) then
    e.frame += 1
    e.animspeed = 5
    end
    
    if (e.frame > 3) then
    del(ephem, e) 
    end 
    
    spr((e.k + e.frame), e.x, e.y)
end
