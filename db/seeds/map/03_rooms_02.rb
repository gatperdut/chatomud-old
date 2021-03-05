p1 = Room.create!(
  title: "Path 1",
  description: "This is the first portion of the path.",
  description_nighttime: "This is the first portion of the path, nighttime description.",
  inventory: Inventory.new,
  area: Area.third,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

p2 = Room.create!(
  title: "Path 2",
  description: "This is the second portion of the path.",
  description_nighttime: "This is the second portion of the path, nighttime description.",
  inventory: Inventory.new,
  area: Area.third,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

p3 = Room.create!(
  title: "Path 3",
  description: "This is the third portion of the path.",
  description_nighttime: "This is the third portion of the path, nighttime description.",
  inventory: Inventory.new,
  area: Area.third,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

p1.update_attributes(wr: p2)

p2.update_attributes(er: p1, wr: p3)

p3.update_attributes(er: p2)

p4 = Room.create!(
  title: "Shop 1",
  description: "This is the first portion of the shop.",
  description_nighttime: nil,
  inventory: Inventory.new,
  area: Area.second,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

p5 = Room.create!(
  title: "Shop 2",
  description: "This is the second portion of the shop.",
  description_nighttime: nil,
  inventory: Inventory.new,
  area: Area.second,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

p6 = Room.create!(
  title: "Shop 3",
  description: "This is the third portion of the shop.",
  description_nighttime: nil,
  inventory: Inventory.new,
  area: Area.second,
  always_lit: false,
  enclosed: false,
  roughness_multiplier: 1.0
)

p4.update_attributes(er: p5)

p5.update_attributes(wr: p4, er: p6)

p6.update_attributes(wr: p5)
