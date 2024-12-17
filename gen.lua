local index = { 'BaseType', 'Rarity', 'FontSize', 'TextColor', 'BorderColor', 'MinimapIcon', 'PlayEffect', 'Continue',
  'Show' }
local indent = ""

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function IsTable(v)
  return type(v) == 'table'
end

local function Comment(comment)
  print("# " .. comment)
end

local function rgbaColor(value)
  return table.concat(value, " ")
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

function ProcessRule(key, value)
  if type(value) ~= "table" then
    io.write(indent .. key .. " " .. value .. '\n')
  elseif type(value) == "table" then
    local comment = value.comment
    value.comment = nil

    if string.find(key, "Color") then
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

local Color = {
  Brown = { 255, 125, 125 }
}

local Icon = {
  Star = "star"
}

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

EffectColor = {
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

minimapIcons = {
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

function IsOp(v)
  return op[v] ~= nil
end

op = {
  Equal       = "=",
  Not         = "!",
  NotEqual    = "!=",
  LessOrEqual = "<=",
  MoreOrEqual = ">=",
  Less        = "<",
  More        = ">",
  ExactMatch  = "=="
}

ItemRarity = {
  Normal = "Normal",
  Magic = "Magic",
  Rare = "Rare",
  Unique = "Unique"
}

-- require "filter-dsl"
-- require "filter-theme"

Comment "WAYSTONES"
Show {
  BaseType = { "Waystone", comment = "comment here" },
  Rarity = { op.LessOrEqual, ItemRarity.Rare }, -- just validate and use the actual operator
  FontSize = 30,
  TextColor = { Color.Brown, comment = "amazing color" },
  BorderColor = Color.Brown, --{ 255, 128, 55, 255 },
  MinimapIcon = { 1, EffectColor.Brown, Icon.Star },
  Continue = {},
  Show = {
    BorderColor = Color.Brown, --{ 255, 128, 55, 255 },
    Show = {
      TextColor = { Color.Brown, comment = "amazing color" },
    }
  }
}

Show {
  Rarity = { ItemRarity.Rare, ItemRarity.Magic, ItemRarity.Unique },
  FontSize = 30,
  PlayEffect = { EffectColor.Grey }
}
