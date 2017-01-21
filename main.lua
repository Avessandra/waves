local planets = require('src/planets')
local narwhal = require('src/narwhal')
local background = require('src/background')

function love.load()
	world = love.physics.newWorld(0, 0, true)
	planets.load()
	narwhal.load()
	background.load()

end

function love.update( dt )
	local speed = 100 * dt

	planets.update(speed)
	background.update(speed)
	narwhal.update(dt)
	world:update(dt)
end

function love.draw()
	background.draw()
	planets.draw()
	narwhal.draw()
end
