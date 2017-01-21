local planets = {}
local gravity_color = {}
local planet_info = {}
local planet_counter = 0

function planets.load()
  table.insert(planet_info, planets.new_planet(nil))
  planet_counter = planet_counter + 1
end

function planets.update()
  local old_planet = planet_info[planet_counter]
  if old_planet.position.x <= love.graphics.getWidth() then
    table.insert(planet_info, planets.new_planet(old_planet))
    planet_counter = planet_counter + 1
  end
end

function planets.new_planet(old_planet)
  local x_new = 95 + love.math.random(0,95)
  local y_new = love.math.random(0, love.graphics.getHeight())
  if old_planet ~= nil then
    while math.sqrt(x_new^2 + (y_new - old_planet.position.y)^2) < 190 do
          y_new = love.math.random(0, love.graphics.getHeight())
    end
    return {
      position = {
        x = old_planet.position.x + x_new,
        y = y_new
      }
    }
  else
    return {
        position = {
          x = x_new,
          y = y_new
        }
    }
  end
end

function planets.draw()
  love.graphics.setColor(105, 229, 52)
  for i = 1, planet_counter, 1 do
    love.graphics.circle("line", planet_info[i].position.x, planet_info[i].position.y, 50)
    love.graphics.circle("line", planet_info[i].position.x, planet_info[i].position.y, 70)
    love.graphics.circle("line", planet_info[i].position.x, planet_info[i].position.y, 95)
  end
end

return planets
