local planets = require('src/planets')
local narwhal = require('src/narwhal')
local background = require('src/background')
local atmossystem = require('src/atmossystem')

local difficulty = 100
local cam_speed = 0

local logo
local button

function love.load()
	world = love.physics.newWorld(0, 0, true)
	planets.load()
	narwhal.load()
	background.load()
	atmossystem.load()
	gamestate = "menu"
	button = love.graphics.newImage('assets/playBtn.png')
	logo = love.graphics.newImage('assets/logo.png')
end

function love.update( dt )

	if love.keyboard.isDown("escape") then
    	love.event.quit()
	end

	if love.keyboard.isDown("return") and gamestate=="menu" then
		gamestate="playing"
	end

	if gamestate=="playing" then
		difficulty = math.min(difficulty + dt * 10, 5000)
		-- the nearer the player is to the right side of the screen, the more skill he has
		player_skill = lerp(1, 0,
			((love.graphics.getWidth() - narwhal.position.x)/love.graphics.getWidth()))^4
		print(player_skill)
		cam_speed = (difficulty + player_skill * narwhal.velocity:length() * 2) * dt

		world:update(dt)
		atmossystem.update(dt)
		planets.update(dt, cam_speed)
		background.update(cam_speed)
		narwhal.update(dt, planets, cam_speed)
	end
end

function love.draw()
	if gamestate=="playing" then
		background.draw()
		planets.draw()
		narwhal.draw()
	elseif gamestate=="menu" then
<<<<<<< HEAD
		love.graphics.draw(button, 100, 100, 0, 0.8)
=======
		love.graphics.draw(logo, love.graphics.getWidth()/2, love.graphics.getHeight()*1/3,
			0,
			1, 1,
			logo:getWidth()/2, logo:getHeight()/2)
		love.graphics.draw(button, 200, 200)
>>>>>>> 5a9c9cd7d67bc8054be4dddbd4bdad0c7eada42e
	end
end

function love.mousepressed(x, y)
	if gamestate == "menu" then
		button_click(x, y)
	end
end

function love.keypressed(key, scancode, isrepeat)
		if gamestate == "menu" and key == "space" then
			gamestate = "playing"
		end
end

function button_click(x, y)
	if x > 100 and x < (100 + (button:getWidth()/0.8))
	and y > 100 and y < (100 + (button:getHeight()/0.8)) then
		gamestate = "playing"
	end
end
