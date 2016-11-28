local timer = {}
timer.__index = timer

function timer.give(entity)
    return setmetatable({
            t = 60,
            dt = 0,
            call = function() end,
            loop = false,
            run = true
        }, timer
    )
end

function timer:set(t, loop)
    self.t = t
    self.loop = loop
end

function timer:update()
    if self.timer.run then
        self.timer.dt = self.timer.dt + 1
    end
    if self.timer.dt > self.timer.t then
        self.timer.call(self)
        self.timer.dt = 0
        if not self.timer.loop then
            self.timer.run = false
        end
    end
    
end

return timer