function copyColor(aseColor)
    return Color(
        aseColor.red,
        aseColor.green,
        aseColor.blue,
        aseColor.alpha)        
end

function assignColor(aseColor)
    if aseColor.alpha > 0 then
        app.fgColor = copyColor(aseColor)
    else
        app.fgColor = Color(0, 0, 0, 0)
    end
end

local function colorToHexWeb(aseColor)
    return string.format("%06x", aseColor.red << 0x10 | aseColor.green << 0x08 | aseColor.blue)
end

function lerp(first, second, by)
    return first * (1 - by) + second * by
end

function lerpRGBInt(color1, color2, amount)
    local X1 = 1 - amount
    local X2 = color1 >> 24 & 255
    local X3 = color1 >> 16 & 255
    local X4 = color1 >> 8 & 255
    local X5 = color1 & 255
    local X6 = color2 >> 24 & 255
    local X7 = color2 >> 16 & 255
    local X8 = color2 >> 8 & 255
    local X9 = color2 & 255
    local X10 = X2 * X1 + X6 * amount
    local X11 = X3 * X1 + X7 * amount
    local X12 = X4 * X1 + X8 * amount
    local X13 = X5 * X1 + X9 * amount
    return X10 << 24 | X11 << 16 | X12 << 8 | X13
end

function colorToInt(color)
    return (color.red << 16) + (color.green << 8) + (color.blue)
end

function colorShift(color, hueShift, satShift, lightShift, shadeShift)
    local newColor = Color(color)

    -- SHIFT HUE
    newColor.hslHue = (newColor.hslHue + hueShift * 360) % 360

    -- SHIFT SATURATION
    if (satShift > 0) then
        newColor.saturation = lerp(newColor.saturation, 1, satShift)
    elseif (satShift < 0) then
        newColor.saturation = lerp(newColor.saturation, 0, -satShift)
    end

    -- SHIFT LIGHTNESS
    if (lightShift > 0) then
        newColor.lightness = lerp(newColor.lightness, 1, lightShift)
    elseif (lightShift < 0) then
        newColor.lightness = lerp(newColor.lightness, 0, -lightShift)
    end

    -- SHIFT SHADING
    local newShade = Color {red = newColor.red, green = newColor.green, blue = newColor.blue}
    local shadeInt = 0
    if (shadeShift >= 0) then
        newShade.hue = 50
        shadeInt = lerpRGBInt(colorToInt(newColor), colorToInt(newShade), shadeShift)
    elseif (shadeShift < 0) then
        newShade.hue = 215
        shadeInt = lerpRGBInt(colorToInt(newColor), colorToInt(newShade), -shadeShift)
    end
    newColor.red = shadeInt >> 16
    newColor.green = shadeInt >> 8 & 255
    newColor.blue = shadeInt & 255

    return newColor
end