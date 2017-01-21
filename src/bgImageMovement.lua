function love.load()
   love.window.setMode(1024, 512)
   image1 = love.graphics.newImage("assets/testBG.png") -- Size of tiles: 512x512
   image2 = love.graphics.newImage("assets/testBG.png")
   -- coordinates
   imageX = 0
   imageY = 0 -- Barely off the screen.
   imageX2 = 511 -- sligthly overlapping 
   imageY2 = 0 -- One on top of the other.

end

function love.draw()
  love.graphics.draw(image1, imageX, imageY)
  love.graphics.draw(image2, imageX2, imageY2)
end

function love.update(dt)
  imageX = imageX + (100 * dt) -- Move the picture at a speed of X times the change in time.
  imageX2 = imageX2 + (100 * dt)

  if imageX >= 1024 then -- width of window
    imageX = -512 -- The original value
  end
  if imageX2 >= 1024 then -- you need to find proper interval for continuous movement
    imageX2 = 0
  end
end