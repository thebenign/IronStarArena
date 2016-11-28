local function init(parent)
    local ship = setmetatable({}, parent)
    
    ship.can_shoot = true
    
    ship:has("position", "sprite", "control", "velocity", "timer", "sfx", "collider")
    
    ship.sfx:new("laser16")
    ship.sfx:setVolume("laser16", .2)
    ship.sfx:new("engine_2")
    ship.sfx:play("engine_2", true)
    ship.sfx:setVolume("engine_2", .1)
    
    ship.position:set(40, 48)
    ship.collider:setType("circle", 20)
    
    ship.sprite:setSprite("ship")
    ship.sprite:register(ship, 3)
    ship.sprite:setOrigin(145, 163)
    ship.sprite.scale = .25
    
    ship.velocity.mag = 0
    ship.velocity.max = 10
    ship.velocity.fric = .1
    
    ship.control:set("up", function(self)
            self.velocity:add(self.sprite.rot, .5)
            self.sfx:setVolume("engine_2", .9)
        end
    )
    
    ship.control:setRelease("up", function(self)
            self.sfx:setVolume("engine_2", .1)
        end
    )
    
    ship.control:set("left", function(self)
            self.sprite.rot = self.sprite.rot - math.rad(7)
        end
    )
    ship.control:set("right", function(self)
            self.sprite.rot = self.sprite.rot + math.rad(7)
        end
    )
    ship.control:set("a", function(self)
            if self.can_shoot then
                self.sfx:play("laser16", false)
                local bullet = self.new("bullet")
                bullet.position.x = self.position.x
                bullet.position.y = self.position.y
                bullet.velocity.dir = ship.sprite.rot
                bullet.velocity.mag = 16
                self.can_shoot = false
                self.timer.run = true
            end
        end
    )
    
    ship.timer:set(1, false)
    
    ship.timer.call = function(self)
        self.can_shoot = true
        self.timer.run = false
    end
    
    return ship
end

return init