local function init(parent)
    local bullet = setmetatable({}, parent)
    
    bullet:has("position", "sprite", "velocity", "timer", "collider")
    
    bullet.collider:setType("circle", 4)
    
    bullet.sprite:setSprite("coin10")
    bullet.sprite:register(bullet, 2)
    
    bullet.sprite:setOrigin(16,16)
    
    bullet.timer:set(45, false)
    bullet.timer.call = function(self)
        self:destroy()
    end
    

    return bullet
end

return init