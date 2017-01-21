local narwhal = {}
local frames = {}
local currentFrame
local elapsed
local pos_x
local pos_y
local narwhal_im
local rotation
local velocity

function narwhal.load()
		narwhal.reset()
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

		for _, planet in ipairs(planets.info) do
			if math.sqrt((planet.data.x - pos_x)^2 + (planet.data.y - pos_y)^2) <= planet.data.size_par*4 then
				local narwhal_to_planet = {
					x = planet.data.x - pos_x,
					y = planet.data.y - pos_y
				}
				local narwhal_grad = math.atan2(narwhal_to_planet.y, narwhal_to_planet.x)
				rotation = narwhal_grad
				pos_x = pos_x + dt*narwhal_to_planet.x
				pos_y = pos_y + dt*narwhal_to_planet.y
				-- if planet.data.y <= pos_y then
				-- 	if pos_x <= planet.data.x then
				--
				-- 	else
				--
				-- 	end
				-- else
				-- 	if pos_x <= planet.data.x then
				--
				-- 	else
				--
				-- 	end
				-- end
			end
		end
		pos_x = pos_x + ( math.cos(rotation) * velocity - math.sin(rotation) * velocity) * dt
		pos_y = pos_y + ( math.sin(rotation) * velocity - math.cos(rotation) * velocity) * dt

end


function narwhal.draw()
	love.graphics.draw(narwhal_im, frames[currentFrame], pos_x, pos_y, math.rad(-20)+rotation, 0.3)
end

function narwhal.reset()
	currentFrame = 1
	elapsed = 0
	pos_x = 40
	pos_y = 40
	rotation = 0
	velocity = 200
end
return narwhal
