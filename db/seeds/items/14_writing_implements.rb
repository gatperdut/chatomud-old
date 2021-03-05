Item.create!(
  short_desc: "a writing quill",
  long_desc: "A writing quill has been discarded here.",
  full_desc: "The plain feather quill is made from a wingfeather, with a sharpened hollow tip.",
  kwords: ["writing", "quill"],
  slot: :void,
  weight: 100,
  containing_inventory: Room.find(3).inventory,
  writing_implement: WritingImplement.new(
    charged: false,
    ink_type: :black_ink,
    single_use: false
  ),
  item_template: ItemTemplate.find_by_code("quill_01")
)

Item.create!(
  short_desc: "a piece of chalk",
  long_desc: "A piece of chalk lies here upon the ground.",
  full_desc: "This is a small nubbin of white chalk. It is a bit irregular in shape, being generally cylindrical but worn down around its edges through use. The chalk is porous and easily powders when held.",
  kwords: ["piece", "chalk"],
  slot: :void,
  weight: 100,
  containing_inventory: Room.find(3).inventory,
  writing_implement: WritingImplement.new(
    charged: true,
    ink_type: :chalk,
    single_use: true
  ),
  item_template: ItemTemplate.find_by_code("chalk_01")
)
