local atmossystem = {}
pulse = 0
local musiclist
local currentMusic = 1


function atmossystem.load()
  local bass = love.audio.newSource("assets/bassbeat.mp3") -- bpm 130
  local default = love.audio.newSource("assets/space4.mp3") -- bpm 140
  musiclist = {
    bass, default
  }
  atmossystem.music = musiclist[1]
  atmossystem.music:setLooping(true)
  atmossystem.music:setVolume(0.2)
  atmossystem.music:play()

  atmossystem.bpm = 140
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
  if atmossystem.timer > 60/atmossystem.bpm then
    love.graphics.setColor(atmossystem.colortable.r, atmossystem.colortable.g, atmossystem.colortable.b)

    atmossystem.timer = 0
    pulse = 1
    atmossystem.cooldown = 0.2
  end
  if atmossystem.cooldown < 0 then
    love.graphics.setColor(235, 255, 255)
  end
  if pulse > 0 then
    pulse = pulse - 2*dt
  end
end

function atmossystem.rotateMusic()
  if currentMusic == 1 then
    currentMusic = 2
  else
    currentMusic = 1
  end
  --currentMusic = #musiclist
  --currentMusic = (1 + ((currentMusic + 1) % #musiclist))
  atmossystem.music:stop()
  atmossystem.music = musiclist[currentMusic]
  atmossystem.music:setLooping(true)
  atmossystem.music:setVolume(0.2)
  atmossystem.music:play()
end

return atmossystem
