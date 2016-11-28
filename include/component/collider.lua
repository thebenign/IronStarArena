local collider = {
    list = {},
    table = {},
    enum = 0,
    size = 150,
    world = require("world").getSize()
    }
collider.__index = collider
collider.w = math.ceil(collider.world[1]/collider.size)

function collider:give()
    collider.enum = collider.enum + 1
    collider.list[collider.enum] = self
    return setmetatable({id = collider.enum, cells = {}, dynamic = true}, collider)
end

function collider:setType(t, ...)
    arg = {...}
    if t == "rectangle" then
        self.w = arg[1]
        self.h = arg[2]
    elseif t == "circle" then
        self.r = arg[1]
        self.w = arg[1]*2
        self.h = arg[1]*2
        self.addMethod = collider.addCircle
    elseif t == "point" then
        self.w = 0
        self.h = 0
    else
        error(t.." is not a valid collider type")
    end
    self.t = t
end


function collider:add()
    collider.list[self.id].collider:addMethod()
end

function collider.addCircle(self)
    local cells = collider.getCells(self.position.x-self.collider.r, self.position.y-self.collider.r, self.collider.w, self.collider.h)
    CELLS = cells
    self.collider.cells = cells
    for i = 1, #cells do
        --collider.list[cells[i]] = self.ref
        
    end
    
end

function collider.getCells(x, y, w, h)
    local cells = {}
    local temp = {}
    local c = 0
    local points = {x, y, x+w, y, x, y+h, x+w, y+h}
    local tx, ty
    for i = 1, 7, 2 do
        ty = points[i+1]/collider.size
        tx = points[i]/collider.size
        c = (ty-ty%1)*collider.w+(tx-tx%1)+1
        if not temp[c] then
            temp[c] = true
            cells[#cells+1] = c
        end
    end
    return cells
end

function collider:update()
    collider.addCircle(collider.list[self.collider.id])    
    ENUM = collider.enum
end

function collider:destroy()
    local id = self.collider.id
    collider.list[collider.enum].collider.id = id
    collider.list[id] = collider.list[collider.enum]
    collider.enum = collider.enum - 1
end
    
return collider