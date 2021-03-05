ItemTemplate.create!(
  short_desc: "a shoddy wooden shield",
  long_desc: "A shoddy wooden shield is here, forgotten by all.",
  full_desc: "These few wooden planks poorly fitted together could be used as a shield.",
  kwords: ["shoddy", "wooden", "shield"],
  code: "shield_01",
  weight: 3000,
  shield_stat_template: ShieldStatTemplate.new(
    variant: :normal,
    quality_modifier: -15
  )
)

ItemTemplate.create!(
  short_desc: "a polished iron shield",
  long_desc: "A polished iron shield rests here.",
  full_desc: "Voluminous and polished. Coming directly from Skyrim.",
  kwords: ["polished", "iron", "shield"],
  code: "shield_02",
  weight: 3000,
  shield_stat_template: ShieldStatTemplate.new(
    variant: :full,
    quality_modifier: 0
  )
)
