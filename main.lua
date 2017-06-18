
package.path = package.path .. ";./include/core/?.lua;./include/component/?.lua;./include/entity/?.lua;./include/helper/?.lua;;"

local env = require("env")
local world = require("world")
local entity = require("ecs")
local under_run = false
local frames = 0

io.stdout:setvbuf("no")
CELLS = {}

require("run")

function love.load(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    
    --local bg = entity("background")
    entity("the_map")
    local ship = entity("local_ship")
    --local hud = entity("hud")
    
    world.camFollow(ship)
    
    world.startMusic(1)
end

function love.update(dt)
    env.dt = env.dt + dt

    if env.dt >= env.t then
        frames = frames + 1
        world.update()
        entity.update(1)
        --env.alpha = env.dt / env.t
        
        env.dt = env.dt - env.t
        --print(env.alpha, env.dt, dt)
    end
    
    --[[
    if env.dt > env.t then
        under_run = true
        print("Under Run", env.dt, frames)
    else
        under_run = false
    end]]
end

function love.resize(w, h)
    env.window_h = h
    env.window_w = w
end

function love.keypressed(k)
    if k == "5" then
        env.debug = not env.debug
        local w,h,flags = love.window.getMode()
        flags.vsync = not flags.vsync
        --love.window.setMode(w, h, flags)
    end
    if k == "-" then
      world.setGlobalVolume("sub", .05)
    end
    if k == "=" then
      world.setGlobalVolume("add", .05)
    end
end

function love.draw()
    if not under_run then
        if env.full_redraw then love.graphics.clear(love.graphics.getBackgroundColor()) end
        entity.draw()
        love.graphics.print(
        "FPS: "..love.timer.getFPS()..
        "\nEntities: "..entity.enum..
        "\nCollider entities: "..tostring(ENUM)
        , 16, 16)
        
    end
    --love.graphics.present()
end