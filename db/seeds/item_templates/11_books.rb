ItemTemplate.create!(
  short_desc: "a small leather-bound book",
  long_desc: "A small leather-bound book has been left here.",
  full_desc: "Who knows what secrets this tome of wisdom may hold?",
  kwords: ["small", "leather-bound", "book"],
  code: "book_01",
  weight: 400,
  book_template: BookTemplate.new(
    page_count: 10
  )
)
