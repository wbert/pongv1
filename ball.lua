local Ball = {}
Ball.__index = Ball

function Ball:new(x,y, radius, speed)
    local self = setmetatable({}, Ball)
    self.x = x
    self.y = y
    self.radius = radius
    self.speed = speed
    self.vx = speed
    self.vy = speed
    return self
end


function Ball:update(dt)
    self.x = self.x + self.vx* dt
    self.y = self.y + self.vy* dt

    if self.y < 0 then
        self.y =  0
        self.vy = -self.vy
    elseif self.y > love.graphics.getHeight() - self.radius then
        self.y = love.graphics.getHeight() - self.radius
        self.vy = -self.vy
    end
end

function Ball:draw()
  love.graphics.circle("fill", self.x, self.y, self.radius)
end


function Ball:reset()
    self.x = love.graphics.getWidth() /2
    self.y = love.graphics.getHeight() /2
    self.vx = self.speed * (math.random(2) == 1 and 1 or -1) 
    self.vy = self.speed * (math.random(2) == 1 and 1 or -1) 
end

function Ball:collides(paddle)
  return self.x - self.radius < paddle.x + paddle.width and
         self.x + self.radius > paddle.x and
         self.y - self.radius < paddle.y + paddle.height and
         self.y + self.radius > paddle.y
end

return Ball