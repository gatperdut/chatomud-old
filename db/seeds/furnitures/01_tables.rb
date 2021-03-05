Furniture.create!(
  short_desc: "a mahogany table with a set of chairs",
  long_desc: "A mahogany table with a set of chairs is here.",
  full_desc: "The table is mahogany and blablabla.",
  kwords: ["table", "mahogany", "set", "chairs"],
  max_seats: 4,
  inventory: Inventory.new,
  room: Room.find(1),
  furniture_template: FurnitureTemplate.find_by_code("table_01")
)
