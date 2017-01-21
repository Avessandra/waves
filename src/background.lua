local background = {}

function background.load()
	-- our tiles
	tile = {}
	tile[0] = love.graphics.newImage( "assets/bgDark.png" )

	map={
	{0,0,0},
	}
	-- map variables
	map_w = #map[1] -- Obtains the width of the first row of the map
	map_h = #map -- Obtains the height of the map
	map_x = 0
	map_y = 0
	tile_w = tile[0]:getWidth()
	tile_h = love.graphics.getHeight()
end

function draw_map()
	offset_x = map_x % tile_w
	offset_y = map_y % tile_h
	firstTile_x = math.floor(map_x / tile_w)
	firstTile_y = math.floor(map_y / tile_h)

	x=1
	y=1
		while x do
			-- Note that this condition block allows us to go beyond the edge of the map.
			if x+firstTile_x >= 1 and x+firstTile_x <= map_w
				then
					local image = tile[map[y+firstTile_y][x+firstTile_x]]
					love.graphics.draw(
						image,
						((x-1)*tile_w) - offset_x - tile_w/2,
						0,
						0,
						tile_w / image:getWidth(),
						tile_h / image:getHeight())

					x=x+1
					--print("normal condition", x, " ", y)
					--print("firstTile_x", firstTile_x)
				else
					--print("else condition", x, " ", y)
					x=1
				break
			end
		end
end

function background.update( speed )
--	local speed = 100 * dt

	map_x = map_x + speed

	if love.keyboard.isDown( "escape" ) then
		love.event.quit()
	end
end

function background.draw()
	draw_map()
end

return background
