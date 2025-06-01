local Paddle = {}
Paddle.__index = Paddle

function Paddle:new(x,y, width, height, speed)
    local self = setmetatable({},  Paddle)
    self.x = x
    self.y= y
    self.width = width
    self.height =height
    self.speed = speed

    return self
end

function Paddle:update(dt,upKey, downKey)
    if love.keyboard.isDown(upKey) then
        self.y = math.max(0, self.y - self.speed * dt)
    elseif love.keyboard.isDown(downKey) then
        self.y =  math.min(love.graphics.getHeight() - self.height, self.y + self.speed * dt)
    end
end

function Paddle:reset()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle