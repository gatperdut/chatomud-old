Item.create!(
  short_desc: "a written piece of parchment",
  long_desc: "A written piece of parchment lies on the floor.",
  full_desc: "The parchment is crisp and rugged to the touch.",
  kwords: ["piece", "parchment", "written"],
  slot: :void,
  weight: 80,
  containing_inventory: Room.find(3).inventory,
  writing: Writing.new(
    wipeable: false,
    post: Post.new(
      content: "Something written on a piece of parchment.",
      page: nil,
      text_info: TextInfo.new(
        character:          Character.all.first,
        ink_type:           :black_ink,
        language:           :westron,
        script:             :sarati,
        language_skill_mod: 30,
        script_skill_mod:   80
      )
    )
  ),
  item_template: ItemTemplate.find_by_code("parchment_01")
)

Item.create!(
  short_desc: "a blank piece of parchment",
  long_desc: "A blank piece of parchment lies on the floor.",
  full_desc: "The parchment is crisp and rugged to the touch.",
  kwords: ["piece", "parchment", "blank"],
  slot: :void,
  weight: 80,
  containing_inventory: Room.find(3).inventory,
  writing: Writing.new(
    wipeable: false,
    post: Post.new(
      content: nil,
      page: nil
    )
  ),
  item_template: ItemTemplate.find_by_code("parchment_01")
)

Item.create!(
  short_desc: "a small wood-framed slateboard",
  long_desc: "A small, wood-framed slateboard has been left here.",
  full_desc: "Framed in pine wood with a dark stain, the body of this rectangular slateboard is made of smooth, blue-grey stone. The top of the slateboard opens up on hinges to reveal a very small, fairly flat storage space inside to hold tools. The underside of the slateboard is padded with wool to rest on one's knees.",
  kwords: ["slateboard", "wood-framed", "framed", "board"],
  slot: :void,
  weight: 80,
  containing_inventory: Room.find(3).inventory,
  writing: Writing.new(
    wipeable: true,
    post: Post.new(
      content: nil,
      page: nil
    )
  ),
  item_template: ItemTemplate.find_by_code("parchment_01")
)
