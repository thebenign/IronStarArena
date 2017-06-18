return function(entity)
    local bg = entity.register()
    
    bg:has("position", "sprite")
    
    bg.position:setRelative(false)
    
    --bg.sprite:set("background", 1)
    --bg.sprite:setOrigin(0,0)
    --bg.sprite:activate()
    bg.sprite:setSprite("background")
    bg.sprite:register(bg, 1)
    return bg
end