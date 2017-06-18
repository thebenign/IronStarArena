local function init(parent)
    local map = setmetatable({}, parent)
    
    map:has("map", "sprite", "position", "collider")
    
    map.map:new("01")
    
    map.collider:setType("map")
    
    map.sprite:setBatch()
    map.sprite:register(map, 1)
    
    
    return map
end

return init