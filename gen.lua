local filter = require "filter-dsl"
local Show, Comment, EffectColor, MinimapIcons, ItemRarity, Op = filter.Show, filter.Comment, filter.EffectColor,
    filter.MinimapIcons, filter.ItemRarity, filter.Op

-- local Color = {
--   Brown = { 255, 125, 125 }
-- }

local FontSize = {
  XL = 45,
  L = 38,
  M = 32,
  S = 24,
  XS = 16,
}

local InGameColors = {
  normalItem = { 200, 200, 200 },
  magicItem = { 136, 136, 255 },
  rareItem = { 255, 255, 119 },
  uniqueItem = { 175, 96, 37 },
  skillGem = { 27, 162, 155 },
  currency = { 170, 158, 130 },
  questItem = { 74, 230, 58 },
  divinationCard = { 14, 186, 255 },
  defaultText = { 127, 127, 127 },
  valueText = { 255, 255, 255 },
  augmentedValueText = { 136, 136, 255 },
  fireDamage = { 150, 0, 0 },
  coldDamage = { 54, 100, 146 },
  lightningDamage = { 255, 215, 0 },
  chaosDamage = { 208, 32, 144 },
  craftedMod = { 184, 218, 242 },
  corrupted = { 210, 0, 0 },
  supporterPackNewItem = { 180, 96, 0 },
  supporterPackItem = { 163, 141, 109 },
  nemesisMod = { 255, 200, 0 },
  nemesisModOutline = { 255, 40, 0 },
  bloodlineMod = { 210, 0, 220 },
  bloodlineModOutline = { 74, 0, 160 },
  tormentMod = { 50, 230, 100 },
  tormentModOutline = { 0, 100, 150 },
  title = { 231, 180, 120 },
  favour = { 170, 158, 120 },
  pink = { 255, 192, 203 },
  dodgerBlue = { 30, 144, 255 }
}

local StashTabColors = {
  darkBrown = { 124, 81, 50 },
  orange = { 191, 91, 0 },
  peach = { 254, 191, 128 },
  deepPurple = { 38, 0, 86 },
  brightPurple = { 88, 0, 179 },
  lavender = { 192, 128, 254 },
  oliveGreen = { 98, 128, 0 },
  limeGreen = { 191, 244, 0 },
  paleYellow = { 239, 254, 128 },
  maroon = { 86, 0, 0 },
  crimson = { 191, 0, 0 },
  lightPink = { 254, 128, 128 },
  navy = { 0, 0, 128 },
  royalBlue = { 0, 0, 254 },
  skyBlue = { 128, 179, 254 },
  amber = { 254, 170, 0 },
  gold = { 254, 213, 0 },
  paleGold = { 254, 254, 153 },
  plum = { 114, 0, 83 },
  magenta = { 204, 0, 154 },
  hotPink = { 254, 128, 222 },
  darkGreen = { 0, 73, 0 },
  lime = { 0, 191, 0 },
  paleGreen = { 128, 254, 128 },
  darkGray = { 42, 42, 42 },
  gray = { 135, 135, 135 },
  lightGray = { 221, 221, 221 }
}

-- Comment "WAYSTONES"
-- Show {
--   BaseType = { "Waystone", comment = "comment here" },
--   Rarity = { Op.LessOrEqual, ItemRarity.Rare },
--   SetFontSize = FontSize.M,
--   SetTextColor = { Color.Brown, comment = "amazing color" },
--   SetBorderColor = Color.Brown, --{ 255, 128, 55, 255 },
--   MinimapIcon = { 1, EffectColor.Brown, MinimapIcons.Kite },
--   Continue = {},
--   Show = {
--     SetBorderColor = Color.Brown, --{ 255, 128, 55, 255 },
--     Show = {
--       BaseType = { "Rune", "Soul Core" },
--       SetTextColor = { Color.Brown, comment = "amazing color" },
--       SetBorderColor = { 255, 128, 55, 255 },
--     }
--   }
-- }
--
-- Show {
--   BaseType = "Rune",
--   Rarity = { ItemRarity.Rare, ItemRarity.Magic, ItemRarity.Unique },
--   SetFontSize = 30,
--   PlayEffect = { EffectColor.Grey, "Temp" }
-- }

Comment 'Runes'
Show {
  Class = "Socketable",
  BaseType = "Rune",
  SetTextColor = StashTabColors.gold,
  SetFontSize = FontSize.L,
  PlayEffect = { EffectColor.Cyan, "Temp" },
  MinimapIcon = { 2, EffectColor.Cyan, MinimapIcons.Triangle },
}

Comment "Charms"
Show {
  BaseType = "Charm",
  SetTextColor = StashTabColors.crimson,
  SetBorderColor = InGameColors.favour,
  SetFontSize = FontSize.M,
}

Comment "Pile of gold"
Show {
  BaseType = { Op.ExactMatch, "Gold" },
  StackSize = 250,
  SetFontSize = FontSize.M,
  SetTextColor = StashTabColors.gold,
  SetBackgroundColor = { 0, 0, 0, 205 }
}

Comment "Gold"
Show {
  BaseType = { Op.ExactMatch, "Gold" },
  SetFontSize = FontSize.M,
  SetTextColor = StashTabColors.paleGold,
  SetBackgroundColor = { 0, 0, 0, 205 }
}

Comment "All the currencies"
Show {
  Class = { Op.ExactMatch, "Stackable Currency" },
  SetFontSize = FontSize.L,
  SetTextColor = StashTabColors.paleGreen,
  SetBackgroundColor = { 0, 0, 0, 205 },
  MinimapIcon = { 2, EffectColor.Green, MinimapIcons.Diamond },
}

Comment "All the gems"
Show {
  Class = "Gem",
  SetFontSize = FontSize.L,
  SetTextColor = StashTabColors.hotPink,
  SetBackgroundColor = { 0, 0, 0, 205 },
  MinimapIcon = { 2, EffectColor.Pink, MinimapIcons.Circle },
}

Comment "Amulets, rings and belts"
Show {
  Class = { Op.ExactMatch, "Rings", 'Amulets', 'Belts' },
  Rarity = { ItemRarity.Normal, ItemRarity.Magic, ItemRarity.Rare },
  SetBorderColor = InGameColors.lightningDamage,
}

Comment 'All items of quality'
Show {
  Quality = { Op.Greater, 0 },
  SetBorderColor = InGameColors.valueText,
  MinimapIcon = { 2, EffectColor.White, MinimapIcons.Triangle }
}

Comment 'Items with sockets'
Show {
  Sockets = { Op.Greater, 0 },
  Rarity = ItemRarity.Normal,
  SetBorderColor = InGameColors.normalItem,
}

Show {
  Sockets = { Op.Greater, 0 },
  Rarity = ItemRarity.Magic,
  SetBorderColor = InGameColors.magicItem,
}

Show {
  Sockets = { Op.Greater, 0 },
  Rarity = ItemRarity.Unique,
  SetBorderColor = InGameColors.uniqueItem,
}

Comment "Highlight magic, rare and unique"
Show {
  Rarity = ItemRarity.Magic,
  SetTextColor = InGameColors.magicItem,
  SetBorderColor = InGameColors.magicItem,
}

Show {
  Rarity = ItemRarity.Rare,
  SetTextColor = InGameColors.rareItem,
  SetBorderColor = InGameColors.rareItem,
  MinimapIcon = { 2, EffectColor.Yellow, MinimapIcons.Circle }
}

Show {
  Rarity = ItemRarity.Unique,
  SetTextColor = InGameColors.uniqueItem,
  SetBorderColor = InGameColors.uniqueItem,
  MinimapIcon = { 2, EffectColor.Orange, MinimapIcons.Circle },
  PlayAlertSound = { 3, 200 },
}

Comment "Show all non-filtered items"
Show {
  SetFontSize = FontSize.M
}
