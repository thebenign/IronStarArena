local sfx = {
    sound_table = require("sound")
    }
sfx.__index = sfx

function sfx.give(entity)
    return setmetatable({sound_list = {}}, sfx)
end

function sfx:new(source)
    self.sound_list[source] = sfx.sound_table[source]
end

function sfx:play(source, looping)
    self.sound_list[source]:setLooping(looping)
    local _ = self.sound_list[source]:play()
end

function sfx:setVolume(source, vol)
    self.sound_list[source]:setVolume(vol)
end

function sfx.update()
end

return sfx