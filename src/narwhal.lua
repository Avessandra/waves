local narwhal = {}
local frames = {}
local currentFrame = 1
local elapsed = 0
local pos_x = 40
local pos_y = 40
local narwhal_im

function narwhal.load()
	 	narwhal_im = love.graphics.newImage('assets/nwm.png')
	  local frameWidth = 512
	  local frameHeight = 256
	  local imageWidth = narwhal_im:getWidth()
	  local imageHeight = narwhal_im:getHeight()
		for i = 0, 8 do
		  table.insert(frames, love.graphics.newQuad(i * 512, 0, frameWidth, frameHeight, imageWidth, imageHeight))
		end
end

function narwhal.update(dt, planets)

    elapsed = elapsed + dt
    if elapsed > 0.05 then
        elapsed = elapsed - 0.05
        if currentFrame == 9 then
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
    -- horizontal movement
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
	    pos_x = pos_x - 50*dt
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
	    pos_x = pos_x + 50*dt
    end
    if pos_y < -20 or pos_y > (love.graphics.getHeight()-40) then
        love.event.quit()
    end

		-- for i = 1, planets.counter do
		-- 	if math.sqrt((planets.info[i].data.x + pos_x)^2 + (planets.info[i].data.y + pos_y)^2) <= planets.info[i].data.size_par then
		-- 		if planets.info[i].data.y <= pos_y then
		-- 			if pos_x <= planets.info[i].data.x then
		--
		-- 			else
		--
		-- 			end
		-- 		else
		-- 			if pos_x <= planets.info[i].data.x then
		--
		-- 			else
		--
		-- 			end
		-- 		end
		-- 	end
		-- end

end


function narwhal.draw()
	love.graphics.draw(narwhal_im, frames[currentFrame], pos_x, pos_y, math.rad(-20), 0.3)
end

return narwhal
