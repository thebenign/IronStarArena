local function init(parent)
    local hud = setmetatable({}, parent)
    
    hud:has("position", "control", "gui")
    
    --hud.box = hud.gui.newElement("rectangle", 32, 32, 64, 64)
    --hud.box:setText("Hello")
    --hud.box:setRadius(10)
    
    return hud
end

return init