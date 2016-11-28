local world = {
    camera = require("camera"),
    music = require("music"),
    w = 2600,
    h = 2600
}

function world.update()
    world.camera.update()
end

function world.setSize(w, h)
    world.w = w
    world.h = h
end

function world.getSize()
    return {world.w, world.h}
end

function world.camFollow(entity)
    world.camera.follow(entity)
end

function world.startMusic(source)
    world.music[source]:setLooping(true)
    world.music[source]:setVolume(.6)
    world.music[source]:play()
end

return world