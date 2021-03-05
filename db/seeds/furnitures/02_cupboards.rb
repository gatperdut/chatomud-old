Furniture.create!(
  short_desc: "a dark metallic cupboard",
  long_desc: "A dark metallic cupboard is attached to the wall.",
  full_desc: "A cupboard made of some dark metal, used to store things in it.",
  kwords: ["dark", "metallic", "cupboard"],
  max_seats: 0,
  inventory: Inventory.new(
    lid: Lid.new(
      open: false
    )
  ),
  room: Room.find(1),
  furniture_template: FurnitureTemplate.find_by_code("cupboard_01")
)
