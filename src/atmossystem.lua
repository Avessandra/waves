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

  atmossystem.colortable = {}
end

function atmossystem.update(dt)
  atmossystem.colortable.r = 128*(1+(math.sin(love.timer.getTime())))
  atmossystem.colortable.g = 128*(1+(math.sin(2+love.timer.getTime())))
  atmossystem.colortable.b = 128*(1+(math.sin(4+love.timer.getTime())))
  atmossystem.timer = atmossystem.timer + dt
  atmossystem.cooldown = atmossystem.cooldown - dt
  if atmossystem.timer > 60/130 then
    love.graphics.setColor(atmossystem.colortable.r, atmossystem.colortable.g, atmossystem.colortable.b)

    atmossystem.timer = 0
    atmossystem.cooldown = 0.2
  end
  if atmossystem.cooldown < 0 then
    love.graphics.setColor(235, 255, 255)
  end
end

return atmossystem
