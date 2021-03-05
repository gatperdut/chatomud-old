Item.create!(
  short_desc: "a bell on a string",
  long_desc: "There is a bell on the ground with a string attached.",
  full_desc: "It would produce a pleasant sound, were it to be left dangling from the string and shaken (sound bell).",
  kwords: ["bell", "string"],
  containing_inventory: Room.find(1).inventory,
  slot: :void,
  weight: 100,
  item_template: ItemTemplate.find_by_code("horn_01"),
  horn_property: HornProperty.new(
    echo: "The ring of a bell fills the area.",
    action_echo_self: "You make a bell on a string ring.",
    action_echo_others: "makes a bell on a string ring.",
    reach: :area
  )
)
