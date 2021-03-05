FurnitureTemplate.create!(
  short_desc: "a dark metallic cupboard",
  long_desc: "A dark metallic cupboard is attached to the wall.",
  full_desc: "A cupboard made of some dark metal, used to store things in it.",
  kwords: ["dark", "metallic", "cupboard"],
  max_seats: 0,
  inventory_template: InventoryTemplate.new(
    lid_template: LidTemplate.new
  ),
  code: "cupboard_01"
)
