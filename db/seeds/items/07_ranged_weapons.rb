Item.create!(
  short_desc: "a yew shortbow",
  long_desc: "A yew shortbow is here.",
  full_desc: "A. Yew. Shortbow.",
  kwords: ["yew", "bow", "shortbow"],
  slot: :void,
  weight: 2000,
  containing_inventory: Room.find(1).inventory,
  item_template: ItemTemplate.find_by_code("weap_06"),
  weapon_stat: WeaponStat.new(
    grip: :both,
    base: :shortbow,
    ranged_stat: RangedStat.new(
      inventory: Inventory.new,
      missile_type: :arrow,
      ranges_suitability: [:short_range, :point_blank, :medium_range, :long_range],
      can_remain_loaded: false
    )
  )
)

Item.create!(
  short_desc: "a sturdy crossbow",
  long_desc: "A sturdy crossbow is here.",
  full_desc: "A. Sturdy. Crossbow.",
  kwords: ["sturdy", "crossbow"],
  slot: :void,
  weight: 2000,
  containing_inventory: Room.find(1).inventory,
  item_template: ItemTemplate.find_by_code("weap_07"),
  weapon_stat: WeaponStat.new(
    grip: :both,
    base: :crossbow,
    ranged_stat: RangedStat.new(
      inventory: Inventory.new,
      missile_type: :bolt,
      ranges_suitability: [:point_blank, :short_range, :medium_range, :long_range],
      can_remain_loaded: true
    )
  )
)
