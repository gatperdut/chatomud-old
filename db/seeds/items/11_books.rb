Item.create!(
  short_desc: "a small leather-bound book",
  long_desc: "A small leather-bound book has been left here.",
  full_desc: "Who knows what secrets this tome of wisdom may hold?",
  kwords: ["small", "leather-bound", "book"],
  slot: :void,
  weight: 300,
  containing_inventory: Room.find(3).inventory,
  book: Book.new(
    current_page: 0,
    page_count:   10,
    posts: [
      Post.new(
        content: "The Flora and Fauna of Middle-Earth",
        page: 0,
        text_info: TextInfo.new(
          character:          Character.all.first,
          ink_type:           :black_ink,
          language:           :westron,
          script:             :sarati,
          language_skill_mod: 30,
          script_skill_mod:   80
        )
      ),
      Post.new(
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        page: 2,
        text_info: TextInfo.new(
          character: Character.all.first,
          ink_type: :black_ink,
          language:           :westron,
          script:              :sarati,
          language_skill_mod:       30,
          script_skill_mod:         80
        )
      ),
      Post.new(
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        page: 3,
        text_info: TextInfo.new(
          character: Character.all.first,
          ink_type: :black_ink,
          language:           :westron,
          script:             :tengwar,
          language_skill_mod:       30,
          script_skill_mod:         80
        )
      ),
      Post.new(
        content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
        page: 5,
        text_info: TextInfo.new(
          character: Character.all.first,
          ink_type: :black_ink,
          language:           :valarin,
          script:               :cirth,
          language_skill_mod:       30,
          script_skill_mod:         80
        )
      ),
      Post.new(
        content: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32.",
        page: 6,
        text_info: TextInfo.new(
          character: Character.all.first,
          ink_type: :red_ink,
          language:           :westron,
          script:             :tengwar,
          language_skill_mod:       30,
          script_skill_mod:         80
        )
      ),
      Post.new(
        content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
        page: 7,
        text_info: TextInfo.new(
          character: Character.all.first,
          ink_type: :black_ink,
          language:           :westron,
          script:             :tengwar,
          language_skill_mod:       30,
          script_skill_mod:         80
        )
      )
    ]
  ),
  item_template: ItemTemplate.find_by_code("book_01")
)

Item.create!(
  short_desc: "a big, dusty tome",
  long_desc: "A big, dusty tome gathers more dust on the ground.",
  full_desc: "You sneeze just by looking at it.",
  kwords: ["big", "dusty", "tome"],
  slot: :void,
  weight: 300,
  containing_inventory: Room.find(3).inventory,
  book: Book.new(
    current_page: 2,
    page_count:   10,
    posts: [
      Post.new(
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        page: 2,
        text_info: TextInfo.new(
          character: Character.all.third,
          ink_type: :blood,
          language:           :westron,
          script:              :sarati,
          language_skill_mod:       30,
          script_skill_mod:         80
        )
      )
    ]
  ),
  item_template: ItemTemplate.find_by_code("book_01")
)
