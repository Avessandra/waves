local planets = require('src/planets')
local narwhal = require('src/narwhal')
local background = require('src/background')

local difficulty = 100
local cam_speed = 0

function love.load()
	world = love.physics.newWorld(0, 0, true)
	planets.load()
	narwhal.load()
	background.load()
end

function love.update( dt )
	difficulty = difficulty + dt/10
	cam_speed = difficulty * dt

	world:update(dt)
	planets.update(cam_speed)
	background.update(cam_speed)
	narwhal.update(dt, planets, cam_speed)
end

function love.draw()
	background.draw()
	planets.draw()
	narwhal.draw()
end
