local background = {}

local map_w = 2 -- Obtains the width of the first row of the map
local map_h = 1 -- Obtains the height of the map
local map_x = 0
local map_y = 0

local image
local tile_w
local tile_scale
local tile_h = love.graphics.getHeight()

function background.load()
	image = love.graphics.newImage("assets/bgDark.png")
	tile_scale = tile_h / image:getHeight()
	tile_w = image:getWidth() * tile_scale
end

function background.draw()
	local offset_x = map_x % tile_w

	for tile_x = 1, map_w do
		love.graphics.draw(
			image,
			((tile_x - 1) * tile_w) - offset_x,
			0,
			0,
			tile_scale,
			tile_scale)
	end

end

function background.update( speed )
	map_x = map_x + speed

	if love.keyboard.isDown( "escape" ) then
		love.event.quit()
	end
end

return background
