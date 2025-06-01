local lurker = require("libs.lurker")
local Paddle = require("paddle")
local Ball = require("ball")
local Timer = require("timer")

function love.load()
    love.window.setMode(800,800)
    love.window.setTitle("Pong v1")

    -- Paddles 
    paddle1 = Paddle:new(10, love.graphics.getHeight()/2 - 50,20,100,600)
    paddle2 = Paddle:new(love.graphics.getHeight() - 30, love.graphics.getHeight()/2 - 50,20,100,600)

    -- Ball 
    ball = Ball:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2,10 ,300)

    -- Player Scores 
    player1Score = 0
    player2Score = 0

    -- Game States
    gameState = "menu"

    -- targetScore
    targetScore = 13 

    -- Timer
    timer = Timer:new(0,300,3)
end

function love.keypressed(key)
    if key == "p" then
        if gameState == "playing" then
            gameState = "paused"
        elseif gameState == "paused" then
            gameState = "countdown"
            timer:start()
        end
    elseif key == "return" then
        if gameState == "menu" then
            gameState = "countdown"
            timer:start()
        elseif gameState == "over" then
            ball:reset()
            player1Score = 0
            player2Score = 0
            gameState = "countdown"
            timer:start()
        end
    elseif key == "r" then
        player1Score = 0
        player2Score = 0
        gameState = "playing"
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    lurker.update()
    if gameState == "playing" then

        paddle1:update(dt, "w", "s")
        paddle2:update(dt, "up", "down")

        ball:update(dt)

        -- Check collisions with paddles
        if ball:collides(paddle1) then
            ball.vx = -ball.vx
            ball.x = paddle1.x + paddle1.width + ball.radius
        elseif ball:collides(paddle2) then
            ball.vx = -ball.vx
            ball.x = paddle2.x - ball.radius
        end

    -- Check scoring
        if ball.x < 0 then
            player2Score = player2Score + 1
            ball:reset()
        elseif ball.x > love.graphics.getWidth() then
            player1Score = player1Score + 1
            ball:reset()
        end

    -- Check Target Score
        if targetScore ==  player1Score or targetScore == player2Score then
            gameState = "over"
            ball:reset()
            paddle1 = Paddle:new(10, love.graphics.getHeight()/2 - 50,20,100,600)
            paddle2 = Paddle:new(love.graphics.getHeight() - 30, love.graphics.getHeight()/2 - 50,20,100,600)
        end
    elseif gameState == "countdown" then
        timer:update(dt)
        if timer.finished then
            gameState="playing"
        end
    end
end

function love.draw()

    love.graphics.setFont(love.graphics.newFont(24))

    if gameState == "menu" then
        love.graphics.printf("Welcome to pong! hit enter to start", 0 ,350, love.graphics.getWidth(), "center")
    end

    if gameState == "paused" then
        love.graphics.printf("Game paused!, press 'p' to resume", 0 ,350, love.graphics.getWidth(), "center")
    end

    if gameState == "over" then
        if player1Score == targetScore then
            love.graphics.printf("Game over! player 1 wins, press 'enter' to play again", 0 ,350, love.graphics.getWidth(), "center")
        elseif player2Score == targetScore then
            love.graphics.printf("Game over! player wins, press 'enter' to play again", 0 ,350, love.graphics.getWidth(), "center")
        end
    end

    if gameState == "countdown" then
        paddle1:draw()
        paddle2:draw()
        ball:draw()
        timer:draw()
    end

    if gameState == "playing" then 
        paddle1:draw()
        paddle2:draw()
        ball:draw()
        love.graphics.print("Player 1: " .. player1Score, 10, 20)
        love.graphics.print("Player 2: " .. player2Score, love.graphics.getWidth() - 140, 20)
    end
end


