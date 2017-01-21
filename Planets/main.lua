local planets = require('planets')

function love.load()
  planets.load()
end


function love.update()
  planets.update()
end

function love.draw()
  planets.draw()
end

--[[
function love.draw()
    love.graphics.setColor(105, 229, 52)
    love.graphics.circle("line", 300, 300, 50)
    love.graphics.circle("line", 300, 300, 70)
    love.graphics.circle("line", 300, 300, 95)
    love.graphics.setColor(105, 229, 52)
    love.graphics.circle("fill", 300, 300, 20, 100) -- Draw white circle with 100 segments.

end
]]--

--[[
-- love.graphics.circle( mode, x, y, radius )

-- Establish some variables/resources on the game load, so that they can be used repeatedly in other functions (such as love.draw).
function love.load()
    x, y, w, h = 20, 20, 60, 20
end

-- Time since the last update in seconds.
function love.update(dt)
    w = w + 1
    h = h + 1
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.setColor(0, 100, 100)
    love.graphics.rectangle("fill", x, y, w, h)
end
]]--
