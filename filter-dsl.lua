local index = {
  'BaseType',
  'Rarity',
  'SetFontSize',
  'SetTextColor',
  'SetBorderColor',
  'MinimapIcon',
  'PlayEffect',
  -- TODO: add rest of the keys here
  'Continue',
  'Show'
}

local indent = "" -- better indentation support with indentLevel and indentSymbol

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

local itemRarity = {
  Normal = "Normal",
  Magic = "Magic",
  Rare = "Rare",
  Unique = "Unique"
}

local effectColor = {
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

local function isTable(v)
  return type(v) == 'table'
end

local function processTableValue(value)
  local comment = value.comment
  value.comment = nil

  -- first value might be a table (ie. it's embedded color table)
  if isTable(value[1]) then
    value = value[1]
  end
  value = table.concat(value, " ")

  return value, comment
end

local function processRule(key, value)
  if key == "Show" then
    Show(value) -- TODO: support comment for show?
    return
  end

  local comment
  if isTable(value) then
    value, comment = processTableValue(value)
  end

  io.write(indent .. key .. " " .. value)
  if comment then
    io.write(" # " .. comment)
  end
  io.write('\n')
end

local function comment(comment)
  print("# " .. comment)
end

-- not defined as local because the reference from `ProcessRule`
function Show(spec)
  io.write('\n' .. indent .. "Show" .. '\n')
  indent = indent .. "  "
  for _, i in ipairs(index) do
    local value = spec[i]
    if value then
      processRule(i, value)
    end
  end
  indent = ""
end

return {
  Show = Show,
  Comment = comment,
  EffectColor = effectColor,
  MinimapIcons = minimapIcons,
  Op = op,
  ItemRarity = itemRarity,
}
