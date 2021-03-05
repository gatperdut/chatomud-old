module ChatoMud
  module Controllers
    module Characters
      class ChoiceController
        def initialize(server, choice)
          @server = server
          @choice = choice
        end

        def stance
          @choice.stance
        end

        def stance_is?(another_stance)
          stance == another_stance
        end

        def stance!(new_stance)
          @choice.stance = new_stance
          @choice.save!
        end

        def stance_colorized
          stance.cyan
        end

        def editor_echoes
          @choice.editor_echoes
        end

        def editor_echoes_is?(editor_echoes)
          @choice.editor_echoes == editor_echoes
        end

        def editor_echoes!(editor_echoes)
          @choice.editor_echoes = editor_echoes
          @choice.save!
        end

        def editor_echoes_colorized
          return "will".cyan if @choice.editor_echoes

          "will not".cyan
        end

        def pace
          @choice.pace
        end

        def pace_is?(pace)
          @choice.pace == pace
        end

        def pace!(pace)
          @choice.pace = pace
          @choice.save!
        end

        def pace_colorized
          pace.cyan
        end

        def language
          @choice.language
        end

        def language_formatted
          @choice.language.humanize.titlecase.blue
        end

        def script
          @choice.script
        end

        def script_formatted
          @choice.script.humanize.titlecase.blue
        end
      end
    end
  end
end
