require "mixins/ink_types/utils"
require "mixins/ink_types/dipping"

module ChatoMud
  module Controllers
    module Items
      class InkSourceController
        include Mixins::InkTypes::Utils
        include Mixins::InkTypes::Dipping

        def initialize(server, item_controller, ink_source)
          @server = server
          @item_controller = item_controller
          @ink_source = ink_source
        end

        def ink_type
          @ink_source.ink_type
        end

        def ink_type_name
          ink_type_name_for(ink_type)
        end

        def is_picking_ink_source?
          is_picking_ink_type?(ink_type)
        end

        def is_dipping_ink_source?
          is_dipping_ink_type?(ink_type)
        end

        def charges
          @ink_source.charges
        end

        def has_charges_left?
          charges.positive?
        end

        def has_no_charges_left?
          !has_charges_left?
        end

        def use_up_charge
          @ink_source.charges = @ink_source.charges - 1
          @ink_source.save!
        end

        def charge(item_controller)
          item_controller.writing_implement_controller.charge_with(ink_type)
          use_up_charge
        end

        def model
          @ink_source
        end
      end
    end
  end
end
