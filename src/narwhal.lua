local Vector = require("src/lib/vector")

local narwhal = {}
local frames = {}
local currentFrame
local elapsed
local narwhal_im
local position
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
    if elapsed > (1 / (velocity:length() * 0.1)) then
        elapsed = 0
        if currentFrame == 9 then
             currentFrame = 1
        else
            currentFrame = currentFrame + 1
        end
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
				velocity = velocity:rotate(rotspeed*dt)
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
				velocity = velocity:rotate(-rotspeed*dt)
   	end
    if position.y < -20 or position.y > love.graphics.getHeight() + 20 or
			position.x < 0 then
        love.event.quit()
    end

		for _, planet in ipairs(planets.info) do
			local narwhal_to_planet = Vector(planet.data.x, planet.data.y) - position
			local distance = narwhal_to_planet:length()

			if distance <= planet.data.size_par then
				love.event.quit()
			elseif distance <= planet.data.size_par*4 then
				local target_angle = narwhal_to_planet:getRadian()
				local gravity = planet.data.size_par / distance^2
				local rotation = velocity:normalize():lerp(narwhal_to_planet:normalize(), gravity * 5):getRadian()

				velocity = Vector.from_radians(rotation) * velocity:length()
				velocity = velocity + gravity * 250
			end
		end

		velocity = velocity - dt * 0.01
		position = position + velocity * dt - Vector(cam_speed, 0)
end


function narwhal.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(narwhal_im, frames[currentFrame], position.x, position.y, math.rad(-10)+velocity:getRadian(), 0.3, 0.3, frameWidth/2, frameHeight/2)
	-- deug circle
	-- love.graphics.circle("fill", pos_x, pos_y, 2)
end

function lerp(a, b, factor)
	return a + (b-a) * factor
end

function narwhal.reset()
	currentFrame = 1
	elapsed = 0
	position = Vector(200, love.graphics.getWidth()/2)
	velocity = Vector(200, 0)
end

return narwhal
