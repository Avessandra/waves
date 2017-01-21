local planets = {}
local gravity_color = {
  gruen = {love.graphics.setColor(77, 255, 136), love.graphics.setColor(102, 255, 153), love.graphics.setColor(128, 255, 170)},
  rot = {love.graphics.setColor(255, 0, 0), love.graphics.setColor(255, 77, 77), love.graphics.setColor(255, 153, 153)},
  lila = {love.graphics.setColor(204, 0, 255), love.graphics.setColor(219, 77, 255), love.graphics.setColor(235, 153, 255)}
}
local planet_info = {}
local planet_counter = 0

function planets.load()
  table.insert(planet_info, planets.new_planet(nil))
  planet_counter = planet_counter + 1
end

function planets.update(speed)
  for i = 1, planet_counter, 1 do
    planet_info[i].info.x = planet_info[i].info.x - speed
  end
  local old_planet = planet_info[planet_counter]
  if old_planet.info.x <= love.graphics.getWidth() then
    table.insert(planet_info, planets.new_planet(old_planet))
    planet_counter = planet_counter + 1
  end
end

function planets.new_planet(old_planet)
  local x_new = 95 + love.math.random(0,95)
  local y_new = love.math.random(0, love.graphics.getHeight())
  local size_par_new = love.math.random(20,30)
  local choose_color = love.math.random(1,3)
  if old_planet ~= nil then
    while math.sqrt(x_new^2 + (y_new - old_planet.info.y)^2) < (size_par_new + old_planet.info.size_par)*4 do
          y_new = love.math.random(0, love.graphics.getHeight())
    end
    return {
      info = {
        x = old_planet.info.x + x_new,
        y = y_new,
        size_par = size_par_new
        --color1 = gravity_color[choose_color][1]
      }
    }
  else
    return {
      info = {
        x = x_new,
        y = y_new,
        size_par = size_par_new
        --color1 = gravity_color[choose_color][1]
      }
    }
  end
end

function planets.draw()
  --love.graphics.setColor(105, 229, 52)
  for i = 1, planet_counter, 1 do
    --planet_info[i].info.color1
    love.graphics.circle("line", planet_info[i].info.x, planet_info[i].info.y, 2.2*planet_info[i].info.size_par)
    love.graphics.circle("line", planet_info[i].info.x, planet_info[i].info.y, 3*planet_info[i].info.size_par)
    love.graphics.circle("line", planet_info[i].info.x, planet_info[i].info.y, 4*planet_info[i].info.size_par)
  end
end

return planets
