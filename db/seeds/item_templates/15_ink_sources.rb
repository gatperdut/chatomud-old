ItemTemplate.create!(
  short_desc: "a small ceramic pot of black ink",
  long_desc: "A small ceramic pot of black ink is here.",
  full_desc: "A container with a precious liquid that stains like hell.",
  kwords: ["small", "ceramic", "pot", "black", "ink"],
  code: "black_ink_01",
  weight: 100,
  ink_source_template: InkSourceTemplate.new(
    ink_type: :black_ink,
    charges: 5
  )
)

ItemTemplate.create!(
  short_desc: "a small box of chalk",
  long_desc: "A small box of chalk lies upon the ground here.",
  full_desc: "It is a small tin box filled with finger-sized cylindrical pieces of chalk.",
  kwords: ["small", "box", "chalk"],
  code: "chalkbox_01",
  weight: 100,
  ink_source_template: InkSourceTemplate.new(
    ink_type: :chalk,
    charges: 5,
    spawned_item_template: ItemTemplate.find_by_code("chalk_01")
  )
)
