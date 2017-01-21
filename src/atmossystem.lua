local atmossystem = {}

function atmossystem.load()
  atmossystem.music = love.audio.newSource("assets/bassbeat.mp3", "static") -- bpm 130
  --atmossystem.music = love.audio.newSource("assets/space3.mp3") -- bpm 140
  atmossystem.music:setLooping(true)
  atmossystem.music:setVolume(0.2)
  atmossystem.music:play()

  atmossystem.bpm = 130
  atmossystem.timer = 0
  atmossystem.cooldown = 0
end

function atmossystem.update(dt)
  atmossystem.timer = atmossystem.timer + dt
  atmossystem.cooldown = atmossystem.cooldown - dt
  if atmossystem.timer > 60/130 then
    love.graphics.setColor(255, 0, 0)

    atmossystem.timer = 0
    atmossystem.cooldown = 0.2
  end
  if atmossystem.cooldown < 0 then
    love.graphics.setColor(235, 153, 255)
  end
end

return atmossystem
