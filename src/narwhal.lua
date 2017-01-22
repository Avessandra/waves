local Vector = require("src/lib/vector")

local narwhal = {}
local frames = {}
local currentFrame
local elapsed
local narwhal_im
local frameWidth = 512
local frameHeight = 256
local rotspeed = 1
dead = false


function narwhal.load()
		narwhal.reset()
	 	narwhal_im = love.graphics.newImage('assets/nwm.png')
		narwhal_part = love.graphics.newImage("assets/particle.png")
	  local imageWidth = narwhal_im:getWidth()
	  local imageHeight = narwhal_im:getHeight()
		for i = 0, 8 do
		  table.insert(frames, love.graphics.newQuad(i * 512, 0, frameWidth, frameHeight, imageWidth, imageHeight))
		end
end

function narwhal.update(dt, planets, cam_speed)
		if dead then
			psystem:update(dt)
			return
		end
    elapsed = elapsed + dt
    if elapsed > (1 / (narwhal.velocity:length() * 0.01)) then
        elapsed = 0
        if currentFrame == 9 then
             currentFrame = 1
        else
            currentFrame = currentFrame + 1
        end
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
				narwhal.velocity = narwhal.velocity:rotate(rotspeed * narwhal.velocity:length()/200 * dt)
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
				narwhal.velocity = narwhal.velocity:rotate(- rotspeed * narwhal.velocity:length()/200 * dt)
   	end

    if narwhal.position.y < -50 or narwhal.position.y > love.graphics.getHeight() + 50 or
			narwhal.position.x < -50 then
        	narwhal.death()
    end

		for _, planet in ipairs(planets.info) do
			local narwhal_to_planet = Vector(planet.data.x, planet.data.y) - narwhal.position
			local distance = narwhal_to_planet:length()

			if distance <= planet.data.size_par then
				narwhal.death()
			elseif distance <= planet.data.size_par*5 then
				local target_angle = narwhal_to_planet:getRadian()
				local gravity = planet.data.size_par / distance^2
				local rotation = narwhal.velocity:normalize():lerp(narwhal_to_planet:normalize(), gravity * 5):getRadian()

				narwhal.velocity = Vector.from_radians(rotation) * narwhal.velocity:length()
				narwhal.velocity = narwhal.velocity + narwhal.velocity * gravity * 1
			end
		end

		narwhal.velocity = narwhal.velocity - narwhal.velocity * 0.08 * dt
		narwhal.position = narwhal.position + narwhal.velocity * dt - Vector(cam_speed, 0)

	if not dead then
		score = ("score: " .. dt * 153343)
	else
		score = score
	end
end


function narwhal.draw()
	if dead then
		love.graphics.setColor(255,255,255)
		love.graphics.print("GAME OVER", love.graphics.getWidth() * 0.5,love.graphics.getHeight() * 0.5, 0, 10, 10, 20, 20)
		-- Draw the particle system at the center of the game window.
		love.graphics.draw(psystem, narwhal.position.x, narwhal.position.x)
	end
	love.graphics.setColor(255,255,255)
	local scale = 0.3 + pulse/16
	love.graphics.draw(narwhal_im, frames[currentFrame], narwhal.position.x, narwhal.position.y, math.rad(-10)+narwhal.velocity:getRadian(), scale, scale, frameWidth/2, frameHeight/2)
	love.graphics.print(score, love.graphics.getWidth()*0.8, 50)
	-- deug circle
	-- love.graphics.circle("fill", pos_x, pos_y, 2)
end

function lerp(a, b, factor)
	return a + (b-a) * factor
end

function narwhal.reset()
	currentFrame = 1
	elapsed = 0
	narwhal.position = Vector(200, love.graphics.getWidth()/2)
	narwhal.velocity = Vector(300, 0)
	dead = false
end

function narwhal.death()
	dead = true
	psystem = love.graphics.newParticleSystem(narwhal_part, 500)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(50)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-200, -200, 200, 200) -- Random movement in all directions.
	psystem:setColors(255, 0, 0, 255, 255, 255, 0, 0) -- Fade to transparency.
end

return narwhal
