#!/bin/bash

# Run from base directory.

ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/battleaxe.csv    > db/seeds/tables/attacks/battleaxe.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/brawl.csv        > db/seeds/tables/attacks/brawl.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/broadsword.csv   > db/seeds/tables/attacks/broadsword.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/club.csv         > db/seeds/tables/attacks/club.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/dagger.csv       > db/seeds/tables/attacks/dagger.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/falchion.csv     > db/seeds/tables/attacks/falchion.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/flail.csv        > db/seeds/tables/attacks/flail.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/greatsword.csv   > db/seeds/tables/attacks/greatsword.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/handaxe.csv      > db/seeds/tables/attacks/handaxe.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/javelin.csv      > db/seeds/tables/attacks/javelin.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/lance.csv        > db/seeds/tables/attacks/lance.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/longsword.csv    > db/seeds/tables/attacks/longsword.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/mace.csv         > db/seeds/tables/attacks/mace.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/morningstar.csv  > db/seeds/tables/attacks/morningstar.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/quarterstaff.csv > db/seeds/tables/attacks/quarterstaff.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/rapier.csv       > db/seeds/tables/attacks/rapier.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/scimitar.csv     > db/seeds/tables/attacks/scimitar.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/shortbow.csv     > db/seeds/tables/attacks/shortbow.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/shortsword.csv   > db/seeds/tables/attacks/shortsword.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/spear.csv        > db/seeds/tables/attacks/spear.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/stiletto.csv     > db/seeds/tables/attacks/stiletto.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/warhammer.csv    > db/seeds/tables/attacks/warhammer.rb
ruby cmd/ext/weapon_tables/convert_weapon_table.rb ext/weapon_tables/warmattock.csv   > db/seeds/tables/attacks/warmattock.rb
