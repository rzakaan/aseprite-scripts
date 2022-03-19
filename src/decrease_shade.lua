dofile("./main_shade.lua")

local spr = app.activeSprite
if not spr then
  app.alert("There is no sprite to export")
  return
end

activeColor = copyColor(app.fgColor)
changeColor = colorShift(activeColor, 0, 0, 0.1, 0)
assignColor(changeColor)