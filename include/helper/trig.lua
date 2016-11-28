local trig = {}

function trig.distance(x1, y1, x2, y2)
    return math.sqrt((y1-y2)^2 + (x1-x2)^2)
end

function trig.theta(x1, y1, x2, y2)
    return math.atan2(y1 - y2, x1 - x2)
end

function trig.translate(x, y, dir, mag)
    return x + math.cos(dir)*mag, y + math.sin(dir)*mag
end

return trig