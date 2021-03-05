module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_stand(params)
            emitter = params[:emitter]

            return unless can_see_action?(emitter)

            you = "You "
            others = "#{emitter.short_desc} "

            if emitter.position_controller.is_sitting?
              if emitter.position_controller.is_accommodated?
                you << "stand up from #{emitter.position_controller.furniture_controller.short_desc}."
                others << "stands up from #{emitter.position_controller.furniture_controller.short_desc}."
              else
                you << "stand up."
                others << "stands up."
              end
            elsif emitter.position_controller.is_resting?
              if emitter.position_controller.is_accommodated?
                you << "stop resting and stand up from #{emitter.position_controller.furniture_controller.short_desc}."
                others << "stops resting and stands up from #{emitter.position_controller.furniture_controller.short_desc}."
              else
                you << "stop resting and stand up."
                others << "stops resting and stands up."
              end
            end

            text = interpolate_me_other(emitter, you, others)

            tx(text)
          end
        end
      end
    end
  end
end
