module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_simple_sit(params)
            emitter = params[:emitter]
            from    = params[:from]

            return unless can_see_action?(emitter)

            you = in_combat_warning(emitter)
            you << "You "
            others = "#{emitter.short_desc} "

            case from
              when :standing
                you << "sit down."
                others << "sits down."
              when :resting
                you << "stop resting and sit up."
                others << "stops resting and sits up."
              else
                raise "standing from invalid position"
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
