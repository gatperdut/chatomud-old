require "controllers/characters/aasm/types/common_aasm"

module ChatoMud
  module Controllers
    module Characters
      module Aasm
        module Types
          class WandererAasm < CommonAasm
            aasm do
              # Empty.
            end

            def do_action
              interpret("emote wanders about.")
            end
          end
        end
      end
    end
  end
end
