local planets = require('src/planets')
local narwhal = require('src/narwhal')
local background = require('src/background')
local atmossystem = require('src/atmossystem')

local difficulty = 100
local cam_speed = 0

local logo, button, rules
local rules_timer = 0
local current_rule = 1

function love.load()
	world = love.physics.newWorld(0, 0, true)
	planets.load()
	narwhal.load()
	background.load()
	atmossystem.load()
	gamestate = "menu"
	button = love.graphics.newImage('assets/playBtn.png')
	logo = love.graphics.newImage('assets/logo.png')
	rules = {
		love.graphics.newImage('assets/basicRules1.png'),
		love.graphics.newImage('assets/basicRules2.png'),
		love.graphics.newImage('assets/basicRules3.png'),
		love.graphics.newImage('assets/basicRules4.png'),
	}
end

function love.update( dt )

	if love.keyboard.isDown("escape") then
    	love.event.quit()
	end

	if love.keyboard.isDown("return") and gamestate=="menu" then
		gamestate="playing"
	end

	rules_timer = rules_timer + dt

	if rules_timer >= 4 * 60/ atmossystem.bpm then
		current_rule = current_rule + 1
		if current_rule > #rules then current_rule = 1 end
		rules_timer = 0
	end

	atmossystem.update(dt)

	if gamestate=="playing" then
		difficulty = math.min(difficulty + dt * 10, 5000)
		-- the nearer the player is to the right side of the screen, the more skill he has
		player_skill = lerp(1, 0,
			((love.graphics.getWidth() - narwhal.position.x)/love.graphics.getWidth()))^4
		print(player_skill)
		cam_speed = (difficulty + player_skill * narwhal.velocity:length() * 2) * dt

		world:update(dt)
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
		love.graphics.draw(logo, love.graphics.getWidth()/2, love.graphics.getHeight()*1/4,
			0,
			1, 1,
			logo:getWidth()/2, logo:getHeight()/2)
		love.graphics.draw(rules[current_rule], love.graphics.getWidth()/2, love.graphics.getHeight()*2/3,
			0,
			1 + pulse/10, 1 + pulse/10,
			logo:getWidth()/2, logo:getHeight()/2
		)
		love.graphics.draw(button, 100, 100, 0, 0.8)
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
