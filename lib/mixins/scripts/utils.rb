module ChatoMud
  module Mixins
    module Scripts
      module Utils
        def script_description(text_info, character_controller)
          return "utterly" unless character_controller.stats_controller.knows_skill?(text_info.script)

          case text_info.script_skill_mod
            when -Float::INFINITY..20
              "crude"
            when 21..30
              "slightly rough"
            when 31..70
              "average"
            when 71..80
              "well-crafted"
            when 81..90
              "outstanding"
            when 91..99
              "masterful"
            when 100..Float::INFINITY
              "perfect"
          end
        end
      end
    end
  end
end
