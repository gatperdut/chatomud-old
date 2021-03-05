module ChatoMud
  module Mixins
    module Characters
      module Comms
        module Guesser
          def guess_spoken_language(speaker_controller)
            return @character_controller.choice_controller.language.humanize.titlecase.blue if can_guess_spoken_language?(speaker_controller)

            "an unknown tongue".blue
          end

          def guess_written_language(language)
            return language.humanize.titlecase.blue if can_guess_written_language?(language)

            "an unknown tongue".blue
          end

          def guess_script(script)
            return script.humanize.titlecase if can_guess_script?(script)

            "unknown".blue
          end

          def can_guess_spoken_language?(speaker_controller)
            return true if speaker_controller == @character_controller

            language = speaker_controller.choice_controller.language.to_sym

            @character_controller.stats_controller.knows_skill?(language)
          end

          def can_guess_written_language?(language)
            @character_controller.stats_controller.knows_skill?(language.to_sym)
          end

          def can_guess_script?(script)
            @character_controller.stats_controller.knows_skill?(script.to_sym)
          end
        end
      end
    end
  end
end
