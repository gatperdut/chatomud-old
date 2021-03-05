ItemTemplate.create!(
  short_desc: "a shitty, ash shortbow",
  long_desc: "A shitty, ash shortbow is here.",
  full_desc: "A. Shitty. Ash. Shortbow. No more description.",
  kwords: ["shity", "ash", "bow", "shortbow"],
  code: "weap_06",
  weight: 2000,
  possible_slots: [:lshoulder, :rshoulder],
  weapon_stat_template: WeaponStatTemplate.new(
    grip: :both,
    base: :shortbow,
    roll_mod: 0,
    critical_mod: 0,
    ranged_stat_template: RangedStatTemplate.new(
      inventory_template: InventoryTemplate.new,
      missile_type: :arrow,
      ranges_suitability: [:short_range, :point_blank, :medium_range, :long_range],
      can_remain_loaded: false
    )
  )
)

ItemTemplate.create!(
  short_desc: "a well-made yew crossbow",
  long_desc: "A well-made yew crossbow is here.",
  full_desc: "A. Well-made. Yew. Crossbow. No more description!",
  kwords: ["well-made", "yew", "crossbow"],
  code: "weap_07",
  weight: 2000,
  weapon_stat_template: WeaponStatTemplate.new(
    grip: :both,
    base: :crossbow,
    roll_mod: 0,
    critical_mod: 0,
    ranged_stat_template: RangedStatTemplate.new(
      inventory_template: InventoryTemplate.new,
      missile_type: :bolt,
      ranges_suitability: [:point_blank, :short_range, :medium_range, :long_range],
      can_remain_loaded: true
    )
  )
)
