local index = {
  'BaseType',
  'Rarity',
  'SetFontSize',
  'SetTextColor',
  'SetBorderColor',
  'MinimapIcon',
  'PlayEffect',
  'Continue',
  'Show'
}

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

local function processRule(key, value)
  if not isTable(value) then
    io.write(indent .. key .. " " .. value .. '\n')
  else
    local comment = value.comment
    value.comment = nil

    if key == "Show" then
      Show(value) -- TODO: support comment for show?
      return
    elseif key == "Continue" then
      value = {}
    end

    -- first value might be a table (ie. it's embedded color table)
    if isTable(value[1]) then
      value = value[1]
    end
    value = table.concat(value, " ")

    io.write(indent .. key .. " " .. value)
    if comment then
      io.write(" # " .. comment)
    end
    io.write('\n')
  end
end

local function comment(comment)
  print("# " .. comment)
end

-- not defined as local because the reference from `ProcessRule`
function Show(spec)
  print('\n' .. indent .. "Show")
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
