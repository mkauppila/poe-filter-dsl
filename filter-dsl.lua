local index = {
  'BaseType',
  'Rarity',
  'SetFontSize',
  'SetTextColor',
  'SetBorderColor',
  'MinimapIcon',
  'PlayEffect',
  'Continue',
  'Show' }

local indent = ""

local op = {
  Equal       = "=",
  Not         = "!",
  NotEqual    = "!=",
  LessOrEqual = "<=",
  MoreOrEqual = ">=",
  Less        = "<",
  More        = ">",
  ExactMatch  = "=="
}

local ItemRarity = {
  Normal = "Normal",
  Magic = "Magic",
  Rare = "Rare",
  Unique = "Unique"
}

local EffectColor = {
  Red = "Red",
  Green = "Green",
  Blue = "Blue",
  Brown = "Brown",
  White = "White",
  Yellow = "Yellow",
  Cyan = "Cyan",
  Grey = "Grey",
  Orange = "Orange",
  Pink = "Pink",
  Purple = "Purple"
}

local minimapIcons = {
  Circle = "Circle",
  Diamond = "Diamond",
  Hexagon = "Hexagon",
  Square = "Square",
  Star = "Star",
  Triangle = "Triangle",
  Cross = "Cross",
  Moon = "Moon",
  Raindrop = "Raindrop",
  Kite = "Kite",
  Pentagon = "Pentagon",
  UpsideDownHouse = "UpsideDownHouse"
}

function IsTable(v)
  return type(v) == 'table'
end

local function rgbaColor(value)
  return table.concat(value, " ")
end


function ProcessRule(key, value)
  if type(value) ~= "table" then
    io.write(indent .. key .. " " .. value .. '\n')
  elseif type(value) == "table" then
    local comment = value.comment
    value.comment = nil

    if key == "BaseType" then
      value = table.concat(value, " ")
    elseif string.find(key, "Color") then
      if type(value[1]) == 'table' then
        value = rgbaColor(value[1])
      else
        value = rgbaColor(value)
      end
    elseif string.find(key, "Rarity") then
      if (IsOp(value[1])) then
        value = value[1] .. " " .. value[2]
      else
        value = table.concat(value, " ")
      end
    elseif key == "MinimapIcon" then
      local size = value[1]
      local color = value[2]
      local icon = value[3]

      value = table.concat({
          validSizeOrDefault(size, 1),
          validEffectColorOrDefault(color, EffectColor.Pink),
          validMinimapIconOrDefault(icon, minimapIcons.Cross),
        },
        " ")
    elseif key == "PlayEffect" then
      value = value[1] .. " " .. "Temp"
    elseif key == "Show" then
      Show(value)
      return
    elseif key == "Continue" then
      value = ""
    else
      value = value[1]
    end

    io.write(indent .. key .. " " .. value)
    if comment then
      io.write(" # " .. comment)
    end
    io.write('\n')
  end
end

function validSizeOrDefault(size, default)
  if (0 <= size and size <= 2) then
    return size
  end
  return default
end

function validEffectColorOrDefault(color, default)
  if (EffectColor[color] ~= nil) then
    return color
  end
  return default
end

function validMinimapIconOrDefault(icon, default)
  if (minimapIcons[icon] ~= nil) then
    return icon
  end
  return default
end

function IsOp(v)
  return op[v] ~= nil
end

local function Comment(comment)
  print("# " .. comment)
end

function Show(spec)
  print('\n' .. indent .. "Show")
  indent = indent .. "  "
  for _, i in ipairs(index) do
    local value = spec[i]
    if value ~= nil then
      ProcessRule(i, value)
    end
  end
  indent = ""
end

return {
  Show = Show,
  Comment = Comment,
  EffectColor = EffectColor,
  minimapIcons = minimapIcons,
  op = op,
  ItemRarity = ItemRarity,
}
