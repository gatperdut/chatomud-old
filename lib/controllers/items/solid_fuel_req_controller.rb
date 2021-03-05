module ChatoMud
  module Controllers
    module Items
      class SolidFuelReqController
        def initialize(server, light_source_controller, solid_fuel_req)
          @server = server
          @light_source_controller = light_source_controller
          @solid_fuel_req = solid_fuel_req
        end

        def is_valid_fuel?(item_controller)
          option_ids.include?(item_controller.item_template_id)
        end

        private

        def option_ids
          @solid_fuel_req.options.pluck(:id)
        end
      end
    end
  end
end
