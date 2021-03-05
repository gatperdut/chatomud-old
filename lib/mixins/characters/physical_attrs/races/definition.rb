module ChatoMud
  module Mixins
    module Characters
      module PhysicalAttrs
        module Races
          module Definition
            def all_races
              [
                :human,
                :elf,
                :dwarf,
                :hobbit,
                :orc,
                :troll
              ]
            end

            def race_caloric_needs_base
              {
                human:  2000,
                elf:    1700,
                dwarf:  2300,
                hobbit: 2200,
                orc:    2000,
                troll:  5000
              }
            end
          end
        end
      end
    end
  end
end
