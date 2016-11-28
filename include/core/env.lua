local env = {
    t = 1/60,
    dt = 0}

env.window_w, env.window_h = love.window.getMode()

function env.getEnv()
    return env
end

love.keyboard.setKeyRepeat(true)
love.keyboard.setTextInput(false)
love.graphics.setDefaultFilter("linear", "linear")

return env