ItemTemplate.create!(
  short_desc: "a writing quill",
  long_desc: "A writing quill has been discarded here.",
  full_desc: "The plain feather quill is made from a wingfeather, with a sharpened hollow tip.",
  kwords: ["writing", "quill"],
  code: "quill_01",
  weight: 40,
  writing_implement_template: WritingImplementTemplate.new(
    single_use: false
  )
)

ItemTemplate.create!(
  short_desc: "a piece of chalk",
  long_desc: "A piece of chalk lies here upon the ground.",
  full_desc: "This is a small nubbin of white chalk. It is a bit irregular in shape, being generally cylindrical but worn down around its edges through use. The chalk is porous and easily powders when held.",
  kwords: ["piece", "chalk"],
  code: "chalk_01",
  writing_implement_template: WritingImplementTemplate.new(
    single_use: true
  )
)
