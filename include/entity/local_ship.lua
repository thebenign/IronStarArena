return function (entity)
    
    local ship = entity.register() -- Register your entity with the entity controller.
    
    local can_shoot = true        -- these are just some locals to track things that 
    local rot_speed = math.rad(6) -- aren't really part of the ECS (yet)
    
    ship:has(
        "position",
        "control", 
        "velocity", 
        "timer", 
        "sfx", 
        "collider", 
        "particle",
        "new_sprite"
    )
    
    local bullet_timer = ship.timer(4, false)   -- here's a timer
    local follow_timer = ship.timer(10, true)
    
    for k, v in pairs(bullet_timer) do
        print (k,v)
    end
    
    --New Sprite Testing Below
    ship.new_sprite:set("ship", 3)
    ship.new_sprite:setOrigin("center")
    ship.new_sprite:setScale(.25)
    ship.new_sprite:activate()
    
    --
    -- acquire the components
    local engine1 = ship.particle:newSystem()
    local engine2 = ship.particle:newSystem()
    
    ship.particle:set("all", 
        {
            run = false,
            scale = .4,
            spread = math.rad(30),
            dist = 0,
            max_s = 3,
            min_s = 0,
            lt = 6,
            hsl = {10,128,100,255}
        }
    )
    
    engine1:followFunction(
        function()
            return ship.position.x-math.cos(ship.position.a-math.rad(36))*40
        end,
        function()
            return ship.position.y-math.sin(ship.position.a-math.rad(36))*40
        end
    )
    
    engine2:followFunction(
        function()
            return ship.position.x-math.cos(ship.position.a+math.rad(36))*40
        end,
        function()
            return ship.position.y-math.sin(ship.position.a+math.rad(36))*40
        end
    )

    ship.sfx:new("laser16")
    ship.sfx:setVolume("laser16", .3)
    
    ship.sfx:new("engine_2")
    ship.sfx:play("engine_2", true)
    ship.sfx:setVolume("engine_2", .1)
    
    ship.position:set(150, 150)
    
    local enemy = entity("circle_enemy")
    
    follow_timer.call = function()
        enemy.velocity:set(
            enemy.velocity.trig.theta(
                ship.position.x,
                ship.position.y,
                enemy.position.x,
                enemy.position.y),
            2)
    end

    
    
    ship.collider:setType("circle", 30)    -- set the collider type to circle with a radius of 30
    ship.collider:collidesWith("map")      -- collision events will be triggered by "map" entities
    ship.collider:setAction("map", "c2r")  -- the collision resolution algorithm to use when colliding with "map"
                                           -- I'll probably remove this and let the engine decide
    
    
    ship.velocity.mag = 0
    ship.velocity.max = 8
    ship.velocity.fric = .1
    
    -- defining keyboard controls
    
    ship.control:on("up", function(self)
            ship.particle:set("all", {
                    run = true,
                    a = ship.position.a-math.pi
                }
            )
            self.velocity:add(self.position.a, .6)  -- velocity component has all the trig you need
            self.sfx:setVolume("engine_2", .9)      -- to do any kind of translations between positions
        end
    )
    
    ship.control:onRelease("up", function(self)
            ship.particle:set("all", {run = false})
            self.sfx:setVolume("engine_2", .1)
        end
    )
    
    ship.control:on("space", function(self)
            local hsl = engine2:get("hsl")
            hsl[1] = (hsl[1] + 1) % 255
            --engine1:setColor(hsl)
            --engine2:setSingle("hsl", hsl)
            engine2.hsl = hsl
            engine2.rgb = {200,200,200,200}
        end
    )
    
    ship.control:on("left", function(self)
            self.position.a = self.position.a - rot_speed
            self.new_sprite:setRotation(self.position.a)
        end
    )
    ship.control:on("right", function(self)
            self.position.a = self.position.a + rot_speed
            self.new_sprite:setRotation(self.position.a)
        end
    )
    ship.control:on("a", function(self)
            if can_shoot then
                --self.velocity:add(self.position.a, -.7)
                self.sfx:play("laser16", false)
                local bullet = self.new("bullet")
                bullet.velocity.mag = 24
                bullet.velocity.dir = ship.position.a+ math.rad(math.random(5)-2.5)
                
                bullet.position:set(bullet.velocity.trig.translate(
                        ship.position.x, 
                        ship.position.y,
                        bullet.velocity.dir,
                        ship.collider.r-16
                    )
                )
                local part = bullet.particle:newSystem()
                part:follow(bullet)
                part.a = ship.position.a
                part.spread = math.rad(10)
                part.hsl = {math.random(255),128,140,255}
                part.pps = 5
                part.max_s = 10
                part.min_s = 7
                part.scale = .25
                part.lt = 8
                part.fric = 0
                
                can_shoot = false
                bullet_timer:start()
            end
        end
    )
    
    bullet_timer.call = function(self)
        can_shoot = true
        bullet_timer:pause()
    end
    
    return ship
end