module ChatoMud
  module Mixins
    module InkTypes
      module Definition
        def all_ink_types
          all_picking_ink_types + all_dipping_ink_types
        end

        def all_picking_ink_types
          [
            :chalk,
            :coal
          ]
        end

        def all_dipping_ink_types
          [
            :red_ink,
            :black_ink,
            :blood,
            :silver_ink,
            :blue_ink,
            :scarlet_ink
          ]
        end
      end
    end
  end
end
