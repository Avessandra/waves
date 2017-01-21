local narwhal = {}

function narwhal.load()
	narwhal = love.graphics.newImage('assets/nwm.png')
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
    pos_x=30
    pos_y=30
end

-- Increase the size of the rectangle every frame.
function narwhal.update(dt)
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

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        pos_y = pos_y + 100*dt
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    	pos_y = pos_y - 100*dt
   	end

    if pos_y < -20 or pos_y > (love.graphics.getHeight()-40) then
        love.event.quit()
    end
end

-- Draw a coloured rectangle.
function narwhal.draw()
	love.graphics.draw(narwhal, frames[currentFrame], pos_x, pos_y, 0, 0.3)
end

return narwhal
