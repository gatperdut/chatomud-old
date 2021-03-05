module ChatoMud
  module Mixins
    module Characters
      module Choices
        module Stances
          module Definition
            def all_stances
              [
                :pacifist,
                :defensive,
                :careful,
                :normal,
                :aggressive,
                :frantic,
                :frenzy
              ]
            end
          end
        end
      end
    end
  end
end
