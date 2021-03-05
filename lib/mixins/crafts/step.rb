require "mixins/random/utils"
require "mixins/crafts/usage"
require "mixins/crafts/result"

require "mixins/characters/physical_attrs/genders/utils"

module ChatoMud
  module Mixins
    module Crafts
      module Step
        include Mixins::Random::Utils
        include Mixins::Crafts::Usage
        include Mixins::Crafts::Result

        include Mixins::Characters::PhysicalAttrs::Genders::Utils

        def handle_craft_steps
          @craft.craft_steps.each do |craft_step|
            handle_fail(craft_step) if craft_step.craft_test && !do_test(craft_step.craft_test)

            item_results = []
            if craft_step.craft_item_results.any?
              craft_step.craft_item_results.each do |craft_item_result|
                item_results << handle_craft_item_result(craft_item_result)
              end
            end

            handle_echo(craft_step, item_results)

            handle_usage(craft_step)

            sleep(craft_step.delay)
          end
        end

        private

        def handle_fail(craft_step)
          text_self   = craft_step.fail_first
          text_others = craft_step.fail_third

          text_others = handle_crafter_placeholders(text_others)

          emit_step_echo(text_self, text_others)

          stop_crafting(false)
        end

        def handle_echo(craft_step, item_results)
          occurrence_indexes = craft_step.find_occurrence_indexes(:echo_first)

          text_self   = craft_step.echo_first
          text_others = craft_step.echo_third

          occurrence_indexes.each do |occurrence_index|
            text_self   = replace_occurrences(text_self,   @ingredients, occurrence_index)
            text_others = replace_occurrences(text_others, @ingredients, occurrence_index)
          end

          text_others = handle_crafter_placeholders(text_others)

          if item_results.any?
            text_self   = handle_result_placeholders(text_self,   item_results)
            text_others = handle_result_placeholders(text_others, item_results)
          end

          @character_controller.room_controller.emit_action_echo("craft_echo", { emitter: @character_controller, text_self: text_self, text_others: text_others })
        end

        def do_test(craft_test)
          roll = d100(:closed)

          roll < @character_controller.stats_controller.skill_modifier(craft_test.skill.to_sym) + craft_test.modifier
        end

        def replace_occurrences(text, _ingredients, index)
          text.sub("$#{index}", @ingredients[index - 1][:results][:item_controllers].map(&:short_desc).join(" and "))
        end

        def handle_crafter_placeholders(text)
          text = text.sub("$crafter", @character_controller.short_desc)
          text = text.sub("$pronoun", personal(@character_controller.physical_attr_controller.gender))

          text
        end

        def handle_result_placeholders(text, item_results)
          item_results.each_with_index do |item_result, index|
            text = text.sub("$result#{index + 1}", item_result.short_desc)
          end

          text
        end

        def emit_step_echo(text_self, text_others)
          @character_controller.room_controller.emit_action_echo("craft_echo", { emitter: @character_controller, text_self: text_self, text_others: text_others })
        end
      end
    end
  end
end
