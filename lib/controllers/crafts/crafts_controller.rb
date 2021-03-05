require "mixins/crafts/step"

module ChatoMud
  module Controllers
    module Crafts
      class CraftsController
        include ChatoMud::Mixins::Crafts::Step

        def initialize(server, character_controller)
          @server               = server
          @character_controller = character_controller
          @crafts_thread        = nil

          @craft                = nil
          @ingredients          = nil
        end

        def is_crafting?
          @crafts_thread.present? && @crafts_thread.alive?
        end

        def stop_crafting(echo)
          @character_controller.tx("You abruptly stop crafting.") if echo
          item_controllers_in_use!(false)
          @crafts_thread&.terminate
          @crafts_thread = nil
        end

        def item_controllers_in_use!(value)
          @ingredients.each do |ingredient|
            ingredient[:results][:item_controllers].each do |item_controller|
              item_controller.in_use = value
            end
          end
        end

        def start_crafting(craft)
          craft_preparation = prepare_for_craft(craft)
          unless craft_preparation[:viable]
            @character_controller.tx(missing_ingredients_list(craft_preparation[:ingredients]))
            return
          end

          @craft       = craft
          @ingredients = craft_preparation[:ingredients]

          item_controllers_in_use!(true)

          @crafts_thread = Thread.new do
            handle_craft_steps
            item_controllers_in_use!(false)
          end
        end

        private

        def prepare_for_craft(craft)
          craft_preparation = {
            viable:      true,
            ingredients: []
          }

          craft.craft_ingredients.each do |craft_ingredient|
            ingredient_preparation = @character_controller.search_ingredient_controllers(craft_ingredient)
            unless ingredient_preparation[:results][:goal_met]
              craft_preparation[:viable] = false
            end
            craft_preparation[:ingredients] << ingredient_preparation
          end

          craft_preparation
        end

        def missing_ingredients_list(gathered_ingredients)
          text = "\n"
          gathered_ingredients.each do |gathered_ingredient|
            results = gathered_ingredient[:results]

            can_craft = results[:goal_met]

            text << "["
            text << "OK".green if     can_craft
            text << "NO".red   unless can_craft
            text << "]"

            text << " #{gathered_ingredient[:craft_ingredient].location} - "

            text << "[x#{gathered_ingredient[:craft_ingredient].how_many}] " if gathered_ingredient[:craft_ingredient].how_many.present?

            if can_craft
              text << "#{results[:item_controllers].map(&:short_desc).join(' and ')}"
            else
              text << "Need #{gathered_ingredient[:item_templates].pluck(:short_desc).map(&:green).join(' or ')}."
              if results[:item_controllers].count.positive?
                text << " You found #{results[:item_controllers].map(&:short_desc).join(' and ')}."
              end
            end

            text << "\n"
          end
          text
        end
      end
    end
  end
end
