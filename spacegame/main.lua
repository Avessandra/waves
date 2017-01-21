local planets = require('planets')
local narwhal = require('narwhal')

function love.load()
	-- our tiles
	tile = {}
	tile[0] = love.graphics.newImage( "bgDark.png" )

	map={
	{0,0,0},
	}
	-- map variables
	map_w = #map[1] -- Obtains the width of the first row of the map
	map_h = #map -- Obtains the height of the map
	map_x = 0
	map_y = 0
	map_display_buffer = 6 -- We have to buffer one tile before and behind our viewpoint.
                               -- Otherwise, the tiles will just pop into view, and we don't want that.
	map_display_w = 20
	map_display_h = 15
	tile_w = 900
	tile_h = 600

	planets.load()
	narwhal.load()

end

function draw_map()
	offset_x = map_x % tile_w
	offset_y = map_y % tile_h
	firstTile_x = 2 --math.floor(map_x / tile_w)
	firstTile_y = math.floor(map_y / tile_h)

	x=1
	y=1
		while x do
			-- Note that this condition block allows us to go beyond the edge of the map.
			if x+firstTile_x >= 1 and x+firstTile_x <= map_w
				then
					love.graphics.draw(
						tile[map[y+firstTile_y][x+firstTile_x]],
						((x-1)*tile_w) - offset_x - tile_w/2)
					x=x+1
					--print("normal condition", x, " ", y)
					print("firstTile_x", firstTile_x)
				else
					--print("else condition", x, " ", y)
					x=1
				break
			end
		end
end

function love.update( dt )
	local speed = 100 * dt

	map_x = map_x + speed
	planets.update(speed)

	if love.keyboard.isDown( "escape" ) then
		love.event.quit()
	end

	narwhal.update(dt)
end

function love.draw()
	draw_map()
	planets.draw()
	narwhal.draw()
end
