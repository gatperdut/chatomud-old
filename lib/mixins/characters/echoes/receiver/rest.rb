module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_rest(params)
            emitter = params[:emitter]
            from    = params[:from]

            return unless can_see_action?(emitter)

            you = in_combat_warning(emitter)
            you << "You "
            others = "#{emitter.short_desc} "

            case from
              when :sitting
                you << "rest your tired bones."
                others << "rests."
              when :standing
                you << "sit down and rest your tired bones."
                others << "sits down and rests."
              else
                raise "resting from invalid position"
            end

            text = interpolate_me_other(emitter, you, others)

            tx(text)
          end

          def in_combat_warning(emitter)
            emitter.combat_controller.is_being_attacked? ? "You are going to get slaughtered! Are YOU MAD??!\n".red : ""
          end
        end
      end
    end
  end
end
