local planets = {}

local gravity_color = {
  gruen = {love.graphics.setColor(77, 255, 136), love.graphics.setColor(102, 255, 153), love.graphics.setColor(128, 255, 170)},
  rot = {love.graphics.setColor(255, 0, 0), love.graphics.setColor(255, 77, 77), love.graphics.setColor(255, 153, 153)},
  lila = {love.graphics.setColor(204, 0, 255), love.graphics.setColor(219, 77, 255), love.graphics.setColor(235, 153, 255)}
}

planets.info = {}
planets.counter = 0

function planets.load()
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
  local x_new = 95 + love.math.random(0,95)
  local y_new = love.math.random(0, love.graphics.getHeight())
  local size_par_new = love.math.random(20,30)
  local choose_color = love.math.random(1,3)
  if old_planet ~= nil then
    while math.sqrt(x_new^2 + (y_new - old_planet.data.y)^2) < (size_par_new + old_planet.data.size_par)*4 do
          y_new = love.math.random(0, love.graphics.getHeight())
    end
    return {
      data = {
        x = old_planet.data.x + x_new,
        y = y_new,
        size_par = size_par_new
        --color1 = gravity_color[choose_color][1]
      }
    }
  else
    return {
      data = {
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
  for index, planet in ipairs(planets.info) do
    --planets.info[i].data.color1
    love.graphics.circle("line", planet.data.x, planet.data.y, 2.2*planet.data.size_par)
    love.graphics.circle("line", planet.data.x, planet.data.y, 3*planet.data.size_par)
    love.graphics.circle("line", planet.data.x, planet.data.y, 4*planet.data.size_par)
  end
end

return planets
