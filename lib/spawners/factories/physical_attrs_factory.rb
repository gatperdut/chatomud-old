require "mixins/random/utils"

module ChatoMud
  module Spawners
    module Factories
      class PhysicalAttrsFactory
        include Mixins::Random::Utils

        def initialize(server)
          @server = server
        end

        def instantiate(physical_attr_template)
          physical_attr_attributes = physical_attr_template.attributes.symbolize_keys.except(:id, :parent_id, :parent_type, :weight_category, :height_category, :genders)

          physical_attr_attributes[:gender] = physical_attr_template.genders.sample

          frame = determine_frame(physical_attr_attributes[:gender], physical_attr_attributes[:race], physical_attr_template.height_category, physical_attr_template.weight_category)

          physical_attr_attributes[:height] = frame[:height]

          physical_attr_attributes[:weight] = frame[:weight]

          physical_attr = PhysicalAttr.new(physical_attr_attributes)

          physical_attr
        end

        private

        def determine_frame(gender, race, height_category, weight_category)
          base_frame_roll = nil
          base_frame      = nil

          loop do
            base_frame_roll = d100

            base_frame = @server.base_frame_referrer.find(base_frame_roll, race)

            break if base_frame.label == height_category
          end

          frame_modifier_roll = nil
          frame_modifier      = nil

          loop do
            frame_modifier_roll = d100(:closed)

            frame_modifier = @server.frame_modifier_referrer.find(frame_modifier_roll, race, gender)

            break if frame_modifier.label == weight_category
          end

          column = base_frame.column + frame_modifier.modifier

          column = column.clamp(0, 26)

          weight_base_frame = @server.base_frame_referrer.find_by_column(race, column)

          {
            height: base_frame.height,
            weight: weight_base_frame.weight
          }
        end
      end
    end
  end
end
