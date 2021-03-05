module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_pour_into(params)
            emitter = params[:emitter]
            source  = params[:source]
            target  = params[:target]
            amount  = params[:amount]

            return unless can_see_action?(emitter)

            text = interpolate_me_other(emitter, "You pour the ", "#{emitter.short_desc} pours the ")

            text << "#{amount.fluid_colorized} from #{source.short_desc} into #{target.short_desc}"

            if source.is_light_source? && source.light_source_controller.is_lit?
              text << ", putting it out in the process."
            else
              text << "."
            end

            tx(text)
          end
        end
      end
    end
  end
end
