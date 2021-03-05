require "controllers/inventories/wound_inventory_controller"

require "mixins/body_parts/utils"

module ChatoMud
  module Controllers
    module Characters
      module Health
        class WoundController
          include Mixins::BodyParts::Utils

          attr_reader :inventory_controller

          def initialize(server, health_controller, wound)
            @server = server
            @health_controller = health_controller
            @wound = wound

            @inventory_controller = @wound.inventory ? Inventories::WoundInventoryController.new(@server, self, @wound.inventory) : nil

            @health_controller.add_wound_controller(self)
          end

          def has_missile_lodged?
            !!@inventory_controller
          end

          def dislodge_missile(character_controller)
            character_controller.inventory_controller.accept_item(@inventory_controller.lodged_missile_controller, true)
            @inventory_controller = nil
            @wound.inventory.destroy
          end

          def will_auto_heal?
            # add infected condition here.
            !has_missile_lodged?
          end

          def damage
            @wound.damage
          end

          def heal_by(amount)
            if damage <= amount
              bye
            else
              @wound.update_attribute(:damage, damage - amount)
            end
          end

          # this is just silly. redo.
          def severity
            case damage
              when 1..4
                "small"
              when 5..14
                "light"
              when 15..24
                "moderate"
              when 25..34
                "serious"
              when 35..44
                "grievous"
              when 45..54
                "horrible"
              else
                "mortal"
            end
          end

          def body_part
            @wound.body_part.to_sym
          end

          def in_body_part?(a_body_part)
            body_part == a_body_part
          end

          def damage_type
            @wound.damage_type.to_sym
          end

          def description
            text = "a #{severity} #{damage_type} in #{body_part_description(body_part)}"

            text << " (#{@inventory_controller.lodged_missile_controller.short_desc} lodged)" if has_missile_lodged?

            text
          end

          private

          def bye
            @health_controller.remove_wound_controller(self)
            @wound.destroy
          end
        end
      end
    end
  end
end
