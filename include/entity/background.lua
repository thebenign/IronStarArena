return function(entity)
    local bg = entity.register()
    
    bg:has("position", "new_sprite")
    
    bg.position:setRelative(false)
    
    bg.new_sprite:set("background", 1)
    bg.new_sprite:setOrigin(0,0)
    bg.new_sprite:activate()
    return bg
end