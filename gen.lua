local filter = require "filter-dsl"
local Show, Comment, EffectColor, MinimapIcons, ItemRarity, Op = filter.Show, filter.Comment, filter.EffectColor,
    filter.MinimapIcons, filter.ItemRarity, filter.Op

local Color = {
  Brown = { 255, 125, 125 }
}


Comment "WAYSTONES"
Show {
  BaseType = { "Waystone", comment = "comment here" },
  Rarity = { Op.LessOrEqual, ItemRarity.Rare },
  SetFontSize = 30,
  SetTextColor = { Color.Brown, comment = "amazing color" },
  SetBorderColor = Color.Brown, --{ 255, 128, 55, 255 },
  MinimapIcon = { 1, EffectColor.Brown, MinimapIcons.Kite },
  Continue = {},
  Show = {
    SetBorderColor = Color.Brown, --{ 255, 128, 55, 255 },
    Show = {
      BaseType = { "Rune", "Soul Core" },
      SetTextColor = { Color.Brown, comment = "amazing color" },
      SetBorderColor = { 255, 128, 55, 255 },
    }
  }
}

Show {
  BaseType = "Rune",
  Rarity = { ItemRarity.Rare, ItemRarity.Magic, ItemRarity.Unique },
  SetFontSize = 30,
  PlayEffect = { EffectColor.Grey, "Temp" }
}
