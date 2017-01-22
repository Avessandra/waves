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

function planets.update(dt, speed)
  for index, planet in ipairs(planets.info) do
    --planet.data.size_par = planet.data.size_par + math.cos(pulse) * 30 * dt
  end
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
        x = 300 + x_new,
        y = y_new,
        size_par = size_par_new,
        type = type,
        color1 = gravity_color1[choose_color],
        color2 = gravity_color2[choose_color],
        color3 = gravity_color3[choose_color]
      }
    }
  end
end

function planets.draw()
  for index, planet in ipairs(planets.info) do
    local planet_image = planet_styles[planet.data.type]
    local radius_add = math.sin(pulse) * 15
    local sx, sy = planet.data.size_par*2/planet_image:getWidth(),planet.data.size_par*2/planet_image:getHeight()

    --love.graphics.setColor(planet.data.color1[1], planet.data.color1[2], planet.data.color1[3])
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(planet_image,
      planet.data.x, planet.data.y,
      0,
      sx,sy,
      planet_image:getWidth()/2,planet_image:getHeight()/2)
    love.graphics.setColor(planet.data.color3[1], planet.data.color3[2], planet.data.color3[3],9)
    love.graphics.circle("fill", planet.data.x, planet.data.y, 4 * (radius_add + planet.data.size_par))
    love.graphics.setColor(planet.data.color2[1], planet.data.color2[2], planet.data.color2[3],8)
    love.graphics.circle("fill", planet.data.x, planet.data.y, 3 * (radius_add + planet.data.size_par))
    love.graphics.setColor(planet.data.color1[1], planet.data.color1[2], planet.data.color1[3],7)
    love.graphics.circle("fill", planet.data.x, planet.data.y, 2.2 * (radius_add + planet.data.size_par))
  end
end

return planets
