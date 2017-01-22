local planets = require('src/planets')
local narwhal = require('src/narwhal')
local background = require('src/background')
local atmossystem = require('src/atmossystem')

local difficulty = 100
local cam_speed = 0

function love.load()
	world = love.physics.newWorld(0, 0, true)
	planets.load()
	narwhal.load()
	background.load()
	atmossystem.load()
	gamestate = "menu"
	button = love.graphics.newImage('assets/shitty_play_button.png')
end

function love.update( dt )

	if love.keyboard.isDown("escape") then
    	love.event.quit()
	end

	if love.keyboard.isDown("return") and gamestate=="menu" then
		gamestate="playing"
	end

	if gamestate=="playing" then
		difficulty = math.min(difficulty + dt*8, 500)
		cam_speed = difficulty * dt

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
		love.graphics.draw(button, 200, 200)
	end
end

function love.mousepressed(x, y)
	if gamestate == "menu" then
		button_click(x, y)
	end
end


function button_click(x, y)
	if x > 200 and x < (200 + button:getWidth())
	and y > 200 and y < (200 + button:getHeight()) then
		gamestate = "playing"
	end
end