return function(entity)
  local bullet = entity.register()

  bullet:has("position", "velocity", "timer", "collider", "sfx", "particle")


  --bullet.sfx:new("wump")
  --bullet.sfx:setVolume("wump", .3)

  bullet.collider:setType("circle", 10)
  bullet.collider:collidesWith("map")
  bullet.collider:setAction("map", "c2r")
  bullet.collider:setFunctionOn("map", function(self)
      --self.sfx:play("wump", false)
      self:destroy()
    end
  )

--  local part = bullet.particle:newSystem()
--  part:follow(bullet)
--  --part.a = ship.position.a
--  part.spread = math.rad(10)
--  part.hsl = {math.random(255),128,60,255}
--  part.pps = 5
--  part.max_s = 7
--  part.min_s = 3
--  part.scale = .5
--  part.lt = 10
--  part.fric = 0

  --[[bullet.sprite:setSprite("coin10")
  bullet.sprite.scale = .75
  bullet.sprite:register(bullet, 2)

  bullet.sprite:setOrigin(16,16)]]

  local timer = bullet.timer(60, false)
  
  timer.call = function(self)
    self:destroy()
  end

  return bullet
end