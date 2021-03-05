ItemTemplate.create!(
  short_desc: "a leather quiver",
  long_desc: "A leather quiver is here.",
  full_desc: "Put your arrows or bolts in here.",
  kwords: ["leather", "quiver"],
  possible_slots: [:lshoulder, :rshoulder],
  is_quiver: true,
  inventory_template: InventoryTemplate.new,
  code: "quiver_01",
  weight: 1000
)
