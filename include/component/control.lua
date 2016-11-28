local control = {}
control.__index = control

function control.give(entity)
    return setmetatable({button={}, unbutton = {}}, control)
end

function control:set(button, call)
    self.button[button] = {
        call = call,
        pressed = false
        }
end

function control:setRelease(button, call)
    self.unbutton[button] = call
end

function control:update()
    for button, table in pairs(self.control.button) do
        if love.keyboard.isDown(button) then
            table.call(self)
            table.pressed = true
        elseif table.pressed and self.control.unbutton[button] then
            self.control.unbutton[button](self)
            table.pressed = false
        end
    end
end

return control