local narwhal = {}
local frames = {}
local currentFrame
local elapsed
local pos_x
local pos_y
local narwhal_im
local rotation
local velocity
local frameWidth = 512
local frameHeight = 256
local rotspeed = 1

function narwhal.load()
		narwhal.reset()
	 	narwhal_im = love.graphics.newImage('assets/nwm.png')
	  local imageWidth = narwhal_im:getWidth()
	  local imageHeight = narwhal_im:getHeight()
		for i = 0, 8 do
		  table.insert(frames, love.graphics.newQuad(i * 512, 0, frameWidth, frameHeight, imageWidth, imageHeight))
		end
end

function narwhal.update(dt, planets, cam_speed)

    elapsed = elapsed + dt
    if elapsed > (1 / (velocity * 0.1)) then
        elapsed = 0
        if currentFrame == 9 then
             currentFrame = 1
        else
            currentFrame = currentFrame + 1
        end
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        rotation = rotation + rotspeed*dt
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    	rotation = rotation - rotspeed*dt
   	end
    if pos_y < -20 or pos_y > love.graphics.getHeight() + 20 or
			pos_x < 0 then
        love.event.quit()
    end

		for _, planet in ipairs(planets.info) do
			local narwhal_to_planet = {
				x = planet.data.x - pos_x,
				y = planet.data.y - pos_y
			}
			local distance = math.sqrt((planet.data.x - pos_x)^2 + (planet.data.y - pos_y)^2)

			if distance <= planet.data.size_par then
				love.event.quit()
			elseif distance <= planet.data.size_par*4 then
				local narwhal_grad = math.atan2(narwhal_to_planet.y, narwhal_to_planet.x)
				local gravity = planet.data.size_par / distance^2
				rotation = lerp(rotation, narwhal_grad, gravity * 2)
				velocity = velocity+gravity*100
			end
		end

		velocity = velocity - (velocity*0.01*dt)
		pos_x = pos_x + ( math.cos(rotation)) *velocity* dt - cam_speed
		pos_y = pos_y + ( math.sin(rotation)) *velocity* dt

end


function narwhal.draw()
	love.graphics.draw(narwhal_im, frames[currentFrame], pos_x, pos_y, math.rad(-10)+rotation, 0.3, 0.3, frameWidth/2, frameHeight/2)
	-- deug circle
	-- love.graphics.circle("fill", pos_x, pos_y, 2)
end

function lerp(a, b, factor)
	return a+(b-a)*factor
end

function narwhal.reset()
	currentFrame = 1
	elapsed = 0
	pos_x = 400
	pos_y = 40
	rotation = 0
	velocity = 200
end

return narwhal
