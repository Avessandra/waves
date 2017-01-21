local planets = {}

local gravity_color1 = {{77, 255, 136}, {255, 0, 0}, {204, 0, 255}}
local gravity_color2 = {{102, 255, 153}, {255, 77, 77},{219, 77, 255}}
local gravity_color3 = {{128, 255, 170}, {255, 153, 153}, {235, 153, 255}}

planets.info = {}
planets.counter = 0

local planet_styles

function planets.load()
  planet1 = love.graphics.newImage('assets/Planet1.png')
  planet2 = love.graphics.newImage('assets/Planet2.png')
  planet2o = love.graphics.newImage('assets/Planet2Orbial.png')
  planet2r = love.graphics.newImage('assets/Planet2Ring.png')
  planet3 = love.graphics.newImage('assets/Planet3Ring.png')
  planet4 = love.graphics.newImage('assets/Planet4.png')
  planet_styles = {planet1, planet2, planet2o, planet2r, planet3, planet4}
  table.insert(planets.info, planets.new_planet(nil))
  planets.counter = planets.counter + 1
end

function planets.update(speed)
  for i = 1, planets.counter do
    planets.info[i].data.x = planets.info[i].data.x - speed
  end
  local last_planet = planets.info[planets.counter]
  if last_planet.data.x <= love.graphics.getWidth() then
    table.insert(planets.info, planets.new_planet(last_planet))
    planets.counter = planets.counter + 1
  end
end

function planets.new_planet(old_planet)
  local x_new = 220 + love.math.random(0,95)
  local y_new = love.math.random(0, love.graphics.getHeight())
  local size_par_new = love.math.random(30,70)
  local choose_color = love.math.random(1,3)
  local type = love.math.random(1,#planet_styles)
  --local color1 = gravity_color1[1]
  --local color2 = gravity_color2[choose_color]
  --local color3 = gravity_color3[choose_color]
  --print(gravity_color1[1])
  if old_planet ~= nil then
    while math.sqrt(x_new^2 + (y_new - old_planet.data.y)^2) < (size_par_new + old_planet.data.size_par)*4 do
          y_new = love.math.random(0, love.graphics.getHeight())
    end
    return {
      data = {
        x = old_planet.data.x + x_new,
        y = y_new,
        size_par = size_par_new,
        type = type,
        color1 = gravity_color1[choose_color],
        color2 = gravity_color2[choose_color],
        color3 = gravity_color3[choose_color]
      }
    }
  else
    return {
      data = {
        x = x_new,
        y = y_new,
        size_par = size_par_new,
        type = type,
        color1 = gravity_color1[choose_color],
        color2 = gravity_color2[choose_color],
        color3 = gravity_color3[choose_color]
        --color1 = gravity_color[choose_color][1]
      }
    }
  end
end

function planets.draw()
  --love.graphics.setColor(105, 229, 52)
  for index, planet in ipairs(planets.info) do
    --planets.info[i].data.color1
    local planet_image = planet_styles[planet.data.type]
    local sx, sy = planet.data.size_par*2/planet_image:getWidth(),planet.data.size_par*2/planet_image:getHeight()
    love.graphics.draw(planet_image,
      planet.data.x, planet.data.y,
      0,
      sx,sy,
      planet_image:getWidth()/2,planet_image:getHeight()/2)

    -- deug circle
    -- love.graphics.circle("fill", planet.data.x, planet.data.y, 2)
    
    love.graphics.setColor(planet.data.color1[1], planet.data.color1[2], planet.data.color1[3])
    love.graphics.circle("line", planet.data.x, planet.data.y, 2.2*planet.data.size_par)
    love.graphics.circle("line", planet.data.x, planet.data.y, 3*planet.data.size_par)
    love.graphics.circle("line", planet.data.x, planet.data.y, 4*planet.data.size_par)
  end
end

return planets
