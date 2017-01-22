local atmossystem = {}
pulse = 0
local musiclist
local currentMusic


function atmossystem.load()
  local default = love.audio.newSource("assets/space4.mp3") -- bpm 140
  local alt = love.audio.newSource("assets/space5.mp3")
  musiclist = {
    alt, default
  }
  currentMusic = math.random(#musiclist)
  atmossystem.rotateMusic()

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
  currentMusic = currentMusic + 1
  if currentMusic > #musiclist then currentMusic = 1 end

  if atmossystem.music then atmossystem.music:stop() end
  atmossystem.music = musiclist[currentMusic]
  atmossystem.music:setLooping(true)
  atmossystem.music:setVolume(0.4)
  atmossystem.music:play()
end

return atmossystem
