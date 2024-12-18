local filter = require "filter-dsl"
-- require "filter-theme"
local Show, Comment, EffectColor, minimapIcons, ItemRarity = filter.Show, filter.Comment, EffectColor, minimapIcons,
    ItemRarity

local Color = {
  Brown = { 255, 125, 125 }
}

local Icon = {
  Star = "star"
}

Comment "WAYSTONES"
Show {
  BaseType = { "Waystone", comment = "comment here" },
  Rarity = { op.LessOrEqual, ItemRarity.Rare },
  SetFontSize = 30,
  SetTextColor = { Color.Brown, comment = "amazing color" },
  SetBorderColor = Color.Brown, --{ 255, 128, 55, 255 },
  MinimapIcon = { 1, EffectColor.Brown, Icon.Star },
  Continue = {},
  Show = {
    SetBorderColor = Color.Brown, --{ 255, 128, 55, 255 },
    Show = {
      BaseType = { "Rune", "Soul Core" },
      TextColor = { Color.Brown, comment = "amazing color" },
      BorderColor = { 255, 128, 55, 255 },
    }
  }
}

Show {
  BaseType = "Rune",
  Rarity = { ItemRarity.Rare, ItemRarity.Magic, ItemRarity.Unique },
  SetFontSize = 30,
  PlayEffect = { EffectColor.Grey }
}
