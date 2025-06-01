local Timer = {}
Timer.__index = Timer

function Timer:new(x,y,duration)
    local self = setmetatable({}, Timer)

    self.x = x
    self.y = y 
    self.duration = duration 
    self.timeLeft = duration 
    self.active = false 
    self.finished= false 

    return self

end


function Timer:start()
    self.timeLeft  = self.duration
    self.active = true
    self.finished = false
end

function Timer:update(dt)
    if self.active and self.timeLeft > 0 then
        self.timeLeft = self.timeLeft - dt
        if self.timeLeft <= 0 then
            self.timeLeft = 0
            self.active = false
            self.finished = true
        end
    end
end

function Timer:draw()
    if  self.active then
        local count = math.ceil(self.timeLeft)
        love.graphics.setColor(1,1,1)
        love.graphics.printf(tostring(count), 0 ,self.y, love.graphics.getWidth(), "center")
    end
end

return Timer