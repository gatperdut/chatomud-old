module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_sit(params)
            emitter = params[:emitter]
            at      = params[:at]

            return unless can_see_action?(emitter)

            you = in_combat_warning(emitter)
            you << "You sit at #{at.short_desc}."
            others = "#{emitter.short_desc} sits at #{at.short_desc}"

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
