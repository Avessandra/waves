local planets = require('src/planets')

local narwhal = {}
local frames = {}
local currentFrame = 1
local elapsed = 0
local pos_x = 30
local pos_y = 30
local narwhal_im

function narwhal.load()
	 	narwhal_im = love.graphics.newImage('assets/nwm.png')
	  local frameWidth = 512
	  local frameHeight = 256
	  local imageWidth = narwhal_im:getWidth()
	  local imageHeight = narwhal_im:getHeight()
	  table.insert(frames, love.graphics.newQuad(0, 0, frameWidth, frameHeight, imageWidth, imageHeight))
	  table.insert(frames, love.graphics.newQuad(512, 0, frameWidth, frameHeight, imageWidth, imageHeight))
	  table.insert(frames, love.graphics.newQuad(1024, 0, frameWidth, frameHeight, imageWidth, imageHeight))
	  table.insert(frames, love.graphics.newQuad(1536, 0, frameWidth, frameHeight, imageWidth, imageHeight))
	  table.insert(frames, love.graphics.newQuad(2048, 0, frameWidth, frameHeight, imageWidth, imageHeight))
	  table.insert(frames, love.graphics.newQuad(2560, 0, frameWidth, frameHeight, imageWidth, imageHeight))
end

function narwhal.update(dt)

    elapsed = elapsed + dt
    if elapsed > 0.05 then
        elapsed = elapsed - 0.05
        if currentFrame == 6 then
             currentFrame = 1
        else
            currentFrame = currentFrame + 1
        end
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
	love.graphics.draw(narwhal_im, frames[currentFrame], pos_x, pos_y, 0, 0.3)
end

return narwhal
