-- Load some default values for our rectangle.
function love.load()
	narwhal = love.graphics.newImage('nwm.png')
    frameWidth = 512
    frameHeight = 256
    imageWidth = narwhal:getWidth()
    imageHeight = narwhal:getHeight()
    frames = {
                 love.graphics.newQuad(0, 0, frameWidth, frameHeight, imageWidth, imageHeight),
                 love.graphics.newQuad(512, 0, frameWidth, frameHeight, imageWidth, imageHeight),
                 love.graphics.newQuad(1024, 0, frameWidth, frameHeight, imageWidth, imageHeight),
                 love.graphics.newQuad(1536, 0, frameWidth, frameHeight, imageWidth, imageHeight),
                 love.graphics.newQuad(2048, 0, frameWidth, frameHeight, imageWidth, imageHeight),
                 love.graphics.newQuad(2560, 0, frameWidth, frameHeight, imageWidth, imageHeight),
             }
    currentFrame = 1
    elapsed = 0
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    elapsed = elapsed + dt
    if elapsed > 0.1 then
        elapsed = elapsed - 0.1
        if currentFrame == 6 then
             currentFrame = 1
        else
            currentFrame = currentFrame + 1
        end
    endrrentFrame = currentFrame + 1
    end
end
 
-- Draw a coloured rectangle.
function love.draw()
	love.graphics.draw(narwhal, frames[currentFrame], 50, 50)
end