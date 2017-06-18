return function (entity)
    local enemy = entity.register()
    
    enemy:has("position", "sprite", "velocity", "timer", "collider")
    
    
    enemy.sprite:register(enemy, 3)
    enemy.sprite:setOrigin(32,32)
    
    
    
    enemy.collider:setType("circle", 32)
    
    --enemy.timer:set(300, false)
    
    --enemy.timer.call = function()
        --enemy:destroy()
    --end
    
    
    return enemy
end