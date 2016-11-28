local function init(parent)
    local bg = setmetatable({}, parent)
    
    bg:has("position", "sprite")
    bg.position:setRelative(false)
    bg.sprite:setSprite("background")
    bg.sprite:register(bg, 1)
    return bg
end

return init