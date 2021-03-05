Protection.create!(level:  1, min_penalty:  0, max_penalty:   0) # Padded     / Naked / Regular clothes
Protection.create!(level:  2, min_penalty:  0, max_penalty:   0) # Padded +   / Heavy clothes
Protection.create!(level:  3, min_penalty:  0, max_penalty:   0) # Padded ++  / Animal
Protection.create!(level:  4, min_penalty:  0, max_penalty:   0) # Padded +++ / Animal +

Protection.create!(level:  5, min_penalty:  0, max_penalty:   6) # Flexible Leather
Protection.create!(level:  6, min_penalty:  0, max_penalty:  12) # Flexible Leather +
Protection.create!(level:  7, min_penalty:  9, max_penalty:  18) # Flexible Leather ++
Protection.create!(level:  8, min_penalty: 12, max_penalty:  25) # Flexible Leather +++

Protection.create!(level:  9, min_penalty: 16, max_penalty:  32) # Rigid Leather
Protection.create!(level: 10, min_penalty: 19, max_penalty:  38) # Rigid Leather +
Protection.create!(level: 11, min_penalty: 22, max_penalty:  44) # Rigid Leather ++  / Animal ++
Protection.create!(level: 12, min_penalty: 24, max_penalty:  50) # Rigid Leather +++ / Animal +++

Protection.create!(level: 13, min_penalty: 28, max_penalty:  57) # Flexible Metal
Protection.create!(level: 14, min_penalty: 31, max_penalty:  63) # Flexible Metal +
Protection.create!(level: 15, min_penalty: 34, max_penalty:  69) # Flexible Metal ++
Protection.create!(level: 16, min_penalty: 37, max_penalty:  75) # Flexible Metal +++

Protection.create!(level: 17, min_penalty: 41, max_penalty:  82) # Rigid Metal
Protection.create!(level: 18, min_penalty: 44, max_penalty:  88) # Rigid Metal +
Protection.create!(level: 19, min_penalty: 47, max_penalty:  94) # Rigid Metal ++
Protection.create!(level: 20, min_penalty: 50, max_penalty: 100) # Rigid Metal +++
