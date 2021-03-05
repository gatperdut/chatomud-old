Item.create!(
  short_desc: "a shoddy wooden shield",
  long_desc: "A shoddy wooden shield is here, forgotten by all.",
  full_desc: "These few wooden planks poorly fitted together could be used as a shield.",
  kwords: ["shoddy", "wooden", "shield"],
  slot: :void,
  weight: 3500,
  containing_inventory: Room.find(1).inventory,
  shield_stat: ShieldStat.new(
    variant: :normal,
    quality_modifier: -15
  ),
  item_template: ItemTemplate.find_by_code("shield_01")
)

Item.create!(
  short_desc: "a polished iron shield",
  long_desc: "A polished iron shield rests here.",
  full_desc: "Voluminous and polished. Coming directly from Skyrim.",
  kwords: ["polished", "iron", "shield"],
  slot: :void,
  weight: 3500,
  containing_inventory: Room.find(1).inventory,
  shield_stat: ShieldStat.new(
    variant: :full,
    quality_modifier: 0
  ),
  item_template: ItemTemplate.find_by_code("shield_02")
)
