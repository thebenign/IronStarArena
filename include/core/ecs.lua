--== Entity Component System ==--

--[[
    The entity component system.
--]]
    


local entity = setmetatable({
    enum = 0,
    list = {},
    }, {__call = function(t, name) return t.new(name) end})
entity.__index = entity

entity.component_table = {
    position = require("position"),
    sprite = require("sprite"),
    control = require("control"),
    velocity = require("velocity"),
    timer = require("timer"),
    sfx = require("sfx"),
    map = require("map"),
    collider = require("collider")
}

entity.entity_table = {
    "local_ship",
    "background",
    "bullet"
}

function entity.populate()
    for i, v in ipairs(entity.entity_table) do
        entity.new(v)
    end
end

function entity.new(name)
    local ent = require(name)(entity)
    entity.enum = entity.enum + 1
    entity.list[entity.enum] = ent
    return ent
end

function entity:destroy()
    self.d_flag = true
end

function entity:has(...)
    local args = {...}
    for i, v in ipairs(args) do
        assert(entity.component_table[v], 'Entity tried to acquire component "'..v..'" which does not exist')
        self[v] = entity.component_table[v].give(self)
        self.comp_list = self.comp_list or {}
        self.comp_list[#self.comp_list+1] = v
    end
end

function entity.update()
    local ent, comp
    for i = entity.enum, 1, -1 do
        ent = entity.list[i]
        for c = 1, #entity.list[i].comp_list do
            comp = ent[ent.comp_list[c]]
            comp.update(ent)
        end
        if ent.d_flag then
            for c = 1, #entity.list[i].comp_list do
                comp = ent[ent.comp_list[c]]
                if comp.destroy then comp.destroy(ent) end
            end
            entity.list[i] = entity.list[entity.enum]
            entity.enum = entity.enum - 1
        end
    end
end

function entity.draw()
    entity.component_table.sprite.draw()
end


return entity