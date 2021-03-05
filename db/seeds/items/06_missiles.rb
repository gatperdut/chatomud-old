Item.create!(
  short_desc: "an iron-tipped arrow",
  long_desc: "An iron-tipped arrow is on the ground.",
  full_desc: "Sharpy sharp!",
  kwords: ["iron-tipped", "arrow"],
  stack: Amount.new(
    current: 17,
    max: 100
  ),
  slot: :void,
  weight: 180,
  containing_inventory: Room.find(1).inventory,
  item_template: ItemTemplate.find_by_code("weap_01"),
  missile_stat: MissileStat.new(
    missile_type: :arrow
  )
)

Item.create!(
  short_desc: "an iron bolt",
  long_desc: "An iron bolt is on the ground",
  full_desc: "Sharpy sharpererrrr!",
  kwords: ["iron", "bolt"],
  stack: Amount.new(
    current: 13,
    max: 100
  ),
  slot: :void,
  weight: 180,
  containing_inventory: Room.find(1).inventory,
  item_template: ItemTemplate.find_by_code("weap_04"),
  missile_stat: MissileStat.new(
    missile_type: :bolt
  )
)
