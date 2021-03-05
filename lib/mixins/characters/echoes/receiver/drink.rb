module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_drink(params)
            emitter = params[:emitter]
            target  = params[:target]
            amount  = params[:amount]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You drink ", "#{emitter.short_desc} drinks ")

            text << "#{target.fluid_controller.taken_portion_description(amount)} #{target.fluid_controller.fluid_colorized} from #{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
