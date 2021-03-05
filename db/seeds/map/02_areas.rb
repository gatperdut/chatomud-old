Area.new(name: "The streets", superarea: Superarea.first).save(validate: false)

Area.new(name: "A shop", superarea: Superarea.first).save(validate: false)

Area.new(name: "A path in the forest", superarea: Superarea.second).save(validate: false)

Area.new(name: "A bloodied arena", superarea: Superarea.third).save(validate: false)
