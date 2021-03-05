b = Item.new(
  short_desc: "a gathering of gossiping folk",
  long_desc: "A gathering of gossiping folk is assembled here.",
  full_desc: "They murmur and bicker.",
  kwords: ["gathering", "gossiping", "folk"],
  slot: :void,
  weight: 0,
  containing_inventory: Room.find(3).inventory,
  board: Board.new(
    posts: []
  ),
  item_template: ItemTemplate.find_by_code("board_01")
)

37.times do |n|
  b.board.posts << Post.new(
    title:      "Title of the message number #{n + 1} in the board.",
    content:    "This is the content of the message number #{n + 1} in the board.",
    created_at: Time.now + 1321.minutes * n,
    text_info: TextInfo.new(
      character: Character.find(n % 4 + 1)
    )
  )
end

b.save!
