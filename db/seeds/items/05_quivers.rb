Item.create!(
  short_desc: "a leather quiver",
  long_desc: "A leather quiver is here.",
  full_desc: "Put your arrows or bolts in here",
  kwords: ["leather", "quiver"],
  possible_slots: [:lshoulder, :rshoulder],
  slot: :void,
  weight: 1000,
  containing_inventory: Room.find(1).inventory,
  item_template: ItemTemplate.find_by_code("quiver_01"),
  is_quiver: true,
  inventory: Inventory.new
)
