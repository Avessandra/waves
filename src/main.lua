local planets = require('planets')
local narwhal = require('narwhal')
local background = require('background')

function love.load()
	planets.load()
	narwhal.load()
	background.load()

end

function love.update( dt )
	local speed = 100 * dt

	planets.update(speed)
	background.update(speed)
	narwhal.update(dt)
end

function love.draw()
	background.draw()
	planets.draw()
	narwhal.draw()
end
