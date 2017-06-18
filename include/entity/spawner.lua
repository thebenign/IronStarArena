return function (entity)
    local spawner = entity.register()
    
    spawner:has("position", "sprite", "timer")
    
    local count = 0
    
    spawner.timer:set(0, true)
    spawner.position:set(600, 600)
    
    spawner.timer.call = function()
        spawner.timer:set(10, true)
        count = count + 1
        local enemy = entity("circle_enemy")
        enemy.position:set(spawner.position:get())
    end
    
    
    return spawner
end