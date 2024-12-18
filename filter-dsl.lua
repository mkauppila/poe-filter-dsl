local index = {
  'Class',
  'BaseType',
  'Rarity',
  'Sockets',
  'StackSize',
  'SetFontSize',
  'SetTextColor',
  'SetBorderColor',
  'SetBackgroundColor',
  'MinimapIcon',
  'PlayEffect',
  'PlayAlertSound',
  -- TODO: add rest of the keys here
  'Continue',
  'Show'
}

local indent = "" -- TODO: better indentation support with indentLevel and indentSymbol

-- TODO: try actual module to fix the forward declaration
-- TODO: support Hide blocks
-- TODO: check for valid keys, abort with error on invalid ones

local op = {
  Equal          = "=",
  Not            = "!",
  NotEqual       = "!=",
  LessOrEqual    = "<=",
  GreaterOrEqual = ">=",
  Less           = "<",
  Greater        = ">",
  ExactMatch     = "=="
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

local function emitEmptyLine()
  io.write('\n')
end

local function emit(key, value, comment)
  io.write(indent)
  io.write(key)
  if value then
    io.write(" " .. value)
  end
  if comment then
    io.write(" # " .. comment)
  end
  io.write('\n')
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

-- forward declarion of `Show` for embedded show blocks
local show

local function processRule(key, value)
  if key == "Show" then
    show(value) -- TODO: support comment for show?
    return
  end

  local comment
  if isTable(value) then
    value, comment = processTableValue(value)
  end

  emit(key, value, comment)
end

local commentEmitted = false
local function comment(comment)
  emitEmptyLine()
  emit("# " .. comment)
  commentEmitted = true
end

show = function(spec)
  if not commentEmitted then
    emitEmptyLine()
  end
  emit "Show"
  commentEmitted = false

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
  Show = show,
  Comment = comment,
  EffectColor = effectColor,
  MinimapIcons = minimapIcons,
  Op = op,
  ItemRarity = itemRarity,
}
