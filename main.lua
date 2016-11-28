package.path = package.path .. ";./include/core/?.lua;./include/component/?.lua;./include/entity/?.lua;./include/helper/?.lua;"

local entity = require("ecs")
local env = require("env")
local world = require("world")

CELLS = {}

function love.load(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    
    --local bg = entity("background")
    entity("the_map")
    local ship = entity("local_ship")
    world.camFollow(ship)
    world.startMusic(1)
end

function love.update(dt)
    env.dt = env.dt + dt
    if env.dt > env.t then
        world.update()
        entity.update()
        env.dt = env.dt - env.t
    end
end

function love.resize(w, h)
    env.window_h = h
    env.window_w = w
end

function love.draw()
    
    entity.draw()
    love.graphics.print(love.timer.getFPS().."\n"..entity.enum.."\n"..tostring(ENUM), 16, 16)
    for y = 0, 18 do
        love.graphics.line(-world.camera.x, y*150-world.camera.y,2600-world.camera.x,y*150-world.camera.y)
    end
    for x = 0, 18 do
        love.graphics.line(x*150-world.camera.x, 0-world.camera.y, x*150-world.camera.x, 2600-world.camera.y)
    end
    
    for i, v in ipairs(CELLS) do
        love.graphics.print(i..", "..v, 16, 64+i*16)
    end
    
end