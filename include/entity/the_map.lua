local function init(parent)
    local map = setmetatable({}, parent)
    
    map:has("map", "sprite", "position")
    map.map:new("01")
    map.sprite:setBatch()
    map.sprite:register(map, 1)
    
    
    return map
end

return init