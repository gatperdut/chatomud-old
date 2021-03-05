require "mixins/ink_types/utils"

module ChatoMud
  module Controllers
    module Items
      class WritingImplementController
        include Mixins::InkTypes::Utils

        def initialize(server, item_controller, writing_implement)
          @server = server
          @item_controller = item_controller
          @writing_implement = writing_implement
        end

        def is_charged?
          @writing_implement.charged
        end

        def discharge
          if bears_picking_ink?
            @item_controller.junk(true)
          else
            @writing_implement.charged = false
            @writing_implement.save!
          end
        end

        def is_single_use?
          @writing_implement.single_use
        end

        def ink_type
          @writing_implement.ink_type
        end

        def ink_type_name
          ink_type_name_for(ink_type)
        end

        def bears_picking_ink?
          is_picking_ink_type?(ink_type)
        end

        def bears_dipping_ink?
          is_dipping_ink_type?(ink_type)
        end

        def charge_with(ink_type)
          @writing_implement.ink_type = ink_type
          @writing_implement.charged = true
          @writing_implement.save!
        end
      end
    end
  end
end
