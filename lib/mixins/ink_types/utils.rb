require "mixins/ink_types/definition"

module ChatoMud
  module Mixins
    module InkTypes
      module Utils
        include Mixins::InkTypes::Definition

        def is_dipping_ink_type?(ink_type)
          all_dipping_ink_types.include?(ink_type.to_sym)
        end

        def is_picking_ink_type?(ink_type)
          all_picking_ink_types.include?(ink_type.to_sym)
        end

        def ink_type_color(ink_type)
          case ink_type.to_sym
            when :chalk
              :light_white
            when :coal
              :light_black
            when :red_ink
              :red
            when :black_ink
              :light_black
            when :blood
              :red
            else
              raise "ink type color for unknown ink type"
          end
        end

        def ink_type_name_for(ink_type)
          ink_type.split("_").join(" ").humanize(capitalize: false).send(ink_type_color(ink_type))
        end
      end
    end
  end
end
