module ChatoMud
  module Mixins
    module Characters
      module Nourishment
        module Definition
          def all_hunger_stages
            [
              "almost starved to death",
              "feeling faint from starvation",
              "slowly starving",
              "ravenous",
              "famished",
              "very hungry",
              "hungry",
              "feeling peckish",
              "satiated",
              "absolutely stuffed"
            ]
          end

          def all_thirst_stages
            [
              "dying of thirst",
              "desperately thirsty",
              "quite parched",
              "feeling very thirsty",
              "feeling thirsty",
              "feeling slightly thirsty",
              "not thirsty",
              "sated",
              "nicely quenched",
              "completely sated"
            ]
          end

          def hunger_penalties
            [
              14,
              12,
              10,
              8,
              6,
              4,
              2,
              0,
              0,
              0
            ]
          end

          def thirst_penalties
            [
              18,
              15,
              12,
              9,
              6,
              3,
              0,
              0,
              0,
              0
            ]
          end
        end
      end
    end
  end
end
