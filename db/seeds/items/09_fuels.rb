Item.create!(
  short_desc: "a lump of coal",
  long_desc: "A lump of coal is on the ground.",
  full_desc: "It will stain your clothes",
  kwords: ["lump", "coal"],
  containing_inventory: Room.find(3).inventory,
  slot: :void,
  weight: 200,
  stack: Amount.new(
    current: 8,
    max: 100
  ),
  item_template: ItemTemplate.find_by_code("fuel_01")
)
